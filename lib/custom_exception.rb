# frozen_string_literal: true

class CustomException < StandardError
  attr_reader :details, :code, :redirect_path

  def initialize(message: 'Internal error server', details: '', code: 500, redirect_path: '/')
    super(message)
    @details = details
    @code = code
    @redirect_path = redirect_path
  end
end
