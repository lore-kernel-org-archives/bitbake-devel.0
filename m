Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SbndZ-0007Jd-OG
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 08:53:05 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 04 Jun 2012 23:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151675880"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 04 Jun 2012 23:42:38 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 4 Jun 2012 23:42:37 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.56]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.90]) with mapi id
	14.01.0355.002; Tue, 5 Jun 2012 14:42:37 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Kang Kai <kai.kang@windriver.com>, "dvhart@linux.intel.com"
	<dvhart@linux.intel.com>
Thread-Topic: [PATCH 2/2] hob2: create a standalone deploy image tool
Thread-Index: AQHNQsyarcFwxg71kUWiyI42avfNLJbrQqgQ
Date: Tue, 5 Jun 2012 06:42:36 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
In-Reply-To: <df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"zhenfeng.zhao@windriver.com" <zhenfeng.zhao@windriver.com>
Subject: Re: [PATCH 2/2] hob2: create a standalone deploy image tool
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
X-List-Received-Date: Tue, 05 Jun 2012 06:53:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Kang Kai [mailto:kai.kang@windriver.com]
> Sent: Tuesday, June 05, 2012 11:37 AM
> To: dvhart@linux.intel.com
> Cc: Wang, Shane; zhenfeng.zhao@windriver.com;
> bitbake-devel@lists.openembedded.org
> Subject: [PATCH 2/2] hob2: create a standalone deploy image tool
>=20
> [Yocto 2388]
>=20
> Create a standalone deploy image tool using the existing dialog
> including DeployImageDialog and ImageSelectionDialog.
>=20
> Duplicate the gtk and pygtk versions check in the hob.py because this
> will be run separately.
>=20
> Update ui/crumbs/utils.py that it needs to 'import bb' when run this
> tool.
>=20
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/bin/bitbake-deployimage   |  135
> +++++++++++++++++++++++++++++++++++++
>  bitbake/lib/bb/ui/crumbs/utils.py |    1 +
>  2 files changed, 136 insertions(+), 0 deletions(-)
>  create mode 100755 bitbake/bin/bitbake-deployimage
>=20
> diff --git a/bitbake/bin/bitbake-deployimage
> b/bitbake/bin/bitbake-deployimage
> new file mode 100755
> index 0000000..8fdd21b
> --- /dev/null
> +++ b/bitbake/bin/bitbake-deployimage
> @@ -0,0 +1,135 @@
> +#!/usr/bin/python
> +
> +
> +requirements =3D "FATAL: Gtk+ 2.20.0 or higher, PyGtk version 2.22.0 or =
higher
> and PyGobject are required to use Hob"
Kai, I don't like you have this kind of limitation for GTK and PyGTK.
Hob.py does have because we want special efforts on the visual components. =
For this simple app,
I don't want you to exclude a lot of users who only have lower versions.



> diff --git a/bitbake/lib/bb/ui/crumbs/utils.py
> b/bitbake/lib/bb/ui/crumbs/utils.py
> index cd01a04..939864f 100644
> --- a/bitbake/lib/bb/ui/crumbs/utils.py
> +++ b/bitbake/lib/bb/ui/crumbs/utils.py
> @@ -22,6 +22,7 @@
>  # bitbake which will allow more flexibility.
>=20
>  import os
> +import bb
Why is this needed? I don't see any change you made in utils.py.
Is that to say without this line, the functions in utils.py don't work?

>=20
>  def which_terminal():
>      term =3D bb.utils.which(os.environ["PATH"], "xterm")
> --
> 1.7.5.4



