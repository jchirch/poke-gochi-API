class ErrorSerializer
  def self.format_error(exception, status_code)
    {
      message: "#{status_code}, result not found",
      errors: exception.message.split(", ")
    }
  end
end