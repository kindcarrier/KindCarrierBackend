class ApplicationInteractor < ActiveInteraction::Base
  set_callback :execute, :around, :catch_errors

  def run!
    run

    raise InteractionError.new(errors, @exception_backtrace) unless valid?

    result
  end

  def self.interactor(interactor, params = [])
    method_name = interactor.to_s.underscore
    define_method method_name do |defaults = {}|
      compose interactor, params.map { |p| [p, send(p)] }.to_h.symbolize_keys.merge(defaults)
    end
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.each do |key, value|
      errors.add(key, value)
    end
  rescue StandardError => e
    @exception_backtrace = e.backtrace
    errors.add(:base, e.message.presence || 'Undefined Error')
  end

  class InteractionError < StandardError
    attr_reader :errors, :message

    def initialize(errors, backtrace = nil)
      @message = errors.full_messages.first
      @errors = errors
      @backtrace = backtrace
    end

    def backtrace
      @backtrace || super
    end
  end
end
