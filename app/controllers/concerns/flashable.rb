module Flashable
  extend ActiveSupport::Concern

    def notice(options = {})
      flash = handle_flash_time_execution options[:now]
      return flash["notice"] = options[:custom] unless options[:custom].nil?
      return flash["notice"] = "Action succeeded!" if options[:basic]

      action = action_name == "destroy" ? "delete" : action_name
      resource = (options[:for] || controller_name.singularize).capitalize

      flash["notice"] = "#{resource} #{options[:with]} was successfully #{action}d!"
    end

    def alert(options = {})
      flash = handle_flash_time_execution options[:now]
      flash["alert"] = options[:custom] || "Something went wrong, please try again"
    end

    private

    def handle_flash_time_execution(msg)
      msg ? flash.now : flash
    end
end
