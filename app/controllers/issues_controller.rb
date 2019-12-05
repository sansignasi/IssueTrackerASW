class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  include Rails.application.routes.url_helpers


  # GET /issues
  # GET /issues.json
  def index
    respond_to do |format|
      @issues = Issue.all
      if params.has_key?(:assignee)
        if User.exists?(first_name: params[:assignee])
          @issues = @issues.where(Asigned: params[:assignee])
        else
          format.json {render json: {"error":"User with id="+params[:assignee]+" does notss exist"}, status: :unprocessable_entity}
        end
      end
      
      if params.has_key?(:type)
        @issues = @issues.where(Type: params[:type])
      end
      
      if params.has_key?(:priority)
        @issues = @issues.where(Priority: params[:priority])
      end
      
      if params.has_key?(:status)
        @issues = @issues.where(Status: params[:status])
      end
      format.html
      format.json {render json: @issues, status: :ok, each_serializer: IssuesSerializer}
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue2 = Issue.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @issue2, status: :ok, serializer: IssuesSerializer}
    end
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    aut_token = params[:token]
    params.delete :token
    user = User.where(["token = ?", aut_token]).first
    if user.nil?
      respond_to do |format|
        format.html { render :new }
        format.json { render json:  {"error":"User no registrado"}, status: :unprocessable_entity }
      end
    else
      @issue = Issue.new(issue_params)
      @issue.Creator = current_user.id
      @issue.Created = Time.now
      @issue.Status = "new"
      respond_to do |format|
        if (issue_params.has_key?(:Asigned) && issue_params[:Asigned] != "" && !User.exists?(id: issue_params[:Asigned]))
            format.json {render json: {"error":"User with id="+issue_params[:Asigned]+" does not exist"}, status: :unprocessable_entity}
        else
          if @issue.save
            format.html { redirect_to @issue }
            format.json { render json: @issue, status: :created, serializer: IssuesSerializer }
          else
            format.html { render :new }
            format.json { render json: @issue.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if(!params[:Asigned] == nil)
        if !User.exists?(id: params[:Asigned])
            format.json {render json: {"error":"User with id="+params[:Asigned]+" does not exist"}, status: :unprocessable_entity}
        else
          @issue_to_update = Issue.find(params[:id])
          @issue_to_update.Updated = Time.now
          @issue_to_update.update(issue_params)
          format.html { redirect_to @issue_to_update }
          format.json { render json: @issue_to_update, status: :ok, serializer: IssuesSerializer}
        end
      else
        @issue_to_update = Issue.find(params[:id])
        @issue_to_update.Updated = Time.now
        @issue_to_update.update(issue_params)
        format.html { redirect_to @issue_to_update }
        format.json { render json: @issue_to_update, status: :ok, serializer: IssuesSerializer}
      end
    end
  end
  

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue2 = Issue.find(params[:id])
    @issue2.destroy
    respond_to do |format|
      format.json { render json: {"message": "success"}, status: :ok }
    end
  end
  
  
  

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue2 = Issue.find(params[:id])
    @issue2.destroy
    respond_to do |format|
      format.json { render json: {"message": "success"}, status: :ok }
    end
  end
  
  def upvote
    respond_to do |format|
        @issue = Issue.find(params[:id])
        #@issue.upvote_by(current_user)
        #if(!User.find(current_user.id).voted_for? @issue)
          @issue.increment!("Vote")
          format.html { redirect_to @issue }
          format.json { render json: @issue, status: :ok }
        #end
        #redirect_to :issue
    end
    @issue = Issue.find(params[:id])
      @issue.upvote_by(current_user)
      if(User.find(current_user.id).voted_for? @issue)
      else
        @issue.increment!("Vote")
      end
      redirect_to :issue

  end
    
  def downvote
    @issue = Issue.find(params[:id])
    @issue.downvote_by(current_user)
    if(User.find(current_user.id).voted_for? @issue)
      @issue.decrement!("Vote")
    end
    redirect_to :issue
  end
  
  def watch
      @issue = Issue.find(params[:id])
      @issue.upvote_by(current_user)
      @issue.increment!("Watch")
      redirect_to :issue
  end
    
  def unwatch
    @issue = Issue.find(params[:id])
    if(@issue.Watch > 0)
       @issue.decrement!("Watch")
    end
    redirect_to :issue
  end
  
  
  
  def update_file
    @issue = Issue.find(params[:id])
    @issue.file.attach(params.require(:file))
  end
  
  def show_attachment
    @issue = Issue.find(params[:id])
    @file = nil
    @issue2 = nil
    if (@issue.file.attached? == true)
      @file = rails_blob_path(@issue.file, only_path: true) if @issue.file.attached?
      @issue2 =ActiveStorage::Bolb.find(params[:id])
    else
      @file = 'no file'
      @issue2=nil
    end
    respond_to do |format|
      format.html {redirect_to issues_url, notice: 'https://secure-crag-93015.herokuapp.com'+@file}
      format.json {render json:{attachment_content_type: @issue2.content_type,attachment_file_name: @issue2.filename,attachment_file_size: @issue2.byte_size,attachment_created_at: @issue2.created_at ,url: 'secure-crag-93015.herokuapp.com'+@file, status: :ok }}
      
      
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.permit(:Title ,:Description, :Type, :Priority, :Status, :Asigned, :Creator, :Created, :Updated, :Vote, :Watch,:file)
    end
end