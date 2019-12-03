class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  $s = ""
  $pi = ""
  $t = ""
  $a = ""
  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all.order(sort_column + " " + sort_direction)
    if params[:status].present? and params[:status].length != 2
      $s = params[:status].join
    end
    if params[:priority].present?
      $pi = params[:priority].join
    end
    if params[:type_issue].present?
      $t = params[:type_issue].join
    end 
    if params[:assignee_id].present?
      $a = params[:assignee_id].join
    end
    
    if (not params[:assignee_id].present?) and (not params[:type_issue].present?) and (not params[:priority].present?) and (not params[:status].present?)
      $s = ""
      $pi = ""
      $t = ""
      $a = ""
    end
    if params[:status].present? and params[:status].length == 2
      $s = "new","open"
    end
    if params[:status].present? and params[:status].length != 2 and params[:status].join == "unresolved"
      $s = "new","open"
    end
    
    
    @issues = @issues.status($s).priority($pi).type_issue($t).assignee_id($a)
    if params.has_key?(:watcher)
      @issues = User.find(params[:watcher]).watched
    end
    er=false
    @user_aux = authenticate
    if(@user_aux.nil?)
     er=true
    else
      if params.has_key?(:watching)
        @issues = User.find(@user_aux.id).watched
      end
    end
    
    if(er == true)
      respond_to do |format|
        format.json {render json: {meta: {code: 401, error_message: "Unauthorized"}}, status: :unauthorized}
      end
    else 
      respond_to do |format|   
        format.html
        format.json {render json: @issues, status: :ok, each_serializer: IssueSerializer}
      end
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