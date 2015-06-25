module ActivityLogs
  def create_activity_log action_name, class_name
    @activity = Activity.new
    @activity.action = action_name
    @activity.object = class_name
    @activity.description = "#{@activity.action} #{@activity.object}"
    @activity.save
  end
end
