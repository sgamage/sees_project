Recaptcha.configure do |config|
  config.public_key  = Rails.env == 'development' ? '6LdGJNQSAAAAAHKWchlcReSLIhm58mmWvre2WXi3': '6Lf8Q9QSAAAAAAvtw63K4b12ahw6DTOnaYt4GEIl'
  config.private_key = Rails.env == 'development' ? '6LdGJNQSAAAAACnYan5Irf0znuFjH4hKV1vi1Eh8' : '6Lf8Q9QSAAAAAMypqVrtgtOm_BA1Dwe-DThYwucR'
end