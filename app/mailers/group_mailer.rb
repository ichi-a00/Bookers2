class GroupMailer < ApplicationMailer
  def notice_event(group, title, body)
    @owner = group.owner
    @body = body
    mail to:      @owner.email,
         subject: title
  end
end
