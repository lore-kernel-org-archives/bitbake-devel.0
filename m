Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <sgw@linux.intel.com>) id 1Sjb0s-0000vW-30
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jun 2012 21:01:22 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 26 Jun 2012 11:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="160966710"
Received: from unknown (HELO [10.255.12.180]) ([10.255.12.180])
	by azsmga001.ch.intel.com with ESMTP; 26 Jun 2012 11:49:22 -0700
Message-ID: <4FEA0432.3080205@linux.intel.com>
Date: Tue, 26 Jun 2012 11:49:22 -0700
From: Saul Wold <sgw@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Cristian Iorga <cristian.iorga@intel.com>
References: <1340381304-20531-1-git-send-email-cristian.iorga@intel.com>
In-Reply-To: <1340381304-20531-1-git-send-email-cristian.iorga@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix for Hob bug #2323
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
X-List-Received-Date: Tue, 26 Jun 2012 19:01:22 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/22/2012 09:08 AM, Cristian Iorga wrote:
> Removed unnecessary button from Recipes screen and
> replaced the button that diplayed packages size and total image size
> from Packages screen with a label.
>
Please change the subject to address what you fixed, not everyone wants 
to look up bug numbers and they should not be in the commit subject.

You can add the bug number at a tag:
[YOCTO #2323]

Please review these general guidelines at:

http://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines

They can be used for oe-core, bitbake, and poky commits.

Thanks
	Sau!

> Signed-off-by: Cristian Iorga<cristian.iorga@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    7 ++-----
>   bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    9 ++-------
>   2 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> index 9895835..1b832eb 100755
> --- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -113,15 +113,12 @@ class PackageSelectionPage (HobPage):
>           self.ins.set_current_page(0)
>
>       def create_visual_elements(self):
> -        self.label = gtk.Button("Packages included: 0\nSelected packages size: 0 MB")
> -        self.label.set_can_default(False)
> -        self.label.set_relief(gtk.RELIEF_HALF)
> -        self.label.connect("clicked", self.included_clicked_cb)
> +        self.label = gtk.Label("Packages included: 0\nSelected packages size: 0 MB")
>           self.eventbox = self.add_onto_top_bar(self.label, 73)
>           self.pack_start(self.eventbox, expand=False, fill=False)
>           self.pack_start(self.group_align, expand=True, fill=True)
>
> -        # set visiable members
> +        # set visible members
>           self.ins = HobNotebook()
>           self.tables = [] # we need to modify table when the dialog is shown
>           # append the tab
> diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> index ece37e0..af68f2a 100755
> --- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -138,15 +138,11 @@ class RecipeSelectionPage (HobPage):
>           self.ins.set_current_page(0)
>
>       def create_visual_elements(self):
> -        self.label = gtk.Button('Recipes included: 0')
> -        self.label.set_can_default(False)
> -        self.label.set_relief(gtk.RELIEF_HALF)
> -        self.label.connect("clicked", self.included_clicked_cb)
> -        self.eventbox = self.add_onto_top_bar(self.label, 73)
> +        self.eventbox = self.add_onto_top_bar(None, 73)
>           self.pack_start(self.eventbox, expand=False, fill=False)
>           self.pack_start(self.group_align, expand=True, fill=True)
>
> -        # set visiable members
> +        # set visible members
>           self.ins = HobNotebook()
>           self.tables = [] # we need modify table when the dialog is shown
>           # append the tabs in order
> @@ -205,7 +201,6 @@ class RecipeSelectionPage (HobPage):
>       def refresh_selection(self):
>           self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
>           _, self.builder.configuration.selected_recipes = self.recipe_model.get_selected_recipes()
> -        self.label.set_label("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
>           self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
>
>       def toggle_item_idle_cb(self, path, view_tree, cell, pagename):


