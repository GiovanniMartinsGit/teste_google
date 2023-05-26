class ApplicationController < ActionController::Base
  before_action :authenticate_merchant!
  
  def configure_permitted_parameters
    # ...
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])

    # ...
  end

  def after_sign_in_path_for(resource)
    # Aqui você pode definir para onde o usuário será redirecionado após o login
    # Por exemplo, se você deseja redirecioná-lo para a página inicial dos comerciantes:
    super
  end
end
