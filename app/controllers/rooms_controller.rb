class RoomsController < ApplicationController

  protect_from_forgery except: [:upload_photo]

  before_action :set_room, except: [:index, :new, :create]
  before_action :is_ready_room, only: [:show, :listing, :edit]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
  
  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "保存しました。"
    else
      flash[:alert] = "問題が発生しました。"
      puts @room.errors.full_messages
      render "users/dashboard"
    end
  end
  def show
    @room = Room.find(params[:id]) 
  end

  def listing
    @room = Room.find(params[:id]) 
  end

  def pricing
  end

  def description
  end

  def amenities
  end

  def location
  end

  def update
    new_params = room_params.to_h

    new_params.delete(:photo) if new_params[:photo].is_a?(ActiveStorage::Attached::One)

    new_params[:price] ||= @room.price
    new_params[:listing_name] ||= @room.listing_name
    new_params[:address] ||= @room.address
  
    if @is_ready
      new_params[:active] = true
    end

    if @room.update(new_params)
      flash[:notice] = "更新しました。"
    else
      flash[:alert] = "問題が発生しました。"
    end
    redirect_back(fallback_location: request.referer)
  end

  def photo_upload
    @room = Room.find(params[:id])
    if params[:room] && params[:room][:photo].present?
      @room.photo.purge if @room.photo.attached?
      if @room.photo.attach(params[:room][:photo])
        flash[:notice] = '写真を更新しました'
      else
        flash[:alert] = '更新に失敗しました'
      end
    end
    render :photo_upload
  end

  def delete_photo
    @room = Room.find(params[:id])
    @room.photo.purge
    redirect_to photo_upload_room_path(@room)
  end


  def preload
    today = Date.today
    reservations = @room.reservations.where("start_date >= ? OR end_date >= ?", today, today)
    render json: reservations
  end
  #　予約 終了日のAJAX処理
  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    output = {
      conflict: is_conflict(start_date, end_date, @room)
    }
    render json: output
  end



  private

  def set_room
    @room = Room.find(params[:id])
     @room.active = false if @room.active.nil?
  end

  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active, :description)
  end

  def is_authorised
    redirect_to root_path, alert: "権限がありません。" unless current_user.id == @room.user_id
  end
  
  def is_ready_room
    @room = Room.find(params[:id]) 
    @is_ready = @room.active && @room.price.present? && @room.listing_name.present? && @room.address.present? && @room.photo.attached?
  end
  def is_conflict(start_date, end_date, room)
    check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
    check.size > 0? true : false
  end
  def current_room_params
    params.require(:room).permit(:photo)
  end

end

