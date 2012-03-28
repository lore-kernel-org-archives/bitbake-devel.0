Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCk1A-0006tf-73
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 05:57:52 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 27 Mar 2012 20:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124108779"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 27 Mar 2012 20:48:48 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 27 Mar 2012 20:48:48 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Wed, 28 Mar 2012 11:48:40 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 5/6] Hob: change the implementing way
	about	get config info for building log
Thread-Index: AQHNDEb3EV1VqJTUPUmjHWqLYlSWzJZ/EXZw
Date: Wed, 28 Mar 2012 03:48:39 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFC23F@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
	<46d12470802e12814f5ecef4f7e676cd5c1784a1.1332871932.git.limingx.l.an@intel.com>
In-Reply-To: <46d12470802e12814f5ecef4f7e676cd5c1784a1.1332871932.git.limingx.l.an@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] Hob: change the implementing way about	get config info for building log
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
X-List-Received-Date: Wed, 28 Mar 2012 03:57:52 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
> Liming An
> Sent: Wednesday, March 28, 2012 2:26 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 5/6] Hob: change the implementing way
> about get config info for building log
>=20
> Make the building log config information to get from the bitbake paramete=
rs
> directly, and then cancel the old way of filting the building log on runn=
ing
>=20
> [YOCTO #2144]
>=20
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py |   86
> ++++++++++++++++++++++++-
>  bitbake/lib/bb/ui/crumbs/builder.py          |    7 ++
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    6 ++
>  bitbake/lib/bb/ui/crumbs/runningbuild.py     |   38 ++----------
>  4 files changed, 100 insertions(+), 37 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> index aecfadf..b69f0ca 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> +++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> @@ -32,6 +32,11 @@ from bb.ui.crumbs.hobwidget import
> HobWarpCellRendererText, HobCellRendererPixbu
>  class RunningBuildModel (gtk.TreeStore):
>      (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON,
> COL_COLOR, COL_NUM_ACTIVE) =3D range(7)
>=20
> +    __gsignals__ =3D {
> +          'update-config-info' : (gobject.SIGNAL_RUN_LAST,
> +                               gobject.TYPE_NONE,
> +                               (gobject.TYPE_STRING,)),
> +    }

That is not necessary any more.
I am going to remove it.

--
Shane


