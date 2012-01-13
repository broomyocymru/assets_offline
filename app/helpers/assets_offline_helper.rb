module AssetsOfflineHelper
  def cached_resources
    resources = Array.new
    if !root["asset-cache"].blank? and root["asset-cache"].count() > 0
      root["asset-cache"].each do |asset_name|
        resources << asset_path(asset_name) + "\n"
    end
    end
    if !root["cache"].blank? and root["cache"].count() > 0
      root["cache"].each do |asset_name|
        resources << asset_name + "\n"
      end
    end

    return resources
  end

  def network_resources
    resources = Array.new
    if !root["asset-network"].blank? and root["asset-network"].count() > 0
      root["asset-network"].each do |asset_name|
        resources << asset_path(asset_name) + "\n"
      end
    end
    if !root["network"].blank? and root["network"].count() > 0
      root["network"].each do |asset_name|
        resources << asset_name + "\n"
      end
    end

    return resources
  end

  def fallback_resources
    resources = Array.new
    if !root["asset-fallback"].blank? and root["asset-fallback"].count() > 0
      root["asset-fallback"].each do |asset_name|
        asset_name_part = asset_name.split("#")
        resources << asset_path(asset_name_part[0].strip()) + asset_path(asset_name_part[1].strip()) + "\n"
      end
    end
    if !root["fallback"].blank? and root["fallback"].count() > 0
      root["fallback"].each do |asset_name|
        asset_name_part = asset_name.split("#")
        resources << asset_name_part[0].strip() + asset_name_part[1].strip() + "\n"
      end
    end

    return resources
  end
end