Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 574267D74A
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 May 2019 19:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id AFA69182D8;
	Sat,  4 May 2019 21:50:30 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 1bLjL3VAc8vQ; Sat,  4 May 2019 21:50:30 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id EC50D182C9;
	Sat,  4 May 2019 21:50:29 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD76C1A05C;
	Sat,  4 May 2019 21:50:29 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B201C1A05B;
	Sat,  4 May 2019 21:50:29 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Sat,  4 May 2019 21:50:29 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by seth.se.axis.com (Postfix) with ESMTP id A4AA97AE;
	Sat,  4 May 2019 21:50:29 +0200 (CEST)
Received: from XBOX04.axis.com (10.0.5.18) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Sat, 4 May 2019 21:50:29 +0200
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Sat, 4 May 2019 21:50:29 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] help: reword "runall" entries to refer
	to a	TASK
Thread-Index: AQHVAeCtZk+h5WeqaUGnGZ8EUk467KZbX7Qw
Date: Sat, 4 May 2019 19:50:29 +0000
Message-ID: <b709ed4b38a746f6a20025811435d3e8@XBOX04.axis.com>
References: <alpine.LFD.2.21.1905031426110.10665@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1905031426110.10665@localhost.localdomain>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] help: reword "runall" entries to refer to a	TASK
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
X-List-Received-Date: Sat, 04 May 2019 19:50:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Robert P. J. Day
> Sent: den 3 maj 2019 20:27
> To: BitBake developer list <bitbake-devel@lists.openembedded.org>
> Subject: [bitbake-devel] [PATCH] help: reword "runall" entries to refer
> to a TASK
>=20
> Rewording argument to the word "TASK" should be self-evident.
>=20
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>=20
> ---
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> index 02058a6f..74b74bff 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> @@ -573,10 +573,10 @@
>                               Writes the event log of the build to a bitb=
ake event
>                               json file. Use '' (empty string) to assign =
the name
>                               automatically.
> -       --runall=3DRUNALL       Run the specified task for any recipe in =
the taskgraph
> +       --runall=3DTASK         Run the specified task for any recipe in =
the taskgraph
>                               of the specified target (even if it wouldn'=
t otherwise
>                               have run).
> -       --runonly=3DRUNONLY     Run only the specified task within the ta=
skgraph of
> +       --runonly=3DTASK        Run only the specified task within the ta=
skgraph of
>                               the specified targets (and any task depende=
ncies those
>                               tasks may have).
>                  </literallayout>

The above information is taken directly from `bitbake -h`. I.e., if you=20
want to change it, you should start by updating the bitbake code.

> --
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Robert P. J. Day                                Ottawa, Ontario, CANADA
>                          http://crashcourse.ca
>=20
> Twitter: http://twitter.com/rpjday
> LinkedIn: http://ca.linkedin.com/in/rpjday
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

//Peter

