class GroupMailer < ApplicationMailer
  def notice_event(group)
    @owner = group.owner
    mail to:      @owner.email,
         subject: 'ちゃんと送れてますか。'
  end
end
