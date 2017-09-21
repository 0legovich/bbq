class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]

  # POST /comments
  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      notify_subscribers(@event, @new_comment)
      redirect_to @event, notice: t('controllers.comments.created')
    else
      render 'events/show', alert: t('controllers.comments.error')
    end
  end

  # DELETE /comments/1
  def destroy
    message = {notice: t('controllers.comments.destroyed')}

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {notice: t('controllers.comments.error')}
    end

    redirect_to @event, message
  end

  private
  def notify_subscribers(event, comment)
    event_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    event_emails -= [comment.user.email] if comment.user

    event_emails.each do |email|
      EventMailer.comment(event, comment, email).deliver_now
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
