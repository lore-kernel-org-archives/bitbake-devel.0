Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAK-0003eB-12
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:20 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044721"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:43 -0700
Message-ID: <4F60F386.9040004@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:42 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<e01f5d85b03194c9338c1689c7cf0b5d054a42db.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <e01f5d85b03194c9338c1689c7cf0b5d054a42db.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 06/11] Hob: Remove the indication in machine/base image combobox
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
> Remove the "--select a machine--" prompt in machine selection.
> Also change "--select a base image--" to "Start from scratch" for
> base image selection.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Looks good.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>   lib/bb/ui/crumbs/hoblistmodel.py           |    2 +-
>   lib/bb/ui/crumbs/imageconfigurationpage.py |   20 +++++++-------------
>   2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
> index 0378828..c19aaa8 100644
> --- a/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -422,7 +422,7 @@ class RecipeListModel(gtk.ListStore):
>       """
>       (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN) = range(11)
>
> -    __dummy_image__ = "--select a base image--"
> +    __dummy_image__ = "Start from scratch"
>
>       __gsignals__ = {
>           "recipelist-populated" : (gobject.SIGNAL_RUN_LAST,
> diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
> index f029bf8..3b1201e 100644
> --- a/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -33,8 +33,6 @@ from bb.ui.crumbs.hobpages import HobPage
>   #
>   class ImageConfigurationPage (HobPage):
>
> -    __dummy_machine__ = "--select a machine--"
> -
>       def __init__(self, builder):
>           super(ImageConfigurationPage, self).__init__(builder, "Image configuration")
>
> @@ -236,22 +234,18 @@ class ImageConfigurationPage (HobPage):
>
>       def machine_combo_changed_cb(self, machine_combo):
>           combo_item = machine_combo.get_active_text()
> -        if not combo_item or combo_item == self.__dummy_machine__:
> -            self.builder.configuration.curr_mach = ""
> -            self.builder.switch_page(self.builder.MACHINE_SELECTION)
> -        else:
> -            self.builder.configuration.curr_mach = combo_item
> -            # Do reparse recipes
> -            self.builder.switch_page(self.builder.RCPPKGINFO_POPULATING)
> +        self.builder.configuration.curr_mach = combo_item
> +        # Do reparse recipes
> +        self.builder.switch_page(self.builder.RCPPKGINFO_POPULATING)
>
>       def update_machine_combo(self):
> -        all_machines = [self.__dummy_machine__] + self.builder.parameters.all_machines
> +        all_machines = self.builder.parameters.all_machines
>
>           model = self.machine_combo.get_model()
>           model.clear()
>           for machine in all_machines:
>               self.machine_combo.append_text(machine)
> -        self.machine_combo.set_active(0)
> +        self.machine_combo.set_active(-1)
>
>       def switch_machine_combo(self):
>           model = self.machine_combo.get_model()
> @@ -261,7 +255,7 @@ class ImageConfigurationPage (HobPage):
>                   self.machine_combo.set_active(active)
>                   return
>               active += 1
> -        self.machine_combo.set_active(0)
> +        self.machine_combo.set_active(-1)
>
>       def image_combo_changed_idle_cb(self, selected_image, selected_recipes, selected_packages):
>           self.builder.update_recipe_model(selected_image, selected_recipes)
> @@ -302,7 +296,7 @@ class ImageConfigurationPage (HobPage):
>           # populate image combo
>           filter = {RecipeListModel.COL_TYPE : ['image']}
>           image_model = recipe_model.tree_model(filter)
> -        active = 0
> +        active = -1
>           cnt = 0
>
>           it = image_model.get_iter_first()

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


