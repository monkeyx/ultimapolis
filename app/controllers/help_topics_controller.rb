class HelpTopicsController < ApplicationController
  before_action :set_help_topic, only: [:show]

  # GET /help_topics
  # GET /help_topics.json
  def index
    @breadcrumbs = [["Home", root_url], ["Help","/help_topics"]]
    @help_topics = HelpTopic.all
  end

  # GET /help_topics/1
  # GET /help_topics/1.json
  def show
    @breadcrumbs = [["Home", root_url], ["Help","/help_topics"], [@help_topic.to_s, "/help_topics/#{@help_topic.id}"]]
    @commentable = @help_topic
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help_topic
      @help_topic = HelpTopic.find(params[:id])
    end
end
