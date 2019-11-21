class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    if(params.has_key?(:issue_type))
      @issues = Issue.where(Type: params[:issue_type])
    elsif(params.has_key?(:issue_status))
      @issues = Issue.where(Status: params[:issue_status])
    elsif(params.has_key?(:issue_creator))
      @issues = Issue.where(Creator: params[:issue_creator])
    elsif(params.has_key?(:issue_priority))
      @issues = Issue.where(Priority: params[:issue_priority])
    else
      @issues = Issue.all
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
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
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def upvote
    @issue = Issue.find(params[:id])
      @issue.upvote_by(current_user)
      if(User.find(current_user.id).voted_for? @issue)
      else
        @issue.increment!("Watch")
      end
      redirect_to :issue
  end
    
  def downvote
    @issue = Issue.find(params[:id])
    @issue.downvote_by(current_user)
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
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:Title ,:Description, :Type, :Priority, :Status, :Asigned, :Creator, :Created, :Updated, :Vote, :Watch,:file)
    end
end