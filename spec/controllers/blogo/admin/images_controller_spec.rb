require 'spec_helper'

describe Blogo::Admin::ImagesController do
  before do
    admin_login
  end

  # Remove uploads
  after do
    FileUtils.rm_rf File.join(Rails.application.root, 'public/blog')
  end

  def image_path(name)
    date_dir = Time.now.strftime('%Y/%m')
    File.join('/blog/images/', date_dir, name)
  end

  def image_file_path(name)
    date_dir = Time.now.strftime('%Y/%m')
    File.join(Rails.application.root, '/public/blog/images/', date_dir, name)
  end


  describe '#create' do
    it 'upload image' do
      upload_file = fixture_file_upload(fixture_image('ruby.png'))

      # First upload
      post :create, :upload => upload_file
      expect(response).to be_success
      expect(response).to render_template('create')
      expect(assigns(:image_path)).to eq image_path('ruby.png')
      expect(assigns(:error)).to be_nil

      uploaded_image = image_file_path('ruby.png')
      expect(File.read(uploaded_image)).to eq File.read(fixture_image('ruby.png'))

      # Second upload (image already exists)
      post :create, :upload => upload_file
      expect(response).to be_success
      expect(response).to render_template('create')
      expect(assigns(:error)).to eq 'Image with name "ruby.png" already exists'
    end
  end
end
