Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TdEx7-000404-Uq
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Nov 2012 07:47:30 +0100
Received: by mail-ee0-f47.google.com with SMTP id l10so6522261eei.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Nov 2012 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=2qO8aYcVQOCsYrZAy7Uzo07ni0sRzIMvG1qkee/GH40=;
	b=ZqjThc3UtCfYpIfOxGQ896SkFsvsHYPSGgHa6CVGwKnSsJFxNh9re/f5+7WZv1cyTf
	afeIbGeL7m1SYsnCT2BB+lCqy3FkT5dagQPBalhX9Jobr4RH15+mqPmUMGSoMOKzYqr0
	LPJ7+JfHXYL9bAHUbs+YB1ggFpbXGaRCziiooavCajD/prPJ3vJgKktRqMessGaWjA7o
	sSZP4EbCk7kWkmZ2u3/VkSbUTqbebaYbLgBJRc70fIztpRGReX08Mefd7SEykZxgxkNN
	yqTsiGaGydjfAa1gwFBaXPxocrb6ovjCNG+ScfnnllEhl39HifRdYjX2aN7WdtBCkcqT
	oREA==
Received: by 10.14.216.193 with SMTP id g41mr54591250eep.37.1353997997314;
	Mon, 26 Nov 2012 22:33:17 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id e2sm38773162eeo.8.2012.11.26.22.33.15
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 26 Nov 2012 22:33:16 -0800 (PST)
Date: Tue, 27 Nov 2012 07:33:10 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Andreas =?iso-8859-1?Q?M=FCller?= <schnitzeltony@googlemail.com>
Message-ID: <20121127063310.GA3408@jama.jama.net>
References: <ly624ss705.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<1353964883.21863.66.camel@ted>
	<CALbNGRS9yaa3PUQPpNqTMV8B9_H=twqtHoBdULr4EtKhLArAng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALbNGRS9yaa3PUQPpNqTMV8B9_H=twqtHoBdULr4EtKhLArAng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
	bitbake-devel@lists.openembedded.org
Subject: Re: Broken SRC_URI handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 27 Nov 2012 06:47:30 -0000
X-Groupsio-MsgNum: 2989
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 02:02:17AM +0100, Andreas M=FCller wrote:
> On Mon, Nov 26, 2012 at 10:21 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Mon, 2012-11-26 at 16:45 +0100, Enrico Scholz wrote:
> >> Hi,
> >>
> >> commit 07b5f84133ac79aac4e939ea5f24390ad7f940a5 introduced a regression
> >> with
> >>
> >> | +            if not newpath or not os.path.exists(newpath) and path.=
find("*") !=3D -1:
> >>
> >>
> >> When an SRC_URI element is not found, some directory in the search path
> >> is copied insted.
> >>
> >> There should be probably added some parentheses in the expression abov=
e.
> >> At the moment, the 'A or B and C' above is interpreted as 'A or (B and
> >> C)' due to operator precedences.
> >
> > I just pushed a fix for this before I read this email! We reached the
> > same conclusion so it should be fixed in master now :)
> >
> > Cheers,
> >
> > Richard
> >
> Not sure if it is related but since last update I get
>=20
> WARNING: Failed to fetch URL file://systemctl, attempting MIRRORS if avai=
lable
> ERROR: Fetcher failure: Unable to find file file://systemctl anywhere.

Hi,

it's slightly different change:
http://patchwork.openembedded.org/patch/39625/

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlC0XqYACgkQN1Ujt2V2gByS7ACgim9krfAhBq8WQrxuAOGFzEbq
x5sAnil18NCT2UJiH0E/PRWWcyTjSMEH
=k9Eh
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
