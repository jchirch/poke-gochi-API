class ErrorSerializer
  def self.format_general_error(exception, status_code)
    {
      message: "#{status_code}, Something went wrong",
      errors: exception.message.split(", ")
    }
  end

  def self.format_specific_error(exception, status_code)
    {
      message: "#{status_code}, Something went wrong",
      errors: exception
    }
  end
end