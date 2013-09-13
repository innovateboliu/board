class TopicsController < ApplicationController
    before_filter :check_course_existence
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    if existing_user
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @topic }
        end
    else
        redirect_to '/signin', :notice => "Pleaes sign in first"
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
    if !existing_user or existing_user.id != @topic.user.id
        redirect_to course_topic_path(@course, @topic), :notice => "You are not eligible to edit this topic"
    else
        respond_to do |format|
            format.html
            format.json { render json: @topic}
        end
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    @topic.user = existing_user
    @topic.course = @course

    respond_to do |format|
      if @topic.user and @topic.save
        format.html { redirect_to @course, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  def reply
      @topic = Topic.find(params[:topic_id])
      @comment = @topic.comments.build

      if existing_user
          respond_to do |format|
              format.html 
          end
      else
        redirect_to '/signin', :notice => "Pleaes sign in first"
      end
  end
  def save_comment
      if !existing_user
          redirect_to(:signin, :notice =>"Please login before reply")
          return;
      end

      if Topic.exists?(params[:topic_id])
          @topic = Topic.find(params[:topic_id])
          @comment = @topic.comments.build(params[:comment])
          @comment.user_id = existing_user.id
          #$redis.publish 'new_reply_topic', " topic_id:" + @topic.id.to_s+" Your topic: " + @topic.title + " has a new reply" + @comment.body
          $redis.publish 'new_reply_topic', {
              :topic_id => @topic.id,
              :topic_user_id => @topic.user.id,
              :comment_from => @comment.user_id
            }.to_json
          
      end

      respond_to do |format|
          if @comment.save
              format.html { redirect_to(course_topic_path(@course, @topic), :notice => 'Your comment is saved successfully!') }
          end
      end
  end

  def add_vote
      @topic = Topic.find(params[:topic_id])
      p "add vote !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      @comment = @topic.comments.find(params[:comment_id])
      @comment.votes += 1
      @comment.save!
      render :text => @comment.votes
      p response.body
      #redirect_to(course_topic_path(@course, @topic), :notice => 'You vote successfully!') 
  end

  def subtract_vote
      @topic = Topic.find(params[:topic_id])
      p "subtract vote !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      p request.original_url 
      @comment = @topic.comments.find(params[:comment_id])
      p @comment
      @comment.votes -= 1
      @comment.save!

      render :text => @comment.votes
      #redirect_to(course_topic_path(@course, @topic), :notice => 'You vote successfully!') 
  end
  private

  def check_course_existence
      @course = Course.find(params[:course_id])
      unless @course
          redirect_to courses_path, :notice => "Error: Course not specified!"
      end
  end
end
