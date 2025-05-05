# require 'rails_helper'

# RSpec.describe "   " do
#   context "when user deletes a message" do
#     it "removes the message from the view", js: true do
#       given_room_with_message
#       user_goes_home_page
#       user_sees_room_name
#       user_clicks_room_name
#       user_sees_message_in_room
#       user_sees_delete_button
#       user_clicks_delete_button
#       user_cannot_see_that_message_now
#     end
#   end

#   def given_room_with_message
#     @room = Room.create!(name: "Test Room")
#     @message = @room.messages.create!(content: "test")
#   end

#   def user_goes_home_page
#     visit rooms_path
#   end

#   def user_sees_room_name
#     expect(page).to have_content("Test Room")
#   end

#   def user_clicks_room_name
#     click_link "Test Room"
#   end

#   def user_sees_message_in_room
#     expect(page).to have_content("test")
#   end

#   def user_sees_delete_button
#     expect(page).to have_button("Delete")
#   end

#   def user_clicks_delete_button
#     click_button "Delete"
#   end

#   def user_cannot_see_that_message_now
#     expect(page).to have_no_content("test", wait: 5)
#   end
# end

require 'rails_helper'

RSpec.describe "User deletes a message", js: true do
  let(:room_name) { "Test Room" }


  context "when a room exists" do
    let!(:room) { Room.create!(name: room_name) }

    context "and user enters the room" do
      before do
        visit rooms_path
        click_link room_name
      end

      context "and the room has multiple messages" do
        let!(:message1) { room.messages.create!(content: "hello") }
        let!(:message2) { room.messages.create!(content: "delete me") }
        let!(:message3) { room.messages.create!(content: "delete me") }

        it "deletes only the specific message clicked" do
          expect(page).to have_content("hello")
          expect(page).to have_content("delete me", count: 2)

          within(all('.message', text: "delete me").first) do
            click_button "Delete"
          end

          expect(page).to have_content("delete me", count: 1)
          expect(page).to have_content("hello")
        end
      end
    end
  end
end
