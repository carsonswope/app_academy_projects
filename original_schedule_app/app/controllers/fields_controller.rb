class FieldsController < ApplicationController
  def index
    @fields = Field.all
  end

  def new
    @field = Field.new
  end

  def create
    @field = Field.new(field_params)
    @field.save
    redirect_to fields_path
  end

  def destroy
    Field.find(params[:id]).destroy
    redirect_to fields_path
  end

  def show
    @field = Field.find(params[:id])
  end

  private

    def field_params
      params.require(:field).permit(:name, :field_type)
    end
end
