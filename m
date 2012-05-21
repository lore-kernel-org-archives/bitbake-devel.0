Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SWGw9-0005yI-II
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 02:57:26 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 20 May 2012 17:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="102198646"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 20 May 2012 17:47:16 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sun, 20 May 2012 17:47:16 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.6]) with mapi id
	14.01.0355.002; Mon, 21 May 2012 08:47:14 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/2][PULL] Hob: Add white/black pattern
	to	filter images
Thread-Index: AQHNMl99M+YHe3eIqEOlzv6ZJH/UnJbTca9w
Date: Mon, 21 May 2012 00:47:13 +0000
Message-ID: <40776A41FC278F40B59438AD47D147A90FD77FDC@SHSMSX102.ccr.corp.intel.com>
References: <cover.1337060999.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1337060999.git.dongxiao.xu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/2][PULL] Hob: Add white/black pattern to	filter images
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
X-List-Received-Date: Mon, 21 May 2012 00:57:26 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Do you have comments on this one?

Thanks,
Dongxiao

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
> Dongxiao Xu
> Sent: Tuesday, May 15, 2012 1:52 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 0/2][PULL] Hob: Add white/black pattern t=
o
> filter images
>=20
> Hi Richard,
>=20
> This pull request adds white/black pattern to filter images listed in ima=
ge
> combobox.
>=20
> Besides, it fixes a small issue on update_image_desc() function.
>=20
> Please help to review and pull.
>=20
> Thanks,
> Dongxiao
>=20
> The following changes since commit
> f8bf4499549f978ce7c93bc088a66f74cd751e2c:
>=20
>   setup.py: fix path for bitbake-selftest (2012-05-13 20:01:59 +0100)
>=20
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Ddxu4/hob-bugfix
>=20
> Dongxiao Xu (2):
>   Hob: Add filter for images listed in image combo
>   Hob: Get image name internally when updating the image description
>=20
>  lib/bb/ui/crumbs/builder.py                |    6 +++-
>  lib/bb/ui/crumbs/hobeventhandler.py        |    2 +
>  lib/bb/ui/crumbs/imageconfigurationpage.py |   42
> ++++++++++++++++++++++++----
>  3 files changed, 43 insertions(+), 7 deletions(-)
>=20
> --
> 1.7.4.1
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


