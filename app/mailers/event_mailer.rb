#require 'net/http'
class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @event = event
    @user_email = subscription.user_email
    @user_name = subscription.user_name

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  def photo(event, photo, email)
    @event = event
    @author_photo = photo.user.name
    @photo = photo.photo.to_s

    #для отправки фотографии как вложение:
    # if File.exist?('public' + @photo)
    #   @photo = 'public' + @photo
    #   attachments['photo'] = File.read(@photo)
    # else
    #   attachments['photo'] = Net::HTTP.get(URI(@photo))
    # end

    mail to: email, subject: "Новая фотография #{event.title}"
  end
end
