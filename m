Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 312 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 30 Jan 2017 10:23:46 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 057BE71957
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Jan 2017 10:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 3C778181DE;
	Mon, 30 Jan 2017 11:18:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id aypAcNxTyDWP; Mon, 30 Jan 2017 11:18:32 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 3163E181D8;
	Mon, 30 Jan 2017 11:18:32 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC6D51A069;
	Mon, 30 Jan 2017 11:18:31 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0B441A067;
	Mon, 30 Jan 2017 11:18:31 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Mon, 30 Jan 2017 11:18:31 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by seth.se.axis.com (Postfix) with ESMTP id D4C1E356;
	Mon, 30 Jan 2017 11:18:31 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Mon, 30 Jan 2017 11:18:31 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1210.000; Mon, 30 Jan 2017 11:18:31 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot and
	pn-depends.dot generation
Thread-Index: AdJ2+uAaNoHPNgEiToa/KWHSmgIe7f//8XKAgACHXID/+Kp0oA==
Date: Mon, 30 Jan 2017 10:18:31 +0000
Message-ID: <ad9f724ded5644aaaaf6e3f9cd3a884b@XBOX02.axis.com>
References: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
	<1485342777.30673.79.camel@linuxfoundation.org>
	<2926401.9a0hO52TuJ@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <2926401.9a0hO52TuJ@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 30 Jan 2017 10:23:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]
> Sent: den 25 januari 2017 20:17
> To: Richard Purdie
> Cc: bitbake-devel@lists.openembedded.org; Peter Kjellerstedt
> Subject: Re: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot
> and pn-depends.dot generation
>=20
> On Wednesday, 25 January 2017 11:12:57 AM NZDT Richard Purdie wrote:
> > On Wed, 2017-01-25 at 11:05 +0000, Peter Kjellerstedt wrote:
> > > pn-dependes.dot when visualizing the dependencies between packages.
> > > Even though task-depends.dot is more complete, trying to render it
> > > is near impossible given the sheer number of nodes and edges it
> > > contains. Already visualizing pn-depends.dot is hard but possible
> > > with some gvpr and tred filtering. Here are some statistics from
> > > one of my typical builds:
> > >
> > >                         Nodes  Edges
> > >                         -----  ------
> > > pn-depends.dot           1183   12087
> > > package-depends.dot      5939   55615
> > > task-depends.dot        13756  125870
> > >
> > > As can be seen, the number of nodes and edges in task-depends.dot
> > > is a magnitude greater than in pn-depends.dot.
> >
> > Its certainly simpler, but the data is just plain buggy. I'm not sure
> > I'd trust anything those files told me, even if they are easier to
> > view.
> >
> > I appreciate task-depends is hard to load graphically, it is helpful
> > even as a text file though, I do use it a lot since its a near direct
> > dump of bitbake's internal parsed task dependencies.
>=20
> What if we collapsed down task-depends.dot to PNs only in order to
> produce pn-depends.dot? Then at least it would be reasonably accurate.
>=20
> Cheers,
> Paul

That would work for me at least.

//Peter


