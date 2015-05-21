# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  library_id :integer          not null
#  number     :string           not null
#  raw_url    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Version, type: :model do
  describe 'respond to' do
    it { is_expected.to respond_to(:library) }
    it { is_expected.to respond_to(:number) }
    it { is_expected.to respond_to(:raw_url) }
  end
  
  describe 'validation' do
    it { is_expected.to validate_presence_of(:library) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:raw_url) }
  end
end
