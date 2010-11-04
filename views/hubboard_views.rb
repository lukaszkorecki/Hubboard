
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: views/hubboard_views.xrc 
# Generated at: Thu Nov 04 23:21:08 +0000 2010

class MainFrame < Wx::Frame
	
	attr_reader :main_toolbar, :refresh_tool, :gist_new_tool,
              :gist_browser_tool, :user_tool, :user_panel,
              :user_avatar, :details_html, :timeline_scroller,
              :status_bar
	
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
		@gist_new_tool = finder.call("gist_new_tool")
		@gist_browser_tool = finder.call("gist_browser_tool")
		@user_tool = finder.call("user_tool")
		@user_panel = finder.call("user_panel")
		@user_avatar = finder.call("user_avatar")
		@details_html = finder.call("details_html")
		@timeline_scroller = finder.call("timeline_scroller")
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
# Generated at: Thu Nov 04 23:21:08 +0000 2010

class EventPanel < Wx::Panel
	
	attr_reader :event_icon, :title_label, :ghlink_button, :user_avatar,
              :contents_html, :published_label, :m_staticline1
	
	def initialize(parent = nil)
		super()
		xml = Wx::XmlResource.get
		xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
		xml.init_all_handlers
		xml.load("views/hubboard_views.xrc")
		xml.load_panel_subclass(self, parent, "event_panel")

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
		
		@event_icon = finder.call("event_icon")
		@title_label = finder.call("title_label")
		@ghlink_button = finder.call("ghlink_button")
		@user_avatar = finder.call("user_avatar")
		@contents_html = finder.call("contents_html")
		@published_label = finder.call("published_label")
		@m_staticline1 = finder.call("m_staticline1")
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
# Generated at: Thu Nov 04 23:21:08 +0000 2010

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


