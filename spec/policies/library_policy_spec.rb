require 'rails_helper'

RSpec.describe LibraryPolicy, type: :policy do
  subject { described_class }

  let(:my_group) { FactoryBot.create :group }
  let(:user) { FactoryBot.create :user, group: my_group }
  let(:my_group_library_1) { FactoryBot.create :library, group: my_group, owner: user }
  let(:my_group_library_2) { FactoryBot.create :library, group: my_group, owner: user }

  let(:other_guest_permitted_group) do
    group = FactoryBot.create :group
    Role.create!(group: group, user: user, role: :guest)
    group
  end
  let(:other_admin_permitted_group) do
    group = FactoryBot.create :group
    Role.create!(group: group, user: user, role: :admin)
    group
  end
  let(:other_owner_permitted_group) do
    group = FactoryBot.create :group
    Role.create!(group: group, user: user, role: :owner)
    group
  end
  let(:other_guest_permitted_group_user) { FactoryBot.create :user, group: other_guest_permitted_group }
  let(:other_admin_permitted_group_user) { FactoryBot.create :user, group: other_admin_permitted_group }
  let(:other_owner_permitted_group_user) { FactoryBot.create :user, group: other_owner_permitted_group }
  let(:other_guest_permitted_group_library) { FactoryBot.create :library, group: other_guest_permitted_group, owner: other_guest_permitted_group_user }
  let(:other_admin_permitted_group_library) { FactoryBot.create :library, group: other_admin_permitted_group, owner: other_admin_permitted_group_user }
  let(:other_owner_permitted_group_library) { FactoryBot.create :library, group: other_owner_permitted_group, owner: other_owner_permitted_group_user }

  let(:others_group) { FactoryBot.create :group }
  let(:others_group_user) { FactoryBot.create :user, group: others_group }
  let(:others_guest_invited_group_library) do
    library = FactoryBot.create :library, group: others_group, owner: others_group_user
    FactoryBot.create(:invitation, user: user, invited_by: others_group_user, library: library, role: :guest)
    library
  end
  let(:others_librarian_invited_group_library) do
    library = FactoryBot.create :library, group: others_group, owner: others_group_user
    FactoryBot.create(:invitation, user: user, invited_by: others_group_user, library: library, role: :librarian)
    library
  end
  let(:others_group_library) { FactoryBot.create :library, group: others_group, owner: others_group_user }

  describe ".scope" do
    subject { Pundit.policy_scope(user, Library) }

    before do
      my_group_library_1
      my_group_library_2
      other_guest_permitted_group_library
      other_admin_permitted_group_library
      other_owner_permitted_group_library
      others_guest_invited_group_library
      others_librarian_invited_group_library
      others_group_library
    end

    it do
      expect(subject).to include(
        my_group_library_1,
        my_group_library_2,
        other_guest_permitted_group_library,
        other_admin_permitted_group_library,
        other_owner_permitted_group_library,
        others_guest_invited_group_library,
        others_librarian_invited_group_library
      )
    end

    it { is_expected.not_to include(others_group_library) }
  end

  permissions :show? do

    context "with own group's library" do
      it { is_expected.to permit(user, my_group_library_1) }
    end

    context "with guest permitted group's library" do
      it { is_expected.to permit(user, other_guest_permitted_group_library) }
    end

    context "with admin permitted group's library" do
      it { is_expected.to permit(user, other_admin_permitted_group_library) }
    end

    context "with owner permitted group's library" do
      it { is_expected.to permit(user, other_owner_permitted_group_library) }
    end

    context "with guest invited library" do
      it { is_expected.to permit(user, others_guest_invited_group_library) }
    end
    
    context "with librarian invited library" do
      it { is_expected.to permit(user, others_librarian_invited_group_library) }
    end
    
    context "with unpermitted group's library" do
      it { is_expected.not_to permit(user, others_group_library) }
    end
  end

  permissions :create? do
    context "with own group's library" do
      let(:new_my_group_library) { FactoryBot.build :library, group: my_group, owner: user }

      it { is_expected.to permit(user, new_my_group_library) }
    end

    context "with guest permitted group's library" do
      let(:new_other_guest_permitted_group_library) { FactoryBot.build :library, group: other_guest_permitted_group, owner: other_guest_permitted_group_user }

      it { is_expected.not_to permit(user, new_other_guest_permitted_group_library) }
    end

    context "with admin permitted group's library" do
      let(:new_other_admin_permitted_group_library) { FactoryBot.build :library, group: other_admin_permitted_group, owner: other_admin_permitted_group_user }

      it { is_expected.to permit(user, new_other_admin_permitted_group_library) }
    end

    context "with owner permitted group's library" do
      let(:new_other_owner_permitted_group_library) { FactoryBot.build :library, group: other_owner_permitted_group, owner: other_owner_permitted_group_user }

      it { is_expected.to permit(user, new_other_owner_permitted_group_library) }
    end

    context "with other's unpermitted group's library" do
      let(:new_others_group_library) { FactoryBot.build :library, group: others_group, owner: others_group_user }

      it { is_expected.not_to permit(user, new_others_group_library) }
    end
  end

  permissions :update? do
    context "with own group's library" do
      it { is_expected.to permit(user, my_group_library_1) }
    end

    context "with guest permitted group's library" do
      it { is_expected.not_to permit(user, other_guest_permitted_group_library) }
    end

    context "with admin permitted group's library" do
      it { is_expected.to permit(user, other_admin_permitted_group_library) }
    end

    context "with owner permitted group's library" do
      it { is_expected.to permit(user, other_owner_permitted_group_library) }
    end

    context "with guest invited library" do
      it { is_expected.not_to permit(user, others_guest_invited_group_library) }
    end
    
    context "with librarian invited library" do
      it { is_expected.not_to permit(user, others_librarian_invited_group_library) }
    end
    
    context "with unpermitted group's library" do
      it { is_expected.not_to permit(user, others_group_library) }
    end
  end

  permissions :destroy? do
    context "with own group's library" do
      it { is_expected.to permit(user, my_group_library_1) }
    end

    context "with guest permitted group's library" do
      it { is_expected.not_to permit(user, other_guest_permitted_group_library) }
    end

    context "with admin permitted group's library" do
      it { is_expected.to permit(user, other_admin_permitted_group_library) }
    end

    context "with owner permitted group's library" do
      it { is_expected.to permit(user, other_owner_permitted_group_library) }
    end

    context "with guest invited library" do
      it { is_expected.not_to permit(user, others_guest_invited_group_library) }
    end
    
    context "with librarian invited library" do
      it { is_expected.not_to permit(user, others_librarian_invited_group_library) }
    end
    
    context "with unpermitted group's library" do
      it { is_expected.not_to permit(user, others_group_library) }
    end
  end
end
