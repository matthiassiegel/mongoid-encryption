# encoding: utf-8

module MongoidEncryption
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    def encrypts(*fields)
      set_callback :save, :before, lambda { |model| 
        fields.each { |field| model[field] = MyApp.encrypt(model[field]) unless model[field].blank? }
      }
      set_callback :save, :after, lambda { |model| 
        fields.each { |field| model[field] = MyApp.decrypt(model[field]) unless model[field].blank? }
      }
      set_callback :find, :after, lambda { |model| 
        fields.each { |field| model[field] = MyApp.decrypt(model[field]) unless model[field].blank? }
      }
    end
    
  end

end