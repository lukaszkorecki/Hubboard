class HPreferencesFrame < PrefrencesFrame

  # FIXME this should be decoupled
  # app.store_prefs should be set by the app class
  # not here
  def on_init
    store_prefs_proc = lambda do
      STDERR << 'Stored prefs'
      App.store_prefs
    end
    evt_button(@apply_prefs_button.get_id) {store_prefs_proc.call}
    evt_text_enter(@gh_username_text.get_id) {store_prefs_proc.call}
    evt_text_enter(@gh_token_text.get_id) {store_prefs_proc.call}
  end

  # sets values of text boxes in pref window
  def set_gh_settings username, token
    @gh_username_text.value = username
    @gh_token_text.value = token
  end

  # reads data from text boxes
  def gh_settings
    data =  [
      @gh_username_text.value.strip.chomp,
      @gh_token_text.value.strip.chomp
    ]
    data = [false, false] if data.select { |el| el.empty? }.length > 0
    data
  end
end
