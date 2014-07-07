Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id B2D716028A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jul 2014 06:13:43 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 06 Jul 2014 23:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,616,1400050800"; d="scan'208";a="453887387"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by azsmga001.ch.intel.com with ESMTP; 06 Jul 2014 23:13:33 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
	ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Sun, 6 Jul 2014 23:13:32 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX157.amr.corp.intel.com ([169.254.9.189]) with mapi id
	14.03.0123.003; Sun, 6 Jul 2014 23:13:32 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Yang, Liezhi (Wind River)" <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] bitbake-user-manual-intro.xml:
	update	for dump-signatures
Thread-Index: AQHPl0qBVY4SqZkVaEOAOeAG6kdbEpuUJnyQ
Date: Mon, 7 Jul 2014 06:13:31 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63A9@ORSMSX101.amr.corp.intel.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
	<29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>
In-Reply-To: <29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] bitbake-user-manual-intro.xml: update	for dump-signatures
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 07 Jul 2014 06:13:48 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch applied,=20

Thanks,=20
Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert Yang
>Sent: Thursday, July 03, 2014 10:39 PM
>To: bitbake-devel@lists.openembedded.org
>Subject: [bitbake-devel] [PATCH 2/2] bitbake-user-manual-intro.xml: update
>for dump-signatures
>
>Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>---
> .../bitbake-user-manual-intro.xml                  |   10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>index ae267b4..e4025a8 100644
>--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>@@ -471,11 +471,13 @@
>        -D, --debug           Increase the debug level. You can specify th=
is more
>                              than once.
>        -n, --dry-run         Don't execute, just go through the motions.
>-       -S DUMP_SIGNATURES, --dump-signatures=3DDUMP_SIGNATURES
>+       -S SIGNATURE_HANDLER, --dump-signatures=3DSIGNATURE_HANDLER
>                              Dump out the signature construction informat=
ion, with
>-                             no task execution. Parameters are passed to =
the
>-                             signature handling code, use 'none' if no sp=
ecific
>-                             handler is required.
>+                             no task execution. The SIGNATURE_HANDLER can=
 be none
>+                             or printdiff, while none means only dump the
>+                             signature, printdiff means compare the dumpe=
d
>+                             signature with the cached one.
>+
>        -p, --parse-only      Quit after parsing the BB recipes.
>        -s, --show-versions   Show current and preferred versions of all r=
ecipes.
>        -e, --environment     Show the global or per-package environment
>complete
>--
>1.7.9.5
>
>--
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel

