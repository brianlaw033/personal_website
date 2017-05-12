class BotActionsController < ApplicationController
  def process_user_input
    @bot_action = BotAction.create(bot_action_params)
    if @bot_action.save
      @return_user_input = @bot_action.user_input
      computed_path = @bot_action.process_input(@return_user_input)
      @return_bot_response = @bot_action.bot_response
      #puts "nnCOMPUTED PATH: #{computed_path.inspect}nn"
      if computed_path.present?
        #redirection to computed_path
        render js: "window.location = '#{computed_path}'"
      end
    end
    respond_to do |format|
      format.js
    end
    if @return_bot_response == 'download'
      redirect_to "https://drive.google.com/uc?export=download&id=0B7G0FkLWmf8DWGFzVFlGRklLQm8"
    end
  end

private

def bot_action_params
    params.require(:bot_action).permit(:user_input)
  end
end
