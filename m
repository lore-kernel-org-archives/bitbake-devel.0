Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S870d-0007MO-ID
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 10:30:11 +0100
Received: by wibhj13 with SMTP id hj13so7371346wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Mar 2012 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=l+j0Hk5H1ByrEOyRVbxJTU1+LBe95ywXniO8ZiULi+4=;
	b=HV33a1Df9AhRAX8oO4b9sjSJnEzYO4aVduqMDjr4zJpD3LTAcOn4DxqpB2fcKKMDUO
	GdHhPRvaUcwXFPS/e/wnmtF7PxK/QRu8OhMT37w8ZVGRXdrBqB99dS6DgdoOfH6Ouotb
	cQBFhmgn0ob1T2GGMNqpWA7b4WFKjE3EGwiuIXget2AgZe+B6/m3akpC6DwDZD5pFjy0
	wdIXGpaywtGYfElJA0scySNnbjd5D1YGZcMuDVqMr31yieqRPTRjROCBQHyXHapFoo5X
	FS+aOyp1PFD/nSSAvKR5iylzMVdSnzI+BAdaBaPyhr+hH2HIoPYP1m+eQHj8hltWMZoV
	lXlg==
Received: by 10.216.139.229 with SMTP id c79mr4223157wej.16.1331803285387;
	Thu, 15 Mar 2012 02:21:25 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id t20sm6125536wiv.0.2012.03.15.02.21.23
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 15 Mar 2012 02:21:24 -0700 (PDT)
Date: Thu, 15 Mar 2012 10:21:22 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Kang Kai <Kai.Kang@windriver.com>
Message-ID: <20120315092122.GE4973@jama.jama.net>
References: <4F605E85.7070904@windriver.com> <1331718176.18586.15.camel@ted>
	<4F61926D.1060709@windriver.com> <4F619CD4.4090103@windriver.com>
	<20120315080310.GC4973@jama.jama.net>
	<4F61B1D0.2080306@windriver.com>
MIME-Version: 1.0
In-Reply-To: <4F61B1D0.2080306@windriver.com>
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
X-List-Received-Date: Thu, 15 Mar 2012 09:30:11 -0000
X-Groupsio-MsgNum: 1294
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline

--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:
> On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 16:03, Martin Jansa wrote:
> > On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
> >> On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 14:55, Kang Kai wrote:
> >>> On 2012=E5=B9=B403=E6=9C=8814=E6=97=A5 17:42, Richard Purdie wrote:
> >>>> On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> >>>>> Hi All,
> >>>>>
> >>>>> I write a script to clean up WORKDIR that remove the obsoleted
> >>>>> packages' build directories.
> >>>>> The script accept a argument as BUILDDIR and I use this clause to
> >>>>> identify the WORKDIR:
> >>>>>
> >>>>>        workdir =3D os.path.join(builddir, 'tmp/work')
> >>>>>
> >>>>> Then validate the workdir exists or not. It works for me but hardco=
de
> >>>>> here as Richard point out.
> >>>>> So is there  a better way to get the WORKDIR here? Thanks.
> >>>> I was thinking of something like:
> >>>>
> >>>> bitbake -e | grep ^WORKDIR
> >> And the result is something like that:
> >> WORKDIR=3D"/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x86_=
64-poky-linux/bblayers-1.0-r0"
> >>
> >> Is it ok to remove 2 items seperated by slash at the end of string?
> >> Right now is:
> >> "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"
> > Aren't you looking for ^TMPDIR ?
>=20
> If use WORKDIR =3D TMPDIR/"work", it is still hard coding.

Assuming 2 items at the end won't work for people using rm_old_work:
http://git.openembedded.org/meta-micro/commit/?id=3Dfcf525654915edb9650f1a6=
c2852f336366f8b2f
or slightly different version:
http://git.shr-project.org/git/?p=3Dmeta-smartphone.git;a=3Dblob;f=3Dmeta-s=
hr/classes/rm_old_work.bbclass

And I think more people have different "tmp/" part e.g. default would be
"tmp-eglibc/" (thanks to TCLIBCAPPEND
meta/conf/distro/defaultsetup.conf:TMPDIR .=3D "${TCLIBCAPPEND}"), but "wor=
k" is=20
quite common.

meta/conf/bitbake.conf:
WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
meta-shr/classes/rm_old_work.bbclass:
WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${PF}"
meta-micro/classes/rm_old_work.bbclass:
WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${PV}-=
${PR}"

Cheers,

>=20
> >> Regards,
> >> Kai
> >>
> >>> If get WORKDIR in this way, I'll update the script with no argument
> >>> because the argument is useless to identify the WORKDIR.
> >>>
> >>> Regards,
> >>> Kai
> >>>> since you already call into bitbake in the script in question.
> >>>>
> >>>> Cheers,
> >>>>
> >>>> Richard
> >>>>
> >>>>
> >>>
> >>> _______________________________________________
> >>> bitbake-devel mailing list
> >>> bitbake-devel@lists.openembedded.org
> >>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> >>
> >> _______________________________________________
> >> bitbake-devel mailing list
> >> bitbake-devel@lists.openembedded.org
> >> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9htJIACgkQN1Ujt2V2gByt8ACgpFjLGIwws6rDo6a1Os+/hPGE
zzQAni9BbROCXN515TeOO0MlClQCsdaR
=53Ce
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
