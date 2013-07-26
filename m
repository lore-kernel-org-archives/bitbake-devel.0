Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BAFA66041D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 15:10:08 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jul 2013 08:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,752,1367996400"; d="scan'208";a="376615514"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2013 08:10:06 -0700
Received: from irsmsx106.ger.corp.intel.com (163.33.3.31) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Fri, 26 Jul 2013 16:10:05 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.64]) by
	IRSMSX106.ger.corp.intel.com ([169.254.8.233]) with mapi id
	14.03.0123.003; Fri, 26 Jul 2013 16:10:05 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH_V2 13/16] bitbake: save packages in
	IMAGE_INSTALL instead of PACKAGE_INSTALL
Thread-Index: AQHOiSvUkBLzJ2kePU2wuxNyiUxcjJl28/oAgAAWD0D///YRAIAAEToA
Date: Fri, 26 Jul 2013 15:10:04 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F42B9@IRSMSX105.ger.corp.intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1972381.8tId4Nj9gB@helios>
	<BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F428A@IRSMSX105.ger.corp.intel.com>
	<8489419.sH39sV5aTi@helios>
In-Reply-To: <8489419.sH39sV5aTi@helios>
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
X-List-Received-Date: Fri, 26 Jul 2013 15:10:08 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, you are right. I did not think about the case when you remove packages=
..
I will correct this and the other mistakes.
Thanks,
Cristiana

-----Original Message-----
From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]=20
Sent: Friday, July 26, 2013 6:06 PM
To: Voicu, Cristiana
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH_V2 13/16] bitbake: save packages in IMA=
GE_INSTALL instead of PACKAGE_INSTALL

On Friday 26 July 2013 14:48:24 Voicu, Cristiana wrote:
> There is for sure a previous value, because all the recipes saved this=20
> way require an image from the layers. Regarding the "append" suffix,=20
> I've found in the documentation that : When you use this variable, it=20
> is best to use it as follows:
>=20
>      IMAGE_INSTALL_append =3D " package-name"

That's more about using it in local.conf than individual image recipes.

I had forgotten that we were "require"ing an existing recipe here and misse=
d it in the code. However isn't there then a problem if you use _append and=
 the user wants to remove something added by the original image using Hob? =
Won't the removed package just be forced back in by virtue of appending to =
the original value of IMAGE_INSTALL?

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

