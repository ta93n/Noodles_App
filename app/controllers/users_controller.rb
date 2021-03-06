class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  ALLOWED_ATTRIBUTES = ["created_at desc", "created_at asc", "rate desc", "rate asc"].freeze

  def index
    @users = User.paginate(page: params[:page], per_page: 10).order(created_at: "ASC") # will_paginateではpagenateメソッドを使った結果が必要
  end

  def show
    @user = User.find(params[:id])
    @main_section_render = "show_posts"
    @posts = if params[:sort]
               validate_order_by(params[:sort])
               @user.posts.paginate(page: params[:page], per_page: 12).order(params[:sort])
             else
               @user.posts.paginate(page: params[:page], per_page: 12).recent
             end
    @selected_sort = params[:sort]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "あなたのメールアドレスにアカウント有効化のメールを送信しました。アカウントを有効にしてください。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  # @userは before_action :correct_user で定義済み
  def edit
    @test_user = @user if @user.email == 'test@test-user.com'
  end

  # @userは before_action :correct_user で定義済み
  def update
    if @user.email != 'test@test-user.com' && @user.update_attributes(user_params)
      flash[:success] = "アカウント情報が変更されました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントが削除されました。"
    redirect_to users_url
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 10)
    @title = "#{@user.name}がフォロー中"
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    @title = "#{@user.name}のフォロワー"
    render 'show_follow'
  end

  def likes
    @user = User.find(params[:id])
    @posts = @user.like_posts.paginate(page: params[:page], per_page: 12).order('likes.created_at desc') # いいねした投稿順に並び替え
    @main_section_render = "show_likes"
    respond_to do |format|
      format.html { render "show" }
      format.js
    end
  end

  private

    # params[:sort]で受け取った値に対してバリデーション
    # 事前に定めた属性名以外はエラーとする
    def validate_order_by(text)
      raise ArgumentError, "Attribute not allowed: #{text}" unless text.in?(ALLOWED_ATTRIBUTES)
    end

    # Strong Parameters
    # マスアサインメント (ユーザーが送信したデータをまるごとUser.newに渡す)の脆弱性を回避
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :image)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
