Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.9245.1618382225025353735
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 23:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: henning.schild@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13E6b20Q022509
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Apr 2021 08:37:02 +0200
Received: from md1za8fc.ad001.siemens.net ([167.87.7.134])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 13E6XOjx004338;
	Wed, 14 Apr 2021 08:33:24 +0200
Date: Wed, 14 Apr 2021 08:33:23 +0200
From: henning.schild@siemens.com
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, isar-users@googlegroups.com,
        Cedric Hombourger  <Cedric_Hombourger@mentor.com>,
        Chris Larson
 <Chris_Larson@mentor.com>
Subject: Re: [PATCH v2 2/3] tests/fetch: deduplicate local git testing code
Message-ID: <20210414083323.29dcb992@md1za8fc.ad001.siemens.net>
In-Reply-To: <979af729ffac904b287ca62d533ac45e430bdc91.camel@linuxfoundation.org>
References: <20210413150251.1969-1-henning.schild@siemens.com>
	<20210413150251.1969-2-henning.schild@siemens.com>
	<979af729ffac904b287ca62d533ac45e430bdc91.camel@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Tue, 13 Apr 2021 22:37:52 +0100
schrieb Richard Purdie <richard.purdie@linuxfoundation.org>:

> On Tue, 2021-04-13 at 17:02 +0200, Henning Schild wrote:
> > Purely cosmetic change that probably improves the code.
> >=20
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> > =C2=A0lib/bb/tests/fetch.py | 33 +++++++--------------------------
> > =C2=A01 file changed, 7 insertions(+), 26 deletions(-) =20
>=20
> The patches look good but could you rebase+resend against master-next=C2=
=A0
> please? We're just sorting the current release out so there is a
> small queue and yours conflicts with another in the queue there.

Done in v3.

regards,
Henning

> Cheers,
>=20
> Richard
>=20

