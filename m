Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCKcy-0001WO-Pn
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 02:51:13 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 26 Mar 2012 17:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123562159"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 26 Mar 2012 17:42:00 -0700
Received: from azsmsx602.amr.corp.intel.com (10.2.121.201) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 26 Mar 2012 17:41:58 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx602.amr.corp.intel.com (10.2.121.201) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 26 Mar 2012 17:41:55 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 27 Mar 2012 08:41:53 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] Hob: show (package,	task) pair
	which is being executed on the build details screen
Thread-Index: AQHNC1oweKYF9IUkeEqYmsbtbsu/C5Z9Tbdw
Date: Tue, 27 Mar 2012 00:41:53 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFB1DE@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332772309.git.shane.wang@intel.com>
	<f906c534c2b3a4dd4f3cc88cff189a17cb132a2e.1332772309.git.shane.wang@intel.com>
In-Reply-To: <f906c534c2b3a4dd4f3cc88cff189a17cb132a2e.1332772309.git.shane.wang@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] Hob: show (package, task) pair which is being executed on the build details screen
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
X-List-Received-Date: Tue, 27 Mar 2012 00:51:13 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I saw Josh had a patch pending to show (recipe, task) pair on http://git.yo=
ctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Djosh/hob&id=3D1840c40=
a77038d3e181830d4aba84a59273eccd1, which hasn't been submitted.
I am OK with his and skip my patch below.

--
Shane

Shane Wang wrote on=A02012-03-26:

> This patch is still for bug 2098 to provide clear information about the t=
ask
> and the package in progress.
>=20
> [Yocto #2098]
>=20
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py |   23
>  ++++++++++++++++------- bitbake/lib/bb/ui/crumbs/builder.py          |=20
>   12 +++++++++--- bitbake/lib/bb/ui/crumbs/runningbuild.py     |    7
>  +++++++ 3 files changed, 32 insertions(+), 10 deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py index c2f980f..1031906
> 100755 --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py +++
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py @@ -47,9 +47,12 @@ class
> BuildDetailsPage (HobPage):
>          self.vbox =3D gtk.VBox(False, 12)
>         =20
>          self.progress_box =3D gtk.VBox(False, 12)
> -        self.task_status =3D gtk.Label() -      =20
> self.task_status.set_alignment(0.0, 0.5) -      =20
> self.progress_box.pack_start(self.task_status, expand=3DFalse, fill=3DFal=
se)
> +        self.rq_status =3D gtk.Label() +      =20
> self.rq_status.set_alignment(0.0, 0.5) +        self.pt_status =3D
> gtk.Label() +        self.pt_status.set_alignment(0.0, 0.5) +      =20
> self.progress_box.pack_start(self.rq_status, expand=3DFalse, fill=3DFalse=
) +
>        self.progress_box.pack_start(self.pt_status, expand=3DFalse,
> fill=3DFalse)
>          self.progress_hbox =3D gtk.HBox(False, 6)
>          self.progress_box.pack_end(self.progress_hbox, expand=3DTrue,
>          fill=3DTrue) self.progress_bar =3D HobProgressBar() @@ -89,11
>          +92,17 @@ class BuildDetailsPage (HobPage):
>          self.back_button.connect("clicked",
>          self.back_button_clicked_cb)
>          self.button_box.pack_start(self.back_button, expand=3DFalse,
> fill=3DFalse)
>=20
> -    def update_build_status(self, tsk_msg):
> -        self.task_status.set_markup(tsk_msg)
> +    def update_runqueue_status(self, msg):
> +        self.rq_status.set_markup(msg)
>=20
> -    def reset_build_status(self):
> -        self.task_status.set_markup("")
> +    def update_package_task_status(self, msg):
> +        self.pt_status.set_markup(msg)
> +
> +    def reset_runqueue_status(self):
> +        self.rq_status.set_markup("")
> +
> +    def reset_package_task_status(self):
> +        self.pt_status.set_markup("")
>=20
>      def show_issues(self):
>          self.num_of_issues +=3D 1
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py
> b/bitbake/lib/bb/ui/crumbs/builder.py index f32a066..245a747 100755 ---
> a/bitbake/lib/bb/ui/crumbs/builder.py +++
> b/bitbake/lib/bb/ui/crumbs/builder.py @@ -218,6 +218,7 @@ class
> Builder(gtk.Window):
>          self.handler.build.connect("build-succeeded",
>          self.handler_build_succeeded_cb)
>          self.handler.build.connect("build-failed",
>          self.handler_build_failed_cb)
>          self.handler.build.connect("task-started",
> self.handler_task_started_cb)
> +        self.handler.build.connect("task-executing",
> self.handler_task_executing_cb)
>          self.handler.build.connect("log-error",
>          self.handler_build_failure_cb)
>          self.handler.connect("generating-data",
>          self.handler_generating_data_cb)
>          self.handler.connect("data-generated",
> self.handler_data_generated_cb)
> @@ -543,7 +544,8 @@ class Builder(gtk.Window):
>          elif self.current_step =3D=3D self.PACKAGE_GENERATING:
>              fraction =3D 0
>          self.build_details_page.update_progress_bar("Build Started: ",
> fraction)
> -        self.build_details_page.reset_build_status()
> +        self.build_details_page.reset_runqueue_status()
> +        self.build_details_page.reset_package_task_status()
>          self.build_details_page.reset_issues()
>      def build_succeeded(self):
> @@ -611,8 +613,12 @@ class Builder(gtk.Window):
>              elif message["eventname"] =3D=3D "runQueueTaskStarted":
>                  fraction =3D 0.2 + 0.8 * fraction
>          self.build_details_page.update_progress_bar(title + ": ", fracti=
on)
> -        self.build_details_page.update_build_status( -          =20
> "<span weight=3D\'bold\'>Running task %s of %s:</span> %s" %
> (message["current"], message["total"], message["task"])) +      =20
> self.build_details_page.update_runqueue_status( +            "<span
> weight=3D\'bold\'>Starting task %s of %s:</span> %s" %
> (message["current"], message["total"], message["task"])) + +    def
> handler_task_executing_cb(self, running_build, message): +      =20
> self.build_details_page.update_package_task_status( +            "<span
> weight=3D\'bold\'>Running task</span> %s <span weight=3D\'bold\'>on
> package</span> %s" % (message["task"], message["package"]))
>=20
>      def handler_build_failure_cb(self, running_build):
>          self.build_details_page.show_issues()
> diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py index 0f58e4e..e9d8070 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py +++
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py @@ -85,6 +85,9 @@ class
> RunningBuild (gobject.GObject):
>            'task-started'    :  (gobject.SIGNAL_RUN_LAST,
>                                  gobject.TYPE_NONE,
>                                 (gobject.TYPE_PYOBJECT,)),
> +          'task-executing'  :  (gobject.SIGNAL_RUN_LAST,
> +                                gobject.TYPE_NONE,
> +                               (gobject.TYPE_PYOBJECT,)),
>            'log-error'       :  (gobject.SIGNAL_RUN_LAST,
>                                  gobject.TYPE_NONE,
>                                 ()),
> @@ -208,6 +211,10 @@ class RunningBuild (gobject.GObject):
>              # Save out the iter so that we can find it when we have a
>              message # that we need to attach to a task.
>              self.tasks_to_iter[(package, task)] =3D i
> +            message =3D {}
> +            message["task"] =3D task
> +            message["package"] =3D package
> +            self.emit("task-executing", message)
>=20
>          elif isinstance(event, bb.build.TaskBase):
>              current =3D self.tasks_to_iter[(package, task)]



