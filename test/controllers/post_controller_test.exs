defmodule IvanBloggo.PostControllerTest do
  use IvanBloggo.ConnCase

  alias IvanBloggo.Post
  @valid_params post: %{body: "some content", title: "some content"}
  @invalid_params post: %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  describe "#index" do
    it "renders the index template", %{conn: conn} do
      conn = get conn, post_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing posts"
    end
  end

  describe "#new" do
    it "renders the new template", %{conn: conn} do
      conn = get conn, post_path(conn, :new)
      assert html_response(conn, 200) =~ "New post"
    end
  end

  describe "#create" do
    context "with valid data" do
      it "redirects to the post show page", %{conn: conn} do
        conn = post conn, post_path(conn, :create), @valid_params
        assert redirected_to(conn) == post_path(conn, :index)
      end
    end

    context "with invalid data" do
      it "renders the new template", %{conn: conn} do
        conn = post conn, post_path(conn, :create), @invalid_params
        assert html_response(conn, 200) =~ "New post"
      end
    end
  end

  describe "#show" do
    it "renders the show template", %{conn: conn} do
      post = Repo.insert %Post{}
      conn = get conn, post_path(conn, :show, post)
      assert html_response(conn, 200) =~ "Show post"
    end
  end

  describe "#edit" do
    test "renders the edit template", %{conn: conn} do
      post = Repo.insert %Post{}
      conn = get conn, post_path(conn, :edit, post)
      assert html_response(conn, 200) =~ "Edit post"
    end
  end

  describe "#update" do
    context "with valid data" do
      it "redirects to the post show page", %{conn: conn} do
        post = Repo.insert %Post{}
        conn = put conn, post_path(conn, :update, post), @valid_params
        assert redirected_to(conn) == post_path(conn, :index)
      end
    end
    context "with invalid data" do
      it "renders the edit template", %{conn: conn} do
        post = Repo.insert %Post{}
        conn = put conn, post_path(conn, :update, post), @invalid_params
        assert html_response(conn, 200) =~ "Edit post"
      end
    end
  end

  describe "#destroy" do
    it "destroys the post and redirects to the index page", %{conn: conn} do
      post = Repo.insert %Post{}
      conn = delete conn, post_path(conn, :delete, post)
      assert redirected_to(conn) == post_path(conn, :index)
      refute Repo.get(Post, post.id)
    end
  end
end
