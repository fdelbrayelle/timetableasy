class CursusController < ApplicationController
  filter_resource_access
  layout 'admin'

  # GET /cursus
  # GET /cursus.xml
  def index
    @cursus = Cursu.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cursus }
    end
  end

  # GET /cursus/1
  # GET /cursus/1.xml
  def show
    @cursu = Cursu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cursu }
    end
  end

  # GET /cursus/new
  # GET /cursus/new.xml
  def new
    @cursu = Cursu.new
    @periode = Periode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cursu }
    end
  end

  # GET /cursus/1/edit
  def edit
    @cursu = Cursu.find(params[:id])
  end

  # POST /cursus
  # POST /cursus.xml
  def create
    @cursu = Cursu.new(params[:cursu])

    respond_to do |format|
      if @cursu.save
        format.html { redirect_to(cursus_path, :notice => 'Cursus crée avec succès.') }
        format.xml  { render :xml => @cursu, :status => :created, :location => @cursu }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cursu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cursus/1
  # PUT /cursus/1.xml
  def update
    @cursu = Cursu.find(params[:id])

    respond_to do |format|
      if @cursu.update_attributes(params[:cursu])
        format.html { redirect_to(cursus_path, :notice => 'Cursus édité avec succès.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cursu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cursus/1
  # DELETE /cursus/1.xml
  def destroy
    @cursu = Cursu.find(params[:id])
    @cursu.destroy

    respond_to do |format|
      format.html { redirect_to(cursus_url) }
      format.xml  { head :ok }
    end
  end
end
