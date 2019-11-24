class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@users = User.all.where(["name like ? or email like ?", "%#{params[:search]}%", "%#{params[:search]}%"])
	end
	def show
		@user = User.find(params[:id])
	end

end
