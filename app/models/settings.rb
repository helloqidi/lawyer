##读取yml配置文件
class Settings < Settingslogic
  #不使用Rails.root, 是因为想在application.rb中使用Settings
  #source "#{Rails.root}/config/application.yml"
  yml_path = File.expand_path('../../../config/application.yml', __FILE__)
  source yml_path
  namespace Rails.env
  load! if Rails.env.development?
end
