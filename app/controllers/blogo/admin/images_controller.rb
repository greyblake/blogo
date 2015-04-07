module Blogo::Admin
  # Handles image upload with CKeditor.
  class ImagesController < BaseController
    skip_before_action :verify_authenticity_token

    layout false

    # Directory in public with blog images
    IMAGE_DIRECTORY = 'system/blog/images'

    # POST /admin/images
    #
    # Upload image.
    def create
      upload_io = params[:upload]

      image_name = upload_io.original_filename
      file_path = Rails.root.join('public', image_directory, image_name)

      if File.exists?(file_path)
        @error = I18n.translate('blogo.admin.image_already_exists', image_name: image_name)
      else
        dir = File.dirname(file_path)
        FileUtils.mkdir_p(dir) unless File.exists?(dir)
        File.binwrite(file_path, upload_io.read)
      end

      @image_path = File.join('/', image_directory, image_name)
    end


    private

    # Image directory with year/month subdirectories.
    #
    # @return [String]
    def image_directory
      @image_directory ||= begin
        date_dir = Time.now.strftime('%Y/%m')
        File.join(IMAGE_DIRECTORY, date_dir)
      end
    end
  end
end
