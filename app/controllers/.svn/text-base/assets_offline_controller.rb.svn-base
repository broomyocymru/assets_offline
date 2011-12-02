require 'yaml'

class AssetsOfflineController < ActionController::Base

  def show
    config = YAML.load_file("#{Rails.root}/config/assets_offline.yml")
    root = config[params[:id]]

    body =  "# GENERATED USING ASSET_OFFLINE\n"
    body <<  "# Mode: #{Rails.env} \n"
    body << "# #{generate_key()} \n\n"

    body << "CACHE MANIFEST \n"
    # CACHE SECTION
    if !root["asset-cache"].blank? and root["asset-cache"].count() > 0
      root["asset-cache"].each do |asset_name|
        body << "#{view_context.asset_path(asset_name)}\n"
      end
    end
    if !root["cache"].blank? and root["cache"].count() > 0
      root["cache"].each do |asset_name|
        body << "#{asset_name}\n"
      end
    end
    body << "\n"

    # NETWORK SECTION
    body << "NETWORK:\n"
    body << "# Resources where a connection is required \n"
    if !root["asset-network"].blank? and root["asset-network"].count() > 0
      root["asset-network"].each do |asset_name|
        body << "#{view_context.asset_path(asset_name)}\n"
      end
    end
    if !root["network"].blank? and root["network"].count() > 0
      root["network"].each do |asset_name|
        body << "#{asset_name}\n"
      end
    end
    body << "\n"

    #FALLBACK SECTION
    body << "FALLBACK:\n"
    body << "# Resources where a connection is used if available \n"
    if !root["asset-fallback"].blank? and root["asset-fallback"].count() > 0
      root["asset-fallback"].each do |asset_name|
        asset_name_part = asset_name.split("#")
        body << "#{view_context.asset_path(asset_name_part[0].strip())} #{view_context.asset_path(asset_name_part[1].strip())}\n"
      end
    end
    if !root["fallback"].blank? and root["fallback"].count() > 0
      root["fallback"].each do |asset_name|
        asset_name_part = asset_name.split("#")
        body << "#{asset_name_part[0].strip()} #{asset_name_part[1].strip()}\n"
      end
    end
    body << "\n"

    headers['Content-Type'] = 'text/cache-manifest'
    render :text => body, :layout => false
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
