Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mSz-0007Gb-0p
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 00:58:21 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 19 Mar 2012 16:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120837672"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 16:49:28 -0700
Message-ID: <4F67C607.50806@linux.intel.com>
Date: Mon, 19 Mar 2012 16:49:27 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<8565670d713978a93a57a96c55b4815a144af3e5.1331910234.git.shane.wang@intel.com>
In-Reply-To: <8565670d713978a93a57a96c55b4815a144af3e5.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 02/12] Hob: use HobNotebook to implement a notebook in build details page
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
X-List-Received-Date: Mon, 19 Mar 2012 23:58:21 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/03/12 08:10, Shane Wang wrote:
> This patch is to use HobNotebook we defined to implement the notebook in the build details page.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/builddetailspage.py |   30 ++++++++++--
>   bitbake/lib/bb/ui/crumbs/runningbuild.py     |   65 ++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+), 5 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> index 8b75ca0..63d2c7b 100755
> --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> +++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> @@ -22,8 +22,10 @@
>
>   import gtk
>   from bb.ui.crumbs.progressbar import HobProgressBar
> -from bb.ui.crumbs.hobwidget import hic
> +from bb.ui.crumbs.hobwidget import hic, HobNotebook
>   from bb.ui.crumbs.runningbuild import RunningBuildTreeView
> +from bb.ui.crumbs.runningbuild import BuildConfigurationTreeView
> +from bb.ui.crumbs.runningbuild import BuildFailureTreeView
>   from bb.ui.crumbs.hobpages import HobPage
>
>   #
> @@ -49,11 +51,29 @@ class BuildDetailsPage (HobPage):
>           self.stop_button.connect("clicked", self.stop_button_clicked_cb)
>           self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
>
> +        self.notebook = HobNotebook()
> +        self.config_tv = BuildConfigurationTreeView()
> +        self.config_model = self.builder.handler.build.model.config_model()
> +        self.config_tv.set_model(self.config_model)
> +        self.scrolled_view_config = gtk.ScrolledWindow ()
> +        self.scrolled_view_config.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
> +        self.scrolled_view_config.add(self.config_tv)
> +        self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build Configuration"))
> +
> +        self.failure_tv = BuildFailureTreeView()
> +        self.failure_model = self.builder.handler.build.model.failure_model()
> +        self.failure_tv.set_model(self.failure_model)
> +        self.scrolled_view_failure = gtk.ScrolledWindow ()
> +        self.scrolled_view_failure.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
> +        self.scrolled_view_failure.add(self.failure_tv)
> +        self.notebook.append_page(self.scrolled_view_failure, gtk.Label("Issues"))
> +
>           self.build_tv = RunningBuildTreeView(readonly=True)
>           self.build_tv.set_model(self.builder.handler.build.model)
> -        self.scrolled_view = gtk.ScrolledWindow ()
> -        self.scrolled_view.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
> -        self.scrolled_view.add(self.build_tv)
> +        self.scrolled_view_build = gtk.ScrolledWindow ()
> +        self.scrolled_view_build.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
> +        self.scrolled_view_build.add(self.build_tv)
> +        self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
>
>           self.button_box = gtk.HBox(False, 6)
>           self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<<  Back to image configuration")
> @@ -86,7 +106,7 @@ class BuildDetailsPage (HobPage):
>           self.progress_bar.reset()
>           self.vbox.pack_start(self.progress_box, expand=False, fill=False)
>
> -        self.vbox.pack_start(self.scrolled_view, expand=True, fill=True)
> +        self.vbox.pack_start(self.notebook, expand=True, fill=True)
>
>           self.box_group_area.pack_end(self.button_box, expand=False, fill=False)
>           self.show_all()
> diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> index 718f692..eedd8d9 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> +++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> @@ -25,6 +25,7 @@ import logging
>   import time
>   import urllib
>   import urllib2
> +import pango
>   from bb.ui.crumbs.hobcolor import HobColors
>
>   class RunningBuildModel (gtk.TreeStore):
> @@ -40,6 +41,32 @@ class RunningBuildModel (gtk.TreeStore):
>                                   gobject.TYPE_STRING,
>                                   gobject.TYPE_INT)
>
> +    def config_model_filter(self, model, it):
> +        msg = model.get(it, self.COL_MESSAGE)[0]
> +        if msg == None or type(msg) != str:
> +            return False
> +        if msg.startswith("\nOE Build Configuration:\n"):
> +            return True
> +        return False

I think I commented on this before, this seems like a heavy way to 
achieve this functionality. Is there not another way we can display the 
Build Configuration to the user without having to filter every message 
emitted?

Further, if we're going to display this information in a separate page 
of the notebook would it not make sense to not show it in the build log 
page?

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


