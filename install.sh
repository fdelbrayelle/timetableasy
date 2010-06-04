#!/bin/bash -
#
# Timetableasy
#
# Usage : ./install-sh username password
#

if [ $# != 2 ]; then
  echo Usage : $0 username password
  exit 1
fi

# Création du projet et de la base de données
rails timetableasy

cd timetableasy

cat << EOF > config/database.yml
development:
  adapter: mysql
  database: db/time_dev
  pool: 5
  timeout: 5000
  username: $1
  password: $2

test:
  adapter: mysql
  database: db/time_test
  pool: 5
  timeout: 5000
  username: $1
  password: $2

production:
  adapter: mysql
  database: db/time_prod
  pool: 5
  timeout: 5000
  username: $1
  password: $2
EOF
rake db:create

# Génération du contrôleur home et de l'action index + Routage
ruby script/generate controller home index

rm public/index.html

mv app/controller/application.rb app/controller/application_controller.rb

cat << EOF > config/routes.rb
ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
EOF

# Création des tables et des relations entre les tables dans les modèles
#ruby script/generate scaffold Evenement nom:string description:text affichage:boolean portee:string debut:datetime duree:integer campu_id:integer espace_id:integer intervenant_id:integer cour_id:integer evaluation_id:integer

ruby script/generate scaffold Evenement nom:string description:text readonly:boolean debut:datetime duree:integer campu_id:integer espace_id:integer intervenant_id:integer user_id:integer role_id:integer classe_id:integer cour_id:integer evaluation_id:integer

ruby script/generate scaffold Campus nom:string pays:string user_id:integer espace_id:integer classe_id:integer

ruby script/generate scaffold Cursus nom:string periode_id:integer

ruby script/generate scaffold Classe user_id:integer etudiant_id:integer periode_id:integer

ruby script/generate scaffold Espace code:string type:string

ruby script/generate scaffold User username:string password:string password_confirmation:string crypted_password:string password_salt:string persistence_token:string nom:string prénom:string email:string date_naissance:date alias:string evenement_id:integer

ruby script/generate migration add_role_id_to_user role_id:integer

ruby script/generate scaffold Periode nom:string début:date fin:date cour_id:integer

ruby script/generate scaffold Cours nom:string heures_total:integer heures_reste:integer evaluation_id:integer

ruby script/generate scaffold Evaluation

cat << EOF > app/models/classe.rb
class Classe < ActiveRecord::Base
  belongs_to :evenement
  belongs_to :campu
  has_many :user
end
EOF

cat << EOF > app/models/campu.rb
class Campu < ActiveRecord::Base
  belongs_to :evenement
  has_one :user
  has_many :classes
  has_many :espaces
  validates_presence_of :nom, :pays
end
EOF

cat << EOF > app/models/espace.rb
class Espace < ActiveRecord::Base
  belongs_to :campu
  belongs_to :evenement
  validates_presence_of :code, :type
end
EOF

cat << EOF > app/models/evenement.rb
class Evenement < ActiveRecord::Base
  has_many :users
  has_many :campus
  has_many :classes
  has_many :espaces
  has_many :cours
  has_many :evaluations
  validates_presence_of :nom, :description, :duree
  validates_numericality_of :duree
end
EOF

cat << EOF > app/models/user.rb 
class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :classe
  belongs_to :campu
  has_many :evenements
  has_many :roles
  validates_presence_of :username, :password, :password_confirmation, :nom, :prénom, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
end
EOF

cat << EOF > app/models/cursu.rb 
class Cursu < ActiveRecord::Base
  has_many :periodes
  validates_presence_of :nom
end
EOF

cat << EOF > app/models/periode.rb 
class Periode < ActiveRecord::Base
  belongs_to :cursu
  belongs_to :classe
  has_many :cours
  validates_presence_of :nom
  validate_period :debut

  def validate_period
    errors.add(:debut, 'must be earlier than end date') if self.debut > self.fin
  end
end
EOF

cat << EOF > app/models/cour.rb 
class Cour < ActiveRecord::Base
  belongs_to :periode
  belongs_to :evenement
  has_many :evaluations
  validates_presence_of :nom
  validates_numericality_of :heures_total, :greater_than => 0
  validates_numericality_of :heures_reste, :greater_than => 0
end
EOF

cat << EOF > app/models/evaluation.rb 
class Evaluation < ActiveRecord::Base
  belongs_to :evenement
end
EOF

rake db:migrate

# Authentification and Authorization

cat << EOF > config/environment.rb
# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "authlogic"
  config.gem "declarative_authorization", :source => "http://gemcutter.org"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # The internationalization framework can be changed to have another default locale (standard is :en) or more load paths.
  # All files from config/locales/*.rb,yml are added automatically.
  # config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :key => '_timetableasy_session',
    :secret      => 'c15137a560ba03c6c6d20d8c5563e0cdadfb52921400b3ecb15e2a97386d153f5dcc94aec14dc09cc2a3a98c876f0ec4d0496d6aa9d9a9a1a2dbad1121b08765'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
end
EOF

rake gems:install

cat << EOF > app/views/users/new.html.erb
<h1>Nouvel utilisateur</h1>

<% form_for(@user) do |f| %>
  <%= f.error_messages %>

  <p>
    <%= f.label :username %><br />
    <%= f.text_field :username %>
  </p>
  <p>
    <%= f.label :password %><br />
    <%= f.password_field :password %>
  </p>
  <p>
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation %>
  </p>
  <p>
    <%= f.label :nom %><br />
    <%= f.text_field :nom %>
  </p>
  <p>
    <%= f.label :prénom %><br />
    <%= f.text_field :prénom %>
  </p>
  <p>
    <%= f.label :email %><br />
    <%= f.text_field :email %>
  </p>
  <p>
    <%= f.label :date_naissance %><br />
    <%= f.date_select :date_naissance, :start_year => 1900, :end_year => Time.now.year - 10, :use_month_numbers => true, :order => [:day, :month, :year] %>
  </p>
  <p>
    <%= f.label :alias %><br />
    <%= f.text_field :alias %>
  </p>
  <p>
    <%= f.submit "Créer" %>
  </p>
<% end %>

<%= link_to 'Retour', users_path %>
EOF

cat << EOF > app/views/users/edit.html.erb
<h1>Editer un utilisateur</h1>

<% form_for(@user) do |f| %>
  <%= f.error_messages %>

  <p>
    <%= f.label :username %><br />
    <%= f.text_field :username %>
  </p>
  <p>
    <%= f.label :password %><br />
    <%= f.password_field :password %>
  </p>
  <p>
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation %>
  </p>
  <p>
    <%= f.label :nom %><br />
    <%= f.text_field :nom %>
  </p>
  <p>
    <%= f.label :prénom %><br />
    <%= f.text_field :prénom %>
  </p>
  <p>
    <%= f.label :email %><br />
    <%= f.text_field :email %>
  </p>
  <p>
    <%= f.label :date_naissance %><br />
    <%= f.date_select :date_naissance, :start_year => 1900, :end_year => Time.now.year - 10, :use_month_numbers => true, :order =>
  </p>
  <p>
    <%= f.label :alias %><br />
    <%= f.text_field :alias %>
  </p>
  <p>
    <%= f.submit "Editer" %>
  </p>
<% end %>

<%= link_to 'Voir', @user %> |
<%= link_to 'Editer', users_path %>
EOF

cat << EOF > app/views/users/index.html.erb
<h1>Liste des utilisateurs</h1>

<table>
  <tr>
    <th>Username</th>
    <th>Nom</th>
    <th>Prénom</th>
    <th>Mail</th>
    <th>Date de naissance</th>
    <th>Alias</th>
  </tr>

<% for user in @users %>
  <tr>
    <td><%=h user.username %></td>
    <td><%=h user.nom %></td>
    <td><%=h user.prénom %></td>
    <td><%=h user.email %></td>
    <td><%=h user.date_naissance %></td>
    <td><%=h user.alias %></td>
    <td><%= link_to 'Voir', user %></td>
    <td><%= link_to 'Editer', edit_user_path(user) %></td>
    <td><%= link_to 'Supprimer', user, :confirm => 'Etes-vous sûr ?', :method => :delete %></td>
  </tr>
<% end %>
</table>

<br />

<%= link_to 'Nouvel utilisateur', new_user_path %>
EOF

cat << EOF > app/controllers/users_controller.rb
class UsersController < ApplicationController
  filter_resource_access

  def index
    @users = User.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Utilisateur ajouté avec succès.'
        format.html { redirect_to(root_url) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Profil édité avec succès.'
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
EOF

# Gestion des sessions

ruby script/generate session user_session

ruby script/generate scaffold user_session username:string password:string

cat << EOF > app/controllers/user_sessions_controller.rb
class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    respond_to do |format|
      if @user_session.save
        flash[:notice] = 'Connecté avec succès.'
        format.html { redirect_to(root_url) }
        format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
EOF

cat << EOF > app/views/user_sessions/new.html.erb
<h1>Login</h1>

<% form_for(@user_session) do |f| %>
  <%= f.error_messages %>

  <p>
    <%= f.label :username %><br />
    <%= f.text_field :username %>
  </p>
  <p>
    <%= f.label :password %><br />
    <%= f.password_field :password %>
  </p>
  <p>
    <%= f.submit "Login" %>
  </p>
<% end %>

<%= link_to 'Retour', root_path %>
EOF

cat << EOF > config/routes.rb
ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.login "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions
  map.resources :pratiques
  map.resources :examens
  map.resources :evaluations
  map.resources :diriges
  map.resources :distanciels
  map.resources :presentiels
  map.resources :cours
  map.resources :periodes
  map.resources :cursus
  map.resources :etudiants
  map.resources :intervenants
  map.resources :managers
  map.resources :administrateurs
  map.resources :users
  map.resources :classes
  map.resources :espaces
  map.resources :campus
  map.resources :evenements
  map.resources :soutenances

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
EOF

cat << EOF > app/controllers/application.rb
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'standard'
  helper :all # include all helpers, all the time
  helper_method :current_user, :current_user_session

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery
  before_filter { |c| Authorization.current_user = c.current_user }
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
EOF

ruby script/generate scaffold Role name:string user_id:string

cat << EOF > app/models/role.rb
class Role < ActiveRecord::Base
  belongs_to :user
end
EOF

cat << EOF > config/authorization_rules.rb
authorization do
  role :administrateur do
    has_permission_on [:users, :campus, :cursus, :classes, :evenements],
        :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :admin, :to => :index
  end
  
  role :manager do
    has_permission_on :campus,
        :to => [:index, :show, :edit, :update]
    has_permission_on [:classes, :evenements],
        :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :guest do
    has_permission_on [:users, :user_sessions], :to => [:new, :create]
  end
end
EOF

cat << EOF > app/controllers/campus_controller.rb
class CampusController < ApplicationController
  filter_resource_access

  def index
    @campus = Campus.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campus }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campus }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campus }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @campus.save
        flash[:notice] = 'Le campus a été créé avec succès.'
        format.html { redirect_to(@campus) }
        format.xml  { render :xml => @campus, :status => :created, :location => @campus }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campus.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @campus.update_attributes(params[:campus])
        flash[:notice] = 'Le campus a été modifié avec succès.'
        format.html { redirect_to(@campus) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campus.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @campus.destroy

    respond_to do |format|
      format.html { redirect_to(campus_url) }
      format.xml  { head :ok }
    end
  end
end
EOF

cat << EOF > app/controllers/cursus_controller.rb
class CursusController < ApplicationController
  filter_resource_access

  def index
    @cursus = Cursus.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cursus }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cursus }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cursus }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @cursus.save
        flash[:notice] = 'Le cursus a été créé avec succès.'
        format.html { redirect_to(@cursus) }
        format.xml  { render :xml => @cursus, :status => :created, :location => @cursus }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cursus.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cursus.update_attributes(params[:cursus])
        flash[:notice] = 'Le cursus a été modifié avec succès.'
        format.html { redirect_to(@cursus) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cursus.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @cursus.destroy

    respond_to do |format|
      format.html { redirect_to(cursus_url) }
      format.xml  { head :ok }
    end
  end
end
EOF

cat << EOF > app/controllers/classes_controller.rb
class ClassesController < ApplicationController
  filter_resource_access

  def index
    @classes = Classe.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classes }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classe }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classe }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @classe.save
        flash[:notice] = 'La classe a été créée avec succès.'
        format.html { redirect_to(@classe) }
        format.xml  { render :xml => @classe, :status => :created, :location => @classe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @classe.update_attributes(params[:classe])
        flash[:notice] = 'La classe a été modifiée avec succès.'
        format.html { redirect_to(@classe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @classe.destroy

    respond_to do |format|
      format.html { redirect_to(classes_url) }
      format.xml  { head :ok }
    end
  end
end
EOF

# Intégration du design et création de l'interface d'administration

cat << EOF > app/helpers/application_helper.rb
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

    def liams_link_to(text, path, classname)
      out = "<span class='" + classname + + "'>"
      out += link_to text, path
      out += "</span>"
      out
    end

end
EOF

cat << EOF > app/views/layouts/standard.html.erb
<!DOCTYPE html>
<html>
	<head>
		<!-- Meta -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<!-- End of Meta -->
		
		<!-- Page title -->
		<title>Globus University - Timetableasy 2010</title>
		<!-- End of Page title -->
		
		<!-- Libraries -->
		<%= stylesheet_link_tag 'layout' %>
		<%= stylesheet_link_tag 'scaffold' %>

		<script type="text/javascript" src="/javascripts/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="/javascripts/easyTooltip.js"></script>
		<script type="text/javascript" src="/javascripts/jquery-ui-1.7.2.custom.min.js"></script>
		<script type="text/javascript" src="/javascripts/jquery.wysiwyg.js"></script>
		<script type="text/javascript" src="/javascripts/hoverIntent.js"></script>
		<script type="text/javascript" src="/javascripts/superfish.js"></script>
		<script type="text/javascript" src="/javascripts/custom.js"></script>
		<!-- End of Libraries -->	
	</head>
	<body>
		<!-- Container -->
		<div id="container">
		
			<!-- Header -->
			<div id="header">
				
				<!-- Top -->
				<div id="top">
					<!-- Logo -->
					<div class="logo" style="text-align: center"><br /><br />
						<a href="index.html#" title="Globus University" class="tooltip"><img src="images/globus_university_bg.png" alt="Globus University" /></a> 
					</div>
					<!-- Meta information -->
					<div class="meta">
						<% if current_user %>
							<p>Bienvenue, <% current_user.prénom %> !</p>
							<ul>
								<% if permitted_to? :index, @admin %>
								    <li><% link_to "Admin", admin_path %></li>
								<% end %>
								<li><%= link_to("Logout", logout_path, :class => 'tooltip') %></li>
								<li><%= link_to("Editer mon profil", edit_user_path(current_user.id)) %></li>
							</ul>
					
						<% else %>
							<p>Bienvenue !</p>
							<ul>
								<li><%= link_to("Login", login_path, :class => 'tooltip') %></li>
								<li><%= link_to("Register", new_user_path, :class => 'tooltip') %></li>
							</ul>
						<% end %>
					</div>
					<!-- End of Meta information -->
				</div>
				<!-- End of Top-->
			
				<!-- The navigation bar -->
				<div id="navbar">
					<ul class="nav">
					
					</ul>
				</div>
				<!-- End of navigation bar" -->
			
			</div>
			<!-- End of Header -->
			
			<!-- Background wrapper -->
			<div id="bgwrap">
		
				<!-- Main Content -->
				<div id="content">
					<div id="main">
					
					    <p style="color: green"><%= flash[:notice] %></p>
                        <%= yield  %>
					
					</div>
				</div>
				<!-- End of Main Content -->	

				<!-- Sidebar -->
				<div id="sidebar">

				</div>		
			</div>
			<!-- End of bgwrap -->
		</div>
		<!-- End of Container -->
		
		<!-- Footer -->
		<div id="footer">
			<p class="mid">
				<a href="#" title="Remonter" class="tooltip">Remonter</a>&middot;<a href="/home" title="Accueil" class="tooltip">Accueil</a><% if current_user %>&middot;<a href="/logout" title="Logout" class="tooltip">Logout</a><% end %>
			</p>
			<p class="mid">
				<!-- Change this to your own once purchased -->
				&copy; Globus University - Timetableasy 2010. All rights reserved.
				<!-- -->
			</p>
		</div>
		<!-- End of Footer -->


	</body>
</html>
EOF

ruby script/generate controller admin index

cat << EOF > app/views/admin/index.html.erb
<h1>Interface d'administration</h1>

<p>Quelle action souhaitez-vous effectuer ?</p>
					
<div class="pad20">
<!-- Big buttons -->
    <ul class="dash">
            <li>
                    <a href="index.html#" title="Créer un nouvel utilisateur" class="tooltip">
	                    <img src="/images/assets/icons/8_48x48.png" alt="" />
	                    <span>Nouvel utilisateur</span>
                    </a>
            </li>
            <li>
                    <a href="index.html#" title="Voir la liste des utilisateurs" class="tooltip">
	                    <img src="/images/assets/icons/7_48x48.png" alt="" />
	                    <span>Utilisateurs</span>
                    </a>
            </li>
            <li>
                    <a href="index.html#" title="Afficher les étudiants inscrits" class="tooltip">
	                    <img src="/images/assets/icons/16_48x48.png" alt="" />
	                    <span>Etudiants inscrits</span>
                    </a>
            </li>
            <li>
                    <a href="index.html#" title="Voir les campus" class="tooltip">
	                    <img src="/images/assets/icons/33_48x48.png" alt="" />
	                    <span>Campus</span>
                    </a>
            </li>
            <li>
                    <a href="index.html#" title="Afficher les cursus courants" class="tooltip">
	                    <img src="/images/assets/icons/31_48x48.png" alt="" />
	                    <span>Cursus</span>
                    </a>
            </li>
            <li>
                    <a href="index.html#" title="Lister les différentes classes" class="tooltip">
	                    <img src="/images/assets/icons/32_48x48.png" alt="" />
	                    <span>Classes</span>
                    </a>
            </li>
    </ul>
    <!-- End of Big buttons -->
</div>
EOF

# Charger un jeu de données en base

cat << EOF > test/fixtures/users.yml
# Read about fixtures at http://ar.rubyonrails.org/classes/Fixtures.html

alexandre:
  username: alexandre
  password: 
  password_confirmation: 
  crypted_password: e377533f2d147cb2abf8ee83a29d50d37774e69fade8abcd040abf045aeb9dd9521aa7745ec62a2bbd2b041a20b741e5a5e9ae94416a53e62e2aea1f0379d6dd
  password_salt: d-TZPqAZqVE0jdtB550H
  persistence_token: 89e6e4d1a43a202cc458efc3de35b9fcb5977bfd9784e95ed65548a049cbe07b49cdb5d2439a94d082be2c6b909706bc0fb6ba50ca9eca155e36fce2d0cad03b
  nom: Cuvillier
  prénom: Alexandre
  email: alexandre.cuvillier@globus.com
  date_naissance: 1987-07-23
  alias: alex
  evenement_id: 
  
benjamin:
  username: benjamin
  password: 
  password_confirmation: 
  crypted_password: e377533f2d147cb2abf8ee83a29d50d37774e69fade8abcd040abf045aeb9dd9521aa7745ec62a2bbd2b041a20b741e5a5e9ae94416a53e62e2aea1f0379d6dd
  password_salt: d-TZPqAZqVE0jdtB550H
  persistence_token: 89e6e4d1a43a202cc458efc3de35b9fcb5977bfd9784e95ed65548a049cbe07b49cdb5d2439a94d082be2c6b909706bc0fb6ba50ca9eca155e36fce2d0cad03b
  nom: Descamps
  prénom: Benjamin
  email: benjamin.descamps@globus.com
  date_naissance: 1987-07-23
  alias: ben
  evenement_id: 
  
cenk:
  username: cenk
  password: 
  password_confirmation: 
  crypted_password: e377533f2d147cb2abf8ee83a29d50d37774e69fade8abcd040abf045aeb9dd9521aa7745ec62a2bbd2b041a20b741e5a5e9ae94416a53e62e2aea1f0379d6dd
  password_salt: d-TZPqAZqVE0jdtB550H
  persistence_token: 89e6e4d1a43a202cc458efc3de35b9fcb5977bfd9784e95ed65548a049cbe07b49cdb5d2439a94d082be2c6b909706bc0fb6ba50ca9eca155e36fce2d0cad03b
  nom: Senkur
  prénom: Cenk
  email: cenk.senkur@globus.com
  date_naissance: 1985-07-23
  alias: cenk
  evenement_id: 

francois:
  username: francois
  password: 
  password_confirmation: 
  crypted_password: e377533f2d147cb2abf8ee83a29d50d37774e69fade8abcd040abf045aeb9dd9521aa7745ec62a2bbd2b041a20b741e5a5e9ae94416a53e62e2aea1f0379d6dd
  password_salt: d-TZPqAZqVE0jdtB550H
  persistence_token: 89e6e4d1a43a202cc458efc3de35b9fcb5977bfd9784e95ed65548a049cbe07b49cdb5d2439a94d082be2c6b909706bc0fb6ba50ca9eca155e36fce2d0cad03b
  nom: Delbrayelle
  prénom: François
  email: francois.delbrayelle@globus.com
  date_naissance: 1987-07-23
  alias: francois
  evenement_id: 
EOF

cat << EOF > test/fixtures/roles.yml
# Read about fixtures at http://ar.rubyonrails.org/classes/Fixtures.html

administrateur:
  name: administrateur
  user_id: 1

manager:
  name: manager
  user_id: 2

intervenant:
  name: intervenant
  user_id: 3

etudiant:
  name: etudiant
  user_id: 4
EOF

rake db:fixtures:load

