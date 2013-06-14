class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index,:new,:create,:destroy]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to tags_url, alert: exception.message
  end

  # GET /tags
  def index
    authorize! :list, Tag, message: "You don't have permission to see the tags, please sign in"
    @tags = Tag.all
  end

  # GET /tags/new
  def new
    authorize! :create, Tag, message: "You don't have permission to create tags"
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
    authorize! :edit, Tag, message: "You don't have permission to edit tags"
  end

  # POST /tags
  def create
    authorize! :create, Tag, message: "You don't have permission to create tags"
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path, notice: 'Tag was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tags/1
  def update
    authorize! :edit, Tag, message: "You don't have permission to edit tags"
    if @tag.update(tag_params)
      redirect_to @tag, notice: 'Tag was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /tags/1
  def destroy
    authorize! :destroy, Tag, message: "You don't have permission to destroy tags"
    @tag.destroy
    redirect_to tags_url, notice: 'Tag was successfully destroyed.'
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params[:tag]
    end
end
