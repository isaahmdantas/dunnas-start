module FormErrorHelper
  def error_messages(resource)
    render('layouts/form_error', resource: resource)
  end
end
