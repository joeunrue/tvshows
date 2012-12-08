require 'test_helper'

class TorrentsControllerTest < ActionController::TestCase
  setup do
    @torrent = Fabricate(:torrent)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:torrents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create torrent" do
    assert_difference('Torrent.count') do
      post :create, torrent: { episode_id: @torrent.episode_id, file: @torrent.file, file_format: @torrent.file_format, filename: @torrent.filename, is_full_season: @torrent.is_full_season, is_nuked: @torrent.is_nuked }
    end

    assert_redirected_to torrent_path(assigns(:torrent))
  end

  test "should show torrent" do
    get :show, id: @torrent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @torrent
    assert_response :success
  end

  test "should update torrent" do
    put :update, id: @torrent, torrent: {
      episode_id: @torrent.episode_id,
      file: @torrent.file,
      file_format: @torrent.file_format,
      filename: @torrent.filename,
      is_full_season: @torrent.is_full_season,
      is_nuked: @torrent.is_nuked
    }
    assert_redirected_to torrent_path(assigns(:torrent))
  end

  test "should destroy torrent" do
    assert_difference('Torrent.count', -1) do
      delete :destroy, id: @torrent
    end

    assert_redirected_to torrents_path
  end
end
