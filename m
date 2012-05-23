Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SX4vO-0003et-Km
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 08:19:58 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 22 May 2012 23:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="103191494"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 22 May 2012 23:09:47 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 22 May 2012 23:09:47 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.90]) with mapi id
	14.01.0355.002; Wed, 23 May 2012 14:09:46 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 5/5] Hob: fixed the issue about the
	'run	image' page should have the primary bug
Thread-Index: AQHNN1+CcJZZgxIqJE66MQSSX3uUbZbW5lxg
Date: Wed, 23 May 2012 06:09:46 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BADA10@SHSMSX102.ccr.corp.intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
	<b57883e090aaf1ecc3b792f7deceb01c2a802177.1337610738.git.limingx.l.an@intel.com>
In-Reply-To: <b57883e090aaf1ecc3b792f7deceb01c2a802177.1337610738.git.limingx.l.an@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] Hob: fixed the issue about the 'run	image' page should have the primary bug
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
X-List-Received-Date: Wed, 23 May 2012 06:19:58 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

As we discussed today, the primary button should be orange as well.

--
Shane

Liming An wrote on=A02012-05-21:

> issues: when build a image for atom-pc, the output does not include live
> image, and 'Save as template' should become the primary action on the
> screen
>=20
> [YOCTO 2326]
>=20
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py index f517544..1538376
> 100755 --- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py +++
> b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py @@ -202,7 +202,7 @@ class
> ImageDetailsPage (HobPage):
>=20
>          # Name
>          self.image_store.clear()
> -        default_toggled =3D False
> +        default_toggled =3D ""
>          default_image_size =3D 0
>          num_toggled =3D 0
>          i =3D 0
> @@ -212,18 +212,20 @@ class ImageDetailsPage (HobPage):
>                  or self.test_deployable(image_name)
>              if not default_toggled:
> -                default_toggled =3D is_toggled
>                  if i =3D=3D (len(image_names) - 1):
> -                    default_toggled =3D True
> -                self.image_store.set(self.image_store.append(), 0,
> image_name, 1, image_size, 2, default_toggled)
> -                if default_toggled:
> +                    is_toggled =3D True
> +                self.image_store.set(self.image_store.append(), 0,
> image_name, 1, image_size, 2, is_toggled)
> +                if is_toggled:
>                      default_image_size =3D image_size
> -                    self.create_bottom_buttons(self.buttonlist,
> image_name) +                    default_toggled =3D image_name +
>              else:
>                  self.image_store.set(self.image_store.append(), 0,
> image_name, 1, image_size, 2, False)
>              i =3D i + 1
>              num_toggled +=3D is_toggled
> +        self.create_bottom_buttons(self.buttonlist, default_toggled)
> +
>          if build_succeeded and (num_toggled < 2):
>              varlist =3D ["Name: ", "Directory: "]
>              vallist =3D []




