# frozen_string_literal: true

module ApplicationHelper
  include AssetManifestParser

  # def assets_path(path)
  #  return "http://localhost:8080/#{path}" if Rails.env.development?
#
 #   manifest = Rails.application.config.assets_manifest
  #  path = manifest[path] if manifest && manifest[path].present?
   # "/dist/#{path}"
 # end

  def javascript_include_tag(url, options = {})
    url = javascript_path(url)
    super(url, options)
  end

  def stylesheet_link_tag(url, options = {})
    url = stylesheet_path(url)
    super(url, options)
  end

  def image_tag(url, options = {})
    url = image_path(url)
    super(url, options)
  end
end
