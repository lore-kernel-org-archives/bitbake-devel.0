Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAI-0003eB-RZ
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:19 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044714"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:41 -0700
Message-ID: <4F60F383.4040109@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:39 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<c5a2b26da70c94f26bfd2e2297cc7b69139ec78c.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <c5a2b26da70c94f26bfd2e2297cc7b69139ec78c.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 07/11] Hob: Remove the recipe/package populated signal
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:19 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> Handle the recipe and package list update in
> handler_command_succeeded_cb(), which could avoid potential race
> condition when doing recipe/package list updating and page switching.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

AFAICS this switches the GUI even if the model is not ready, which seems 
like a reasonable change.

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/builder.py      |   18 ++++++++----------
>   lib/bb/ui/crumbs/hoblistmodel.py |   14 --------------
>   2 files changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index f9844de..c6b1a3d 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -200,8 +200,6 @@ class Builder(gtk.Window):
>           self.connect("delete-event", self.destroy_window_cb)
>           self.recipe_model.connect ("recipe-selection-changed",  self.recipelist_changed_cb)
>           self.package_model.connect("package-selection-changed", self.packagelist_changed_cb)
> -        self.recipe_model.connect ("recipelist-populated",      self.recipelist_populated_cb)
> -        self.package_model.connect("packagelist-populated",     self.packagelist_populated_cb)
>           self.handler.connect("config-updated",           self.handler_config_updated_cb)
>           self.handler.connect("package-formats-updated",  self.handler_package_formats_updated_cb)
>           self.handler.connect("layers-updated",           self.handler_layers_updated_cb)
> @@ -413,10 +411,14 @@ class Builder(gtk.Window):
>                            self.handler.GENERATE_IMAGE]:
>               self.handler.request_package_info_async()
>           elif initcmd == self.handler.POPULATE_PACKAGEINFO:
> +            if self.current_step == self.RCPPKGINFO_POPULATING:
> +                self.switch_page(self.RCPPKGINFO_POPULATED)
> +                self.rcppkglist_populated()
> +                return
> +
> +            self.rcppkglist_populated()
>               if self.current_step == self.FAST_IMAGE_GENERATING:
>                   self.switch_page(self.IMAGE_GENERATING)
> -            elif self.current_step == self.RCPPKGINFO_POPULATING:
> -                self.switch_page(self.RCPPKGINFO_POPULATED)
>               elif self.current_step == self.PACKAGE_GENERATING:
>                   self.switch_page(self.PACKAGE_GENERATED)
>               elif self.current_step == self.IMAGE_GENERATING:
> @@ -448,7 +450,7 @@ class Builder(gtk.Window):
>       def handler_data_generated_cb(self, handler):
>           self.window_sensitive(True)
>
> -    def recipelist_populated_cb(self, recipe_model):
> +    def rcppkglist_populated(self):
>           selected_image = self.configuration.selected_image
>           selected_recipes = self.configuration.selected_recipes[:]
>           selected_packages = self.configuration.selected_packages[:]
> @@ -458,11 +460,7 @@ class Builder(gtk.Window):
>                                               " ".join(selected_packages))
>
>           self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
> -
>           self.update_recipe_model(selected_image, selected_recipes)
> -
> -    def packagelist_populated_cb(self, package_model):
> -        selected_packages = self.configuration.selected_packages[:]
>           self.update_package_model(selected_packages)
>
>       def recipelist_changed_cb(self, recipe_model):
> @@ -825,7 +823,7 @@ class Builder(gtk.Window):
>           self.switch_page(self.RECIPE_SELECTION)
>
>       def initiate_new_build(self):
> -	self.configuration.curr_mach = ""
> +        self.configuration.curr_mach = ""
>           self.image_configuration_page.switch_machine_combo()
>           self.switch_page(self.MACHINE_SELECTION)
>
> diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
> index c19aaa8..edd61b5 100644
> --- a/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -36,9 +36,6 @@ class PackageListModel(gtk.TreeStore):
>       (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC) = range(11)
>
>       __gsignals__ = {
> -        "packagelist-populated" : (gobject.SIGNAL_RUN_LAST,
> -                                gobject.TYPE_NONE,
> -                                ()),
>           "package-selection-changed" : (gobject.SIGNAL_RUN_LAST,
>                                   gobject.TYPE_NONE,
>                                   ()),
> @@ -135,8 +132,6 @@ class PackageListModel(gtk.TreeStore):
>       """
>       The populate() function takes as input the data from a
>       bb.event.PackageInfo event and populates the package list.
> -    Once the population is done it emits gsignal packagelist-populated
> -    to notify any listeners that the model is ready
>       """
>       def populate(self, pkginfolist):
>           self.clear()
> @@ -194,8 +189,6 @@ class PackageListModel(gtk.TreeStore):
>                        self.COL_RPROV, rprov, self.COL_SIZE, size,
>                        self.COL_BINB, "", self.COL_INC, False)
>
> -        self.emit("packagelist-populated")
> -
>       """
>       Check whether the item at item_path is included or not
>       """
> @@ -425,9 +418,6 @@ class RecipeListModel(gtk.ListStore):
>       __dummy_image__ = "Start from scratch"
>
>       __gsignals__ = {
> -        "recipelist-populated" : (gobject.SIGNAL_RUN_LAST,
> -                                gobject.TYPE_NONE,
> -                                ()),
>           "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST,
>                                     gobject.TYPE_NONE,
>                                    ()),
> @@ -524,8 +514,6 @@ class RecipeListModel(gtk.ListStore):
>       """
>       The populate() function takes as input the data from a
>       bb.event.TargetsTreeGenerated event and populates the RecipeList.
> -    Once the population is done it emits gsignal recipelist-populated
> -    to notify any listeners that the model is ready
>       """
>       def populate(self, event_model):
>           # First clear the model, in case repopulating
> @@ -580,8 +568,6 @@ class RecipeListModel(gtk.ListStore):
>               self.pn_path[pn] = path
>               it = self.iter_next(it)
>
> -        self.emit("recipelist-populated")
> -
>       """
>       Update the model, send out the notification.
>       """

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


