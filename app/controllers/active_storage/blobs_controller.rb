class ActiveStorage::BlobsController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob

  def show
    expires_in ActiveStorage::Blob.service.url_expires_in

    if access_allowed?(@blob)
      redirect_to @blob.service_url(disposition: params[:disposition])
    else
      head :forbidden
    end
  end

  private
  def access_allowed?(blob)
    # サービスに応じたアクセス処理を記述する。

  end
end