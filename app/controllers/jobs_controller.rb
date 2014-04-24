class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job }
      else
        format.html { render action: 'new' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    
    if !job_params[:predecessor_id].nil? && job_params[:predecessor_id]!=""
      @predecessor = Job.find(job_params[:predecessor_id])    
      @job.predecessor_id=@predecessor.id
      @predecessor.successor_id=@job.id
      @predecessor.save
    end

    if !job_params[:successor_id].nil? && job_params[:successor_id]!=""
      @successor = Job.find(job_params[:successor_id])
      @job.successor_id=@successor.id
      @successor.predecessor_id=@job.id
      @successor.save
    end

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  # => EMBA METHOD FOR THE EXERCISE
  #=================================
  def exercise_method

    # => All jobs
    @old = Job.all
    @jobs=Set.new
    @jobs=@old
    @result=Set.new
    # => let remove the singles, independent one
    @jobs.each do |f|      
      if f.predecessor_id.nil? && f.successor_id.nil?
        if @result.add?(f).nil?
          return 'Error 1'
        end
        @jobs.delete(f)
      end
      if f.predecessor_id==f.id || f.successor_id==f.id
        raise "#{f.inspect}"
        
        return 'Error 0'
      end
    end

    # => following successors
    @jobs.each do |f|
      if f.predecessor_id.nil?        
        loop do
          if @result.empty?
            @result.add(f)
          elsif @result.add?(f).nil?
            return 'Error 2'
          end
          @jobs.delete(f)
          if !f.successor_id.nil?
            f = Job.find(f.successor_id)
          else
            f=nil
          end
          break if !f 
        end
      end
    end
    
    if @jobs.any?
      return 'Error 3'
    end
    return @result
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:name, :predecessor_id,:successor_id)
    end
    
end
