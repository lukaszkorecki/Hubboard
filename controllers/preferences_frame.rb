class HPreferencesFrame < PrefrencesFrame

  def set_gh_settings username, token
    @gh_username_text.value = username
    @gh_token_text.value = token
  end
  def get_gh_settings
    return [
      @gh_token_text.value,
      @gh_token_text.value
    ]
  end
end
