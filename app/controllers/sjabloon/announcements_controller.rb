  class Sjabloon::AnnouncementsController < ApplicationController
  before_action :mark_all_as_read, if: :user_signed_in?
  before_action :set_announcement, only: [:edit, :update, :destroy]
  before_action :redirect_to_route_not_found, unless: :user_is_admin?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @announcements = Sjabloon::Announcement.order(published_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @announcements.limit(3) }
    end
  end

  def new
    @announcement = Sjabloon::Announcement.new
  end

  def create
    @announcement = Sjabloon::Announcement.new(announcement_params)
    @announcement.user = current_user

    if @announcement.save!
      redirect_to announcements_path, notice: "Created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @announcement.update!(announcement_params)
      redirect_to announcements_path, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy!

    redirect_to announcements_path, notice: "Removed"
  end

  private

  def mark_all_as_read
    current_user.update!(last_announcement_read_at: Time.current)
  end

  def redirect_to_route_not_found
    raise ActionController::RoutingError, "Not Found"
  end

  def user_is_admin?
    current_user&.admin?
  end

  def announcement_params
    params.require(:sjabloon_announcement).permit(
      :title,
      :body,
      :announcement_type,
      :show_site_wide,
      :target,
      :published_at
    )
  end

  def set_announcement
    @announcement = Sjabloon::Announcement.find(params[:id])
  end
end

