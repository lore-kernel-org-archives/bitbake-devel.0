Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mWt-0007lX-RW
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:02:24 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Mar 2012 16:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141526379"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 16:53:31 -0700
Message-ID: <4F67C6FB.9040008@linux.intel.com>
Date: Mon, 19 Mar 2012 16:53:31 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<a3da790ea2d0b8119ecccc394c9817ddc68c68b8.1331910235.git.shane.wang@intel.com>
In-Reply-To: <a3da790ea2d0b8119ecccc394c9817ddc68c68b8.1331910235.git.shane.wang@intel.com>
Subject: Re: [PATCH 12/12] Hob: per UI design add refresh icon for building log
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 20 Mar 2012 00:02:24 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> From: Liming An<limingx.l.an@intel.com>
>
> To add the HobCellRendererPixbuf object which has the same feather as the gtk.CellRendererPixbuf and added the task-refresh stock icon which is an animation icon function.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py    |  193 ++++++++++++++++++++++++++++++
>   bitbake/lib/bb/ui/crumbs/runningbuild.py |   20 +++-
>   2 files changed, 208 insertions(+), 5 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index d4ee94e..fee9935 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -53,6 +53,7 @@ class hic:
>       ICON_INFO_HOVER_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('info/info_hover.png'))
>       ICON_INDI_CONFIRM_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/confirmation.png'))
>       ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/error.png'))
> +    ICON_INDI_REFERENCE_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('indicators/refresh.png'))
>
>   class hcc:
>
> @@ -687,3 +688,195 @@ class HobNotebook(gtk.VBox):
>           search.set_style(style)
>           search.set_text(self.search_name)
>           search.set_editable(False)
> +
> +class RefreshRuningController(gobject.GObject):
> +    __gsignals__ = {
> +            # emit when it completed a cycle
> +            "refresh-cycle-completed":(gobject.SIGNAL_RUN_LAST,
> +                                    gobject.TYPE_NONE,
> +                                    ()),
> +    }
> +    def __init__(self, widget=None, iter=None):
> +        gobject.GObject.__init__(self)
> +        self.timeout_id = None
> +        self.current_angle_pos = 0.0
> +        self.step_angle = 0.0
> +        self.alpha = 1.0
> +        self.tree_headers_height = 0
> +        self.running_cell_areas = []
> +
> +    def is_active(self):
> +        if self.timeout_id:
> +            return True
> +        else:
> +            return False
> +
> +    def reset(self):
> +        self.force_stop(True)
> +        self.current_angle_pos = 0.0
> +        self.timeout_id = None
> +        self.step_angle = 0.0
> +
> +    ''' time_iterval: (1~1000)ms, which will be as the basic interval count for timer
> +        init_usrdata: the current data which related the progress-bar will be at
> +        min_usrdata: the range of min of user data
> +        max_usrdata: the range of max of user data
> +        step: each step which you want to progress
> +        Note: the init_usrdata should in the range of from min to max, and max should>  min
> +             step should<  (max - min)
> +    '''
> +    def start_run(self, time_iterval, init_usrdata, min_usrdata, max_usrdata, step, tree):
> +        if (not time_iterval) or (not max_usrdata):
> +            return
> +        usr_range = (max_usrdata - min_usrdata) * 1.0
> +        self.current_angle_pos = (init_usrdata * 1.0) / usr_range
> +        self.step_angle = (step * 1) / usr_range
> +        self.timeout_id = gobject.timeout_add(int(time_iterval),
> +        self.make_image_on_progressing_cb, tree)
> +        self.tree_headers_height = self.get_treeview_headers_height(tree)
> +
> +    def force_stop(self, after_hide_or_not=False):
> +        if self.timeout_id:
> +            gobject.source_remove(self.timeout_id)
> +            self.timeout_id = None
> +        if self.running_cell_areas:
> +            self.running_cell_areas = []
> +
> +    def on_draw_cb(self, pixbuf, cr, x, y, img_width, img_height, do_refresh=True):
> +        if pixbuf:
> +            r = max(img_width/2, img_height/2)
> +            cr.translate(x + r, y + r)
> +            if do_refresh:
> +                cr.rotate(2 * math.pi * self.current_angle_pos)
> +                cr.set_source_pixbuf(pixbuf, -img_width/2, -img_height/2)
> +                # you can use the cr.paint() to replace cr.paint_with_alpha() when no need alpha
> +                # we needed to change the alpha with the speed of running,
> +                if self.current_angle_pos<  0.3:
> +                    self.alpha = 1.0 - self.step_angle
> +                else:
> +                    self.alpha = self.current_angle_pos
> +                cr.paint_with_alpha(self.alpha)
> +            else:
> +                cr.set_source_pixbuf(pixbuf, -img_width/2, -img_height/2)
> +                cr.paint()
> +
> +    def get_treeview_headers_height(self, tree):
> +        if tree and (tree.get_property("headers-visible") == True):
> +            height = tree.get_allocation().height - tree.get_bin_window().get_size()[1]
> +            return height
> +
> +        return 0
> +
> +    def make_image_on_progressing_cb(self, tree):
> +        self.current_angle_pos += self.step_angle
> +        if (self.current_angle_pos>= 1):
> +            self.current_angle_pos = self.step_angle
> +            self.emit("refresh-cycle-completed")
> +
> +        for rect in self.running_cell_areas:
> +            tree.queue_draw_area(rect.x, rect.y + self.tree_headers_height, rect.width, rect.height)
> +
> +        return True
> +
> +    def append_running_cell_area(self, cell_area):
> +        if cell_area and (cell_area not in self.running_cell_areas):
> +            self.running_cell_areas.append(cell_area)
> +
> +    def remove_running_cell_area(self, cell_area):
> +        if cell_area in self.running_cell_areas:
> +            self.running_cell_areas.remove(cell_area)
> +        if not self.running_cell_areas:
> +            self.reset()
> +
> +gobject.type_register(RefreshRuningController)
> +
> +class HobCellRendererPixbuf(gtk.GenericCellRenderer):
> +    __gproperties__ = {
> +       "icon-name": (gobject.TYPE_STRING, "setPixbufByStockName",
> +      "set icon by specified stock name, and add the refresh animation icon 'task-refresh'", "", gobject.PARAM_READWRITE),
> +       "stock-size": (gobject.TYPE_STRING, "setTheStockSize",
> +      "set ICON_SIZE as 'DIALOG','BUTTON', 'MENU', 'DND', 'LARGE_TOOLBAR','SMALL_TOOL_BAR'", "", gobject.PARAM_READWRITE),
> +    }
> +    def __init__(self):
> +        gtk.GenericCellRenderer.__init__(self)
> +        self.control = RefreshRuningController()
> +        self.cell_attr = {"icon-name":"", "stock-size":gtk.ICON_SIZE_DND}
> +        # create default refrensh stock icon
> +        self.set_pixbuf_to_stock_icon(self.create_default_pixbuf())

This is a very heavyweight way to implement this functionality and very 
specific to the specific use for the build log.

I have a patch which I've not yet submitted which adds a similar widget 
that's more generic and fewer lines of code:
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=josh/hob&id=3926d93f1fd04b476d5810d347d38e0dfc247c3d

class CellRendererPixbufActivatable(gtk.CellRendererPixbuf):
	"""
	A custom CellRenderer implementation which is activatable
	so that we can handle user clicks
	"""
	__gsignals__ = { 'clicked' : (gobject.SIGNAL_RUN_LAST,
					gobject.TYPE_NONE,
				       (gobject.TYPE_STRING,)), }

	def __init__(self):
		gtk.CellRendererPixbuf.__init__(self)
		self.set_property('mode',
				gtk.CELL_RENDERER_MODE_ACTIVATABLE)

	 """
	 Respond to a user click on a cell
	 """
	 def do_activate(self, even, widget, path, background_area, cell_area, 
flags):
		self.emit('clicked', path)

Would you be willing to hold this patch until I've submitted the generic 
implementation and then build atop that?

> +
> +    '''set property for exactly cell
> +    '''
> +    def do_set_property(self, pspec, value):
> +        self.cell_attr[pspec.name] = value
> +        if (pspec.name == "stock-size") and (value in [gtk.ICON_SIZE_BUTTON, gtk.ICON_SIZE_DND, \
> +                                                       gtk.ICON_SIZE_DIALOG, gtk.ICON_SIZE_LARGE_TOOLBAR, \
> +                                                       gtk.ICON_SIZE_MENU, gtk.ICON_SIZE_SMALL_TOOLBAR]):
> +            self.cell_attr["stock-size"] = value
> +
> +    def do_get_property(self, pspec):
> +        return self.cell_attr[pspec.name]
> +
> +    def reset(self):
> +        pass
> +
> +    def create_default_pixbuf(self):
> +        try:
> +            pixbuf = gtk.gdk.pixbuf_new_from_file(
> +                hic.ICON_INDI_REFERENCE_FILE
> +            )
> +        except Exception, e:
> +            print e.message
> +            self.reset()
> +            return None
> +        return pixbuf
> +
> +    def set_pixbuf_to_stock_icon(self, pixbuf=None, stock_id="task-refresh"):
> +        if pixbuf and stock_id and (gtk.icon_factory_lookup_default(stock_id) == None):
> +            icon_factory = gtk.IconFactory()
> +            icon_factory.add_default()
> +            icon_factory.add('task-refresh',gtk.IconSet(pixbuf))
> +            gtk.stock_add([('task-refresh', '_label', 0, 0, '')])
> +
> +            return icon_factory.lookup(stock_id)
> +
> +        return None
> +
> +    def get_pixbuf_from_stock_icon(self, widget, stock_id="", size=gtk.ICON_SIZE_DIALOG):
> +        if widget and stock_id and gtk.icon_factory_lookup_default(stock_id):
> +            return widget.render_icon(stock_id, size)
> +
> +        return None
> +
> +    ''' render cell exactly, "icon-name" is priority
> +        if use the 'task-refresh' will make the pix animation
> +        if 'pix' will change the pixbuf for it from the pixbuf or image.
> +    '''
> +    def on_render(self, window, tree, background_area,cell_area, expose_area, flags):
> +        if (not self.control) or (not tree):
> +            return
> +        x, y, w, h = self.on_get_size(tree, cell_area)
> +        x += cell_area.x
> +        y += cell_area.y
> +        w -= 2 * self.get_property("xpad")
> +        h -= 2 * self.get_property("ypad")
> +
> +        cairo_context = window.cairo_create()
> +
> +        stock_id = self.cell_attr["icon-name"]
> +        pix = self.get_pixbuf_from_stock_icon(tree, stock_id, self.cell_attr["stock-size"])
> +        if stock_id == 'task-refresh':
> +            self.control.append_running_cell_area(cell_area)
> +            if self.control.is_active():
> +                self.control.on_draw_cb(pix, cairo_context, x, y, w, h, True)
> +            else:
> +                self.control.start_run(100, 0, 0, 1000, 80, tree)
> +        else:
> +            self.control.remove_running_cell_area(cell_area)
> +            self.control.on_draw_cb(pix, cairo_context, x, y, w, h, False)
> +
> +    def on_get_size(self, widget, cell_area):
> +        if self.cell_attr["icon-name"]:
> +            w, h = gtk.icon_size_lookup(self.cell_attr["stock-size"])
> +            return 0, 0, w, h
> +
> +        return 0, 0, 0, 0
> diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> index d8af55c..534f30a 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> +++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> @@ -1,4 +1,3 @@
> -
>   #
>   # BitBake Graphical GTK User Interface
>   #
> @@ -27,6 +26,7 @@ import urllib
>   import urllib2
>   import pango
>   from bb.ui.crumbs.hobcolor import HobColors
> +from bb.ui.crumbs.hobwidget import HobCellRendererPixbuf
>
>   class RunningBuildModel (gtk.TreeStore):
>       (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = range(7)
> @@ -67,6 +67,13 @@ class RunningBuildModel (gtk.TreeStore):
>           model.set_visible_func(self.failure_model_filter)
>           return model
>
> +    def foreach_cell_func(self, model, path, iter, usr_data=None):
> +        if model.get_value(iter, self.COL_ICON) == "task-refresh":
> +            model.set(iter, self.COL_ICON, "")
> +
> +    def close_task_refresh(self):
> +        self.foreach(self.foreach_cell_func, None)
> +
>   class RunningBuild (gobject.GObject):
>       __gsignals__ = {
>             'build-started' : (gobject.SIGNAL_RUN_LAST,
> @@ -188,7 +195,7 @@ class RunningBuild (gobject.GObject):
>               # Because this parent package now has an active child mark it as
>               # such.
>               # @todo if parent is already in error, don't mark it green
> -            self.model.set(parent, self.model.COL_ICON, "gtk-execute",
> +            self.model.set(parent, self.model.COL_ICON, "task-refresh",
>                              self.model.COL_COLOR, HobColors.RUNNING)
>
>               # Add an entry in the model for this task
> @@ -196,7 +203,7 @@ class RunningBuild (gobject.GObject):
>                                               package,
>                                               task,
>                                               "Task: %s" % (task),
> -                                            "gtk-execute",
> +                                            "task-refresh",
>                                               HobColors.RUNNING,
>                                               0))
>
> @@ -283,6 +290,8 @@ class RunningBuild (gobject.GObject):
>               # Emit a generic "build-complete" signal for things wishing to
>               # handle when the build is finished
>               self.emit("build-complete")
> +            # reset the all cell's icon indicator
> +            self.model.close_task_refresh()
>               if pbar:
>                   pbar.set_text(event.msg)
>
> @@ -291,6 +300,8 @@ class RunningBuild (gobject.GObject):
>                   # If the command fails with an exit code we're done, emit the
>                   # generic signal for the UI to notify the user
>                   self.emit("build-complete")
> +                # reset the all cell's icon indicator
> +                self.model.close_task_refresh()
>
>           elif isinstance(event, bb.event.CacheLoadStarted) and pbar:
>               pbar.set_title("Loading cache")
> @@ -344,7 +355,7 @@ class RunningBuildTreeView (gtk.TreeView):
>           self.readonly = readonly
>
>           # The icon that indicates whether we're building or failed.
> -        renderer = gtk.CellRendererPixbuf ()
> +        renderer = HobCellRendererPixbuf ()
>           col = gtk.TreeViewColumn ("Status", renderer)
>           col.add_attribute (renderer, "icon-name", 4)
>           self.append_column (col)
> @@ -426,7 +437,6 @@ class BuildConfigurationTreeView(gtk.TreeView):
>           self.message_renderer.set_property('font-desc', font)
>           self.append_column (self.message_column)
>
> -
>   class BuildFailureTreeView(gtk.TreeView):
>
>       def __init__ (self):

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


