class AddApplicationSupportStatuses < ActiveRecord::Migration
  
  def up
    ApplicationSupportStatus.create(:status => "The student will not meet E12 critieria")
    ApplicationSupportStatus.create(:status => "Does not attend this school")  
  end

  def down
    #FIXME: write the downgrade script
  end
end
