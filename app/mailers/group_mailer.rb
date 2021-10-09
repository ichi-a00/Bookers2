class GroupMailer < ApplicationMailer
  def notice_event(group, title, body)
    #インスタンス変数にしとけばメールの文章にも使えるぽい
    @owner = group.owner
    @groupname = group.name
    @body = body
    #タイトルはここでしかつかわん

    #binding.pry

    group.users.each do |gu|
      #mail でメール送る。
      @username = gu.name
      mail to:      gu.email,
           subject: title
    end

  end
end
