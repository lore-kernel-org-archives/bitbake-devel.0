Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rcb4f-0004Hy-RQ
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Dec 2011 12:08:06 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 19 Dec 2011 03:01:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="87197766"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by azsmga001.ch.intel.com with ESMTP; 19 Dec 2011 03:01:01 -0800
Received: from pgsmsx104.gar.corp.intel.com (10.221.44.91) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 19 Dec 2011 19:01:00 +0800
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	PGSMSX104.gar.corp.intel.com (10.221.44.91) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Mon, 19 Dec 2011 19:00:59 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi;
	Mon, 19 Dec 2011 19:00:59 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 19 Dec 2011 19:00:58 +0800
Thread-Topic: [bitbake-devel] [PATCH 00/10 v2] Hob2 related bitbake changes
Thread-Index: Acy6+TIS+R4DTnXdR9S0wyQQ/5OIrwDRDSGw
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12ED44B5F8@shsmsx501.ccr.corp.intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Subject: Re: [PATCH 00/10 v2] Hob2 related bitbake changes
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
X-List-Received-Date: Mon, 19 Dec 2011 11:08:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Could you hold this patchset for a moment? I have some new version for it a=
nd will send out soon.
Sorry for inconvenience.

Thanks,
Dongxiao

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
> Dongxiao Xu
> Sent: Thursday, December 15, 2011 3:15 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 00/10 v2] Hob2 related bitbake changes
>=20
> Hi Richard,
>=20
> This pull request is the second version that introduces several hob2 rela=
ted
> bitbake changes.
> Please help to review and pull.
>=20
> Changes from v1:
> Add "resolve" option in generateTargetsTree() instead of adding a new
> generateTargetsTreePro function. Thanks for Josh's suggestions.
>=20
> Thanks,
> Dongxiao
>=20
> The following changes since commit
> 71b53a3f0766ca464560a1f6a449f9424fbdf7ae:
>   Matthew McClintock (1):
>         siggen.py: If both sigs have a variable in it's whitelist then do=
n't say it's
> changed
>=20
> are available in the git repository at:
>=20
>   git://git.pokylinux.org/poky-contrib dxu4/hob2-bitbake-change-v2
>=20
> http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Ddxu4/hob2-bitbake=
-chang
> e-v2
>=20
> Dongxiao Xu (10):
>   command.py: Modify needcache value for certain functions
>   cache: Use configuration's hash value to validate cache
>   cooker: user bb.configuration.data to inject events
>   command.py: add initCooker API
>   command.py: add parseConfigurationFiles API
>   command.py: add resolve option for generateTargetsTree API
>   event.py: Add a new event PackageInfo
>   xmlrpc: Change BitbakeServerInfo init function
>   cooker: remove command import in cooker.py
>   bitbake: add a new option "--server-only"
>=20
>  bin/bitbake             |   23 +++++++++++++------
>  lib/bb/cache.py         |   32 ++++++++++-----------------
>  lib/bb/command.py       |   31 +++++++++++++++++++++++---
>  lib/bb/cooker.py        |   55
> ++++++++++++++++++++++++++++++++++++++--------
>  lib/bb/data_smart.py    |   17 ++++++++++++++
>  lib/bb/event.py         |    9 +++++++
>  lib/bb/server/xmlrpc.py |    8 +++---
>  7 files changed, 130 insertions(+), 45 deletions(-)
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


