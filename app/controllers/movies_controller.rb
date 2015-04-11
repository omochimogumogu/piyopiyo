class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  before_action do
    @breadcrumbs = []
  end

  before_action only: [:show, :new, :edit] do
    @breadcrumbs << {title: "index", path: movies_path}
  end

  # GET /movies
  # GET /movies.json
  def index
    @breadcrumbs << {title: "index"}

    keyword = params[:search]
    if keyword.present?
      @movies = Movie.where(['title LIKE ?', "%#{keyword}%"])
    else
      @movies = Movie.all
      #@movies = Movie.all.order({:created_at => :desc})◀︎ちゃんと書くとこうなる（上は省略形）
    end
    @movies = @movies.order(created_at: :desc)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @breadcrumbs << {title: @movie.title}
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    @breadcrumbs << {title: "new"}
  end

  # GET /movies/1/edit
  def edit
    pp [:hohoghoe, params]
    @movie = Movie.find(params[:id])
    @breadcrumbs << {title: "edit"}
  end

  # POST /movies
  # POST /movies.json
  def create
    pp '======='
    pp params[:movie]
    pp '======='

    array = ['gokudou','miyazaki', nil, 'nakamura']
    p array[0]

    hash = {title: 'gokudou', director: 'miyazaki'}
    p hash[:title] #-> gokudou
    p hash[:director] #-> miyazaki


    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully recorded.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #def search
    #@movies=Movie.where("title like ?","%" + "トトロ" + "%")
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :original_title, :director, :rate)
      #movieに関するデータで、なおかつpermit()の中のデータだけをparamsとして使います
      #これをstrong paramaterといいます
    end

end
