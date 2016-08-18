class EvaluationMailer < ApplicationMailer
  default from: "hr_evaluation@mmj.vn"
  layout 'mailer'

  def send_account_infor(staff)
    @staff = staff
    mail(
      to: 'tmhungbg@gmail.com',
      subject: 'HR Evaluation Account Information'
    )
  end
end
