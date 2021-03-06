module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成される
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id # signed = 署名付きcookie/cookieをブラウザに保存する前に安全に暗号化する
    cookies.permanent[:remember_token] = user.remember_token # permanent = cookieを永続化させる
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id]) # (ユーザーIDにユーザーIDのセッションを代入した結果) ユーザーIDのセッションが存在すれば
      @current_user ||= User.find_by(id: user_id) # ユーザーIDが存在しない状態でfindを使うと例外が発生してしまうので、find.by()を使う
    elsif (user_id = cookies.signed[:user_id]) # signedで暗号化されたcookieを復号する
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token]) # ユーザーの記憶ダイジェストとcookiesの記憶トークンが一致するかの確認
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get? # GETリクエストが送られたURLをsession変数の:forwarding_urlキーに格納
  end
end
