Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 243A4731C1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jan 2016 14:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 585BD2E194;
	Thu, 14 Jan 2016 15:47:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id x799hUqSap9m; Thu, 14 Jan 2016 15:47:14 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 349412E068;
	Thu, 14 Jan 2016 15:47:14 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 0F14C144E;
	Thu, 14 Jan 2016 15:47:14 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 03D79A7;
	Thu, 14 Jan 2016 15:47:14 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by thoth.se.axis.com (Postfix) with ESMTP id 0125A34297;
	Thu, 14 Jan 2016 15:47:14 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1104.5;
	Thu, 14 Jan 2016 15:47:13 +0100
Received: from XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04]) by
	XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04%12]) with mapi id
	15.00.1104.000; Thu, 14 Jan 2016 15:47:13 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Andre McCurdy
	<armccurdy@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH] fetch/git: Change to use clearer ssh url
	syntax for broken servers
Thread-Index: AQHRSU3451UemDen+Uabr9iI8HBObp758d0AgAALwwCAASMOIA==
Date: Thu, 14 Jan 2016 14:47:13 +0000
Message-ID: <90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
In-Reply-To: <1452723582.28375.118.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Thu, 14 Jan 2016 14:47:17 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 13 januari 2016 23:20
> To: Andre McCurdy
> Cc: bitbake-devel
> Subject: Re: [bitbake-devel] [PATCH] fetch/git: Change to use clearer
> ssh url syntax for broken servers
>=20
> On Wed, 2016-01-13 at 13:37 -0800, Andre McCurdy wrote:
> > On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > Some servers, e.g. bitbucket.org can't cope with ssh:// as part of
> > > the git url syntax. git itself is happy enough with this but you
> > > get server side errors when using it.
> > >
> > > This changes the git fetcher to use the more common ssh url format
> > > which also means we need a : before the path.
> >
> > This seems to break SRC_URIs using ssh to access self hosted git
> > servers setup following the process described here:
> >
> >   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Ser
> > ver
> >
> > An example of such a SRC_URI, which now fails to work:
> >
> >   SRC_URI =3D "git
> > ://git@mylocalserver.com:/opt/git/myrepo.git;protocol=3Dssh"
>=20
> Does:
>=20
> SRC_URI =3D "git://git@mylocalserver.com/opt/git/myrepo.git;protocol=3Dss=
h"
>=20
> work though?

The above may work, but this does not any more:

SRC_URI =3D "git://git@mylocalserver.com:12345/opt/git/myrepo.git;protocol=
=3Dssh"

I.e., when the Git server requires a port, like our Gerrit server does...
Please revert the commit and solve the actual problem with bitbucket.org=20
some other way.

> I'm not sure we ever suggested people should use ":/" in SRC_URI since
> that isn't a url format the system was ever designed to cope with. It
> might have happened to work but that is different...
>=20
> Cheers,
>=20
> Richard

//Peter


