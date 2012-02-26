Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S1YE7-00079i-AK
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 08:08:59 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Feb 2012 22:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121478255"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2012 22:59:28 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Sun, 26 Feb 2012 14:59:27 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Sun, 26 Feb 2012 14:59:26 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/6] Hob tweaks
Thread-Index: AQHM813Vyr1p0fHrPkSAhQycgVjEHJZOwOPg
Date: Sun, 26 Feb 2012 06:59:26 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC0FD00966@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Hob tweaks
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
X-List-Received-Date: Sun, 26 Feb 2012 07:08:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ACK all 6 patches.

But hold on a second to check in, since we have some fixes locally and I wi=
ll rebase yours.

--
Shane

Joshua Lock wrote on=A02012-02-25:

> Here's a first pass of tweaks for the Hob GUI based on a brief
> interaction with the landing page of the GUI. It's by no means a perfect
> set of changes, my HIG related tweaks are based on memory and examples
> in the code that remains from Hob v1.
>=20
> If nothing else the button ordering will need fixing fairly soonish as
> regular Linux Gtk+ desktop users like myself will soon start clicking
> the wrong buttons due to the inverted order.
>=20
> Cheers,
> Joshua
>=20
> CC: Dongxiao Xu <dongxiao.xu@intel.com>
>=20
> The following changes since commit
> c7486a09310fe63b1aa1b7b0bb9450f306b6093b:
>=20
>   bitbake/cooker: terminate when errors found in layer configuration
> (2012-02-24 23:30:16 +0000)
>=20
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> Joshua Lock (6):
>   crumbs: Factor common dialogue configuration out
>   crumbs/builder: use the name Hob consistently
>   crumbs: move towards more standard dialogue spacing
>   crumbs: fix button order in several dialogues
>   hig: try to avoid setting explicit dialogue sizes
>   crumbs/hig: tweak UI and layout of LayerSelectionDialog
>  lib/bb/ui/crumbs/builder.py   |   56 +++++++++++-----------
>  lib/bb/ui/crumbs/hig.py       |  102
>  +++++++++++++++++++--------------------- lib/bb/ui/crumbs/hobwidget.py
>  |   12 ++-- 3 files changed, 82 insertions(+), 88 deletions(-)



