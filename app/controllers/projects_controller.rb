class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    # @project = Project.new(params[:project])

    if params[:removed_ids].present? && params[:removed_ids].reject(&:empty?).present?
     params[:removed_ids].reject(&:empty?).each do |each_rec|
     find_rec = Project.find(each_rec)
     find_rec.delete
     end
    end  
    if params[:name].present?
     count_of_records = (params[:name].count-1)
    (0..(count_of_records-1)).each do |each_rec|
      name= params[:name][each_rec]
      find_project= Project.where(:name=>"#{name}").first_or_initialize
      find_project.name=params[:name][each_rec]
      find_project.description = params[:description][each_rec]
      find_project.price = params[:price][each_rec]
    # project = Project.new(:name=>name,:description=>description,:price=>price)
    if find_project.save
     @project=true
    end

    end
  end
    if @project.present?
    redirect_to "/projects"
   else
    format.html { render action: "new" }
   end

    # respond_to do |format|
    #   if @project.save
    #     format.html { redirect_to @project, notice: 'Project was successfully created.' }
    #     format.json { render json: @project, status: :created, location: @project }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @project.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
