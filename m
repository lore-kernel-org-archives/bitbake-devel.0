Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 8B41960017
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 19:06:40 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 08 Jul 2014 12:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,626,1400050800"; d="scan'208";a="454602720"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
	by azsmga001.ch.intel.com with ESMTP; 08 Jul 2014 12:06:37 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
	ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Tue, 8 Jul 2014 12:05:22 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX156.amr.corp.intel.com ([169.254.8.193]) with mapi id
	14.03.0123.003; Tue, 8 Jul 2014 12:05:22 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Documentation: A few tweaks to Chapter
	2, BitBake User Manual
Thread-Index: AQHPmraNo4WHMWoObEuUHS8gcsYMMJuWiYug
Date: Tue, 8 Jul 2014 19:05:20 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB6AED@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407081010150.14336@localhost>
In-Reply-To: <alpine.LFD.2.11.1407081010150.14336@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: A few tweaks to Chapter 2, BitBake User Manual
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
X-List-Received-Date: Tue, 08 Jul 2014 19:06:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Applied.  Needs merged into BB repo.

Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Tuesday, July 08, 2014 7:11 AM
>To: BitBake developer list
>Subject: [bitbake-devel] [PATCH] Documentation: A few tweaks to Chapter 2,
>BitBake User Manual
>
>
>Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>---
>
>  only questionable part is my example of busybox supplying two versions,
>perhaps that's outside the scope of this manual.
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
>b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
>index 8b6e0b4..403ad5b 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
>@@ -7,7 +7,8 @@
>     <para>
>         The primary purpose for running BitBake is to produce some kind
>         of output such as a single installable package, a kernel, a softw=
are
>-        development kit, or even a full, board-specific bootable Linux im=
age.
>+        development kit, or even a full, board-specific bootable Linux im=
age,
>+        complete with bootloader, kernel and root filesystem.
>         Of course, you can execute the <filename>bitbake</filename>
>         command with options that cause it to execute single tasks,
>         compile single recipe files, capture or clear data, or simply @@ =
-45,6
>+46,11 @@
>                 build host with hyper-threading will most likely show eig=
ht
>processors,
>                 which is the value you would then assign to that variable=
.
>             </para>
>+
>+            <para>
>+                A possibly simpler solution is that some Linux distributi=
ons
>+                (Debian, Ubuntu) provide the <filename>ncpus</filename>
>command.
>+            </para>
>         </note>
>     </para>
>
>@@ -84,7 +90,7 @@
>             <link linkend=3D'var-BBFILES'><filename>BBFILES</filename></l=
ink>.
>             <filename>BBPATH</filename> is used to search for
>             configuration and class files under the
>-            <filename>conf</filename> and <filename>classes</filename>
>+            <filename>conf/</filename> and
>+ <filename>classes/</filename>
>             directories, respectively.
>             <filename>BBFILES</filename> is used to locate both recipe
>             and recipe append files
>@@ -464,6 +470,29 @@
>      PREFERRED_VERSION_a =3D "1.1"
>             </literallayout>
>         </para>
>+
>+        <note>
>+            <para>
>+                It's common for a recipe to provide two versions -- a sta=
ble,
>+                numbered (and preferred) version, and a version that is
>+                automatically checked out from a source code repository t=
hat
>+                is considered more "bleeding edge" but can be selected on=
ly
>+                explicitly.
>+            </para>
>+
>+            <para>
>+                For example, in the OpenEmbedded codebase, there is a sta=
ndard,
>+                versioned recipe file for BusyBox,
>+                <filename>busybox_1.22.1.bb</filename>,
>+                but there is also a Git-based version,
>+                <filename>busybox_git.bb</filename>, which explicitly con=
tains the
>line
>+                <literallayout class=3D'monospaced'>
>+    DEFAULT_PREFERENCE =3D "-1"
>+                </literallayout>
>+                to ensure that the numbered, stable version is always pre=
ferred
>+                unless the developer selects otherwise.
>+            </para>
>+        </note>
>     </section>
>
>     <section id=3D'bb-bitbake-dependencies'>
>
>rday
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

