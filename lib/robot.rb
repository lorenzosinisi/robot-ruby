module Robot
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir[lib_path + "/robot/**/*.rb"].each { |file| require file }
