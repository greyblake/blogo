module Blogo::Admin
  module BaseHelper
    def blogo_form_for(object, options = {}, &block)
      options[:builder] = Blogo::FormBuilder
      form_for(object, options, &block)
    end
  end
end
