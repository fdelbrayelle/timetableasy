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
    has_permission_on :admin, :to => :index
  end

  role :intervenant do
    
  end

  role :etudiant do
    
  end

  role :guest do
    has_permission_on :users, :to => [:new, :create, :edit]
    has_permission_on :user_sessions, :to => [:new, :create]
  end
end
