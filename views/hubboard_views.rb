
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: views/hubboard_views.xrc 
# Generated at: Sun Oct 10 15:15:02 +0100 2010

class MainFrame < Wx::Frame
	
	attr_reader :user_panel, :user_avatar, :user_name, :settings_button,
              :timeline_tabs, :dashboard_panel, :m_statictext2,
              :own_panel, :m_statictext3, :gist_panel, :m_statictext4
	
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
		
		@user_panel = finder.call("user_panel")
		@user_avatar = finder.call("user_avatar")
		@user_name = finder.call("user_name")
		@settings_button = finder.call("settings_button")
		@timeline_tabs = finder.call("timeline_tabs")
		@dashboard_panel = finder.call("dashboard_panel")
		@m_statictext2 = finder.call("m_staticText2")
		@own_panel = finder.call("own_panel")
		@m_statictext3 = finder.call("m_staticText3")
		@gist_panel = finder.call("gist_panel")
		@m_statictext4 = finder.call("m_staticText4")
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end

