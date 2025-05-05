require 'rails_helper'

RSpec.describe "User delete Message " do
  context "when user deletes a message" do
    it "removes the message from the view", js: true do
      given_room_with_message
      user_goes_home_page
      user_sees_room_name
      user_clicks_room_name
      user_sees_message_in_room
      user_sees_delete_button
      user_clicks_delete_button
      user_cannot_see_that_message_now
    end
  end

  def given_room_with_message
    @room = Room.create!(name: "Test Room")
    @message = @room.messages.create!(content: "test")
  end

  def user_goes_home_page
    visit rooms_path
  end

  def user_sees_room_name
    expect(page).to have_content("Test Room")
  end

  def user_clicks_room_name
    click_link "Test Room"
  end

  def user_sees_message_in_room
    expect(page).to have_content("test")
  end

  def user_sees_delete_button
    expect(page).to have_button("Delete")
  end

  def user_clicks_delete_button
    click_button "Delete"
  end

  def user_cannot_see_that_message_now
    expect(page).to have_no_content("test", wait: 5)
  end
end
