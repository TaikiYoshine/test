# frozen_string_literal: true

Rails.application.config.assets_manifest =
  (JSON.parse(File.read(Rails.root.join('dist', 'manifest.json'))) if File.exist?(Rails.root.join('dist', 'manifest.json')))
