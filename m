Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4EF9E6FE41
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jul 2014 07:44:07 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 10 Jul 2014 00:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,636,1400050800"; d="scan'208";a="571004219"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
	by orsmga002.jf.intel.com with ESMTP; 10 Jul 2014 00:44:02 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
	ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Thu, 10 Jul 2014 00:44:02 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX154.amr.corp.intel.com ([169.254.11.3]) with mapi id
	14.03.0123.003; Thu, 10 Jul 2014 00:44:01 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Documentation: Add a couple examples
	to	conditional data.
Thread-Index: AQHPm3BO1M+tIN3Ti02n9oYs3AUAepuY7Z5g
Date: Thu, 10 Jul 2014 07:44:00 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB812B@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407090819380.6147@localhost>
In-Reply-To: <alpine.LFD.2.11.1407090819380.6147@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: Add a couple examples to	conditional data.
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
X-List-Received-Date: Thu, 10 Jul 2014 07:44:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Applied.  I added some wording to call out the examples as being OpenEmbedd=
ed metadata-based examples.  I am assuming the examples were pulled from th=
e poky area.  For the BB manual, we want to try to keep the manual isolated=
 as much as possible from YP.  This is difficult but that is the intent.   =
Also, for future patches, I use a 5-space indentation convention for any co=
de examples between the <literallayout> and </literallayout> tags.=20

Change needs to be merged into the bitbake repo.

Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Wednesday, July 09, 2014 5:21 AM
>To: BitBake developer list
>Subject: [bitbake-devel] [PATCH] Documentation: Add a couple examples to
>conditional data.
>
>
>Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>---
>
>  i think having a couple real-life examples here would make a huge
>difference.
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>index a9f5072..e433d85 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>@@ -372,6 +372,23 @@
>                         You select the os-specific version of the
><filename>TEST</filename>
>                         variable by appending the "os" override to the va=
riable
>                         (i.e.<filename>TEST_os</filename>).
>+                        </para>
>+
>+                        <para>
>+                            As a practical example, the following lines f=
rom
>+                            one of the Linux kernel recipe files will fir=
st set
>+                            the kernel branch variable <filename>KBRANCH<=
/filename>
>+                            to a default value, then conditionally overri=
de that
>+                            value based on the architecture of the build:
>+                        <literallayout class=3D'monospaced'>
>+    KBRANCH =3D "standard/base"
>+    KBRANCH_qemuarm  =3D "standard/arm-versatile-926ejs"
>+    KBRANCH_qemumips =3D "standard/mti-malta32"
>+    KBRANCH_qemuppc  =3D "standard/qemuppc"
>+    KBRANCH_qemux86  =3D "standard/common-pc/base"
>+    KBRANCH_qemux86-64  =3D "standard/common-pc-64/base"
>+    KBRANCH_qemumips64 =3D "standard/mti-malta64"
>+                        </literallayout>
>                         </para></listitem>
>                     <listitem><para><emphasis>Appending and
>Prepending:</emphasis>
>                         BitBake also supports append and prepend operatio=
ns to @@ -
>385,6 +402,18 @@
>                         </literallayout>
>                         In this example, <filename>DEPENDS</filename> bec=
omes
>                         "glibc ncurses libmad".
>+                        </para>
>+
>+                        <para>
>+                            Again using a kernel recipe file as an exampl=
e, the
>+                            following lines will conditionally append to =
the
>+                            <filename>KERNEL_FEATURES</filename> variable=
 based
>+                            on the architecture:
>+                        <literallayout class=3D'monospaced'>
>+    KERNEL_FEATURES_append =3D " ${KERNEL_EXTRA_FEATURES}"
>+    KERNEL_FEATURES_append_qemux86=3D" cfg/sound.scc
>cfg/paravirt_kvm.scc"
>+    KERNEL_FEATURES_append_qemux86-64=3D" cfg/sound.scc
>cfg/paravirt_kvm.scc"
>+                        </literallayout>
>                         </para></listitem>
>                 </itemizedlist>
>             </para>
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

