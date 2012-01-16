require 'yaml'

class AssetsOfflineController < ActionController::Base
  Mime::Type.register 'text/cache-manifest', :manifest

  def show
    # Load the configuration file and make it accessible to the template.
    config = YAML.load_file("#{Rails.root}/config/assets_offline.yml")
    @root = config[params[:id]]

    # Generate the checksum for the file.
    @key = generate_key()

    respond_to do |format|
      format.manifest
    end
  end

  private

  def generate_key
    if Rails.env.production?
      production_key
    else
      development_key
    end

  end

  def production_key
    #Invalidate production by updating the datetime stamp in the comment
    path = "#{Rails.root}/config/assets_offline.yml"
    Digest::SHA2.hexdigest(File.read(path)) if ::File.file?(path)
  end

  def development_key
    now = Time.now.to_i - Time.now.to_i % 5
    Digest::SHA2.hexdigest(now.to_s)
  end

end
