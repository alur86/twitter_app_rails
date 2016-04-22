class Twitt < ActiveRecord::Base

 validates_presence_of :message
 validates_length_of :message, :minimum => 10, :maximum => 140


 def twitter_params
      params.require(:user).permit(:message)
 end



end
