require_relative '../../config/application'
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags

  def self.list_posts
    posts = Post.order('updated_at DESC')
    posts.map do |post|
      [post.title, post.content, post.tags.pluck(:tag)]
    end
  end

  def self.add_post(id, title, content, *tags)
    # user_id = User.where("username = ?", username).pluck(:id)[0]
    post = Post.create(title: title, content: content, user_id: id)
    tags.each do |tag|
      post.tags << Tag.new(tag: tag)
    end
  end

end
