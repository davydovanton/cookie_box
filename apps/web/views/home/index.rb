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
  end
end
