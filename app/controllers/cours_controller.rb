class CoursController < ApplicationController
  # GET /cours
  # GET /cours.xml
  def index
    @cours = Cours.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cours }
    end
  end

  # GET /cours/1
  # GET /cours/1.xml
  def show
    @cours = Cours.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cours }
    end
  end

  # GET /cours/new
  # GET /cours/new.xml
  def new
    @cours = Cours.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cours }
    end
  end

  # GET /cours/1/edit
  def edit
    @cours = Cours.find(params[:id])
  end

  # POST /cours
  # POST /cours.xml
  def create
    @cours = Cours.new(params[:cours])

    respond_to do |format|
      if @cours.save
        flash[:notice] = 'Cours was successfully created.'
        format.html { redirect_to(@cours) }
        format.xml  { render :xml => @cours, :status => :created, :location => @cours }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cours.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cours/1
  # PUT /cours/1.xml
  def update
    @cours = Cours.find(params[:id])

    respond_to do |format|
      if @cours.update_attributes(params[:cours])
        flash[:notice] = 'Cours was successfully updated.'
        format.html { redirect_to(@cours) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cours.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cours/1
  # DELETE /cours/1.xml
  def destroy
    @cours = Cours.find(params[:id])
    @cours.destroy

    respond_to do |format|
      format.html { redirect_to(cours_url) }
      format.xml  { head :ok }
    end
  end
end
