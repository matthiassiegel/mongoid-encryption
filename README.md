# MongoidEncryption — store encrypted fields in Rails apps

A very basic implementation for Mongoid that allows database fields to be encrypted before they are saved, and automatically decrypted each time they are loaded by the app.

As privacy becomes more important online, it makes sense to encrypt sensitive information when stored in databases. If the database gets hacked, the information in it won't be very usable if encrypted well. In general encryption makes sense for text fields that are not used to query information, e.g. in a users table it won't make sense to encrypt the email field if users are being queried by their email address. However if user queries only ever happen by email address, it may be possible to encrypt fields like first name, last name, address etc.

The usefulness of this extension largely depends on the individual use case (who would have thought).


## How to use

Create two methods ```encrypt``` and ```decrypt``` somewhere in your app that handle the encryption and decryption of data:

    def encrypt(data)
      ...
    end

    def decrypt(encrypted_data)
      ...
    end

See gems like [Gibberish](https://github.com/mdp/gibberish) for easy encryption using AES and other algorithms.

Put ```mongoid_encryption.rb``` in the ```lib``` directory of your app. Edit the file and make sure the encrypt/decrypt methods point to your own methods.

Load the encryption module in every model that uses it:

    class User
      include Mongoid::Document
      include Mongoid::Timestamps::Short
      include MongoidEncryption
  
      ...
    end

Now, still in your model, you can name fields that should be encrypted like this:

    encrypts :first_name, :last_name

Done.

## Caveats

This has never been tested on apps with an already populated database, only apps that used the extension from the development stage. With existing data it will likely cause problems.

'Once you go black, you never go back.' - it's the same with this type of encryption. If you decide to store some fields in an encrypted fashion and later decide to remove the encryption from the model, of course the data in the database will still be encrypted and you need to figure out a manual way of decrypting it again.


## Copyright & License

Copyright (c) 2013 Matthias Siegel.
See [LICENSE](https://github.com/matthiassiegel/mongoid-encryption/tree/master/LICENSE.md) for details.