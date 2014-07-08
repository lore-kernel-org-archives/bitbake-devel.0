Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D7337703F9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 12:34:40 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Jul 2014 05:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,625,1400050800"; d="scan'208";a="540233950"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
	by orsmga001.jf.intel.com with ESMTP; 08 Jul 2014 05:34:12 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX105.amr.corp.intel.com ([169.254.4.21]) with mapi id
	14.03.0123.003; Tue, 8 Jul 2014 05:34:12 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Documentation: A few more tweaks to
	Chapter 1, BitBake User Manual.
Thread-Index: AQHPmeoO0IkE19Kci0uv8R9qNwqksZuWHeKw
Date: Tue, 8 Jul 2014 12:34:11 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB68EC@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407070945460.9880@localhost>
In-Reply-To: <alpine.LFD.2.11.1407070945460.9880@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: A few more tweaks to Chapter 1, BitBake User Manual.
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
X-List-Received-Date: Tue, 08 Jul 2014 12:34:42 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Applied (for the most part).  Needs to be merged with bitbake repo.

Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Monday, July 07, 2014 6:47 AM
>To: BitBake developer list
>Subject: [bitbake-devel] [PATCH] Documentation: A few more tweaks to
>Chapter 1, BitBake User Manual.
>
>
>Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>---
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>index af2400f..bf39857 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>@@ -212,11 +212,12 @@
>                     <listitem><para>Where the source code resides and
>                         how to fetch it</para></listitem>
>                     <listitem><para>Whether the source code requires
>-                        any patches</para></listitem>
>+                        any patches, where to find them and how to apply
>+                        them</para></listitem>
>                     <listitem><para>How to configure and compile the
>                         source code</para></listitem>
>                     <listitem><para>Where on the target machine to instal=
l the
>-                        package or packages being compiled</para></listit=
em>
>+                        package or packages created</para></listitem>
>                 </itemizedlist>
>             </para>
>
>@@ -228,7 +229,10 @@
>                     The term "package" is also commonly used to describe =
recipes.
>                     However, since the same word is used to describe pack=
aged
>                     output from a project, it is best to maintain a singl=
e
>-                    descriptive term, "recipes".
>+                    descriptive term, "recipes". Put another way, a singl=
e
>+                    "recipe" file is quite capable of generating a number=
 of
>+                    related but separately installable "packages"; this i=
s
>+                    actually fairly common.
>                 </note>
>             </para>
>         </section>
>@@ -248,7 +252,7 @@
>                 The main configuration file is the sample
>                 <filename>bitbake.conf</filename> file, which is
>                 located within the BitBake source tree
>-                <filename>conf</filename> directory.
>+                <filename>conf/</filename> directory.
>             </para>
>         </section>
>
>@@ -262,7 +266,7 @@
>                 The BitBake source tree currently comes with one class me=
tadata file
>                 called <filename>base.bbclass</filename>.
>                 You can find this file in the
>-                <filename>classes</filename> directory.
>+                <filename>classes/</filename> directory.
>                 The <filename>base.bbclass</filename> class files is spec=
ial since it
>                 is always included automatically for all recipes
>                 and classes.
>@@ -313,7 +317,6 @@
>                 Append files, which are files that have the
>                 <filename>.bbappend</filename> file extension, extend or
>                 override information in an existing recipe file.
>-                recipe file.
>             </para>
>
>             <para>
>@@ -326,8 +329,8 @@
>             </para>
>
>             <para>
>-                Information in append files overrides the information in =
the
>-                similarly-named recipe file.
>+                Information in append files extends or overrides the info=
rmation in
>the
>+                underlying, similarly-named recipe file.
>             </para>
>
>             <para>
>@@ -352,6 +355,12 @@
>                 However, if you named the append file
>                 <filename>busybox_1.%.bbappend</filename>, then you would
>have a match.
>             </para>
>+
>+            <para>
>+                In the most general case, you could name the append file =
something
>as
>+                simple as <filename>busybox_%.bbappend</filename> to be
>entirely
>+                version independent.
>+            </para>
>         </section>
>     </section>
>
>@@ -359,7 +368,7 @@
>         <title>Obtaining BitBake</title>
>
>         <para>
>-            You can obtain BitBake several different ways:
>+            You can obtain BitBake in one of several different ways:
>             <itemizedlist>
>                 <listitem><para><emphasis>Cloning BitBake:</emphasis>
>                     Using Git to clone the BitBake source code repository=
 @@ -432,7
>+441,7 @@
>                     has been thoroughly tested for compatibility with the=
 other
>                     components.
>                     For information on how to check out a particular BitB=
ake-based
>-                    build system, the build system's supporting documenta=
tion.
>+                    build system, consult that build system's supporting
>documentation.
>                     </para></listitem>
>             </itemizedlist>
>         </para>
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

