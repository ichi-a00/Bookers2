class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :search_room_id

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def search_room_id(user)
    unless user.id == current_user.id  #current_userと@userが一致していなければ
      currentRoomUser = RoomUser.where(user_id: current_user.id)  #current_userが既にルームに参加しているか判断
      receiveUser = RoomUser.where(user_id: user.id)  #他の@userがルームに参加しているか判断

      currentRoomUser.each do |cu|    #current_userが参加していルームを取り出す
        receiveUser.each do |u|    #@userが参加しているルームを取り出す
          if cu.room_id == u.room_id    #current_userと@userのルームが同じか判断(既にルームが作られているか)
            #@haveroom = true    #falseの時(同じじゃない時)の条件を記述するために変数に代入
            return cu.room_id   #ルームが共通しているcurrent_userと@userに対して変数を指定
            #binding.pry
          end
        end
      end
    end
    return nil
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :profile_image, :introduction])
  end
end
