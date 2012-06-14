unless defined? D22AdminConfig
  Dc2AdminConfig= c = YAML::load_file(File.join(Rails.root,"config/dc2-config.yaml"))['development']
end
