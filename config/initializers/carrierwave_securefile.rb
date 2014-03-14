CarrierWave::SecureFile.configure do |config|
  # if using anything except AES:   
  #config.cypher = ("Your cypher code here")[0..55]
  # Optional: specify the encrpytion_type.  This can be blowfish, rijndael, or gost.
  # config.encryption_type = "blowfish"

  # if using AES:
  config.encryption_type = :aes
  config.aes_key = ENV['AES_KEY']
  config.aes_iv = ENV['IV_KEY']
 end
