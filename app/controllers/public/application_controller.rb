class Public::ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  #↑divise利用の機能(ユーザ登録、ログイン認証etcが使われる前に
  #configure_permitted_parametersメソッドが実行される)
  #このメソッドはdvise_parameter_sanitizer.permitを使うことでサインアップの際にユーザー名のデータ操作を許可している
  
  def after_sign_in_path_for(resource)
    post_images_path
  end
  
  def after_sign_out_path_for(resource)
    about_path
  end
  
  private
  
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end  
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
