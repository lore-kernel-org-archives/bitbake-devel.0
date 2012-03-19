Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mTK-0007HY-TY
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 00:58:43 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 19 Mar 2012 16:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120837795"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 16:49:50 -0700
Message-ID: <4F67C61D.9060903@linux.intel.com>
Date: Mon, 19 Mar 2012 16:49:49 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<8432d919ec2154295bd60cf608f83843ca030b1b.1331910234.git.shane.wang@intel.com>
In-Reply-To: <8432d919ec2154295bd60cf608f83843ca030b1b.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 03/12] Hob: show indicators on the tabs of the Hob notebook
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
X-List-Received-Date: Mon, 19 Mar 2012 23:58:43 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> This patch is to show the indicators (e.g., the number of the issues) in the build details page to highlight.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/builddetailspage.py |   10 ++++++++++
>   bitbake/lib/bb/ui/crumbs/builder.py          |    5 +++++
>   bitbake/lib/bb/ui/crumbs/hobwidget.py        |   14 ++++++++++++++
>   bitbake/lib/bb/ui/crumbs/runningbuild.py     |    4 ++++
>   4 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> index 63d2c7b..7a5cfe6 100755
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
> index 1d255ac..318bcbf 100755
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
> @@ -533,6 +534,7 @@ class Builder(gtk.Window):
>           elif self.current_step == self.PACKAGE_GENERATING:
>               fraction = 0
>           self.build_details_page.update_progress_bar("Build Started: ", fraction)
> +        self.build_details_page.reset_issues()
>
>       def build_succeeded(self):
>           if self.current_step == self.FAST_IMAGE_GENERATING:
> @@ -600,6 +602,9 @@ class Builder(gtk.Window):
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
> index 8fa663c..2c3d831 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -619,6 +619,20 @@ class HobNotebook(gtk.VBox):
>
>           self.tb.show()
>
> +    def show_indicator_icon(self, title, number):
> +        for i, child in enumerate(self.tabbar.children):
> +            if child["toggled_page"] == -1:
> +                continue
> +            if child["title"] == title:
> +                self.tabbar.show_indicator_icon(i, number)
> +
> +    def hide_indicator_icon(self, title):
> +        for i, child in enumerate(self.tabbar.children):
> +            if child["toggled_page"] == -1:
> +                continue
> +            if child["title"] == title:
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


