Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7WM7-0008Md-TL
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Mar 2012 19:21:56 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 13 Mar 2012 11:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="138191687"
Received: from unknown (HELO [10.255.15.212]) ([10.255.15.212])
	by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2012 11:12:44 -0700
Message-ID: <4F5F8E1C.9070403@linux.intel.com>
Date: Tue, 13 Mar 2012 11:12:44 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <a5a40bda286914ab82e99d22da1e39e63ccace31.1331558221.git.shane.wang@intel.com>
	<291c138d68bb9ae807842b03d43dd848684b7279.1331558221.git.shane.wang@intel.com>
In-Reply-To: <291c138d68bb9ae807842b03d43dd848684b7279.1331558221.git.shane.wang@intel.com>
Subject: Re: [PATCH 3/3] Hob: show indicators on the tabs of the Hob notebook
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
X-List-Received-Date: Tue, 13 Mar 2012 18:21:56 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/03/12 06:23, Shane Wang wrote:
> This patch is to show the indicators (e.g., the number of the issues) in the build details page to highlight.


My understanding of the design is that warnings are an "Issue" too, can 
we emit the signal for a warning too?

> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/builddetailspage.py |   10 ++++++++++
>   bitbake/lib/bb/ui/crumbs/builder.py          |    5 +++++
>   bitbake/lib/bb/ui/crumbs/hobwidget.py        |   14 ++++++++++++++
>   bitbake/lib/bb/ui/crumbs/runningbuild.py     |    4 ++++
>   4 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> index 8ebcf08..4a9f658 100755
> --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> +++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> @@ -37,6 +37,8 @@ class BuildDetailsPage (HobPage):
>       def __init__(self, builder):
>           super(BuildDetailsPage, self).__init__(builder, "Building ...")
>
> +        self.num_of_issues = 0
> +
>           # create visual elements
>           self.create_visual_elements()
>
> @@ -80,6 +82,14 @@ class BuildDetailsPage (HobPage):
>           self.back_button.connect("clicked", self.back_button_clicked_cb)
>           self.button_box.pack_start(self.back_button, expand=False, fill=False)
>
> +    def show_issues(self):
> +        self.num_of_issues += 1
> +        self.notebook.show_indicator_icon("Issues", self.num_of_issues)
> +
> +    def reset_issues(self):
> +        self.num_of_issues = 0
> +        self.notebook.hide_indicator_icon("Issues")
> +
>       def _remove_all_widget(self):
>           children = self.vbox.get_children() or []
>           for child in children:
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index a905030..be8abd9 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -212,6 +212,7 @@ class Builder(gtk.Window):
>           self.handler.build.connect("build-succeeded",    self.handler_build_succeeded_cb)
>           self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
>           self.handler.build.connect("task-started",       self.handler_task_started_cb)
> +        self.handler.build.connect("log-error",          self.handler_build_failure_cb)
>           self.handler.connect("generating-data",          self.handler_generating_data_cb)
>           self.handler.connect("data-generated",           self.handler_data_generated_cb)
>           self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
> @@ -518,6 +519,7 @@ class Builder(gtk.Window):
>           elif self.current_step == self.PACKAGE_GENERATING:
>               fraction = 0
>           self.build_details_page.update_progress_bar("Build Started: ", fraction)
> +        self.build_details_page.reset_issues()
>
>       def build_succeeded(self):
>           if self.current_step == self.FAST_IMAGE_GENERATING:
> @@ -585,6 +587,9 @@ class Builder(gtk.Window):
>                   fraction = 0.2 + 0.8 * fraction
>           self.build_details_page.update_progress_bar(title + ": ", fraction)
>
> +    def handler_build_failure_cb(self, running_build):
> +        self.build_details_page.show_issues()
> +
>       def destroy_window_cb(self, widget, event):
>           lbl = "<b>Do you really want to exit the Hob image creator?</b>"
>           dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 9af19f6..d1557a8 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -619,6 +619,20 @@ class HobNotebook(gtk.VBox):
>
>           self.tb.show()
>
> +    def show_indicator_icon(self, title, number):
> +        for i in range(len(self.tabbar.children)):
> +            if self.tabbar.children[i]["toggled_page"] == -1:
> +                continue
> +            if self.tabbar.children[i]["title"] == title:
> +                self.tabbar.show_indicator_icon(i, number)
> +
> +    def hide_indicator_icon(self, title):
> +        for i in range(len(self.tabbar.children)):
> +            if self.tabbar.children[i]["toggled_page"] == -1:
> +                continue
> +            if self.tabbar.children[i]["title"] == title:
> +                self.tabbar.hide_indicator_icon(i)
> +
>       def tab_switched_cb(self, widget, page):
>           self.notebook.set_current_page(page)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> index eedd8d9..ddac232 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> +++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> @@ -84,6 +84,9 @@ class RunningBuild (gobject.GObject):
>             'task-started'   : (gobject.SIGNAL_RUN_LAST,
>                                 gobject.TYPE_NONE,
>                                 (gobject.TYPE_PYOBJECT,)),
> +          'log-error'      : (gobject.SIGNAL_RUN_LAST,
> +                              gobject.TYPE_NONE,
> +                              ()),
>             }
>       pids_to_task = {}
>       tasks_to_iter = {}
> @@ -134,6 +137,7 @@ class RunningBuild (gobject.GObject):
>               if event.levelno>= logging.ERROR:
>                   icon = "dialog-error"
>                   color = HobColors.ERROR
> +                self.emit("log-error")
>               elif event.levelno>= logging.WARNING:
>                   icon = "dialog-warning"
>                   color = HobColors.WARNING

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


