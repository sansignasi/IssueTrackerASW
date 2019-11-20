Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "633802704237-rffkpcckj1sg42tp1g02jppcl4jf2hak.apps.googleusercontent.com", "2MU4V10g-m6n1TtounVG2tzy"
end