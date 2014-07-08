Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id EA9CF6ACD4
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 12:14:48 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 08 Jul 2014 05:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,625,1400050800"; d="scan'208";a="569935266"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by orsmga002.jf.intel.com with ESMTP; 08 Jul 2014 05:14:42 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX102.amr.corp.intel.com ([169.254.1.82]) with mapi id
	14.03.0123.003; Tue, 8 Jul 2014 05:14:42 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Documentation: User manual,	chapter 1:
	Minor tweaks.
Thread-Index: AQHPmdpPAvrD6cFQxUa0YbctVv5hkZuWGAsA
Date: Tue, 8 Jul 2014 12:14:40 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB68D3@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407070749140.6927@localhost>
In-Reply-To: <alpine.LFD.2.11.1407070749140.6927@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: User manual, chapter 1: Minor tweaks.
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
X-List-Received-Date: Tue, 08 Jul 2014 12:14:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Applied to contrib area.  Needs merged into bitbake.

Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Monday, July 07, 2014 4:54 AM
>To: BitBake developer list
>Subject: [bitbake-devel] [PATCH] Documentation: User manual, chapter 1:
>Minor tweaks.
>
>
>Some minor fixes and additions to the first couple sections of the BitBake=
 User
>Manual.
>
>Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>---
>
>  first in what will probably be a series of patches fiddling around with =
the
>bitbake user manual, since i want to use it in an upcoming yocto course so=
 i
>might as well add in the stuff i'd be pointing out, anyway.
>
>  this is for just the first part of chapter 1 -- i'll submit patches in b=
ite-size
>pieces rather than trying to do monster patches all at once. some of this =
isn't
>really fixing stuff so much as just my idea of rewording, but i'll always =
bundle
>in stuff like that with actual corrections.
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>index af2400f..2df30ad 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>@@ -34,18 +34,19 @@
>             <itemizedlist>
>                 <listitem><para>
>                     BitBake executes tasks according to provided
>-                    metadata that builds up the tasks.
>-                    Metadata is stored in recipe (<filename>.bb</filename=
>),
>-                    recipe "append" (<filename>.bbappend</filename>),
>-                    configuration (<filename>.conf</filename>), and class
>-                    (<filename>.bbclass</filename>) files and provides
>+                    metadata that builds up the tasks. Metadata is stored=
 in
>+                    recipe (<filename>.bb</filename>) and related
>+                    recipe "append" (<filename>.bbappend</filename>) file=
s,
>+                    configuration (<filename>.conf</filename>) and underl=
ying
>+                    include (<filename>.inc</filename>) files, and class
>+                    (<filename>.bbclass</filename>) files, and provides
>                     BitBake with instructions on what tasks to run and
>                     the dependencies between those tasks.
>                     </para></listitem>
>                 <listitem><para>
>                     BitBake includes a fetcher library for obtaining sour=
ce
>                     code from various places such as local files, source =
control
>-                    systems, websites, or local files.
>+                    systems or websites.
>                     </para></listitem>
>                 <listitem><para>
>                     The instructions for each unit to be built (e.g. a pi=
ece @@ -56,7
>+57,7 @@
>                     </para></listitem>
>                 <listitem><para>
>                     BitBake includes a client/server abstraction and can
>-                    be used from a command line or used as a service over=
 XMLRPC
>and
>+                    be used from a command line or used as a service
>+ over XML-RPC and
>                     has several different user interfaces.
>                     </para></listitem>
>             </itemizedlist>
>@@ -80,8 +81,10 @@
>             Today, BitBake is the primary basis of the
>             <ulink
>url=3D"http://www.openembedded.org/">OpenEmbedded</ulink>
>             project, which is being used to build and maintain Linux
>-            distributions such as the Angstrom Distribution and which is =
used
>-            as the build tool for Linux projects such as the Yocto Projec=
t.
>+            distributions such as the
>+            <ulink url=3D"http://www.angstrom-distribution.org/">Angstrom
>Distribution</ulink>
>+            and which is used as the build tool for Linux projects such a=
s the
>+            <ulink url=3D"https://www.yoctoproject.org/">Yocto Project</u=
link>.
>         </para>
>
>         <para>
>@@ -152,7 +155,7 @@
>                     </para></listitem>
>                 <listitem><para>
>                     Split metadata into layers and allow layers
>-                    to override each other.
>+                    to enhance or override other layers.
>                     </para></listitem>
>                 <listitem><para>
>                     Allow representation of a given set of input variable=
s
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

