Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SEzye-0003M0-RF
	for bitbake-devel@lists.openembedded.org;
	Tue, 03 Apr 2012 11:24:37 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 03 Apr 2012 02:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
	d="scan'208,223";a="136995102"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
	by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2012 02:14:21 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.40]) by
	IRSMSX103.ger.corp.intel.com ([169.254.3.225]) with mapi id
	14.01.0355.002; Tue, 3 Apr 2012 10:13:30 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 09/10] Hob: Change base image to
	"Create your own image" if customized
Thread-Index: AQHNEXoIc8wp/sD5qEaYN6K3+dHv+w==
Date: Tue, 3 Apr 2012 09:13:29 +0000
Message-ID: <CBA07A25.C269%belen.barros.pena@intel.com>
In-Reply-To: <ee2f10ed2092ed21c7f8a0798c18404fdb30063a.1333269705.git.dongxiao.xu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.194.99]
MIME-Version: 1.0
Subject: Re: [PATCH 09/10] Hob: Change base image to "Create your own image" if customized
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
X-List-Received-Date: Tue, 03 Apr 2012 09:24:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6CEE630C263DC4A853F8FA339D00919@intel.com>
Content-Transfer-Encoding: quoted-printable

From the design side of things, I am not sure this is a good idea. I've
explicitly selected 'base image x'. If I then customise it, I still think
I am working on 'base image x'. I might not understand why my selection of
base image has been changed automatically. In general, it is not a good
idea to have software that changes things I do of its own accord. Such
behaviours undermine the sense of control users should have when
interacting with software.

Cheers

Belen

On 01/04/2012 13:14, "Dongxiao Xu" <dongxiao.xu@intel.com> wrote:

>Once user did customization to his base image, we change the base image
>to be "Create your own image" to avoid some issues caused by the
>relationship between base image and its default recipes and packages.
>
>This fixes [YOCTO #2211]
>
>Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
>---
> lib/bb/ui/crumbs/builder.py                |    3 +++
> lib/bb/ui/crumbs/imageconfigurationpage.py |    2 ++
> lib/bb/ui/crumbs/packageselectionpage.py   |    6 ++++++
> lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +++++
> 4 files changed, 16 insertions(+), 0 deletions(-)
>
>diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
>index 8427623..20d4652 100755
>--- a/lib/bb/ui/crumbs/builder.py
>+++ b/lib/bb/ui/crumbs/builder.py
>@@ -258,6 +258,9 @@ class Builder(gtk.Window):
>         self.recipe_model =3D recipe_model
>         self.package_model =3D package_model
>=20
>+        # Indicate whether user has customized the image
>+        self.customized =3D False
>+
>         # create visual elements
>         self.create_visual_elements()
>=20
>diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py
>b/lib/bb/ui/crumbs/imageconfigurationpage.py
>index 9271c48..d3cae9d 100644
>--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
>+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
>@@ -289,6 +289,8 @@ class ImageConfigurationPage (HobPage):
>         if not selected_image:
>             return
>=20
>+        self.builder.customized =3D False
>+
>         selected_recipes =3D []
>=20
>         image_path =3D self.builder.recipe_model.pn_path[selected_image]
>diff --git a/lib/bb/ui/crumbs/packageselectionpage.py
>b/lib/bb/ui/crumbs/packageselectionpage.py
>index d855e58..e071b07 100755
>--- a/lib/bb/ui/crumbs/packageselectionpage.py
>+++ b/lib/bb/ui/crumbs/packageselectionpage.py
>@@ -90,6 +90,7 @@ class PackageSelectionPage (HobPage):
>         super(PackageSelectionPage, self).__init__(builder, "Packages")
>=20
>         # set invisiable members
>+        self.recipe_model =3D self.builder.recipe_model
>         self.package_model =3D self.builder.package_model
>=20
>         # create visual elements
>@@ -193,6 +194,11 @@ class PackageSelectionPage (HobPage):
>             self.package_model.exclude_item(item_path=3Dpath)
>=20
>         self.refresh_selection()
>+        if not self.builder.customized:
>+            self.builder.customized =3D True
>+            self.builder.configuration.selected_image =3D
>self.recipe_model.__dummy_image__
>+            self.builder.rcppkglist_populated()
>+
>         self.builder.window_sensitive(True)
>=20
>     def table_toggled_cb(self, table, cell, view_path, toggled_columnid,
>view_tree):
>diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py
>b/lib/bb/ui/crumbs/recipeselectionpage.py
>index e4616a8..2d438d5 100755
>--- a/lib/bb/ui/crumbs/recipeselectionpage.py
>+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
>@@ -187,6 +187,11 @@ class RecipeSelectionPage (HobPage):
>             self.recipe_model.exclude_item(item_path=3Dpath)
>=20
>         self.refresh_selection()
>+        if not self.builder.customized:
>+            self.builder.customized =3D True
>+            self.builder.configuration.selected_image =3D
>self.recipe_model.__dummy_image__
>+            self.builder.rcppkglist_populated()
>+
>         self.builder.window_sensitive(True)
>=20
>     def table_toggled_cb(self, table, cell, view_path, toggled_columnid,
>view_tree):
>--=20
>1.7.4.1
>
>
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



