Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAG-0003eB-EF
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:16 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044675"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:29 -0700
Message-ID: <4F60F378.6070206@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:28 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<b2f277bf2d1de5aff3f9ef5be9cd3a9c81897852.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <b2f277bf2d1de5aff3f9ef5be9cd3a9c81897852.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 11/11] Hob: improve recipe/package selection performance
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:16 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> Originally we will send selection chagned notification in each
> include_item and exclude_item, which is time cost since these are
> recursive functions and we may select hundreds of recipes/packages.
>
> The improvement is to move the notification from include_item and
> exclude_item to the place where the two functions are called.
> This could greatly improve the selection/deselection speed for recipe
> and package lists.

Awesome! So instead of sending the change notification for each 
included/excluded item with this change the signal will be sent once 
when a set of changes are made. Right?

>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/hoblistmodel.py         |   10 +++-------
>   lib/bb/ui/crumbs/packageselectionpage.py |    1 +
>   lib/bb/ui/crumbs/recipeselectionpage.py  |    1 +
>   3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
> index edd61b5..caf31bc 100644
> --- a/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -216,8 +216,6 @@ class PackageListModel(gtk.TreeStore):
>
>           self[item_path][self.COL_INC] = True
>
> -        self.selection_change_notification()
> -
>           it = self.get_iter(item_path)
>
>           # If user explicitly selects a recipe, all its providing packages are selected.
> @@ -276,8 +274,6 @@ class PackageListModel(gtk.TreeStore):
>
>           self[item_path][self.COL_INC] = False
>
> -        self.selection_change_notification()
> -
>           item_name = self[item_path][self.COL_NAME]
>           item_rdep = self[item_path][self.COL_RDEP]
>           it = self.get_iter(item_path)
> @@ -343,6 +339,7 @@ class PackageListModel(gtk.TreeStore):
>               else:
>                   left.append(pn)
>
> +        self.selection_change_notification()
>           return left
>
>       def get_selected_packages(self):
> @@ -604,7 +601,6 @@ class RecipeListModel(gtk.ListStore):
>           item_deps = self[item_path][self.COL_DEPS]
>
>           self[item_path][self.COL_INC] = True
> -        self.selection_change_notification()
>
>           item_bin = self[item_path][self.COL_BINB].split(', ')
>           if binb and not binb in item_bin:
> @@ -642,8 +638,6 @@ class RecipeListModel(gtk.ListStore):
>
>           self[item_path][self.COL_INC] = False
>
> -        self.selection_change_notification()
> -
>           item_name = self[item_path][self.COL_NAME]
>           item_deps = self[item_path][self.COL_DEPS]
>           if item_deps:
> @@ -703,6 +697,7 @@ class RecipeListModel(gtk.ListStore):
>                   path = self.pn_path[pn]
>                   self.include_item(item_path=path,
>                                     binb="User Selected")
> +        self.selection_change_notification()
>
>       def get_selected_image(self):
>           it = self.get_iter_first()
> @@ -724,3 +719,4 @@ class RecipeListModel(gtk.ListStore):
>           self.include_item(item_path=path,
>                             binb="User Selected",
>                             image_contents=True)
> +        self.selection_change_notification()
> diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
> index 0427fe2..4fb199e 100755
> --- a/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -206,6 +206,7 @@ class PackageSelectionPage (HobPage):
>           else:
>               self.package_model.exclude_item(item_path=path)
>
> +        self.refresh_selection()
>           self.builder.window_sensitive(True)
>
>       def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
> diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
> index 234734c..50d4363 100755
> --- a/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -202,6 +202,7 @@ class RecipeSelectionPage (HobPage):
>           else:
>               self.recipe_model.exclude_item(item_path=path)
>
> +        self.refresh_selection()
>           self.builder.window_sensitive(True)
>
>       def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


