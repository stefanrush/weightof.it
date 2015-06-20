require 'clockwork'
require_relative './../config/boot'
require_relative './../config/environment'

module Clockwork
  every(1.day, 'notification.mailer.job', at: '08:00') do
    if Library.unapproved.count > 0
      Admin.notify.each do |admin|
        NotificationMailer.new_contributions(admin).deliver_now
      end
    end
  end
end
