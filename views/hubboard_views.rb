
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: views/hubboard_views.xrc 
# Generated at: Sat Oct 16 23:03:57 +0100 2010

class MainFrame < Wx::Frame
	
	attr_reader :user_panel, :user_name, :user_avatar, :details_html,
              :timeline, :timeline_scroller, :timeline_contents
	
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
		@user_name = finder.call("user_name")
		@user_avatar = finder.call("user_avatar")
		@details_html = finder.call("details_html")
		@timeline = finder.call("timeline")
		@timeline_scroller = finder.call("timeline_scroller")
		@timeline_contents = finder.call("timeline_contents")
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
# Generated at: Sat Oct 16 23:03:57 +0100 2010

class EventPanel < Wx::Panel
	
	attr_reader :user_name, :user_avatar, :details_html
	
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
		
		@user_name = finder.call("user_name")
		@user_avatar = finder.call("user_avatar")
		@details_html = finder.call("details_html")
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end


