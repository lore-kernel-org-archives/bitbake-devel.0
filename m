Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 6931765CA9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jul 2014 06:00:13 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 06 Jul 2014 22:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,616,1400050800"; d="scan'208";a="453883239"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by azsmga001.ch.intel.com with ESMTP; 06 Jul 2014 22:59:55 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
	ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Sun, 6 Jul 2014 22:59:54 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX158.amr.corp.intel.com ([169.254.10.127]) with mapi id
	14.03.0123.003; Sun, 6 Jul 2014 22:59:54 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Yang, Liezhi (Wind River)" <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake-user-manual-metadata.xml:
	remove populate_staging
Thread-Index: AQHPl1N0nV5laRWcYkOMhYlUWRylbJuUIlnw
Date: Mon, 7 Jul 2014 05:59:53 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB6386@ORSMSX101.amr.corp.intel.com>
References: <cover.1404455961.git.liezhi.yang@windriver.com>
	<b1c51cb854393ae662b63034b60e1878fe7cdf14.1404455961.git.liezhi.yang@windriver.com>
In-Reply-To: <b1c51cb854393ae662b63034b60e1878fe7cdf14.1404455961.git.liezhi.yang@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake-user-manual-metadata.xml:	remove populate_staging
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
X-List-Received-Date: Mon, 07 Jul 2014 06:00:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have applied this patch.=20

Thanks
Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert Yang
>Sent: Thursday, July 03, 2014 11:42 PM
>To: bitbake-devel@lists.openembedded.org
>Subject: [bitbake-devel] [PATCH 1/1] bitbake-user-manual-metadata.xml:
>remove populate_staging
>
>There is no populate_staging any longer, should be populate_sysroot.
>
>Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>---
> .../bitbake-user-manual-metadata.xml               |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-
>metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-
>metadata.xml
>index a9f5072..a10a660 100644
>--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>@@ -1466,9 +1466,9 @@
>                 complete before that task can be executed.
>                 Here is an example:
>                 <literallayout class=3D'monospaced'>
>-     do_configure[deptask] =3D "do_populate_staging"
>+     do_configure[deptask] =3D "do_populate_sysroot"
>                 </literallayout>
>-                In this example, the <filename>do_populate_staging</filen=
ame>
>+                In this example, the <filename>do_populate_sysroot</filen=
ame>
>                 task of each item in <filename>DEPENDS</filename> must co=
mplete
>before
>                 <filename>do_configure</filename> can execute.
>             </para>
>@@ -1543,9 +1543,9 @@
>                 the data in <filename>DEPENDS</filename>.
>                 Here is an example:
>                 <literallayout class=3D'monospaced'>
>-     do_patch[depends] =3D "quilt-native:do_populate_staging"
>+     do_patch[depends] =3D "quilt-native:do_populate_sysroot"
>                 </literallayout>
>-                In this example, the <filename>do_populate_staging</filen=
ame>
>+                In this example, the <filename>do_populate_sysroot</filen=
ame>
>                 task of the target <filename>quilt-native</filename>
>                 must have completed before the
>                 <filename>do_patch</filename> task can execute.
>--
>1.7.9.5
>
>--
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel

