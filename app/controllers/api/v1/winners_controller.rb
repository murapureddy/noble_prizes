class Api::V1::WinnersController < ApplicationController
  before_action :reading_json_data, only: [:index, :finding_year_and_category, :alphabetailc_order]


  #Search a Nobel prize winner by name
  def index
    @names = []
    if @data.present?
      if params[:search].present?
        @data["prizes"].group_by {|x| puts x["laureates"].group_by {|v| @names << x if v["firstname"] == params[:search]}}
      else
        @names = @data
      end
    end
    render :json => @names
  end


  #Show a list of all Winners in Alphabetical order (With year and category against the
  def alphabetailc_order
    @sorting_order = @data["prizes"].sort_by{|a| a["year"]}.group_by{|a| puts a["laureates"].sort_by{|k|  k["firstname"]}}
    #@sorting_order = @data["prizes"].sort_by { |a |  [a["year"],a["category"]] }.sort_by{|a|}
    render :json => @sorting_order
  end



  #Search Prize winner based on the year and category (Peace/Chemistry/Physics etc...)
  # Find out Nobel prize winner in a year input by him
  def finding_year_and_category
    @year = []
    if @data.present?
      if params[:year].present? && params[:category].present?
        #debugger
        @data["prizes"].group_by {|x| @year << x if (x["year"]==params[:year] && x["category"]==params[:category])}
      elsif params[:year].present?
        @data["prizes"].group_by {|x| @year << x if x["year"]==params[:year]}
      else
        @data["prizes"].group_by {|x|  @year << x if x["category"] == params[:category]}
      end
    end
    render :json => @year
  end

  def reading_json_data
    @data = JSON.parse(File.read("/home/sudarshan/sudarsha/railsprojects/winner_application/public/winners.json"))
  end


end
