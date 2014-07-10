Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E081B6FE41
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jul 2014 07:47:39 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 10 Jul 2014 00:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,636,1400050800"; d="scan'208";a="571005423"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
	by orsmga002.jf.intel.com with ESMTP; 10 Jul 2014 00:46:54 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
	ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Thu, 10 Jul 2014 00:46:54 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX112.amr.corp.intel.com ([169.254.12.245]) with mapi id
	14.03.0123.003; Thu, 10 Jul 2014 00:46:54 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Documentation: Add examples to User
	Manual, Metadata chapter
Thread-Index: AQHPm24A//HRGfIMV0iJnjHFCGWK+ZuY7yuw
Date: Thu, 10 Jul 2014 07:46:53 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB8149@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407090802320.5937@localhost>
In-Reply-To: <alpine.LFD.2.11.1407090802320.5937@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: Add examples to User Manual, Metadata chapter
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
X-List-Received-Date: Thu, 10 Jul 2014 07:47:42 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Applied with a bit of rewording and whitespace correction for the example. =
 Change needs to be merged to the bitbake repo.

Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Wednesday, July 09, 2014 5:04 AM
>To: BitBake developer list
>Subject: [bitbake-devel] [PATCH] Documentation: Add examples to User
>Manual, Metadata chapter
>
>
>Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>---
>
>  as long as i've understood everything correctly, this is just throwing i=
n some
>physical examples of a couple concepts.
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>index a9f5072..423d9a4 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>@@ -285,6 +285,16 @@
>                 The flags are immediately set to "abc" and "123", respect=
ively.
>                 The <filename>a</filename> flag becomes "abc456".
>             </para>
>+
>+            <para>
>+                Note that there is no need to pre-define variable flags; =
you
>+                can simply start using them.  One extremely common applic=
ation
>+                is to attach some brief documentation to a BitBake variab=
le as
>+                follows:
>+                <literallayout class=3D'monospaced'>
>+    CACHE[doc] =3D "The directory holding the cache of the metadata."
>+                </literallayout>
>+            </para>
>         </section>
>
>         <section id=3D'inline-python-variable-expansion'>
>@@ -298,7 +308,19 @@
>      DATE =3D "${@time.strftime('%Y%m%d',time.gmtime())}"
>                 </literallayout>
>                 This example results in the <filename>DATE</filename>
>-                variable becoming the current date.
>+                variable being set to the current date.
>+            </para>
>+
>+            <para>
>+                Probably the most common use of this feature is to extrac=
t
>+                the value of variables from BitBake's internal data dicti=
onary,
>+                <filename>d</filename>. The following lines
>+                select the values of, respectively, a package name and it=
s
>+                version number:
>+                <literallayout class=3D'monospaced'>
>+    PN =3D "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] o=
r
>'defaultpkgname'}"
>+    PV =3D "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] o=
r
>'1.0'}"
>+                </literallayout>
>             </para>
>         </section>
>
>
>--
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                        http://crashcourse.ca
>
>Twitter:                                       http://twitter.com/rpjday
>LinkedIn:                               http://ca.linkedin.com/in/rpjday
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel

