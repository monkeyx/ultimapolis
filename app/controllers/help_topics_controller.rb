class HelpTopicsController < ApplicationController
  before_action :set_help_topic, only: [:show]

  # GET /help_topics
  # GET /help_topics.json
  def index
    @help_topics = HelpTopic.all
  end

  # GET /help_topics/1
  # GET /help_topics/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help_topic
      @help_topic = HelpTopic.find(params[:id])
    end
end
