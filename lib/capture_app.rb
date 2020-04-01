
class AppNotFoundError < StandardError
end

class AppsNotFoundError < StandardError
end

# store a list of ui app configs, indexed by app id and by domain.
module AppList
  @apps_by_id     = {}


  def self.all_apps(reload_yaml = true)
    @apps_by_id.values.flatten.map { |app| CaptureApp.new app }
  end

  def self.find_by(app_id)
    app = @apps_by_id[app_id.to_i]
    if app.blank?
        raise AppNotFoundError
    end
    app
  end

  def self.create_app(products)
    next_app = all_apps().length
    app = nil
    if next_app == 0
        app = CaptureApp.new({id: 1, products: products, current_balance:0})
    else
        app = CaptureApp.new({id: next_app+1, products: products, current_balance:0})
    end
    @apps_by_id[next_app+1] = app
    app
  end
end

class CaptureApp < OpenStruct

  attr_accessor :capture

  def self.all_apps
    AppList.all_apps
  end

  def self.find_by(arg)
    app = AppList.find_by(arg)
    app
  end

  def self.create_app(vals)
    app = AppList.create_app(vals)
  end

end
