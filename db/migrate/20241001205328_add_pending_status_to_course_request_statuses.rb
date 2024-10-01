class AddPendingStatusToCourseRequestStatuses < ActiveRecord::Migration[7.0]
  def up
    CourseRequestStatus.create(name: "pending", description: "Pending approval")
    CourseRequestStatus.create(name: "accepted", description: "Request accepted")
    CourseRequestStatus.create(name: "rejected", description: "Request rejected")
  end

  def down
    CourseRequestStatus.where(name: ["pending", "accepted", "rejected"]).destroy_all
  end
end