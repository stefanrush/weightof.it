class NotificationMailer < ApplicationMailer
  def new_contributions(admin)
    count         = Library.unapproved.count
    contributions = (count == 1) ? "contribution" : "contributions"
    subject       = "#{count} new #{contributions} to weightof.it!"
    
    mail(to: admin.email, subject: subject)
  end
end
