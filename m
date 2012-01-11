Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rkocb-0005vR-3w
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 04:13:05 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 10 Jan 2012 19:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="94566810"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by azsmga001.ch.intel.com with ESMTP; 10 Jan 2012 19:05:33 -0800
Received: from pgsmsx104.gar.corp.intel.com (10.221.44.91) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 11 Jan 2012 11:05:17 +0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX104.gar.corp.intel.com (10.221.44.91) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 11 Jan 2012 11:05:16 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.88]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.223]) with mapi id
	14.01.0355.002; Wed, 11 Jan 2012 11:05:16 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1 v2][PULL] Hob: a new implementation
	for	human oriented builder
Thread-Index: AQHM0A2QTNMla1FsY0qNCIBlFxIFdJYGe0CQ
Date: Wed, 11 Jan 2012 03:05:15 +0000
Message-ID: <40776A41FC278F40B59438AD47D147A90FCA142F@SHSMSX102.ccr.corp.intel.com>
References: <cover.1326250200.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326250200.git.dongxiao.xu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/1 v2][PULL] Hob: a new implementation for	human oriented builder
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
X-List-Received-Date: Wed, 11 Jan 2012 03:13:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi List,

The [PATCH 1/1] is too big for mailing list, if you want to read the code, =
please refer to:
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Ddxu4/hob=
-v2&id=3D1ece4fdbc9f352e7adbe37a2793a8b738392fca9

Thanks,
Dongxiao

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
> Dongxiao Xu
> Sent: Wednesday, January 11, 2012 11:05 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 0/1 v2][PULL] Hob: a new implementation f=
or
> human oriented builder
>=20
> Hi Richard,
>=20
> This is the second pull request for hob new implementation.
>=20
> Please help to review and pull.
>=20
> Note this pull request has dependency on dxu4/hob-bitbake-changes-v2 and
> dxu4/hob-oecore-changes-v2.
>=20
> Changes from v1:
> 1. Change according to the new package dump mechanism.
>=20
> Thanks,
> Dongxiao
>=20
> The following changes since commit
> 1fd378dbf9689d3597cb15efe866f39ca4e3dfb7:
>   Dongxiao Xu (1):
>         runqueue: fire sceneQueueTaskStarted event when a setscene queue
> starts
>=20
> are available in the git repository at:
>=20
>   git://git.pokylinux.org/poky-contrib dxu4/hob-v2
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Ddxu4/hob-v2
>=20
> Dongxiao Xu (1):
>   Hob: A new implemetation for Human Oriented Builder
>=20
>  bitbake/lib/bb/ui/crumbs/advancedsetting.py  |  246 ++++
>  bitbake/lib/bb/ui/crumbs/hobwidget.py        |  524 ++++++++
>  bitbake/lib/bb/ui/crumbs/layerselection.py   |  107 ++
>  bitbake/lib/bb/ui/crumbs/packagelistmodel.py |  580 +++++++++
>  bitbake/lib/bb/ui/crumbs/progressbar.py      |  184 +++
>  bitbake/lib/bb/ui/crumbs/recipelistmodel.py  |  860 +++++++++++++
>  bitbake/lib/bb/ui/crumbs/template.py         |  189 +++
>  lib/bb/ui/crumbs/configurator.py             |  346 -----
>  lib/bb/ui/crumbs/hobeventhandler.py          |  396 +++---
>  lib/bb/ui/crumbs/hobprefs.py                 |  335 -----
>  lib/bb/ui/crumbs/layereditor.py              |  153 ---
>  lib/bb/ui/crumbs/progress.py                 |   20 -
>  lib/bb/ui/crumbs/runningbuild.py             |   15 +-
>  lib/bb/ui/crumbs/tasklistmodel.py            |  620 ---------
>  lib/bb/ui/hob.py                             | 1731
> ++++++++++++--------------
>  lib/bb/ui/uihelper.py                        |   42 +
>  16 files changed, 3735 insertions(+), 2613 deletions(-)  create mode 100=
644
> bitbake/lib/bb/ui/crumbs/advancedsetting.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/hobwidget.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/layerselection.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/packagelistmodel.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/progressbar.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/recipelistmodel.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/template.py
>  delete mode 100644 lib/bb/ui/crumbs/configurator.py  delete mode 100644
> lib/bb/ui/crumbs/hobprefs.py  delete mode 100644
> lib/bb/ui/crumbs/layereditor.py  delete mode 100644
> lib/bb/ui/crumbs/progress.py  delete mode 100644
> lib/bb/ui/crumbs/tasklistmodel.py  mode change 100644 =3D> 100755
> lib/bb/ui/hob.py
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


