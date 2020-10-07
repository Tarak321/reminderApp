class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_user!, except: [:index, :new,:create, :edit, :update, :show]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
    ActiveStorage::Current.host = "http://localhost:4000"
    attachment_blob = ActiveStorage::Attachment.find_by(record_type: "User", record_id: @user.id)
    @direct_url=""
    if attachment_blob
      attachment_blob=attachment_blob.blob
      @direct_url = ActiveStorage::Blob.service.url(
        attachment_blob.key,
        expires_in: 20000,
        disposition: "attachment",
        filename: attachment_blob.filename,
        content_type: attachment_blob.content_type
      )
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        ActiveStorage::Current.host = "http://localhost:4000"
        attachment_blob = ActiveStorage::Attachment.find_by(record_type: "User", record_id: @user.id)
        @direct_url=""
        if attachment_blob
          attachment_blob=attachment_blob.blob
          @direct_url = ActiveStorage::Blob.service.url(
            attachment_blob.key,
            expires_in: 20000,
            disposition: "attachment",
            filename: attachment_blob.filename,
            content_type: attachment_blob.content_type
          )
        end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :email_address, :contact_number, :country, :date_of_birth,:blood_group,:weight,:height,:profile_image)
    end
end
