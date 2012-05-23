Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SX0dX-0000mk-9G
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 03:45:15 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 22 May 2012 18:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="103123588"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 22 May 2012 18:35:05 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 22 May 2012 18:35:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.6]) with mapi id
	14.01.0355.002; Wed, 23 May 2012 09:35:02 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Xu, Jiajun" <jiajun.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 0/4] Replace HobNotebook with
	gtk.Notebook,	comments invited
Thread-Index: AQHNGcyjbg38xxk96UmyJK1/SAMVwpbW1Dvg
Date: Wed, 23 May 2012 01:35:02 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BAD871@SHSMSX102.ccr.corp.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Replace HobNotebook with gtk.Notebook, comments invited
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
X-List-Received-Date: Wed, 23 May 2012 01:45:15 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Josh, I just found I can't run Hob on my Ubuntu 10.04 after I checked out t=
he latest master.

Since Ubuntu 10.04 is a long-term-support version, can we do something to m=
ake Hob compatible with that?
What kind of failure did you meet on Ubuntu 10.04?

--
Shane

Joshua Lock wrote on=A02012-04-14:

> *** This series prevents users of distros with old Gtk+ releases using Ho=
b ***
>=20
> This is a follow-on from my RFC of yesterday with a similar title. Sadly =
I
> hadn't realised that one of the API calls I am using is not available in =
the
> version of gtk+ shipped with CentOS 6 (gtk.Notebook.set_action_widget).
>=20
> This change will prevent CentOS 6 users from being able to use Hob.
>=20
> I spent some time in Gtk+ internals trying to figure out if we can
> emulate the behaviour on older versions but the GtkNotebook widget
> internals were enhanced significantly to support the set_action_widget
> API.
>=20
> I've submitted the change as an RFC regardless, it's ready to merge if we=
're
> willing to make the sacrifice.
>=20
> The primary motivation for making this change, and making it so late in
> the cycle, is maintainability. The diffstat says it all - we're
> replacing an ~400LOC custom widget with a ~100LOC set of 3 widgets which
> subclass standard toolkit widgets.
>=20
> An added benefit is that standard toolkit widgets generally integrate bet=
ter
> into the users OS thanks to inheriting their standard theme.
>=20
> Tested on:
> Fedora 16 (x86_64) - PASS
> CentOS 6.2 (x86_64) - FAIL: Gtk+ version too old
> Ubuntu 10.04 (x86_64) - Fail: pygtk version too old
> Ubuntu 12.04 Beta (x86_64) - PASS
>=20
> Per the final patch in the series the changes here require gtk+-2.20 or n=
ewer
> and pygtk 2.22 or newer.
>=20
> Cheers,
> Joshua
>=20
> The following changes since commit
> 434fdb3913cc78e2e9cdeede4c4fa7f1c8ef8892:
>=20
>   Hob: Added required packages for toolchain. (2012-04-13 12:00:12 +0100)
> are available in the git repository at:
>   git://github.com/incandescant/bitbake gtk2.20
>   https://github.com/incandescant/bitbake/tree/gtk2.20
> Joshua Lock (4):
>   lib/bb/ui/crumbs/: replace custom HobNotebook
>   lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
>   lib/bb/ui/crumbs/imageconfiguration: fix combo boxes drop-down width
>   hob: update required pygtk to 2.22.0 and gtk+ to 2.20.0
>  lib/bb/ui/crumbs/builddetailspage.py       |    6 +-
>  lib/bb/ui/crumbs/hobwidget.py              |  499
>  +++++++--------------------- lib/bb/ui/crumbs/imageconfigurationpage.py
>  |    2 - lib/bb/ui/crumbs/packageselectionpage.py   |    3 +-
>  lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +- lib/bb/ui/hob.py =20
>                          |    2 +- 6 files changed, 120 insertions(+),
>  397 deletions(-)



