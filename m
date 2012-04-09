Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SH6Xp-0007GC-82
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 06:49:37 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 08 Apr 2012 21:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="86787739"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 08 Apr 2012 21:40:19 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sun, 8 Apr 2012 21:40:19 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Mon, 9 Apr 2012 12:40:17 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 20/20] Hob: change the logic for
	rcppkglist_populated()
Thread-Index: AQHNFXB8p02EPGkI1EyAsQAk1RO+BZaR6qow
Date: Mon, 9 Apr 2012 04:40:16 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B17AFF@SHSMSX102.ccr.corp.intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
	<082019720337beea55d9cb110b127966313eb956.1333880210.git.shane.wang@intel.com>
In-Reply-To: <082019720337beea55d9cb110b127966313eb956.1333880210.git.shane.wang@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 20/20] Hob: change the logic for	rcppkglist_populated()
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
X-List-Received-Date: Mon, 09 Apr 2012 04:49:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Skip this patch only, I am going to send another version to fix the bug.

--
Shane

Shane Wang wrote on=A02012-04-08:

> There are some bugs in the previous log of rcppkglist_populated. [Yocto
> #2255] is one of them.
>=20
> Once more, when the user loads a template, changes the base image to the
> other one which is not the same as the one in the template, changes the
> machine, and then you will find the base image specified in the template
> disappears.
>=20
> This patch changes the logic as follows:
> - If any template is loaded into this Hob session, its base image will be
>   remembered always. After the recipe list and the package list are
>   populated, the template base image will be appended. That is to fix
>   the above bug. - If the reason for reparsing recipes is any settings
>   are changed, Hob will remember selected_recipes and selected_packages.
>   The behaviour is the same as before, because we don't want to clear
>   the user selection. - If the reason for reparsing recipes is the
>   machine is changed, including a template is loaded (which causes the
>   machine is changed), Hob will forget selected_recipes and
>   selected_packages the user selects. (see [Yocto #2255] for details)
> - Again, we reuse the code for rcppkglist_populated() for any base image
> changing.
>   I.e., when the user changes any base image, Hob will forget the previou=
s
>   selected_recipes and selected_packages.
> In Hob code, two places will cause recipe parsing. One is settings are
> changed. The other is machine is changed.
>=20
> [Yocto #2255]
>=20
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py                |   65
>  +++++++++++++++++--- bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
>  |   30 ++-------- 2 files changed, 62 insertions(+), 33 deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py
> b/bitbake/lib/bb/ui/crumbs/builder.py index 4997cd4..849a1f0 100755 ---
> a/bitbake/lib/bb/ui/crumbs/builder.py +++
> b/bitbake/lib/bb/ui/crumbs/builder.py @@ -26,6 +26,7 @@ import copy
>  import os import subprocess import shlex +import glib from
>  bb.ui.crumbs.template import TemplateMgr from
>  bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage from
>  bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
> @@ -259,6 +260,7 @@ class Builder(gtk.Window):
>          self.handler =3D hobHandler
>         =20
>          self.template =3D None
> +        self.loaded_images =3D []
>=20
>          # build step self.current_step =3D None @@ -339,7 +341,8 @@ clas=
s
>          Builder(gtk.Window): self.set_user_config()
>          self.handler.parse_generate_configuration()
> -    def populate_recipe_package_info_async(self):
> +    def populate_recipe_package_info_async(self, mach_changed =3D True):
> +        self.mach_changed =3D mach_changed
>          self.switch_page(self.RCPPKGINFO_POPULATING) # Parse recipes
>          self.set_user_config() @@ -395,6 +398,12 @@ class
>          Builder(gtk.Window): self.template.load(path)
>          self.configuration.load(self.template)
> +        entry =3D {}
> +        entry["image"] =3D self.configuration.selected_image
> +        entry["recipes"] =3D self.configuration.selected_recipes[:]
> +        entry["packages"] =3D self.configuration.selected_packages[:]
> +        self.loaded_images.append(entry)
> +
>          for layer in self.configuration.layers:
>              if not os.path.exists(layer+'/conf/layer.conf'):
>                  return False
> @@ -589,17 +598,57 @@ class Builder(gtk.Window):
>          self.window_sensitive(True)
>      def rcppkglist_populated(self):
> +        # remember those images loaded previously in this Hob session +
>        for entry in self.loaded_images: +          =20
> self.recipe_model.image_list_append(entry["image"], +                "
> ".join(entry["recipes"]), +                " ".join(entry["packages"]))
> + +        if self.mach_changed: +
> self.update_rcppkglist_forgotten(self.configuration.selected_image) +  =20
>     else: +            self.update_rcppkglist_remembered() + +    def
> update_rcppkglist_idle(self, selected_image, selected_recipes,
> selected_packages): +        self.update_recipe_model(selected_image,
> selected_recipes) +        self.update_package_model(selected_packages)
> +        self.window_sensitive(True) + +    def
> update_rcppkglist_forgotten(self, selected_image =3D None): +      =20
> self.window_sensitive(False) + +        selected_recipes =3D
> selected_packages =3D [] +        self.recipe_model.reset() +      =20
> self.package_model.reset() + +        selected_image_desc =3D "" +      =
=20
> if selected_image: +            image_path =3D
> self.recipe_model.pn_path[selected_image] +            image_iter =3D
> self.recipe_model.get_iter(image_path) +            selected_packages =3D
> self.recipe_model.get_value(image_iter,
> self.recipe_model.COL_INSTALL).split() +            selected_image_desc
> =3D self.recipe_model.get_value(image_iter, self.recipe_model.COL_DESC) +
> + self.image_configuration_page.update_image_combo(self.recipe_model,
> selected_image, selected_image_desc) + +      =20
> glib.idle_add(self.update_rcppkglist_idle, selected_image,
> selected_recipes, selected_packages) + + +    def
> update_rcppkglist_remembered(self): +      =20
> self.window_sensitive(False) +
>          selected_image =3D self.configuration.selected_image
>          selected_recipes =3D self.configuration.selected_recipes[:]
>          selected_packages =3D self.configuration.selected_packages[:]
> -        self.recipe_model.image_list_append(selected_image, -         =20
>                                  " ".join(selected_recipes), -         =20
>                                  " ".join(selected_packages)) +      =20
> selected_image_desc =3D "" +        if selected_image: +          =20
> image_path =3D self.recipe_model.pn_path[selected_image] +          =20
> image_iter =3D self.recipe_model.get_iter(image_path) +          =20
> selected_image_desc =3D self.recipe_model.get_value(image_iter,
> self.recipe_model.COL_DESC)
>=20
> - self.image_configuration_page.update_image_combo(self.recipe_model,
> selected_image) -        self.update_recipe_model(selected_image,
> selected_recipes) -        self.update_package_model(selected_packages)
> + self.image_configuration_page.update_image_combo(self.recipe_model,
> selected_image, selected_image_desc) + +      =20
> glib.idle_add(self.update_rcppkglist_idle, selected_image,
> selected_recipes, selected_packages)
>=20
>      def recipelist_changed_cb(self, recipe_model):
>          self.recipe_details_page.refresh_selection() @@ -905,7 +954,7
>          @@ class Builder(gtk.Window): if not
>          self.configuration.curr_mach:
>              self.update_config_async()
>          else:
> -            self.populate_recipe_package_info_async() +          =20
> self.populate_recipe_package_info_async(mach_changed =3D False)
>=20
>      def deploy_image(self, image_name):
>          if not image_name:
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py index
> c2e0f5f..c63fc61 100644 ---
> a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py +++
> b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py @@ -21,7 +21,6 @@
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> =20
>  import gtk -import glib from bb.ui.crumbs.progressbar import
>  HobProgressBar from bb.ui.crumbs.hobcolor import HobColors from
>  bb.ui.crumbs.hobwidget import hic, HobImageButton, HobInfoButton,
> HobAltButton, HobButton
> @@ -259,7 +258,7 @@ class ImageConfigurationPage (HobPage):
>=20
>          self.builder.configuration.curr_mach =3D combo_item
>          # Do reparse recipes
> -        self.builder.populate_recipe_package_info_async()
> +        self.builder.populate_recipe_package_info_async(mach_changed
> =3D True)
>=20
>      def update_machine_combo(self):
>          all_machines =3D self.builder.parameters.all_machines
> @@ -280,32 +279,11 @@ class ImageConfigurationPage (HobPage):
>              active +=3D 1
>          self.machine_combo.set_active(-1)
> -    def image_combo_changed_idle_cb(self, selected_image,
> selected_recipes, selected_packages): -      =20
> self.builder.update_recipe_model(selected_image, selected_recipes) -   =20
>    self.builder.update_package_model(selected_packages) -      =20
> self.builder.window_sensitive(True) -
>      def image_combo_changed_cb(self, combo):
> -        self.builder.window_sensitive(False)
>          selected_image =3D self.image_combo.get_active_text()
>          if not selected_image:
>              return
> - -        selected_recipes =3D [] - -        image_path =3D
> self.builder.recipe_model.pn_path[selected_image] -        image_iter =3D
> self.builder.recipe_model.get_iter(image_path) -      =20
> selected_packages =3D self.builder.recipe_model.get_value(image_iter,
> self.builder.recipe_model.COL_INSTALL).split() - -        mark =3D ("<spa=
n
> %s>%s</span>\n") % (self.span_tag('small'),
> self.builder.recipe_model.get_value(image_iter,
> self.builder.recipe_model.COL_DESC)) -      =20
> self.image_desc.set_markup(mark) - -      =20
> self.builder.recipe_model.reset() -      =20
> self.builder.package_model.reset() - -      =20
> self.show_baseimg_selected() - -      =20
> glib.idle_add(self.image_combo_changed_idle_cb, selected_image,
> selected_recipes, selected_packages) +      =20
> self.builder.update_rcppkglist_forgotten(selected_image)
>=20
>      def _image_combo_connect_signal(self):
>          if not self.image_combo_id:
> @@ -316,7 +294,7 @@ class ImageConfigurationPage (HobPage):
>              self.image_combo.disconnect(self.image_combo_id)
>              self.image_combo_id =3D None
> -    def update_image_combo(self, recipe_model, selected_image):
> +    def update_image_combo(self, recipe_model, selected_image,
> selected_image_desc):
>          # Update the image combo according to the images in the
>          recipe_model # populate image combo filter =3D
>          {RecipeListModel.COL_TYPE : ['image']}
> @@ -348,6 +326,8 @@ class ImageConfigurationPage (HobPage):
>=20
>          if active !=3D -1:
>              self.show_baseimg_selected()
> +            mark =3D "<span %s>%s</span>\n" % (self.span_tag('small'),
> selected_image_desc) +            self.image_desc.set_markup(mark)
>=20
>          self._image_combo_connect_signal()




