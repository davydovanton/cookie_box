module Web::Views::Home
  class Index
    include Web::View

    def auth_button
      if current_account.login
        link_to 'Logout', '/auth/logout'
      else
        link_to 'Login', '/auth/github'
      end
    end

    def extra_styles
      html.link rel: 'stylesheet', href: 'https://www.launchaco.com/static/AllTemplates.min.css'
    end
  end
end
