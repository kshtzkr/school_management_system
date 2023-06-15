class BatchesController < ApplicationController
  before_action :set_batch, only: %i[ show edit update destroy ]

  # GET /batches or /batches.json
  def index
    @batches = Batch.all
  end

  # GET /batches/1 or /batches/1.json
  def show
  end

  # GET /batches/new
  def new
    @batch = Batch.new
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches or /batches.json
  def create
    @batch = Batch.new(batch_params)

    respond_to do |format|
      if @batch.save
        format.html { redirect_to batch_url(@batch), notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to batch_url(@batch), notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to batches_url, notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def link_student
    user = User.find_by(id: params[:user_id])
    @batch = Batch.find_by(id: params[:batch_id])
    linking = params[:linking] == 'true' ? true : false
    if user.present? && @batch.present?
      if linking
        if current_user.is_admin? || current_user.is_school_admin?
          user.user_batches.create(batch_id: @batch.id,is_approved: true, progress: 0)
        else
          user.user_batches.create(batch_id: @batch.id, progress: 0)
        end
        respond_to do |format|
          format.html { redirect_to batch_url(@batch), notice: "User has been successfully linked to batch." }
          format.json { render :show, status: :ok, location: @batch }
        end
      else
        linked_user = @batch.user_batches.find_by(user_id: user.id)
        linked_user.destroy if linked_user.present?
        respond_to do |format|
          format.html { redirect_to batch_url(@batch), notice: "User has been successfully Unlinked to batch." }
          format.json { render :show, status: :ok, location: @batch }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve_student_batch
    user_batch = UserBatch.find_by(batch_id: params[:batch_id],user_id: params[:user_id])
    if user_batch
      user_batch.update(is_approved: true)
      respond_to do |format|
        format.html { redirect_to batch_url(user_batch.batch), notice: "Student has been approved for the batch." }
        format.json { render :show, status: :ok, location: user_batch.batch }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: user_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def student_progress
    user_batch = UserBatch.find_by(batch_id: params[:batch_id],user_id: params[:user_id])
    if user_batch
      user_batch.update(progress: user_batch.progress+1)
      respond_to do |format|
        format.html { redirect_to batch_url(user_batch.batch), notice: "Your progress is increased by 1%." }
        format.json { render :show, status: :ok, location: user_batch.batch }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: user_batch.errors, status: :unprocessable_entity }
      end
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:name, :course_id)
    end
end
