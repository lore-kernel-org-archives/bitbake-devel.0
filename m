Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S85mx-0005Nv-3m
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:11:59 +0100
Received: by wibhj13 with SMTP id hj13so3359167wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Mar 2012 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=tbtiMYeMNNCODy4Fyvv16pm9Rs0hIlR0M6rNQ/zZ1tk=;
	b=e45LsPIGx6/ozHCqHZsO1R7b2291fU90v6MSDbAayhOHQuqKoPegjHzmYYjHxJ8KWa
	SyeX+E3EnVb9CdKLNetUeH41HVpKQpvpx+oyv0A5WAiA3gSHC53N7kLjLdZpnz/WV/TT
	wtY+DSYSvMjWkkERhw8Jt1IPByR+McycGQzKaidYK0gNOgl/mI2+6zA5e5+Y6mlqgHLU
	hMlFZksVWPLXtl97Cym8YiACi1w73u5WGJk6gN0LHDhW1eoW1NaisUcmwUUCjLeHcwDH
	M0QRg5OR27X/KGsajlwmFtQcmIZYT9kG9jyNuVsq5hCO7QP7jzWhdxYDyVs3ICsYRmm+
	tumA==
Received: by 10.180.79.231 with SMTP id m7mr13237661wix.11.1331798593066;
	Thu, 15 Mar 2012 01:03:13 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id ff9sm3200335wib.2.2012.03.15.01.03.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 15 Mar 2012 01:03:12 -0700 (PDT)
Date: Thu, 15 Mar 2012 09:03:10 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Kang Kai <Kai.Kang@windriver.com>
Message-ID: <20120315080310.GC4973@jama.jama.net>
References: <4F605E85.7070904@windriver.com> <1331718176.18586.15.camel@ted>
	<4F61926D.1060709@windriver.com> <4F619CD4.4090103@windriver.com>
MIME-Version: 1.0
In-Reply-To: <4F619CD4.4090103@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: How to identify WORKDIR?
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
X-List-Received-Date: Thu, 15 Mar 2012 08:11:59 -0000
X-Groupsio-MsgNum: 1278
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline

--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
> On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 14:55, Kang Kai wrote:
> > On 2012=E5=B9=B403=E6=9C=8814=E6=97=A5 17:42, Richard Purdie wrote:
> >> On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> >>> Hi All,
> >>>
> >>> I write a script to clean up WORKDIR that remove the obsoleted
> >>> packages' build directories.
> >>> The script accept a argument as BUILDDIR and I use this clause to
> >>> identify the WORKDIR:
> >>>
> >>>       workdir =3D os.path.join(builddir, 'tmp/work')
> >>>
> >>> Then validate the workdir exists or not. It works for me but hardcode
> >>> here as Richard point out.
> >>> So is there  a better way to get the WORKDIR here? Thanks.
> >> I was thinking of something like:
> >>
> >> bitbake -e | grep ^WORKDIR
> And the result is something like that:
> WORKDIR=3D"/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x86_64-=
poky-linux/bblayers-1.0-r0"
>=20
> Is it ok to remove 2 items seperated by slash at the end of string?=20
> Right now is:
> "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"

Aren't you looking for ^TMPDIR ?

>=20
> Regards,
> Kai
>=20
> >
> > If get WORKDIR in this way, I'll update the script with no argument=20
> > because the argument is useless to identify the WORKDIR.
> >
> > Regards,
> > Kai
> >>
> >> since you already call into bitbake in the script in question.
> >>
> >> Cheers,
> >>
> >> Richard
> >>
> >>
> >
> >
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9hoj4ACgkQN1Ujt2V2gBwSjwCgrv3GCxeSau6Qg7jDcqdVLbLl
fV0An1Bwfuv5EW2ba7VxW5YnJ6G8gDaF
=rKvW
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
