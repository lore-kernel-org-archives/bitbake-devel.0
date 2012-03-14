Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAK-0003eJ-Gy
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:20 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044727"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:46 -0700
Message-ID: <4F60F388.4020301@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:44 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<c86fa48517606d647dea901f803d3b22ff334c9f.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <c86fa48517606d647dea901f803d3b22ff334c9f.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 05/11] Hob: Remove the reset button in recipe/package selection page
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:20 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/builder.py              |    6 ------
>   lib/bb/ui/crumbs/packageselectionpage.py |   11 -----------
>   lib/bb/ui/crumbs/recipeselectionpage.py  |    9 ---------
>   3 files changed, 0 insertions(+), 26 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index a905030..f9844de 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -361,12 +361,6 @@ class Builder(gtk.Window):
>           self.handler.set_extra_config(self.configuration.extra_setting)
>           self.handler.set_extra_inherit("packageinfo")
>
> -    def reset_recipe_model(self):
> -        self.recipe_model.reset()
> -
> -    def reset_package_model(self):
> -        self.package_model.reset()
> -
>       def update_recipe_model(self, selected_image, selected_recipes):
>           self.recipe_model.set_selected_image(selected_image)
>           self.recipe_model.set_selected_recipes(selected_recipes)
> diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
> index a8628ac..0427fe2 100755
> --- a/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -118,12 +118,6 @@ class PackageSelectionPage (HobPage):
>               if self.pages[i]['name'] == "Included":
>                   tab.connect("row-activated", self.tree_row_activated_cb)
>
> -            reset_button = gtk.Button("Reset")
> -            reset_button.connect("clicked", self.reset_clicked_cb)
> -            hbox = gtk.HBox(False, 5)
> -            hbox.pack_end(reset_button, expand=False, fill=False)
> -            tab.pack_start(hbox, expand=False, fill=False)
> -
>               label = gtk.Label(self.pages[i]['name'])
>               self.ins.append_page(tab, label)
>               self.tables.append(tab)
> @@ -206,11 +200,6 @@ class PackageSelectionPage (HobPage):
>               size_str = str(size) + ' KB'
>           return size_str
>
> -    # Callback functions
> -    def reset_clicked_cb(self, button):
> -        self.package_model.reset()
> -        self.builder.reset_package_model()
> -
>       def toggle_item_idle_cb(self, path):
>           if not self.package_model.path_included(path):
>               self.package_model.include_item(item_path=path, binb="User Selected")
> diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
> index aea9c0c..234734c 100755
> --- a/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -141,11 +141,6 @@ class RecipeSelectionPage (HobPage):
>               tab.connect("toggled", self.table_toggled_cb)
>               if self.pages[i]['name'] == "Included":
>                   tab.connect("row-activated", self.tree_row_activated_cb)
> -            reset_button = gtk.Button("Reset")
> -            reset_button.connect("clicked", self.reset_clicked_cb)
> -            hbox = gtk.HBox(False, 5)
> -            hbox.pack_end(reset_button, expand=False, fill=False)
> -            tab.pack_start(hbox, expand=False, fill=False)
>
>               label = gtk.Label(self.pages[i]['name'])
>               self.ins.append_page(tab, label)
> @@ -201,10 +196,6 @@ class RecipeSelectionPage (HobPage):
>           self.label.set_text("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
>           self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
>
> -    # Callback functions
> -    def reset_clicked_cb(self, button):
> -        self.builder.reset_recipe_model()
> -
>       def toggle_item_idle_cb(self, path):
>           if not self.recipe_model.path_included(path):
>               self.recipe_model.include_item(item_path=path, binb="User Selected", image_contents=False)

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


