Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 507E971C3D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Feb 2017 15:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 0FDBF2E4DA;
	Thu,  2 Feb 2017 16:13:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id OHNJImIDXbiU; Thu,  2 Feb 2017 16:13:31 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bes.se.axis.com (Postfix) with ESMTPS id F258B2E5C3;
	Thu,  2 Feb 2017 16:13:30 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A50171E084;
	Thu,  2 Feb 2017 16:13:30 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DBD1E07F;
	Thu,  2 Feb 2017 16:13:30 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Thu,  2 Feb 2017 16:13:30 +0100 (CET)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by thoth.se.axis.com (Postfix) with ESMTP id 8D6DD34F;
	Thu,  2 Feb 2017 16:13:30 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Thu, 2 Feb 2017 16:13:30 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1210.000; Thu, 2 Feb 2017 16:13:30 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot and
	pn-depends.dot generation
Thread-Index: AdJ2+uAaNoHPNgEiToa/KWHSmgIe7f//8XKAgACHXID/+Kp0oP/sTVWg
Date: Thu, 2 Feb 2017 15:13:29 +0000
Message-ID: <18a389a972ed472da8e87b379275679a@XBOX02.axis.com>
References: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
	<1485342777.30673.79.camel@linuxfoundation.org>
	<2926401.9a0hO52TuJ@peggleto-mobl.ger.corp.intel.com>
	<ad9f724ded5644aaaaf6e3f9cd3a884b@XBOX02.axis.com>
In-Reply-To: <ad9f724ded5644aaaaf6e3f9cd3a884b@XBOX02.axis.com>
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
X-List-Received-Date: Thu, 02 Feb 2017 15:13:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Peter Kjellerstedt
> Sent: den 30 januari 2017 11:19
> To: Paul Eggleton; Richard Purdie
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot
> and pn-depends.dot generation
>=20
> > -----Original Message-----
> > From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]
> > Sent: den 25 januari 2017 20:17
> > To: Richard Purdie
> > Cc: bitbake-devel@lists.openembedded.org; Peter Kjellerstedt
> > Subject: Re: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot
> > and pn-depends.dot generation
> >
> > On Wednesday, 25 January 2017 11:12:57 AM NZDT Richard Purdie wrote:
> > > On Wed, 2017-01-25 at 11:05 +0000, Peter Kjellerstedt wrote:
> > > > pn-dependes.dot when visualizing the dependencies between
> > > > packages. Even though task-depends.dot is more complete, trying=20
> > > > to render it is near impossible given the sheer number of nodes=20
> > > > and edges it contains. Already visualizing pn-depends.dot is hard=20
> > > > but possible with some gvpr and tred filtering. Here are some=20
> > > > statistics from one of my typical builds:
> > > >
> > > >                         Nodes  Edges
> > > >                         -----  ------
> > > > pn-depends.dot           1183   12087
> > > > package-depends.dot      5939   55615
> > > > task-depends.dot        13756  125870
> > > >
> > > > As can be seen, the number of nodes and edges in task-depends.dot
> > > > is a magnitude greater than in pn-depends.dot.
> > >
> > > Its certainly simpler, but the data is just plain buggy. I'm not
> > > sure I'd trust anything those files told me, even if they are=20
> > > easier to view.
> > >
> > > I appreciate task-depends is hard to load graphically, it is
> > > helpful even as a text file though, I do use it a lot since=20
> > > its a near direct dump of bitbake's internal parsed task=20
> > > dependencies.
> >
> > What if we collapsed down task-depends.dot to PNs only in order to
> > produce pn-depends.dot? Then at least it would be reasonably
> > accurate.
> >
> > Cheers,
> > Paul
>=20
> That would work for me at least.
>=20
> //Peter

Another concern here is the depexp UI which I believe currently uses=20
the same data that ends up in pn-depends.dot. (I noticed this the=20
other day when I could not find a dependency in the depexp UI that I=20
expected should be there, and based on the discussion in this mail=20
thread then searched in task-depends.dot and found the dependency=20
there as expected).

//Peter


