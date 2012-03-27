Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCLma-0002s7-13
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 04:05:12 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 26 Mar 2012 18:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123580818"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 26 Mar 2012 18:56:07 -0700
Received: from azsmsx602.amr.corp.intel.com (10.2.121.201) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 26 Mar 2012 18:56:07 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx602.amr.corp.intel.com (10.2.121.201) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 26 Mar 2012 18:56:07 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 27 Mar 2012 09:56:06 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 5/5] HOB: Splited configuration info of
	building log to a independently page from the log page
Thread-Index: AQHNCzzqzng4iJpN2U2Y//hvWWc3OJZ9Yr+w
Date: Tue, 27 Mar 2012 01:56:06 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFB25A@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332752084.git.limingx.l.an@intel.com>
	<356038d60e6b46c51719cdb6f626ce7b8121cc32.1332752084.git.limingx.l.an@intel.com>
In-Reply-To: <356038d60e6b46c51719cdb6f626ce7b8121cc32.1332752084.git.limingx.l.an@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] HOB: Splited configuration info of	building log to a independently page from the log page
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
X-List-Received-Date: Tue, 27 Mar 2012 02:05:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Liming An wrote on=A02012-03-26:

> Make the building log config information to a new page as request
>=20
> [YOCTO #2144]
>=20
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py |   10 ++++++++--
>  bitbake/lib/bb/ui/crumbs/runningbuild.py     |   26
>  ++++++++++++-------------- 2 files changed, 20 insertions(+), 16
>  deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py index c2f980f..362f63d
> 100755 --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py +++
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py @@ -60,8 +60,6 @@ class
> BuildDetailsPage (HobPage):
>=20
>          self.notebook =3D HobNotebook()
>          self.config_tv =3D BuildConfigurationTreeView()
> -        self.config_model =3D
> self.builder.handler.build.model.config_model() -      =20
> self.config_tv.set_model(self.config_model)
>          self.scrolled_view_config =3D gtk.ScrolledWindow ()
>          self.scrolled_view_config.set_policy(gtk.POLICY_NEVER,
>          gtk.POLICY_ALWAYS)
>          self.scrolled_view_config.add(self.config_tv) @@ -82,6 +80,7 @@
>          class BuildDetailsPage (HobPage):
>          self.scrolled_view_build.add(self.build_tv)
>          self.notebook.append_page(self.scrolled_view_build,
> gtk.Label("Log"))
>=20
> +        self.builder.handler.build.model.connect('update-config-info',
> self.update_config_model_cb)
>          self.builder.handler.build.model.connect_after("row-changed",
> self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(),
> self.build_tv)
>=20
>          self.button_box =3D gtk.HBox(False, 6)
> @@ -158,3 +157,10 @@ class BuildDetailsPage (HobPage):
>                  self.endpath =3D path
>                  if v_adj.value =3D=3D (v_adj.upper - v_adj.page_size): #
> check the gtk.adjustment position is at end boundary or not
>                      treeview.scroll_to_cell(path)
> + +    def update_config_model_cb(self, origin, msg): +        if msg
> and type(msg) =3D=3D str: +            import gobject +          =20
> config_model =3D gtk.ListStore(gobject.TYPE_STRING) +          =20
> config_model.append([msg]) +          =20
> self.config_tv.set_model(config_model) diff --git
> a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py index aecfadf..98cba79 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py +++
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py @@ -32,6 +32,11 @@ from
> bb.ui.crumbs.hobwidget import HobWarpCellRendererText,
> HobCellRendererPixbu
>  class RunningBuildModel (gtk.TreeStore):
>      (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON,
> COL_COLOR, COL_NUM_ACTIVE) =3D range(7)
>=20
> +    __gsignals__ =3D {
> +          'update-config-info' : (gobject.SIGNAL_RUN_LAST,
> +                               gobject.TYPE_NONE,
> +                               (gobject.TYPE_STRING,)),
> +    }
>      def __init__ (self):
>          gtk.TreeStore.__init__ (self,
>                                  gobject.TYPE_STRING, @@ -42,14 +47,6 @@
>                                  class RunningBuildModel
>                                  (gtk.TreeStore): gobject.TYPE_STRING,
>                                  gobject.TYPE_INT)
> -    def config_model_filter(self, model, it):
> -        msg =3D model.get(it, self.COL_MESSAGE)[0]
> -        if not msg or type(msg) !=3D str:
> -            return False
> -        if msg.startswith("\nOE Build Configuration:\n"):
> -            return True
> -        return False
> -
>      def failure_model_filter(self, model, it):
>          color =3D model.get(it, self.COL_COLOR)[0]
>          if not color:
> @@ -58,11 +55,6 @@ class RunningBuildModel (gtk.TreeStore):
>              return True
>          return False
> -    def config_model(self):
> -        model =3D self.filter_new()
> -        model.set_visible_func(self.config_model_filter)
> -        return model
> -
>      def failure_model(self):
>          model =3D self.filter_new()
>          model.set_visible_func(self.failure_model_filter)
> @@ -75,6 +67,8 @@ class RunningBuildModel (gtk.TreeStore):
>      def close_task_refresh(self):
>          self.foreach(self.foreach_cell_func, None)
> +    def update_configuration_info(self, msg):
> +        self.emit("update-config-info", msg)
>=20
>  class RunningBuild (gobject.GObject):
>      __gsignals__ =3D {
> @@ -138,6 +132,10 @@ class RunningBuild (gobject.GObject):
>              # mask the error message as it's not informative for the use=
r.
>              if event.msg.startswith("Execution of event handler
> 'run_buildstats' failed"):
>                  return
> +            # split the configuration info to a independent view page
> +            if event.msg.startswith("\nOE Build Configuration:\n"):
> +                self.model.update_configuration_info(event.msg)
> +                return
Still heavy? A better way we can do is to collect self.configuration from b=
uilder.py and show it on the build details screen when build starts.

>=20
>              if (event.levelno < logging.INFO or
>                  event.msg.startswith("Running task")):
> @@ -434,7 +432,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
>=20
>          # The message of the build.
>          self.message_renderer =3D HobWarpCellRendererText
> (col_number=3D0) -        self.message_column =3D gtk.TreeViewColumn
> ("Message", self.message_renderer, text=3DRunningBuildModel.COL_MESSAGE,
> background=3DRunningBuildModel.COL_COLOR) +        self.message_column =
=3D
> gtk.TreeViewColumn ("Message", self.message_renderer, text=3D0)
>          font =3D self.get_style().font_desc
>          font.set_size(pango.SCALE * 13)
>          self.message_renderer.set_property('font-desc', font)




