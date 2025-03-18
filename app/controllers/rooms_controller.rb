class RoomsController < ApplicationController

  protect_from_forgery except: [:upload_photo]

  before_action :set_room, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
  before_action :default_image

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
      render :new
    end
  end
  def show
    @photo = @room.photo
    @i = 0
  end

  def listing
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
    new_params = room_params
    new_params = room_params.merge(active: true) if is_ready_room

    if @room.update(new_params)
      flash[:notice] = "保存しました。"
    else
      flash[:alert] = "問題が発生しました。"
    end
    redirect_back(fallback_location: request.referer)
  end

  def photo_upload
    @room = Room.find(params[:id])
    binding.pry
    if params[:room] && params[:room][:photo].present?
      if @room.photo.attach(params[:room][:photo])
        flash[:notice] = '写真を更新しました'
        redirect_to @room
      else
        flash[:alert] = '更新に失敗しました'
        render :photo_upload
      end
    else
      flash[:alert] = 'ファイルが選択されていません'
    end
  
    redirect_to @room
  end

  def default_image
    if !@room.photo.attached?
      @room.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_room.png')), filename: 'default_room.png', content_type: 'image/png')
    end
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
  end
  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active, :description, :photo)
  end

  def is_authorised
    redirect_to root_path, alert: "権限がありません。" unless current_user.id == @room.user_id
  end
  
  def is_ready_room
    !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.address.blank? &&!@room.photo.empty?
  end
  def is_conflict(start_date, end_date, room)
    check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
    check.size > 0? true : false
  end
  def current_room_params
    params.require(:room).permit(:photo)
  end


end
