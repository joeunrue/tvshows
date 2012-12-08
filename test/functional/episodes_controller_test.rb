require 'test_helper'

class EpisodesControllerTest < ActionController::TestCase
  setup do
    @show = Fabricate(:show)
    @episode = Fabricate(:episode, show: @show)
  end

  test "should get index" do
    get :index, show_id: @show
    assert_response :success
    assert_not_nil assigns(:episodes)
  end

  test "should get new" do
    get :new, show_id: @show
    assert_response :success
  end

  test "should create episode" do
    assert_difference('Episode.count') do
      post :create, episode: { title: @episode.title }, show_id: @show
    end

    assert_redirected_to show_episode_path(@show, assigns(:episode))
  end

  test "should show episode" do
    get :show, id: @episode, show_id: @show
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @episode, show_id: @show
    assert_response :success
  end

  test "should update episode" do
    put :update, id: @episode, episode: { title: @episode.title }, show_id: @show
    assert_redirected_to show_episode_path(@show, assigns(:episode))
  end

  test "should destroy episode" do
    assert_difference('Episode.count', -1) do
      delete :destroy, id: @episode, show_id: @show
    end

    assert_redirected_to episodes_path(@show)
  end
end
