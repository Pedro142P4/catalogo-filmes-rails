require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path

    assert_selector "h1", text: I18n.t("movies.index.title")
  end
  test "should not save movie without title" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
    user.save!

    movie = Movie.new(user: user)

    assert_not movie.save, "Saved the movie without a title"

    assert_includes movie.errors[:title], I18n.t("errors.messages.blank")
  end
end
