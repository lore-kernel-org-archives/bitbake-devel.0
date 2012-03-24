Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBF4q-0001YV-6Y
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:43:28 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Mar 2012 17:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144391317"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2012 17:34:29 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "Barros Pena, Belen"
	<belen.barros.pena@intel.com>, Giulia Piu <giulia@closertag.com>, "Wang,
	Shane" <shane.wang@intel.com>
In-Reply-To: <0873c2b5ad4810eb019ec860760b46c917dc6d68.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<0873c2b5ad4810eb019ec860760b46c917dc6d68.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 08:32:19 +0800
Message-ID: <1332549139.1849.12.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/9] lib/bb/ui/crumbs/recipeselectionpage: add 'Build image' button per design
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
X-List-Received-Date: Sat, 24 Mar 2012 00:43:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> The design calls for the 'Build packages' button to be a secondary action
> and a 'Build image' primary action to exist on the recipe selection page.

Sorry, I think this design doesn't make sense.

Thinking of this scenario, if a user clicks "Create your own image" in
base image drop down list, and then clicks "View Recipes" to select some
recipes, if we allow user to directly click "Build image" here, it is
wrong since nothing has been set to PACKAGE_INSTALL variable and the
image build will fail.

Also it will confuse user that, they would think what they selected in
the recipe page will be packed into the final image, however it isn't.
Therefore I suggest removing the "build image" button in recipe
selection page.

Thanks,
Dongxiao


> 
> Fixes [YOCTO #2165]
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/recipeselectionpage.py |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
> index 881b2ec..e77e79b 100755
> --- a/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -151,11 +151,16 @@ class RecipeSelectionPage (HobPage):
>          button_box = gtk.HBox(False, 6)
>          self.box_group_area.pack_end(button_box, expand=False, fill=False)
>  
> -        self.build_packages_button = HobButton('Build packages')
> -        self.build_packages_button.set_size_request(205, 49)
> -        self.build_packages_button.set_tooltip_text("Build packages for customization")
> -        self.build_packages_button.set_flags(gtk.CAN_DEFAULT)
> -        self.build_packages_button.grab_default()
> +        self.build_image_button = HobButton('Build image')
> +        self.build_image_button.connect("clicked", self.build_image_clicked_cb)
> +        button_box.pack_end(self.build_image_button, expand=False, fill=False)
> +        self.build_image_button.set_size_request(205, 49)
> +        self.build_image_button.set_tooltip_text("Build packages for customization")
> +        self.build_image_button.set_flags(gtk.CAN_DEFAULT)
> +        self.build_image_button.grab_default()
> +        label = gtk.Label("or")
> +        button_box.pack_end(label, expand=False, fill=False)
> +        self.build_packages_button = HobAltButton('Build packages')
>          self.build_packages_button.connect("clicked", self.build_packages_clicked_cb)
>          button_box.pack_end(self.build_packages_button, expand=False, fill=False)
>  
> @@ -174,6 +179,9 @@ class RecipeSelectionPage (HobPage):
>      def back_button_clicked_cb(self, button):
>          self.builder.show_configuration()
>  
> +    def build_image_clicked_cb(self, button):
> +        self.builder.build_image()
> +
>      def refresh_selection(self):
>          self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
>          _, self.builder.configuration.selected_recipes = self.recipe_model.get_selected_recipes()




