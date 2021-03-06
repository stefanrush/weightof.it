# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  position   :integer          default(0), not null
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Category, type: :model do
  describe "respond to" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:position) }
    it { is_expected.to respond_to(:libraries) }
    it { is_expected.to respond_to(:active) }
  end

  describe "associations" do
    it { is_expected.to have_many(:libraries) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:position) }
  end

  it_behaves_like "Sluggable"
end
