Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SUY0E-0004mv-0r
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 08:46:30 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 15 May 2012 23:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="100644396"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 15 May 2012 23:36:28 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 15 May 2012 23:36:27 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.90]) with mapi id
	14.01.0355.002; Wed, 16 May 2012 14:36:25 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/3] Hob: add '--select a machine--'
	and	'--select a base image--' to GUI
Thread-Index: AQHNMdAPxOFxxEvdoUeCbTC3SqoYY5bL+G0g
Date: Wed, 16 May 2012 06:36:25 +0000
Message-ID: <40776A41FC278F40B59438AD47D147A90FD76135@SHSMSX102.ccr.corp.intel.com>
References: <cover.1336999687.git.limingx.l.an@intel.com>
	<dcc3df42e3c5b5b50a2e1b48dca947e0fe347c0e.1336999687.git.limingx.l.an@intel.com>
In-Reply-To: <dcc3df42e3c5b5b50a2e1b48dca947e0fe347c0e.1336999687.git.limingx.l.an@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] Hob: add '--select a machine--' and	'--select a base image--' to GUI
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
X-List-Received-Date: Wed, 16 May 2012 06:46:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Liming,

I simply tried this patch, and I saw the "--select a base image--" is liste=
d in the bottom part of the combo menu.

I think it should be the first one?

Thanks,
Dongxiao

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of Liming
> An
> Sent: Monday, May 14, 2012 8:52 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/3] Hob: add '--select a machine--' and =
'--select
> a base image--' to GUI
>=20
> [YOCTO #2175]
>=20
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py                |    6 ++--
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    6 ++--
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   35
> +++++++++++++++----
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
>  4 files changed, 34 insertions(+), 15 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py
> b/bitbake/lib/bb/ui/crumbs/builder.py
> index 42d0f2c..eb60b89 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -438,7 +438,7 @@ class Builder(gtk.Window):
>          toolchain_packages =3D []
>          if self.configuration.toolchain_build:
>              toolchain_packages =3D
> self.package_model.get_selected_packages_toolchain()
> -        if self.configuration.selected_image =3D=3D
> self.recipe_model.__dummy_image__:
> +        if self.configuration.selected_image =3D=3D
> self.recipe_model.__custom_image__:
>              packages =3D self.package_model.get_selected_packages()
>              image =3D self.hob_image
>          else:
> @@ -752,7 +752,7 @@ class Builder(gtk.Window):
>              fraction =3D 1.0
>              self.parameters.image_names =3D []
>              selected_image =3D self.recipe_model.get_selected_image()
> -            if selected_image =3D=3D self.recipe_model.__dummy_image__:
> +            if selected_image =3D=3D self.recipe_model.__custom_image__:
>                  linkname =3D 'hob-image-' + self.configuration.curr_mach
>              else:
>                  linkname =3D selected_image + '-' +
> self.configuration.curr_mach @@ -890,7 +890,7 @@ class
> Builder(gtk.Window):
>          selected_packages =3D self.package_model.get_selected_packages()
> or []
>=20
>          # If no base image and no selected packages don't build anything
> -        if not (selected_packages or selected_image !=3D
> self.recipe_model.__dummy_image__):
> +        if not (selected_packages or selected_image !=3D
> self.recipe_model.__custom_image__):
>              lbl =3D "<b>No selections made</b>\nYou have not made any
> selections"
>              lbl =3D lbl + " so there isn't anything to bake at this time=
."
>              dialog =3D CrumbsMessageDialog(self, lbl,
> gtk.STOCK_DIALOG_INFO) diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel=
.py
> b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> index 0b54f91..37cee78 100644
> --- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -456,7 +456,7 @@ class RecipeListModel(gtk.ListStore):
>      """
>      (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB,
> COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC) =3D
> range(12)
>=20
> -    __dummy_image__ =3D "Create your own image"
> +    __custom_image__ =3D "Create your own image"
>=20
>      __gsignals__ =3D {
>          "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST, @@
> -565,14 +565,14 @@ class RecipeListModel(gtk.ListStore):
>          self.clear()
>=20
>          # dummy image for prompt
> -        self.set(self.append(), self.COL_NAME, self.__dummy_image__,
> +        self.set(self.append(), self.COL_NAME, self.__custom_image__,
>                   self.COL_DESC, "Use the 'View recipes' and 'View
> packages' " \
>                                  "options to select what you want to
> include " \
>                                  "in your image.",
>                   self.COL_LIC, "", self.COL_GROUP, "",
>                   self.COL_DEPS, "", self.COL_BINB, "",
>                   self.COL_TYPE, "image", self.COL_INC, False,
> -                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN,
> self.__dummy_image__)
> +                 self.COL_IMG, False, self.COL_INSTALL, "",
> + self.COL_PN, self.__custom_image__)
>=20
>          for item in event_model["pn"]:
>              name =3D item
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index 7d19912..51594b3 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -33,6 +33,9 @@ from bb.ui.crumbs.hobpages import HobPage  #  class
> ImageConfigurationPage (HobPage):
>=20
> +    __dummy_machine__ =3D "--select a machine--"
> +    __dummy_image__   =3D "--select a base image--"
> +
>      def __init__(self, builder):
>          super(ImageConfigurationPage, self).__init__(builder, "Image
> configuration")
>=20
> @@ -261,9 +264,15 @@ class ImageConfigurationPage (HobPage):
>=20
>      def machine_combo_changed_cb(self, machine_combo):
>          combo_item =3D machine_combo.get_active_text()
> -        if not combo_item:
> +        if not combo_item or combo_item =3D=3D self.__dummy_machine__:
>              return
>=20
> +        # remove __dummy_machine__ item from the store list after first
> user selection
> +        # because it is no longer valid
> +        combo_store =3D machine_combo.get_model()
> +        if len(combo_store) and (combo_store[0][0] =3D=3D
> self.__dummy_machine__):
> +            machine_combo.remove_text(0)
> +
>          self.builder.configuration.curr_mach =3D combo_item
>          if self.machine_combo_changed_by_manual:
>              self.builder.configuration.clear_selection()
> @@ -274,13 +283,13 @@ class ImageConfigurationPage (HobPage):
>          self.builder.populate_recipe_package_info_async()
>=20
>      def update_machine_combo(self):
> -        all_machines =3D self.builder.parameters.all_machines
> +        all_machines =3D [self.__dummy_machine__] +
> + self.builder.parameters.all_machines
>=20
>          model =3D self.machine_combo.get_model()
>          model.clear()
>          for machine in all_machines:
>              self.machine_combo.append_text(machine)
> -        self.machine_combo.set_active(-1)
> +        self.machine_combo.set_active(0)
>=20
>      def switch_machine_combo(self):
>          self.machine_combo_changed_by_manual =3D False @@ -291,7
> +300,7 @@ class ImageConfigurationPage (HobPage):
>                  self.machine_combo.set_active(active)
>                  return
>              active +=3D 1
> -        self.machine_combo.set_active(-1)
> +        self.machine_combo.set_active(0)
>=20
>      def update_image_desc(self, selected_image):
>          desc =3D ""
> @@ -311,9 +320,15 @@ class ImageConfigurationPage (HobPage):
>      def image_combo_changed_cb(self, combo):
>          self.builder.window_sensitive(False)
>          selected_image =3D self.image_combo.get_active_text()
> -        if not selected_image:
> +        if not selected_image or (selected_image =3D=3D
> self.__dummy_image__):
>              return
>=20
> +        # remove __dummy_image__ item from the store list after first
> user selection
> +        # because it is no longer valid
> +        combo_store =3D combo.get_model()
> +        if len(combo_store) and (combo_store[0][0] =3D=3D
> self.__dummy_image__):
> +            combo.remove_text(0)
> +
>          self.builder.customized =3D False
>=20
>          selected_recipes =3D []
> @@ -356,14 +371,14 @@ class ImageConfigurationPage (HobPage):
>              path =3D image_model.get_path(it)
>              it =3D image_model.iter_next(it)
>              image_name =3D image_model[path][recipe_model.COL_NAME]
> -            if image_name =3D=3D
> self.builder.recipe_model.__dummy_image__:
> +            if image_name =3D=3D
> self.builder.recipe_model.__custom_image__:
>                  continue
>              self.image_combo.append_text(image_name)
>              if image_name =3D=3D selected_image:
>                  active =3D cnt
>              cnt =3D cnt + 1
> -
> self.image_combo.append_text(self.builder.recipe_model.__dummy_image__)
> -        if selected_image =3D=3D self.builder.recipe_model.__dummy_image=
__:
> +
> self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
> +        if selected_image =3D=3D self.builder.recipe_model.__custom_imag=
e__:
>              active =3D cnt
>=20
>          self.image_combo.set_active(-1) @@ -371,6 +386,10 @@ class
> ImageConfigurationPage (HobPage):
>=20
>          if active !=3D -1:
>              self.show_baseimg_selected()
> +        else:
> +            # Set a indicator text to combo store when first open
> +            self.image_combo.insert_text(0, self.__dummy_image__)
> +            self.image_combo.set_active(0)
>=20
>          self._image_combo_connect_signal()
>=20
> diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> index 6bc9c16..5164999 100755
> --- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -219,7 +219,7 @@ class RecipeSelectionPage (HobPage):
>          self.refresh_selection()
>          if not self.builder.customized:
>              self.builder.customized =3D True
> -            self.builder.configuration.selected_image =3D
> self.recipe_model.__dummy_image__
> +            self.builder.configuration.selected_image =3D
> + self.recipe_model.__custom_image__
>              self.builder.rcppkglist_populated()
>=20
>          self.builder.window_sensitive(True)
> --
> 1.7.5.4
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


