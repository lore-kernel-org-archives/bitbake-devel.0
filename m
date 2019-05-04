Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id A74E67D3F4
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 May 2019 23:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id F39E318297;
	Sun,  5 May 2019 01:18:06 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id NO-NQCU4pHn5; Sun,  5 May 2019 01:18:06 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 0FB38182BB;
	Sun,  5 May 2019 01:18:06 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EED451E06E;
	Sun,  5 May 2019 01:18:05 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E33A31E06C;
	Sun,  5 May 2019 01:18:05 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Sun,  5 May 2019 01:18:05 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id D4C5E2A5A;
	Sun,  5 May 2019 01:18:05 +0200 (CEST)
Received: from xbox12.axis.com (10.0.5.26) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Sun, 5 May 2019 01:18:05 +0200
Received: from XBOX04.axis.com (10.0.5.18) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Sun, 5 May 2019 01:18:05 +0200
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Sun, 5 May 2019 01:18:05 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] use the word "task" as the argument for
	--runall and --runonly
Thread-Index: AQHVArz7feMfZQUOAkOZo/rh4NC+P6ZbljpQ
Date: Sat, 4 May 2019 23:18:05 +0000
Message-ID: <691f396185cf4503a6a853f6ae330616@XBOX04.axis.com>
References: <alpine.LFD.2.21.1905041701580.507@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1905041701580.507@localhost.localdomain>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] use the word "task" as the argument for --runall and --runonly
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
X-List-Received-Date: Sat, 04 May 2019 23:18:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Robert P. J. Day
> Sent: den 4 maj 2019 23:04
> To: BitBake developer list <bitbake-devel@lists.openembedded.org>
> Subject: [bitbake-devel] [PATCH] use the word "task" as the argument
> for --runall and --runonly
>=20
> The proper argument for "--runall" and "--runonly" should be "task".
>=20
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>=20
> ---
>=20
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index 8d1978f9..66ef84c7 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -280,10 +280,10 @@ class BitBakeConfigParameters(cookerdata.ConfigPara=
meters):
>                            help=3D"Writes the event log of the build to a=
 bitbake event json file. "
>                                 "Use '' (empty string) to assign the name=
 automatically.")
>=20
> -        parser.add_option("", "--runall", action=3D"append", dest=3D"run=
all",
> +        parser.add_option("", "--runall", action=3D"append", dest=3D"tas=
k",
>                            help=3D"Run the specified task for any recipe =
in the taskgraph of the specified target (even if it wouldn't otherwise hav=
e run).")
>=20
> -        parser.add_option("", "--runonly", action=3D"append", dest=3D"ru=
nonly",
> +        parser.add_option("", "--runonly", action=3D"append", dest=3D"ta=
sk",
>                            help=3D"Run only the specified task within the=
 taskgraph of the specified targets (and any task dependencies those tasks =
may have).")

That will not work as it changes the name of the variables used to retrieve=
 the =20
arguments in the code, e.g., both self.cooker.configuration.runonly and=20
self.cooker.configuration.runall would become=20
self.cooker.configuration.task, which obviously doesn't work. What you want=
 to=20
do instead is add metavar arguments to the add_option() calls. I.e.:

        parser.add_option("", "--runall", action=3D"append", dest=3D"runall=
", metavar=3D"TASK",
                          help=3D"Run the specified task for any recipe in =
the taskgraph of the specified target (even if it wouldn't otherwise have r=
un).")

        parser.add_option("", "--runonly", action=3D"append", dest=3D"runon=
ly", metavar=3D"TASK",
                          help=3D"Run only the specified task within the ta=
skgraph of the specified targets (and any task dependencies those tasks may=
 have).")

//Peter


