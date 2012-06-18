module CommonContent
  class Engine < ::Rails::Engine
    config.to_prepare do
      ApplicationController.helper(ContentsHelper)
    end
  end
end
