require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue = issues(:one)
  end

  test "should get index" do
    get issues_url
    assert_response :success
  end

  test "should get new" do
    get new_issue_url
    assert_response :success
  end

  test "should create issue" do
    assert_difference('Issue.count') do
<<<<<<< HEAD
      post issues_url, params: { issue: { asignee: @issue.asignee, created: @issue.created, creator: @issue.creator, description: @issue.description, priority: @issue.priority, status: @issue.status, title: @issue.title, type: @issue.type, updated: @issue.updated, vote: @issue.vote, watch: @issue.watch } }
=======
      post issues_url, params: { issue: { assigned: @issue.assigned, created: @issue.created, creator: @issue.creator, description: @issue.description, priority: @issue.priority, status: @issue.status, title: @issue.title, type: @issue.type, updated: @issue.updated, vote: @issue.vote, watch: @issue.watch } }
>>>>>>> dead917efe6133b59bc33d370aec9cc3284ad0a7
    end

    assert_redirected_to issue_url(Issue.last)
  end

  test "should show issue" do
    get issue_url(@issue)
    assert_response :success
  end

  test "should get edit" do
    get edit_issue_url(@issue)
    assert_response :success
  end

  test "should update issue" do
<<<<<<< HEAD
    patch issue_url(@issue), params: { issue: { asignee: @issue.asignee, created: @issue.created, creator: @issue.creator, description: @issue.description, priority: @issue.priority, status: @issue.status, title: @issue.title, type: @issue.type, updated: @issue.updated, vote: @issue.vote, watch: @issue.watch } }
=======
    patch issue_url(@issue), params: { issue: { assigned: @issue.assigned, created: @issue.created, creator: @issue.creator, description: @issue.description, priority: @issue.priority, status: @issue.status, title: @issue.title, type: @issue.type, updated: @issue.updated, vote: @issue.vote, watch: @issue.watch } }
>>>>>>> dead917efe6133b59bc33d370aec9cc3284ad0a7
    assert_redirected_to issue_url(@issue)
  end

  test "should destroy issue" do
    assert_difference('Issue.count', -1) do
      delete issue_url(@issue)
    end

    assert_redirected_to issues_url
  end
end
