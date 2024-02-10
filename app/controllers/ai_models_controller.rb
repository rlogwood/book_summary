class AiModelsController < ApplicationController
  def chatgpt_models
    @models = ChatGptModel.all
    respond_to do |format|
      format.json { render json: @models}
    end
  end
end
