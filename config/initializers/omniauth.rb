# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
provider :twitter, "O17BkR1X6knWFntCLPGJ7JlR0", "LdtMZetLFlxJ4NMUiOCPsfP0O5XhmUyxhEVDFAWb5nQfIg0I5t"

end

def OmniAuth.login_path(provider)
    "/auth/#{provider}"
end
