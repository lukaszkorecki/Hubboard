
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: views/hubboard_views.xrc 
# Generated at: Sun Dec 19 16:32:49 +0000 2010

class MainFrame < Wx::Frame
	
	attr_reader :main_toolbar, :refresh_tool, :see_on_gh_tool,
              :preferences_tool, :m_splitter1, :m_panel2, :title_list,
              :m_panel3, :event_icon, :title_label, :event_content,
              :published_label, :gh_visit_link, :details_html,
              :user_avatar, :status_bar
	
	def initialize(parent = nil)
		super()
		xml = Wx::XmlResource.get
		xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
		xml.init_all_handlers
		xml.load("views/hubboard_views.xrc")
		xml.load_frame_subclass(self, parent, "main_frame")

		finder = lambda do | x | 
			int_id = Wx::xrcid(x)
			begin
				Wx::Window.find_window_by_id(int_id, self) || int_id
			# Temporary hack to work around regression in 1.9.2; remove
			# begin/rescue clause in later versions
			rescue RuntimeError
				int_id
			end
		end
		
		@main_toolbar = finder.call("main_toolbar")
		@refresh_tool = finder.call("refresh_tool")
		@see_on_gh_tool = finder.call("see_on_gh_tool")
		@preferences_tool = finder.call("preferences_tool")
		@m_splitter1 = finder.call("m_splitter1")
		@m_panel2 = finder.call("m_panel2")
		@title_list = finder.call("title_list")
		@m_panel3 = finder.call("m_panel3")
		@event_icon = finder.call("event_icon")
		@title_label = finder.call("title_label")
		@event_content = finder.call("event_content")
		@published_label = finder.call("published_label")
		@gh_visit_link = finder.call("gh_visit_link")
		@details_html = finder.call("details_html")
		@user_avatar = finder.call("user_avatar")
		@status_bar = finder.call("status_bar")
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: views/hubboard_views.xrc 
# Generated at: Sun Dec 19 16:32:49 +0000 2010

class NewGistFrame < Wx::Frame
	
	attr_reader :m_panel3, :m_textctrl1, :m_statictext3, :m_textctrl2,
              :m_statictext31, :m_textctrl21, :m_hyperlink1,
              :m_button1
	
	def initialize(parent = nil)
		super()
		xml = Wx::XmlResource.get
		xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
		xml.init_all_handlers
		xml.load("views/hubboard_views.xrc")
		xml.load_frame_subclass(self, parent, "NewGistFrame")

		finder = lambda do | x | 
			int_id = Wx::xrcid(x)
			begin
				Wx::Window.find_window_by_id(int_id, self) || int_id
			# Temporary hack to work around regression in 1.9.2; remove
			# begin/rescue clause in later versions
			rescue RuntimeError
				int_id
			end
		end
		
		@m_panel3 = finder.call("m_panel3")
		@m_textctrl1 = finder.call("m_textCtrl1")
		@m_statictext3 = finder.call("m_staticText3")
		@m_textctrl2 = finder.call("m_textCtrl2")
		@m_statictext31 = finder.call("m_staticText31")
		@m_textctrl21 = finder.call("m_textCtrl21")
		@m_hyperlink1 = finder.call("m_hyperlink1")
		@m_button1 = finder.call("m_button1")
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: views/hubboard_views.xrc 
# Generated at: Sun Dec 19 16:32:49 +0000 2010

class PrefrencesFrame < Wx::Frame
	
	attr_reader :m_panel5, :m_statictext7, :gh_username_text, :text2354,
              :gh_token_text, :apply_prefs_button
	
	def initialize(parent = nil)
		super()
		xml = Wx::XmlResource.get
		xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
		xml.init_all_handlers
		xml.load("views/hubboard_views.xrc")
		xml.load_frame_subclass(self, parent, "preferences_frame")

		finder = lambda do | x | 
			int_id = Wx::xrcid(x)
			begin
				Wx::Window.find_window_by_id(int_id, self) || int_id
			# Temporary hack to work around regression in 1.9.2; remove
			# begin/rescue clause in later versions
			rescue RuntimeError
				int_id
			end
		end
		
		@m_panel5 = finder.call("m_panel5")
		@m_statictext7 = finder.call("m_staticText7")
		@gh_username_text = finder.call("gh_username_text")
		@text2354 = finder.call("text2354")
		@gh_token_text = finder.call("gh_token_text")
		@apply_prefs_button = finder.call("apply_prefs_button")
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end


