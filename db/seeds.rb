#creating users
p "running seed .........."
user_password = 'welcome'
User.create(:email => 'student@example.com', :password => user_password, :password_confirmation => user_password)
User.create(:email => 'easprincipal@example.com', :password => user_password, :password_confirmation => user_password, :user_type => 'PRINCIPAL')
User.create(:email => 'noneasprincipal@example.com', :password => user_password, :password_confirmation => user_password, :user_type => 'PRINCIPAL')
User.create(:email => 'admin@example.com', :password => user_password, :password_confirmation => user_password, :user_type => 'ADMIN')

 
#creating states
State.create(:name => 'WA')
State.create(:name => 'NSW')
State.create(:name => 'WIC')
State.create(:name => 'SA')
State.create(:name => 'QLD')
State.create(:name => 'NT')

 
#adding faculty
Faculty.create(:name => 'Agriculture')
Faculty.create(:name => 'Arts')
Faculty.create(:name => 'Education')
Faculty.create(:name => 'Engineering')
Faculty.create(:name => 'Nursing')
Faculty.create(:name => 'Science')
Faculty.create(:name => 'Veterinary Science')
Faculty.create(:name => 'SCA')
Faculty.create(:name => 'Health Sciences')
  
 
  
#Adding the category
Category.create(:category_name => 'Study Skills')
Category.create(:category_name => 'Acadamic Skills')
Category.create(:category_name => 'Resilienace')
Category.create(:category_name => 'Preparedness for University')
Category.create(:category_name => 'Community/School participation')
 
#Adding question
Question.create(:category_id => Category.find_by_category_name('Study Skills').id, :question_text => 'Has well developed organisational skills')
Question.create(:category_id => Category.find_by_category_name('Study Skills').id, :question_text => 'Able to prioritise tasks in order of importance') 
Question.create(:category_id => Category.find_by_category_name('Study Skills').id, :question_text => 'Has time-management skills and can plan and meet deadlines')
Question.create(:category_id => Category.find_by_category_name('Study Skills').id, :question_text => 'Likes learning new things and actively seeks out information')

Question.create(:category_id => Category.find_by_category_name('Acadamic Skills').id, :question_text => 'Capacity for abstract thought and analysis')
Question.create(:category_id => Category.find_by_category_name('Acadamic Skills').id, :question_text => 'Able to research and synthesise text from several sources') 
Question.create(:category_id => Category.find_by_category_name('Acadamic Skills').id, :question_text => 'Able to organise ideas and articulate a position orally and in written form')
Question.create(:category_id => Category.find_by_category_name('Acadamic Skills').id, :question_text => 'Engages in class discussions and contributes and shares ideas')

Question.create(:category_id => Category.find_by_category_name('Resilienace').id, :question_text => 'Is committed to succeeding/able to persevere ')
Question.create(:category_id => Category.find_by_category_name('Resilienace').id, :question_text => 'Manages setbacks/ disappointments/ failures as opportunities to learn and develop') 
Question.create(:category_id => Category.find_by_category_name('Resilienace').id, :question_text => 'Able to solve problems independently in the first instance')


Question.create(:category_id => Category.find_by_category_name('Preparedness for University').id, :question_text => 'Is well suited to their selected course ')
Question.create(:category_id => Category.find_by_category_name('Preparedness for University').id, :question_text => 'I am confident in their ability to be able to study at a tertiary level ') 
Question.create(:category_id => Category.find_by_category_name('Preparedness for University').id, :question_text => 'Has motivation to achieve long-term goals')

Question.create(:category_id => Category.find_by_category_name('Community/School participation').id, :question_text => 'Has positively contributed to the school or wider community')


#Adding the category
Answer.create(:answer_text => 'Strongly agree')
Answer.create(:answer_text => 'Agree')
Answer.create(:answer_text => 'Uncertain')
Answer.create(:answer_text => ' Disagree')
Answer.create(:answer_text => 'strongly disagree')
#Answer.create(:answer_text => 'Not Applicable')

#Adding the Application status
ApplicationStatus.create(:status => 'Application Received')
ApplicationStatus.create(:status => 'Principal Application Received')
ApplicationStatus.create(:status => 'Short Listed Applicant')
ApplicationStatus.create(:status => 'Selected for Conditional Offer')
ApplicationStatus.create(:status => 'Applicant Accepts Conditional Offer')
ApplicationStatus.create(:status => 'ATAR')
ApplicationStatus.create(:status => 'Course UAC Requirement Number')
ApplicationStatus.create(:status => 'Subject Requirement met')
ApplicationStatus.create(:status => 'Financial Status Requirement Met')
ApplicationStatus.create(:status => 'Applying for L-SEC School or EAS')
ApplicationStatus.create(:status => 'Formal Offer')
ApplicationStatus.create(:status => 'Applicant Enrolled')


#adding courses
Course.create(:name => 'Science in Agriculture', :faculty_name => 'Agriculture', :course_code => '511001')
Course.create(:name => 'Environmental Systems', :faculty_name => 'Agriculture', :course_code => '511006')
Course.create(:name => 'Arts', :faculty_name => 'Arts', :course_code => '511200')
Course.create(:name => 'Education (Primary)', :faculty_name => 'Education', :course_code => '511600')
Course.create(:name => 'Engineering (Electrical)(Telecommunications, Electronics, Computer)', :faculty_name => 'Engineering', :course_code => '511750')
Course.create(:name => 'Nursing (Advanced Studies)', :faculty_name => 'Nursing', :course_code => '511925')
Course.create(:name => 'Liberal Arts and Science', :faculty_name => 'Science', :course_code => '512009')
Course.create(:name => 'Science', :faculty_name => 'Science', :course_code => '512040')
Course.create(:name => 'Animal and Veterinary Bioscience', :faculty_name => 'Veterinary Science', :course_code => '512105')
Course.create(:name => 'Visual Arts', :faculty_name => 'SCA', :course_code => '512200')
Course.create(:name => 'Occupational Therapy', :faculty_name => 'Health Sciences', :course_code => '512600')
Course.create(:name => 'Physiotherapy', :faculty_name => 'Health Sciences', :course_code => '512605')
Course.create(:name => 'Speech Pathology', :faculty_name => 'Health Sciences', :course_code => '512610')
Course.create(:name => 'MRS-Diagnostic Radiography', :faculty_name => 'Health Sciences', :course_code => '512625')
Course.create(:name => 'Exercise Physiology', :faculty_name => 'Health Sciences', :course_code => '512652')
Course.create(:name => 'Exercise and Sport Science', :faculty_name => 'Health Sciences', :course_code => '512655')

ApplicationSupportStatus.create(:status => "From my knoledge this student doesnot meet the E12 L-SEC eligibility criteria")
ApplicationSupportStatus.create(:status => "I believe it is unlikely the student will meet the E12 course criteria")
ApplicationSupportStatus.create(:status => "Does not attend this school")


