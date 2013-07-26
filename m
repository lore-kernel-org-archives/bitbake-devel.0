Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 2BB6960017
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 14:48:37 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Jul 2013 07:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,751,1367996400"; d="scan'208";a="371749564"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2013 07:48:27 -0700
Received: from irsmsx152.ger.corp.intel.com (163.33.192.66) by
	IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Fri, 26 Jul 2013 15:48:25 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.64]) by
	IRSMSX152.ger.corp.intel.com ([169.254.6.33]) with mapi id
	14.03.0123.003; Fri, 26 Jul 2013 15:48:25 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH_V2 13/16] bitbake: save packages in
	IMAGE_INSTALL instead of PACKAGE_INSTALL
Thread-Index: AQHOiSvUkBLzJ2kePU2wuxNyiUxcjJl28/oAgAAWD0A=
Date: Fri, 26 Jul 2013 14:48:24 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F428A@IRSMSX105.ger.corp.intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1374752549-29471-14-git-send-email-cristiana.voicu@intel.com>
	<1972381.8tId4Nj9gB@helios>
In-Reply-To: <1972381.8tId4Nj9gB@helios>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH_V2 13/16] bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Jul 2013 14:48:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

There is for sure a previous value, because all the recipes saved this way =
require an image from the layers.
Regarding the "append" suffix, I've found in the documentation that :
When you use this variable, it is best to use it as follows:

     IMAGE_INSTALL_append =3D " package-name"

Here is the link: http://www.yoctoproject.org/docs/current/mega-manual/mega=
-manual.html#var-IMAGE_INSTALL

And yes, I have missed a space.=20
Thanks,
Cristiana

-----Original Message-----
From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]=20
Sent: Friday, July 26, 2013 5:22 PM
To: Voicu, Cristiana
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH_V2 13/16] bitbake: save packages in IMA=
GE_INSTALL instead of PACKAGE_INSTALL

Hi Cristiana,

On Thursday 25 July 2013 14:42:26 Cristiana Voicu wrote:
> Hob retrieves the list of recipes and packages using the IMAGE_INSTALL=20
> variable, so a custom image should be saved using this variable.
> Changed how the image is saved in a bb file
>=20
> [YOCTO #4193]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/cooker.py |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py index=20
> ad92dea..48be434 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1159,11 +1159,11 @@ class BBCooker:
>                  if topdir in base_image:
>                      base_image =3D require_line.split()[1]
>                  imagefile.write("require " + base_image + "\n")
> -            package_install =3D "PACKAGE_INSTALL_forcevariable =3D \""
> +            image_install =3D "IMAGE_INSTALL_append =3D \""
>              for package in package_queue:
> -                package_install +=3D str(package) + " "
> -            package_install +=3D "\"\n"
> -            imagefile.write(package_install)
> +                image_install +=3D str(package) + " "
> +            image_install +=3D "\"\n"
> +            imagefile.write(image_install)
>=20
>              description_var =3D "DESCRIPTION =3D \"" + description + "\"=
\n"
>              imagefile.write(description_var)

If this is within the image recipe it should be using IMAGE_INSTALL =3D rat=
her than appending to an existing value. At the moment it looks like you're=
 using _append with no leading space which could interact poorly with any p=
revious value set, and in any case I'm not entirely sure we need to support=
 having a previous value in there within this context.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

