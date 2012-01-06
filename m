Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj6DT-00005k-76
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:36:03 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 06 Jan 2012 01:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="93588265"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by orsmga001.jf.intel.com with ESMTP; 06 Jan 2012 01:28:38 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 6 Jan 2012 17:28:36 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.199]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.223]) with mapi id
	14.01.0355.002; Fri, 6 Jan 2012 17:28:33 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1][PULL] hob: A new implementation
	for	Human Oriented Builder
Thread-Index: AQHMzFRbgKN2e96dpkOu48DHhhsrK5X/EgLw
Date: Fri, 6 Jan 2012 09:28:32 +0000
Message-ID: <40776A41FC278F40B59438AD47D147A90159AE@SHSMSX102.ccr.corp.intel.com>
References: <cover.1325841596.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325841596.git.dongxiao.xu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/1][PULL] hob: A new implementation for	Human Oriented Builder
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
X-List-Received-Date: Fri, 06 Jan 2012 09:36:03 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi List,

The [PATCH 1/1] is a big change and the mail size exceeds 40KB. If you want=
 to see the commit,
please refer to http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=
=3Ddxu4/hob&id=3D4c725f3fd2971b8ca20611c61dfbe240bfcca59a

Thanks,
Dongxiao

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
> Dongxiao Xu
> Sent: Friday, January 06, 2012 5:22 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 0/1][PULL] hob: A new implementation for
> Human Oriented Builder
>=20
> Hi Richard,
>=20
> This pull request is a new implementation for hob.
> Please help to review and pull.
>=20
> Note that this change has dependency on hob-bitbake-changes and
> hob-oecore-changes.
>=20
> Thanks,
> Dongxiao
>=20
> The following changes since commit
> c9c075648019ee0f55b2ed916b40567307cd5674:
>   Dongxiao Xu (1):
>         runqueue: fire sceneQueueTaskStarted event when a setscene queue
> starts
>=20
> are available in the git repository at:
>=20
>   git://git.pokylinux.org/poky-contrib dxu4/hob
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Ddxu4/hob
>=20
> Dongxiao Xu (1):
>   Hob2: A new implemetation for Human Oriented Builder
>=20
>  bitbake/lib/bb/ui/crumbs/advancedsetting.py  |  246 ++++
>  bitbake/lib/bb/ui/crumbs/hobwidget.py        |  524 ++++++++
>  bitbake/lib/bb/ui/crumbs/layerselection.py   |  107 ++
>  bitbake/lib/bb/ui/crumbs/packagelistmodel.py |  552 ++++++++
>  bitbake/lib/bb/ui/crumbs/progressbar.py      |  184 +++
>  bitbake/lib/bb/ui/crumbs/recipelistmodel.py  |  860 +++++++++++++
>  bitbake/lib/bb/ui/crumbs/template.py         |  189 +++
>  lib/bb/ui/crumbs/configurator.py             |  346 -----
>  lib/bb/ui/crumbs/hobeventhandler.py          |  392 +++---
>  lib/bb/ui/crumbs/hobprefs.py                 |  335 -----
>  lib/bb/ui/crumbs/layereditor.py              |  153 ---
>  lib/bb/ui/crumbs/progress.py                 |   20 -
>  lib/bb/ui/crumbs/runningbuild.py             |   15 +-
>  lib/bb/ui/crumbs/tasklistmodel.py            |  620 ---------
>  lib/bb/ui/hob.py                             | 1736
> ++++++++++++--------------
>  lib/bb/ui/uihelper.py                        |   42 +
>  16 files changed, 3716 insertions(+), 2605 deletions(-)  create mode 100=
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


