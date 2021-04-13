Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.8503.1618317847529423261
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 05:44:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: henning.schild@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13DCi18t016559
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Apr 2021 14:44:01 +0200
Received: from md1za8fc.ad001.siemens.net ([167.87.48.83])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 13DCeJnT013759;
	Tue, 13 Apr 2021 14:40:19 +0200
Date: Tue, 13 Apr 2021 14:40:18 +0200
From: henning.schild@siemens.com
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, isar-users@googlegroups.com,
        "Hombourger, Cedric" <Cedric_Hombourger@mentor.com>,
        "Larson, Chris"
 <Chris_Larson@mentor.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: add support for disabling shared clones on unpack
Message-ID: <20210413144018.1be69c07@md1za8fc.ad001.siemens.net>
In-Reply-To: <65bf5f7ea9041131d5106cd45cf19e709f468d2d.camel@linuxfoundation.org>
References: <20171220164209.9609-1-henning.schild@siemens.com>
	<20171220174538.441d517f@mmd1pvb1c.ad001.siemens.net>
	<20180130131805.4725ccf3@mmd1pvb1c.ad001.siemens.net>
	<20210412170519.53612c01@md1za8fc.ad001.siemens.net>
	<65bf5f7ea9041131d5106cd45cf19e709f468d2d.camel@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Tue, 13 Apr 2021 11:23:00 +0100
schrieb Richard Purdie <richard.purdie@linuxfoundation.org>:

> Hi,
>=20
> On Mon, 2021-04-12 at 17:05 +0200, Henning Schild wrote:
> > this is still pretty much relevant to Isar, where an unpack with git
> > goes into a chroot. Having a way not clone "shared" would really
> > help us in Isar.
> >=20
> > Any comments? Except for this one maybe not applying anymore, did
> > not try. =20
>=20
> I'm torn on this, I can see the use case but it isn't one we've
> typically run into. I can see how it is Isar specific.
>=20
> I'm hesitant as the more "forks" in codepath we add to the fetcher,
> the harder it becomes to test and maintain.

That is clear, but thanks for considering Isar even though it is not
the biggest user of bitbake.

> Would you be able to add some tests for this to the testsuite=C2=A0
> (bitbake-selftest)? If we have some tests we could probably add
> something.

Sure thing, if that increases the chance of a merge.

> I did also wonder whether this should be a per url parmeter or a
> global fetcher behaviour option? You'd end up adding this to all urls
> in your usecase?

That is a good point, yes we would be forced to set that per url. I
think i will go for=20
  d.getVar("BB_GIT_NOSHARE") =3D=3D "1"
in v2. A variable isar can set in its bitbake.conf.

Thanks,
Henning

>=20
> Cheers,
>=20
> Richard
>=20
>=20

