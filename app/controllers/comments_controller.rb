class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: :show

  # GET /comments
  # GET /comments.json
  def index
    redirect_to root_path
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    redirect_to root_path
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if !@comment.user.eql? (current_user)
      @comment.errors.add(:base, "You're messing with me, huh?")
      raise ActiveRecord::RecordInvalid.new(@comment)
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.snippet, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

    if !@comment.user.eql? (current_user)
      @comment.errors.add(:base, "You're messing with me, huh?")
      raise ActiveRecord::RecordInvalid.new(@comment)
    end

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.snippet, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if (@comment.user.eql?( current_user ))
      snippet = @comment.snippet
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to snippet_path(snippet) }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to comment_path(@comment) }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :snippet_id)
    end
end
