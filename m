Return-Path: <joe@deserted.net>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by mail.openembedded.org (Postfix) with ESMTP id 82A496F572
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 13:50:31 +0000 (UTC)
Received: by mail-ob0-f179.google.com with SMTP id va2so11063721obc.38
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Apr 2014 06:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent;
	bh=9qedWkCq9dr94xwiAMvYSirnL5X6C8Fnzfpv8IpSnzk=;
	b=NpvVYYfb2kttN1Qh6TGr4052OGdS/aB12Sfax8l5snFyGo86EYjwmSSemVjKQS8MNb
	4nc/PADcCu4O1AQ1ptgnM+26UFuaOD53q4S72EJuch30xCNg4TSIb3jUzL/f/fgNhMW7
	qE4XWEI0xY2wrkWFrczx7yIwrP25y1rcIWwA9GfdgOtaWSC67fDAOXQWgAEjIYkJqQzc
	rf3D/4FpmjdpZ2FpMHvz8Y+E/bYGk/2tjuGEMeRwQEcmQCa+jdUss52OgmCQbhShOS6N
	ALiWgcXHqsuT2WgfZbrYBSEWdeqH2tKYNowqfFEN1Hiz5UnDc7GsxwaL0pTuibDtvnPV
	FC5Q==
X-Gm-Message-State: ALoCoQn1l9CJu4JdC09w9yxaGTWGa92fySDBbUSr8GrpmyE68Rf+vcES7KwvbJlXpBpuFA6rwez+
X-Received: by 10.182.40.201 with SMTP id z9mr8737010obk.45.1396360231970;
	Tue, 01 Apr 2014 06:50:31 -0700 (PDT)
Received: from deserted.net (24-246-4-250.cable.teksavvy.com. [24.246.4.250])
	by mx.google.com with ESMTPSA id
	wj7sm29984815obc.8.2014.04.01.06.50.30 for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 01 Apr 2014 06:50:30 -0700 (PDT)
Date: Tue, 1 Apr 2014 09:50:28 -0400
From: Joe MacDonald <joe@deserted.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140401135024.GA16104@deserted.net>
References: <1396298667-17975-1-git-send-email-joe@deserted.net>
	<1396342711.14790.92.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1396342711.14790.92.camel@ted>
X-URL: http://github.com/joeythesaint/joe-s-common-environment/tree/master
X-Configuration: git://github.com/joeythesaint/joe-s-common-environment.git
X-Editor: Vim-703 http://www.vim.org
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: parse: allow vars_from_file to consider inc files as recipes
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
X-List-Received-Date: Tue, 01 Apr 2014 13:50:36 -0000
X-Groupsio-MsgNum: 4611
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Re: [bitbake-devel] [PATCH] bitbake: parse: allow vars_from_file to consid=
er inc files as recipes] On 14.04.01 (Tue 09:58) Richard Purdie wrote:

> On Mon, 2014-03-31 at 16:44 -0400, joe@deserted.net wrote:
> > From: Joe MacDonald <joe@deserted.net>
> >=20
> > A side-effect of making vars_from_file return None for non-recipes is t=
hat
> > PV gets 'None' if you have an included file named <recipe>.inc.  If the=
re
> > is a recipe with a version number in the name for a .inc file, it's
> > probably reasonable to calculate PV based on that file, rather than giv=
ing
> > it 'None' (which becomes 1.0 in most cases).
> >=20
> > Signed-off-by: Joe MacDonald <joe@deserted.net>
> > ---
> >  bitbake/lib/bb/parse/__init__.py |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > I ran into this when building meta-selinux where there's a chain of inc=
ludes:
> >=20
> >    refpolicy-mls_2.20130424.bb
> >     -> refpolicy_2.20130424.inc
> >       -> refpolicy_common.inc
>=20
> The question to ask here is why is PV being expanded during the .inc
> file?
>=20
> When this code was changed, we did find some issues like this but it
> usually means something unexpected was happening and "bad" PV values
> were actually being used in some cases. It was therefore a conscious
> decision not to do this.

Oh, okay.  I scanned back through the mailing list traffic from the time
when it went in but didn't see a discussion there, but likely it was a
more interactive thing.

> If I take this change, you could get PV of "common" being used in the
> second .inc file which is nasty.

I don't want to keep using meta-selinux as an example here, (since it
mostly ends up looking bad for meta-selinux, I suppose) but I can
actually see a case where -common would be organizationally desirable.
Or at least not ugly.  recipies-security/selinux has a collection of
core selinux recipes, each has their own patches directory which
potentially co-mingles patches for versioned and git-based recipes or
both.  Right now none of the recipes in there are doing the
<specific> -> <versioned> -> <common> include thing, but it's not a huge
stretch to imagine it being useful.

In other cases that'd be done with a versioned directory name and a
files/ directory, but that would make things less clear, not more in
this scenario.  So having a <recipie>-common directory would be kind of
good.

> I'd therefore much rather figure out what is happening to cause the
> expansion of PV in the .inc file and see if we can't avoid that.
>=20
> Looking at the layer, the issue is:
>=20
> FILESEXTRAPATHS_prepend :=3D "${THISDIR}/refpolicy-${PV}:"
>=20
> and I'd suggest that line move to the .bb files in this case.

That's what I'll do if you're not convinced on this patch, but when I
started down that path yesterday afternoon I got thinking about what I'd
laid out above and that I would be duplicating the exact same line in
three recipes right now (-mcs, -mls and -standard) and adding it to any
other new policies that get submitted.  That really is a common piece
shared among all the variants and it seemed like the right thing to do
was have it only in one place.

--=20
-Joe MacDonald.
:wq

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlM6xBIACgkQwFvcllog0XzGCQCgumM1w6xIN/NmQqr5XJsQQk6M
XNQAn1Badrp6TSN5MzV+OUyVHEeJsL8p
=3IoZ
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
