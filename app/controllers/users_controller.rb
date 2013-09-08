class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if is_eligible
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
    else
        redirect_to :courses, :notice => "You are not eligible to check user information"
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    if existing_user
        redirect_to :courses, :notice => "You've already signed in"
    else
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @user }
        end
    end
  end

  # GET /users/1/edit
  def edit
    if is_eligible
        respond_to do |format|
          format.html # edit.html.erb
          format.json { render json: @user }
        end
    else
        redirect_to :courses, :notice => "You are not eligible to check user information"
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to '/', notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if is_eligible
        @user.destroy

        respond_to do |format|
          format.html { redirect_to users_url }
          format.json { head :no_content }
        end
    else
        redirect_to :courses, :notice => "You are not eligible to check user information"
    end
  end

  private

  def is_eligible
      if User.exists?(params[:id])
          @user = User.find(params[:id]);
          if !existing_user || existing_user.id != @user.id
              false
          else
              true
          end
      else
          false
      end
  end
end
