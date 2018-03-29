class Api::V2::LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy]

  # GET /libraries
  # GET /libraries.json
  def index
    #currenbt user all libearies
    @libraries = current_user.libraries.all
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
  end

  # GET /libraries/new
  def new
    @user = current_user
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  #for creating library 
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to api_ver_library_path(id: @library.red_id), notice: 'Library was successfully created.' }
        format.json { render json: @library, status: :created }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  #for updating library
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to api_ver_library_path(id: @library.red_id), notice: 'Library was successfully updated.' }
        format.json { render json: @library, status: :ok }
      else
        format.html { render edit_api_ver_library_path(id: @library.red_id) }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
      #authorize @library
    @library.destroy
    respond_to do |format|
      format.html { redirect_to api_ver_libraries_path, notice: 'Library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      #for getting one library
      @library = Library.find_by_red_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:red_id, :purchased_on, :user_id, :description, :library_data)
    end
end
