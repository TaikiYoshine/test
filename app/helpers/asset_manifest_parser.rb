# frozen_string_literal: true

module AssetManifestParser
  def stylesheet_path(file_name)
    "/assets/stylesheets/#{manifest_stylesheets[file_name]}"
  end

  def javascript_path(file_name)
    "public/packs/javascripts/#{manifest_javascripts[file_name]}"
  end

  def image_path(file_name)
    "/assets/images/#{manifest_images[file_name]}"
  end

  private

  def manifest_javascripts
    manifest_file('javascripts')
  end

  def manifest_stylesheets
    manifest_file('stylesheets')
  end

  def manifest_images
    manifest_file('images')
  end

  def manifest_file(type)
    file = Rails.root.join('public', 'packs', type, 'manifest.json')
    File.exist?(file)? JSON.parse(File.read(file)) : {}
  end
end
