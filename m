Return-Path: <scott.m.rifenbark@intel.com>
X-Greylist: delayed 607 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 10 Jul 2014 07:46:14 UTC
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E745B7045A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jul 2014 07:46:14 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 10 Jul 2014 00:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,636,1400050800"; d="scan'208";a="559796644"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
	by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2014 00:36:07 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
	ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Thu, 10 Jul 2014 00:36:07 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX155.amr.corp.intel.com ([169.254.7.214]) with mapi id
	14.03.0123.003; Thu, 10 Jul 2014 00:36:07 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Documentation: Remove "fakeroot" from
	the list of task flags.
Thread-Index: AQHPm42Zo+6Qrh/5kUO9E7oxPl68zpuY68KQ
Date: Thu, 10 Jul 2014 07:36:06 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB8113@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407091143050.11033@localhost>
In-Reply-To: <alpine.LFD.2.11.1407091143050.11033@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: Remove "fakeroot" from the list of task flags.
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
X-List-Received-Date: Thu, 10 Jul 2014 07:46:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Applied as is.  Needs to be merged to bitbake repo.

Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Wednesday, July 09, 2014 8:44 AM
>To: BitBake developer list
>Subject: [bitbake-devel] [PATCH] Documentation: Remove "fakeroot" from
>the list of task flags.
>
>
>"fakeroot" is now specified as a function attribute, not as a task flag.
>
>Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
>---
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>index a9f5072..9a40c54 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>@@ -1140,12 +1140,6 @@
>                     Tells BitBake to not generate a stamp file for a task=
,
>                     which implies the task should always be executed.
>                     </para></listitem>
>-                <listitem><para><emphasis>fakeroot:</emphasis>
>-                    Causes a task to be run in a fakeroot environment,
>-                    obtained by adding the variables in
>-                    <link linkend=3D'var-
>FAKEROOTENV'><filename>FAKEROOTENV</filename></link>
>-                    to the environment.
>-                    </para></listitem>
>                 <listitem><para><emphasis>umask:</emphasis>
>                     The umask to run the task under.
>                     </para></listitem>
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

