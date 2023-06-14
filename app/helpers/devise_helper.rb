

module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved', count: resource.errors.count,
                                                   resource: resource.class.model_name.human.downcase)

    html = <<-HTML
              <div class="alert alert-dismissible bg-primary d-flex flex-column flex-sm-row p-5 mb-10" role="alert">
                <span class="svg-icon svg-icon-2hx svg-icon-light me-4 mb-5 mb-sm-0">
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <rect opacity="0.3" x="2" y="2" width="20" height="20" rx="10" fill="currentColor"/>
                  <rect x="11" y="14" width="7" height="2" rx="1" transform="rotate(-90 11 14)" fill="currentColor"/>
                  <rect x="11" y="17" width="2" height="2" rx="1" transform="rotate(-90 11 17)" fill="currentColor"/>
                  </svg>
                </span>
                <div class="d-flex flex-column text-light pe-0 pe-sm-10">
                  <h4>#{sentence}</h4>
                  <ul id="list_error_devise">#{messages}</ul>
                </div>

                <button type="button" class="position-absolute position-sm-relative m-2 m-sm-0 top-0 end-0 btn btn-icon ms-sm-auto" data-bs-dismiss="alert">
                  <span class="svg-icon svg-icon-2x svg-icon-light">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path opacity="0.3" d="M6.7 19.4L5.3 18C4.9 17.6 4.9 17 5.3 16.6L16.6 5.3C17 4.9 17.6 4.9 18 5.3L19.4 6.7C19.8 7.1 19.8 7.7 19.4 8.1L8.1 19.4C7.8 19.8 7.1 19.8 6.7 19.4Z" fill="currentColor"/>
                      <path d="M19.5 18L18.1 19.4C17.7 19.8 17.1 19.8 16.7 19.4L5.40001 8.1C5.00001 7.7 5.00001 7.1 5.40001 6.7L6.80001 5.3C7.20001 4.9 7.80001 4.9 8.20001 5.3L19.5 16.6C19.9 16.9 19.9 17.6 19.5 18Z" fill="currentColor"/>
                    </svg>
                  </span>
                </button>
              </div>
    HTML
    html.html_safe
  end
end
