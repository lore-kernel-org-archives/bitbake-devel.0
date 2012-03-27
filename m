Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCL4V-0002Ad-2w
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 03:19:39 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 26 Mar 2012 18:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="81895522"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 26 Mar 2012 18:10:34 -0700
Received: from azsmsx603.amr.corp.intel.com (10.2.161.23) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 26 Mar 2012 18:10:34 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx603.amr.corp.intel.com (10.2.161.23) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 26 Mar 2012 18:10:33 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 27 Mar 2012 09:10:32 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/5] Hob: add refresh icon as ui
	request in	building log
Thread-Index: AQHNCzzfiA1ucNY9fU6X0pdKDifvu5Z9VdYg
Date: Tue, 27 Mar 2012 01:10:31 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFB222@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332752084.git.limingx.l.an@intel.com>
	<5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
In-Reply-To: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] Hob: add refresh icon as ui request in	building log
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
X-List-Received-Date: Tue, 27 Mar 2012 01:19:39 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Liming An wrote on=A02012-03-26:

> add a refresh icon to indicator the running task, for avoid add more heav=
y to
> bitbake building process, increased the timer interval counter, and decre=
ased
> the refresh icon render size.
>=20
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobwidget.py    |  169
>  ++++++++++++++++++++++++++++++ bitbake/lib/bb/ui/crumbs/runningbuild.py
>  |   20 +++- 2 files changed, 185 insertions(+), 4 deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> b/bitbake/lib/bb/ui/crumbs/hobwidget.py index 8936f0a..ffdd551 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py +++
> b/bitbake/lib/bb/ui/crumbs/hobwidget.py @@ -57,6 +57,7 @@ class hic:
>      ICON_INDI_REMOVE_HOVER_FILE   =3D os.path.join(HOB_ICON_BASE_DIR,
>      ('indicators/remove-hover.png')) ICON_INDI_ADD_FILE            =3D
>      os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
>      ICON_INDI_ADD_HOVER_FILE      =3D
> os.path.join(HOB_ICON_BASE_DIR, ('indicators/add-hover.png'))
> +    ICON_INDI_REFRESH_FILE        =3D
> os.path.join(HOB_ICON_BASE_DIR, ('indicators/refresh.png'))
>=20
>  class hcc:
> @@ -793,3 +794,171 @@ class
> HobWarpCellRendererText(gtk.CellRendererText):
>          return adjwidth
>  gobject.type_register(HobWarpCellRendererText)
> + +class RefreshRuningController(gobject.GObject): +    def
> __init__(self, widget=3DNone, iter=3DNone): +      =20
> gobject.GObject.__init__(self) +        self.timeout_id =3D None +      =
=20
> self.current_angle_pos =3D 0.0 +        self.step_angle =3D 0.0 +      =20
> self.tree_headers_height =3D 0 +        self.running_cell_areas =3D [] + =
+ =20
>  def is_active(self): +        if self.timeout_id: +            return
> True +        else: +            return False + +    def reset(self): +=20
>       self.force_stop(True) +        self.current_angle_pos =3D 0.0 +    =
=20
>   self.timeout_id =3D None +        self.step_angle =3D 0.0 + +    '''
> time_iterval: (1~1000)ms, which will be as the basic interval count for
> timer +        init_usrdata: the current data which related the
> progress-bar will be at +        min_usrdata: the range of min of user
> data +        max_usrdata: the range of max of user data +        step:
> each step which you want to progress +        Note: the init_usrdata
> should in the range of from min to max, and max should > min +         =20
>   step should < (max - min) +    ''' +    def start_run(self,
> time_iterval, init_usrdata, min_usrdata, max_usrdata, step, tree): +   =20
>    if (not time_iterval) or (not max_usrdata): +            return +   =20
>    usr_range =3D (max_usrdata - min_usrdata) * 1.0 +      =20
> self.current_angle_pos =3D (init_usrdata * 1.0) / usr_range +      =20
> self.step_angle =3D (step * 1) / usr_range +        self.timeout_id =3D
> gobject.timeout_add(int(time_iterval), +      =20
> self.make_image_on_progressing_cb, tree) +      =20
> self.tree_headers_height =3D self.get_treeview_headers_height(tree) + +  =
=20
> def force_stop(self, after_hide_or_not=3DFalse): +        if
> self.timeout_id: +            gobject.source_remove(self.timeout_id) + =20
>          self.timeout_id =3D None +        if self.running_cell_areas: + =
=20
>          self.running_cell_areas =3D [] + +    def on_draw_cb(self,
> pixbuf, cr, x, y, img_width, img_height, do_refresh=3DTrue): +        if
> pixbuf: +            r =3D max(img_width/2, img_height/2) +          =20
> cr.translate(x + r, y + r) +            if do_refresh: +              =20
> cr.rotate(2 * math.pi * self.current_angle_pos) + +          =20
> cr.set_source_pixbuf(pixbuf, -img_width/2, -img_height/2) +          =20
> cr.paint() + +    def get_treeview_headers_height(self, tree): +      =20
> if tree and (tree.get_property("headers-visible") =3D=3D True): +        =
  =20
> height =3D tree.get_allocation().height -
> tree.get_bin_window().get_size()[1] +            return height + +     =20
>  return 0 + +    def make_image_on_progressing_cb(self, tree): +      =20
> self.current_angle_pos +=3D self.step_angle +        if
> (self.current_angle_pos >=3D 1): +            self.current_angle_pos =3D
> self.step_angle + +        for rect in self.running_cell_areas: +      =20
>     tree.queue_draw_area(rect.x, rect.y + self.tree_headers_height,
> rect.width, rect.height) + +        return True + +    def
> append_running_cell_area(self, cell_area): +        if cell_area and
> (cell_area not in self.running_cell_areas): +          =20
> self.running_cell_areas.append(cell_area) + +    def
> remove_running_cell_area(self, cell_area): +        if cell_area in
> self.running_cell_areas: +          =20
> self.running_cell_areas.remove(cell_area) +        if not
> self.running_cell_areas: +            self.reset() +
> +gobject.type_register(RefreshRuningController) + +class
> HobCellRendererPixbuf(gtk.CellRendererPixbuf): +    def __init__(self):
> +        gtk.CellRendererPixbuf.__init__(self) +        self.control =3D
> RefreshRuningController() +        # create default refrensh stock icon
> +        self.set_hob_icon_to_stock_icon(hic.ICON_INDI_REFERENCE_FILE,
> "task-refresh") + +    def set_hob_icon_to_stock_icon(self, file_path,
> stock_id=3D""): +        try: +            pixbuf =3D
> gtk.gdk.pixbuf_new_from_file(file_path) +        except Exception, e: +=20
>           return None + +        if pixbuf and stock_id and
> (gtk.icon_factory_lookup_default(stock_id) =3D=3D None): +          =20
> icon_factory =3D gtk.IconFactory() +            icon_factory.add_default(=
)
> +            icon_factory.add(stock_id, gtk.IconSet(pixbuf)) +         =20
>  gtk.stock_add([(stock_id, '_label', 0, 0, '')]) + +            return
> icon_factory.lookup(stock_id) + +        return None + +    def
> get_pixbuf_from_stock_icon(self, widget, stock_id=3D"",
> size=3Dgtk.ICON_SIZE_DIALOG): +        if widget and stock_id and
> gtk.icon_factory_lookup_default(stock_id): +            return
> widget.render_icon(stock_id, size) + +        return None + +    def
> set_icon_name_to_id(self, name): +        if name and type(name) =3D=3D s=
tr:
> +            if name.startswith("gtk") or name =3D=3D "task-refresh": +  =
  =20
>           stock_id =3D name +            else: +                stock_id =
=3D
> 'gtk-' + name + +        return stock_id + +    ''' render cell exactly,
> "icon-name" is priority +        if use the 'task-refresh' will make the
> pix animation +        if 'pix' will change the pixbuf for it from the
> pixbuf or image. +    ''' +    def do_render(self, window, tree,
> background_area,cell_area, expose_area, flags): +        if (not
> self.control) or (not tree): +            return + +        x, y, w, h =
=3D
> self.on_get_size(tree, cell_area) +        x +=3D cell_area.x +        y
> +=3D cell_area.y +        w -=3D 2 * self.get_property("xpad") +        h=
 -=3D
> 2 * self.get_property("ypad") + +        stock_id =3D "" +        if
> self.props.icon_name: +            stock_id =3D
> self.set_icon_name_to_id(self.props.icon_name) +        elif
> self.props.stock_id: +            stock_id =3D self.props.stock_id +     =
=20
>  elif self.props.pixbuf: +            pix =3D self.props.pixbuf +      =20
> else: +            return + +        if stock_id: +            pix =3D
> self.get_pixbuf_from_stock_icon(tree, stock_id, self.props.stock_size) +
>        if stock_id =3D=3D 'task-refresh': +          =20
> self.control.append_running_cell_area(cell_area) +            if
> self.control.is_active(): +                self.control.on_draw_cb(pix,
> window.cairo_create(), x, y, w, h, True) +            else: +          =20
>     self.control.start_run(200, 0, 0, 1000, 200, tree) +        else: +=20
>           self.control.remove_running_cell_area(cell_area) +          =20
> self.control.on_draw_cb(pix, window.cairo_create(), x, y, w, h, False) +
> +    def on_get_size(self, widget, cell_area): +        if
> self.props.icon_name or self.props.pixbuf or self.props.stock_id: +    =20
>       w, h =3D gtk.icon_size_lookup(self.props.stock_size) +          =20
> return 0, 0, w, h + +        return 0, 0, 0, 0 +
> +gobject.type_register(HobCellRendererPixbuf) diff --git
> a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py index 0f58e4e..aecfadf 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py +++
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py @@ -27,7 +27,7 @@ import
> urllib
>  import urllib2
>  import pango
>  from bb.ui.crumbs.hobcolor import HobColors
> -from bb.ui.crumbs.hobwidget import HobWarpCellRendererText +from
> bb.ui.crumbs.hobwidget import HobWarpCellRendererText,
> HobCellRendererPixbuf
>=20
>  class RunningBuildModel (gtk.TreeStore):
>      (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON,
> COL_COLOR, COL_NUM_ACTIVE) =3D range(7)
> @@ -68,6 +68,14 @@ class RunningBuildModel (gtk.TreeStore):
>          model.set_visible_func(self.failure_model_filter)
>          return model
> +    def foreach_cell_func(self, model, path, iter, usr_data=3DNone):
> +        if model.get_value(iter, self.COL_ICON) =3D=3D "task-refresh":
> +            model.set(iter, self.COL_ICON, "")
> +
> +    def close_task_refresh(self):
> +        self.foreach(self.foreach_cell_func, None)
> +
> +
>  class RunningBuild (gobject.GObject):
>      __gsignals__ =3D {
>            'build-started'   :  (gobject.SIGNAL_RUN_LAST,
> @@ -189,7 +197,7 @@ class RunningBuild (gobject.GObject):
>              # Because this parent package now has an active child mark
>              it as # such. # @todo if parent is already in error, don't
>              mark it green
> -            self.model.set(parent, self.model.COL_ICON, "gtk-execute",
> +            self.model.set(parent, self.model.COL_ICON, "task-refresh",
>                             self.model.COL_COLOR,
> HobColors.RUNNING)
>=20
>              # Add an entry in the model for this task
> @@ -197,7 +205,7 @@ class RunningBuild (gobject.GObject):
>                                              package,
>                                              task,
>                                              "Task: %s" % (task),
> -                                            "gtk-execute",
> +                                            "task-refresh",
>                                              HobColors.RUNNING,
>                                              0))
> @@ -284,6 +292,8 @@ class RunningBuild (gobject.GObject):
>              # Emit a generic "build-complete" signal for things wishing =
to
>              # handle when the build is finished
>              self.emit("build-complete")
> +            # reset the all cell's icon indicator
> +            self.model.close_task_refresh()
>              if pbar:
>                  pbar.set_text(event.msg)
> @@ -292,6 +302,8 @@ class RunningBuild (gobject.GObject):
>                  # If the command fails with an exit code we're done,
>                  emit the # generic signal for the UI to notify the user
>                  self.emit("build-complete")
> +                # reset the all cell's icon indicator
> +                self.model.close_task_refresh()
>=20
>          elif isinstance(event, bb.event.CacheLoadStarted) and pbar:
>              pbar.set_title("Loading cache")
> @@ -346,7 +358,7 @@ class RunningBuildTreeView (gtk.TreeView):
>          self.readonly =3D readonly
>         =20
>          # The icon that indicates whether we're building or failed.
> -        renderer =3D gtk.CellRendererPixbuf ()
> +        renderer =3D HobCellRendererPixbuf ()
This change will break goggle and puccho, because they are reusing RunningB=
uildTreeView.
I asked him to send another version of the patches.


>          col =3D gtk.TreeViewColumn ("Status", renderer)
>          col.add_attribute (renderer, "icon-name", 4)
>          self.append_column (col)




