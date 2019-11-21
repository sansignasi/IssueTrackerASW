module IssuesHelper
  
  def issue_type(issue_type)
    if issue_type == "bug"
      content_tag :span, "#{issue_type}", class: "tag is-primary"
    elsif issue_type == "enhancement"
      content_tag :span, "#{issue_type}", class: "tag is-primary"
    elsif issue_type == "proposal"
      content_tag :span, "#{issue_type}", class: "tag is-primary"
    elsif issue_type == "task"
      content_tag :span, "#{issue_type}", class: "tag is-primary"
    else
      ""
    end
  end
  
  def issue_status(issue_status)
    if issue_status == "new"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "closed"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "wontfix"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "duplicate"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "invalid"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "on hold"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "resolved"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    elsif issue_status == "open"
      content_tag :span, "#{issue_status}", class: "tag is-primary"
    else
      ""
    end
  end
  
  def issue_priority(issue_priority)
    if issue_priority == "trivial"
      content_tag :span, "#{issue_priority}", class: "tag is-primary"
    elsif issue_priority == "minor"
      content_tag :span, "#{issue_priority}", class: "tag is-primary"
    elsif issue_priority == "major"
      content_tag :span, "#{issue_priority}", class: "tag is-primary"
    elsif issue_priority == "critical"
      content_tag :span, "#{issue_priority}", class: "tag is-primary"
    elsif issue_priority == "blocker"
      content_tag :span, "#{issue_priority}", class: "tag is-primary"
    end
  end
end