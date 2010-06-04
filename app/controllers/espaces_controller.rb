class EspacesController < ApplicationController
  # GET /espaces
  # GET /espaces.xml
  def index
    @espaces = Espace.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @espaces }
    end
  end

  # GET /espaces/1
  # GET /espaces/1.xml
  def show
    @espace = Espace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @espace }
    end
  end

  # GET /espaces/new
  # GET /espaces/new.xml
  def new
    @espace = Espace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @espace }
    end
  end

  # GET /espaces/1/edit
  def edit
    @espace = Espace.find(params[:id])
  end

  # POST /espaces
  # POST /espaces.xml
  def create
    @espace = Espace.new(params[:espace])

    respond_to do |format|
      if @espace.save
        flash[:notice] = 'Espace was successfully created.'
        format.html { redirect_to(@espace) }
        format.xml  { render :xml => @espace, :status => :created, :location => @espace }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @espace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /espaces/1
  # PUT /espaces/1.xml
  def update
    @espace = Espace.find(params[:id])

    respond_to do |format|
      if @espace.update_attributes(params[:espace])
        flash[:notice] = 'Espace was successfully updated.'
        format.html { redirect_to(@espace) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @espace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /espaces/1
  # DELETE /espaces/1.xml
  def destroy
    @espace = Espace.find(params[:id])
    @espace.destroy

    respond_to do |format|
      format.html { redirect_to(espaces_url) }
      format.xml  { head :ok }
    end
  end
end
