class Attachment
  #http://railsforum.com/viewtopic.php?id=30382
  attr_accessor :file_name, :file_path
  
  def self.attachment_list(files, file_names)
    attachments = []
    count = 0
    if files
      files.each do |file|
        att = Attachment.new 
        att.file_name = file_names["#{count}"]
        att.file_path = file[1].original_filename
        attachments << att
        count += 1
      end
    end
    attachments
  end
  
end