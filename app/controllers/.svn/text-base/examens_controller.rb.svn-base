class ExamensController < ApplicationController
  # GET /examens
  # GET /examens.xml
  def index
    @examens = Examen.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examens }
    end
  end

  # GET /examens/1
  # GET /examens/1.xml
  def show
    @examen = Examen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examen }
    end
  end

  # GET /examens/new
  # GET /examens/new.xml
  def new
    @examen = Examen.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examen }
    end
  end

  # GET /examens/1/edit
  def edit
    @examen = Examen.find(params[:id])
  end

  # POST /examens
  # POST /examens.xml
  def create
    @examen = Examen.new(params[:examen])

    respond_to do |format|
      if @examen.save
        flash[:notice] = 'Examen was successfully created.'
        format.html { redirect_to(@examen) }
        format.xml  { render :xml => @examen, :status => :created, :location => @examen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examens/1
  # PUT /examens/1.xml
  def update
    @examen = Examen.find(params[:id])

    respond_to do |format|
      if @examen.update_attributes(params[:examen])
        flash[:notice] = 'Examen was successfully updated.'
        format.html { redirect_to(@examen) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examens/1
  # DELETE /examens/1.xml
  def destroy
    @examen = Examen.find(params[:id])
    @examen.destroy

    respond_to do |format|
      format.html { redirect_to(examens_url) }
      format.xml  { head :ok }
    end
  end
end
