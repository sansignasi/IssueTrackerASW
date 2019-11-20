module IssuesHelper
  
  def issue_type(issue_type)
    if issue_type == "bug"
      content_tag :span, "#{job_type}", class: "tag is-primary"
    elsif issue_type == "enhancement"
      content_tag :span, "#{job_type}", class: "tag is-primary"
    elsif issue_type == "proposal"
      content_tag :span, "#{job_type}", class: "tag is-primary"
    elsif issue_type == "task"
      content_tag :span, "#{job_type}", class: "tag is-primary"
    else
      ""
    end
  end
end