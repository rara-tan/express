class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @partner = User.find(params[:partner_id])
    @message = current_user.messages.build(partner_id: params[:partner_id], content: message_params[:content])
    if @message.save
      flash[:success] = 'ダイレクトメッセージを送りました。'
      redirect_to message_path(@partner)
    else
      @messages = Message
                    .where(user_id: current_user.id, partner_id: @partner.id)
                    .or(Message.where(user_id: @partner.id, partner_id: current_user.id))
                    .order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'ダイレクトメッセージに失敗しました。'
      render 'messages/show'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @partner = User.find(@message.partner_id)
    @message.destroy
    flash[:success] = 'ダイレクトメッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def show
    @partner = User.find(params[:id])
    @message = current_user.messages.build
    @messages = Message
                  .where(user_id: current_user.id, partner_id: @partner.id)
                  .or(Message.where(user_id: @partner.id, partner_id: current_user.id))
                  .order('created_at DESC').page(params[:page])
  end
  
  private

  def message_params
    params.require(:message).permit(:content)
  end
  
  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_to root_url
    end
  end
end
