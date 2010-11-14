class HPreferencesFrame < PrefrencesFrame

  def on_init
    evt_button(@apply_prefs_button.get_id) do
      App.store_prefs
    end
  end

  def set_gh_settings username, token
    @gh_username_text.value = username
    @gh_token_text.value = token
  end
  def gh_settings
    data =  [
      @gh_username_text.value.strip.chomp,
      @gh_token_text.value.strip.chomp
    ]
    data = [false, false] if data.select { |el| el.empty? }.length > 0
    data
  end
end
