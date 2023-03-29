class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts = Post.where('title ILIKE ?', "%#{params[:term]}%") if params[:term]
    #@posts = Post.where('title ILIKE ?', "%#{params[:term]}%").or(Post.where("tags ->> 'name' = ?", "#{params[:term]}")) if params[:term]
    render json: serialize_posts(@posts)
  end

  def serialize_posts(posts)
    @posts.map do |post|
      {
        title: post.title,
        id: post.id,
        tags: post.tags.map { |tag| { name: tag.name } }
      }
    end
  end
end
