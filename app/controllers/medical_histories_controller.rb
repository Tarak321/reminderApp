class MedicalHistoriesController < ApplicationController
  before_action :set_medical_history, only: [:show, :edit, :update, :destroy]
  before_action :validate_user!, except: [:index, :new,:create, :edit, :update, :show, :get_for_self,:get_for_dependents, :get_self_and_dependents,:destroy]


  # GET /medical_histories
  # GET /medical_histories.json
  def index
    @medical_histories = MedicalHistory.all
  end

  # GET /medical_histories/1
  # GET /medical_histories/1.json
  def show
  end
  def get_for_self
    user_id = params[:user_id]

    # @medical_histories = MedicalHistory
    #       .where(user_id: user_id, dependent_id: nil)
    #       .where("( ? BETWEEN startdate AND enddate OR ? BETWEEN startdate AND enddate)", DateTime.now.to_date, DateTime.now.next_day.to_date)
    #       .order(:startdate, :asc)

    # for today
    @medical_histories = MedicalHistory
          .where(user_id: user_id, dependent_id: nil)
          .where("? BETWEEN start_date AND end_date", DateTime.now.to_date)
          .order(:start_date, :asc)

    # if no records for today, then get for tomorrow
    if @medical_histories.size == 0 
      @medical_histories = MedicalHistory
      .where(user_id: user_id, dependent_id: nil)
      .where("? BETWEEN startdate AND enddate",  DateTime.now.next_day.to_date)
      .order(:start_date, :asc) 
    end
    
          
    render json: @medical_histories
  end

  def get_for_dependents
    user_id = params[:user_id]
    # @medical_histories = MedicalHistory
    #             .where.not(dependent_id: nil)
    #             .where(user_id: user_id)

    # deps = User.find(user_id).dependents
    # p deps 

    @medical_histories = [];

    @medical_histories_today =  MedicalHistory
        .where.not(dependent_id: nil)
        .where(user_id: user_id)
        .where("? BETWEEN start_date AND end_date", DateTime.now.to_date)

        puts "******************"
    # byebug

    ids = []
    
    @medical_histories_today.all.map do |record|
      ids << record.dependent_id
    end

    @medical_history_tomorrow = MedicalHistory
      .where.not(dependent_id: nil)
      .where(user_id: user_id)
      .where("? BETWEEN start_date AND end_date",  DateTime.now.next_day.to_date)
      .where("dependent_id not in (?)", ids)
      .order(:start_date, :asc) 

    @medical_history_tomorrow = @medical_history_tomorrow || []
  
    @medical_histories = @medical_histories_today +  @medical_history_tomorrow

    render json: @medical_histories
  end

  def get_self_and_dependents
    user_id = params[:user_id]
    @medical_histories = MedicalHistory.where(user_id: user_id)

    render json: @medical_histories
  end

  # GET /medical_histories/new
  def new
    @medical_history = MedicalHistory.new
  end

  # GET /medical_histories/1/edit
  def edit
  end

  # POST /medical_histories
  # POST /medical_histories.json
  def create
    @medical_history = MedicalHistory.new(medical_history_params)

    respond_to do |format|
      if @medical_history.save
        format.html { redirect_to @medical_history, notice: 'Medical history was successfully created.' }
        format.json { render :show, status: :created, location: @medical_history }
      else
        format.html { render :new }
        format.json { render json: @medical_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medical_histories/1
  # PATCH/PUT /medical_histories/1.json
  def update
    respond_to do |format|
      if @medical_history.update(medical_history_params)
        format.html { redirect_to @medical_history, notice: 'Medical history was successfully updated.' }
        format.json { render :show, status: :ok, location: @medical_history }
      else
        format.html { render :edit }
        format.json { render json: @medical_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_histories/1
  # DELETE /medical_histories/1.json
  def destroy
    @medical_history.destroy
    respond_to do |format|
      format.html { redirect_to medical_histories_url, notice: 'Medical history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical_history
      @medical_history = MedicalHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medical_history_params
      params.require(:medical_history).permit(:illness, :drname, :medicine, :start_date, :end_date, :dosage_amount, :dosage_frequency, :dosage_time, :email_notify, :user_id, :dependent_id,:relation)
    end
end
