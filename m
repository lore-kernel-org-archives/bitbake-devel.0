Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCXJ8-0000Qa-FA
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 16:23:34 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Mar 2012 07:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="82120168"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2012 07:14:31 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 27 Mar 2012 07:14:30 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Tue, 27 Mar 2012 22:14:29 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/4] More Hob tweaks
Thread-Index: AQHNC8pbp4tuiuN8+U+SCbHPV9wSPJZ+L8NA
Date: Tue, 27 Mar 2012 14:14:28 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFB733@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] More Hob tweaks
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
X-List-Received-Date: Tue, 27 Mar 2012 14:23:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ACK.

But I also persist in my opinion for the fix that there would be only one b=
utton "Close" for layer dialog;-)

--
Shane

Joshua Lock wrote on=A02012-03-27:

> Hi all,
>=20
> Here's some more tweaks for Hob.
>=20
> The primary/secondary button styling change is similar to the same titled
> patch I submitted recently only the 'Advanced settings' dialogue retains =
it's
> Save/Cancel buttons.
>=20
> I've also included some layout changes to match design and ensure the
> widgets are not moved around when re-drawing the layout.
>=20
> Cheers,
> Joshua
>=20
> The following changes since commit
> 02d3451b2e0744204a1280f9effe9fd862bb4faf:
>=20
>   Hob: add build status labels in the build details screen to make it mor=
e
> close to the visual design (2012-03-25 12:13:58 +0100)
>=20
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> Joshua Lock (4):
>   lib/bb/ui/crumbs: apply primary/secondary dialogue button styling
>   lib/bb/ui/crumbs: tweak build status display
>   lib/bb/ui/crumbs/imageconfigurationpage: ensure widgets stay
>     positioned lib/bb/ui/crumbs/imagedetails: use secondary button style
>     for 'View files'
>  lib/bb/ui/crumbs/builddetailspage.py       |    9 ++-
>  lib/bb/ui/crumbs/builder.py                |  111
>  +++++++++++++++++---------- lib/bb/ui/crumbs/hig.py                  =20
>  |   34 +++++---- lib/bb/ui/crumbs/imageconfigurationpage.py |   20
>  ++++-- lib/bb/ui/crumbs/imagedetailspage.py       |    6 +- 5 files
>  changed, 115 insertions(+), 65 deletions(-)



