require "application_system_test_case"

class IssuesTest < ApplicationSystemTestCase
  setup do
    @issue = issues(:one)
  end

  test "visiting the index" do
    visit issues_url
    assert_selector "h1", text: "Issues"
  end

  test "creating a Issue" do
    visit issues_url
    click_on "New Issue"

    fill_in "Asignee", with: @issue.asignee
    fill_in "Created", with: @issue.created
    fill_in "Creator", with: @issue.creator
    fill_in "Description", with: @issue.description
    fill_in "Priority", with: @issue.priority
    fill_in "Status", with: @issue.status
    fill_in "Title", with: @issue.title
    fill_in "Type", with: @issue.type
    fill_in "Updated", with: @issue.updated
    fill_in "Vote", with: @issue.vote
    fill_in "Watch", with: @issue.watch
    click_on "Create Issue"

    assert_text "Issue was successfully created"
    click_on "Back"
  end

  test "updating a Issue" do
    visit issues_url
    click_on "Edit", match: :first

    fill_in "Asignee", with: @issue.asignee
    fill_in "Created", with: @issue.created
    fill_in "Creator", with: @issue.creator
    fill_in "Description", with: @issue.description
    fill_in "Priority", with: @issue.priority
    fill_in "Status", with: @issue.status
    fill_in "Title", with: @issue.title
    fill_in "Type", with: @issue.type
    fill_in "Updated", with: @issue.updated
    fill_in "Vote", with: @issue.vote
    fill_in "Watch", with: @issue.watch
    click_on "Update Issue"

    assert_text "Issue was successfully updated"
    click_on "Back"
  end

  test "destroying a Issue" do
    visit issues_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Issue was successfully destroyed"
  end
end
