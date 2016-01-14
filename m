Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id F0673731DB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jan 2016 17:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 76E042E0B5;
	Thu, 14 Jan 2016 18:50:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id cVnYDqDaxPNX; Thu, 14 Jan 2016 18:50:02 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 79E2B2E110;
	Thu, 14 Jan 2016 18:50:02 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 5B1FD15E7;
	Thu, 14 Jan 2016 18:50:02 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 4F8941446;
	Thu, 14 Jan 2016 18:50:02 +0100 (CET)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by seth.se.axis.com (Postfix) with ESMTP id 3DA673E3CD;
	Thu, 14 Jan 2016 18:50:02 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1104.5;
	Thu, 14 Jan 2016 18:50:02 +0100
Received: from XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04]) by
	XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04%12]) with mapi id
	15.00.1104.000; Thu, 14 Jan 2016 18:50:02 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Olof Johansson <olofjn@axis.com>, Andre McCurdy <armccurdy@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] fetch/git: Change to use clearer ssh url
	syntax for broken servers
Thread-Index: AQHRSU3451UemDen+Uabr9iI8HBObp758d0AgAALwwCAASMOIP//+6+AgAAYB4CAAARxAIAAGaeQ
Date: Thu, 14 Jan 2016 17:50:02 +0000
Message-ID: <36fc0893749647d8aeef0cc8cfd68435@XBOX02.axis.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
	<1452785159.28375.135.camel@linuxfoundation.org>
	<CAJ86T=X9LU04NhjnaLtq+G7WSE6=9t2yiNF2MiuDrnn+M5exLQ@mail.gmail.com>
	<20160114170752.GH31212@axis.com>
In-Reply-To: <20160114170752.GH31212@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
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
X-List-Received-Date: Thu, 14 Jan 2016 17:50:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Olof Johansson
> Sent: den 14 januari 2016 18:08
> To: Andre McCurdy; Richard Purdie; bitbake-devel
> Cc: Peter Kjellerstedt
> Subject: Re: [bitbake-devel] [PATCH] fetch/git: Change to use clearer
> ssh url syntax for broken servers
>=20
> On 16-01-14 08:51 -0800, Andre McCurdy wrote:
> > > I'm not sure there is one other than special casing bitbucket urls
> in
> > > the fetcher.
> >
> > But I don't think there is any problem with BitBucket. The original
> > bug report was caused by trying to use a URL with a ':' between the
> > host and the repo path. A URL like that does not work when prefixed
> by
> > ssh://, it's the same for GitHub URLs too.
>=20
> Indeed, the reported URL is not an RFC 3986 comformant URI. While
>=20
>   ssh://example.com:/username/project.git
>=20
> would be a kind of valid URI (the RFC doesn't forbid having an
> empty port, see section 3.2.3), not having a path delimiter at
> all however is not allowed. And fixing this by breaking RFC
> comformant use cases is very suprising to me.
>=20
> --
> olofjn

I have now looked at the ticket [YOCTO #8864] and actually created an=20
account on bitbucket.org to actually verify what is happening, and I=20
can only come to the conclusion that the ticket is gibberish. I have=20
tried the following two URL:s with bitbucket.org, and they both work=20
as expected:

git@bitbucket.org:Saur2000/test1.git
ssh://git@bitbucket.org/Saur2000/test1.git

The real error to the SRC_URI given in the ticket:

SRC_URI =3D "git://git@bitbucket.org:<username>/<repository>.git;rev=3Dfoo"

is that it is missing the protocol argument. Changing it to:

SRC_URI =3D "git://git@bitbucket.org/<username>/<repository>.git;protocol=
=3Dssh;rev=3Dfoo"

should make everything work as expected.

The ticket author obviously did not realize that the git:// scheme=20
used in the SRC_URI is for BitBake and not for Git, and that when=20
the protocol=3Dssh argument is added, then the rest of the URI must=20
be changed to match the syntax expected by an ssh:// URI even though=20
the scheme in SRC_URI is git://.

//Peter


