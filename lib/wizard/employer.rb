module Wizard
  module Employer
    STEPS = %w(step1 step2 step3 step4).freeze

    class Base
      include ActiveModel::Model
      attr_accessor :employer

      delegate *::Employer.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :employer

      def initialize(employer_attributes)
        @employer = ::Employer.new(employer_attributes)
      end
    end

    class Step1 < Base
      validates :title, presence: true
      validates :name, presence: true
      validates :city, presence: true
    end

    class Step2 < Step1
      validates :state, presence: true
      validates :work_schedule, presence: true
    end

    class Step3 < Step2
      validates :diploma, presence: true
      validates :category, presence: true
    end

    class Step4 < Step3
      validates :responsibility, presence: true
      validates :requirement, presence: true
    end
  end
end
