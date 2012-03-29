Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SD55T-0000DR-DR
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 04:27:43 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 28 Mar 2012 19:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="82864537"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 28 Mar 2012 19:18:39 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 28 Mar 2012 19:18:38 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 29 Mar 2012 10:18:37 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/6] Hob tweaks & fixes
Thread-Index: AQHNDUMxDLmzYBUW/kKPyBxvI8AbE5aAieyA
Date: Thu, 29 Mar 2012 02:18:37 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFDCAF@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Hob tweaks & fixes
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
X-List-Received-Date: Thu, 29 Mar 2012 02:27:43 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ACK.

--
Shane

Joshua Lock wrote on=A02012-03-29:

> Here are some more minor fixes for Hob, please review and consider for
> inclusion.
>=20
> Regards,
> Joshua
>=20
> The following changes since commit
> f9cf2671c0ecad153db11bca1aebe151213bfb42:
>=20
>   bb.build: use relative log links, not absolute (2012-03-28 22:28:00 +01=
00)
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> Joshua Lock (6):
>   lib/bb/ui/crumbs/hobwidget: add padding to HobImageButton
>   lib/bb/ui/crumbs/imageconfigurationpage: add extra space between
>     widgets
>   lib/bb/ui/crumbs/hobwidget: change text sizes in HobImageButton
>   lib/bb/ui/crumbs/builder: allow user to cancel Layer selection
>     dialogue lib/bb/ui/crumbs: hob progress bar should not be red when
>     user stops build
>   lib/bb/ui/crumbs/hig: fix layers_changed test
>  lib/bb/ui/crumbs/builddetailspage.py       |    2 +-
>  lib/bb/ui/crumbs/builder.py                |   25
>  +++++++++++++++++-------- lib/bb/ui/crumbs/hig.py                    |=20
>    7 +++++-- lib/bb/ui/crumbs/hobwidget.py              |    6 +++---
>  lib/bb/ui/crumbs/imageconfigurationpage.py |    4 ++--
>  lib/bb/ui/crumbs/progressbar.py            |    8 +++++--- 6 files
>  changed, 33 insertions(+), 19 deletions(-)




