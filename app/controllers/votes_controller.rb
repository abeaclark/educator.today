class VotesController < ApplicationController


  def create
    return render plain: 'login' unless current_user

    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
    update_post

    if @vote.save
      render plain: '200'
    else
      render plain: '300'
    end
  end

  def destroy
    @vote = Vote.find_by(user_id: current_user.id, post_id: params[:post_id])
    @vote.destroy
    render plain: '200'
  end

  private

    def update_post
      post = @vote.post
      post.upvotes += 1
      post.save
    end


    def vote_params
      params.permit(:post_id)
    end

end
