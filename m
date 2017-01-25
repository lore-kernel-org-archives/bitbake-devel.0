Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 8D65265C90
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jan 2017 11:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 3A2062E0F1;
	Wed, 25 Jan 2017 12:05:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id RkxYrUj8KcEv; Wed, 25 Jan 2017 12:05:06 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bes.se.axis.com (Postfix) with ESMTPS id DCE1E2E4C1;
	Wed, 25 Jan 2017 12:05:06 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCDF11E07D;
	Wed, 25 Jan 2017 12:05:06 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A421E07B;
	Wed, 25 Jan 2017 12:05:06 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Wed, 25 Jan 2017 12:05:06 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by seth.se.axis.com (Postfix) with ESMTP id B4BAFE3C;
	Wed, 25 Jan 2017 12:05:06 +0100 (CET)
Received: from xbox11.axis.com (10.0.5.25) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Wed, 25 Jan 2017 12:05:06 +0100
Received: from XBOX02.axis.com (10.0.5.16) by xbox11.axis.com (10.0.5.25) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Wed, 25 Jan 2017 12:05:06 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1210.000; Wed, 25 Jan 2017 12:05:06 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot and
	pn-depends.dot generation
Thread-Index: AdJ2+uAaNoHPNgEiToa/KWHSmgIe7Q==
Date: Wed, 25 Jan 2017 11:05:06 +0000
Message-ID: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] cooker: Drop package-depends.dot and pn-depends.dot generation
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
X-List-Received-Date: Wed, 25 Jan 2017 11:05:10 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 23 januari 2017 23:38
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot and
> pn-depends.dot generation
>=20
> A long time ago when we switched to task basked execution we added
> task-depends.dot and generated package-depends.dot and pn-depends.dot
> for compatibility as best we could.=09
>=20
> The problem is they contain partial data about the taskgraph, its
> incomplete and tends to confuse users.
>=20
> I propose we remove the two compatibilty outputs and just generate
> the one which contains definitive data.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Is there any alternative to removing package-depends.dot and=20
especially pn-depends.dot? The reason I ask is because we use=20
pn-dependes.dot when visualizing the dependencies between packages.=20
Even though task-depends.dot is more complete, trying to render it=20
is near impossible given the sheer number of nodes and edges it=20
contains. Already visualizing pn-depends.dot is hard but possible=20
with some gvpr and tred filtering. Here are some statistics from=20
one of my typical builds:

                        Nodes  Edges
                        -----  ------
pn-depends.dot           1183   12087
package-depends.dot      5939   55615
task-depends.dot        13756  125870

As can be seen, the number of nodes and edges in task-depends.dot=20
is a magnitude greater than in pn-depends.dot.

//Peter


