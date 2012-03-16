Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S8Qzq-0003tV-US
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 07:50:43 +0100
Received: by wgbdr12 with SMTP id dr12so119819wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Mar 2012 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=g3EhnC2xheyEpwZmAaCHjahnum/7irjr9lF2hjGZENw=;
	b=eMZS9o7+icCxnmExnd3mA7ab5SFUKXoW3nemYzC5eFBY+5tFOKC8B2W3FEbc2LAf5g
	A6glpaum7H1bljiZSUV8/ovvKbKEk8N+qZZMFhIC62hRTVZi1CA44x5r77vbiuP60tfb
	/3LQv9YWDNFtiCTOaAM7gA7r5YorktekQVjgbVE99V+pA9zStKMOTsR4VqXmlS9Fzqha
	EICmVW6yezOuDNkaBjvtzg//0BGRarmVeDIfoyum7RSxRqkmob73ROtY8Nb8p0Vm+UwR
	JHhZvi0u9a3QtuD2OH2njNlosl26txOG12huiIKM2oyViwWB5JGSbufv7UFeqzA6/zA1
	dqUg==
Received: by 10.180.87.8 with SMTP id t8mr32709122wiz.15.1331880115587;
	Thu, 15 Mar 2012 23:41:55 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id ez18sm1076332wid.4.2012.03.15.23.41.53
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 15 Mar 2012 23:41:54 -0700 (PDT)
Date: Fri, 16 Mar 2012 07:41:52 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Denys Dmytriyenko <denis@denix.org>
Message-ID: <20120316064152.GA3855@jama.jama.net>
References: <4F605E85.7070904@windriver.com> <1331718176.18586.15.camel@ted>
	<4F61926D.1060709@windriver.com> <4F619CD4.4090103@windriver.com>
	<20120315080310.GC4973@jama.jama.net>
	<4F61B1D0.2080306@windriver.com>
	<20120315092122.GE4973@jama.jama.net>
	<20120315181844.GE30363@denix.org>
MIME-Version: 1.0
In-Reply-To: <20120315181844.GE30363@denix.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Kang Kai <Kai.Kang@windriver.com>, bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 16 Mar 2012 06:50:43 -0000
X-Groupsio-MsgNum: 1301
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 02:18:44PM -0400, Denys Dmytriyenko wrote:
> On Thu, Mar 15, 2012 at 10:21:22AM +0100, Martin Jansa wrote:
> > On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:
> > > On 2012???03???15??? 16:03, Martin Jansa wrote:
> > > > On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
> > > >> On 2012???03???15??? 14:55, Kang Kai wrote:
> > > >>> On 2012???03???14??? 17:42, Richard Purdie wrote:
> > > >>>> On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> > > >>>>> Hi All,
> > > >>>>>
> > > >>>>> I write a script to clean up WORKDIR that remove the obsoleted
> > > >>>>> packages' build directories.
> > > >>>>> The script accept a argument as BUILDDIR and I use this clause =
to
> > > >>>>> identify the WORKDIR:
> > > >>>>>
> > > >>>>>        workdir =3D os.path.join(builddir, 'tmp/work')
> > > >>>>>
> > > >>>>> Then validate the workdir exists or not. It works for me but ha=
rdcode
> > > >>>>> here as Richard point out.
> > > >>>>> So is there  a better way to get the WORKDIR here? Thanks.
> > > >>>> I was thinking of something like:
> > > >>>>
> > > >>>> bitbake -e | grep ^WORKDIR
> > > >> And the result is something like that:
> > > >> WORKDIR=3D"/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/=
x86_64-poky-linux/bblayers-1.0-r0"
> > > >>
> > > >> Is it ok to remove 2 items seperated by slash at the end of string?
> > > >> Right now is:
> > > >> "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"
> > > > Aren't you looking for ^TMPDIR ?
> > >=20
> > > If use WORKDIR =3D TMPDIR/"work", it is still hard coding.
> >=20
> > Assuming 2 items at the end won't work for people using rm_old_work:
> > http://git.openembedded.org/meta-micro/commit/?id=3Dfcf525654915edb9650=
f1a6c2852f336366f8b2f
> > or slightly different version:
> > http://git.shr-project.org/git/?p=3Dmeta-smartphone.git;a=3Dblob;f=3Dme=
ta-shr/classes/rm_old_work.bbclass
>=20
> Martin,
>=20
> Can you please point me to more details about this class - any background=
 or=20
> discussions... Thanks.

Hi,

Well it works better then rm_work with sstate and the original class is
=66rom meta-micro (so maybe ask pb if you want more details, but the class
is quite simple). I've just replaced last directory name because of this
issue:

http://git.shr-project.org/git/?p=3Dmeta-smartphone.git;a=3Dcommit;h=3D0d4c=
17de1ba7343d82bb10c311754e29d573c485

Cheers,

>=20
> --=20
> Denys
>=20
>=20
> > And I think more people have different "tmp/" part e.g. default would be
> > "tmp-eglibc/" (thanks to TCLIBCAPPEND
> > meta/conf/distro/defaultsetup.conf:TMPDIR .=3D "${TCLIBCAPPEND}"), but =
"work" is=20
> > quite common.
> >=20
> > meta/conf/bitbake.conf:
> > WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
> > meta-shr/classes/rm_old_work.bbclass:
> > WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${PF}"
> > meta-micro/classes/rm_old_work.bbclass:
> > WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${=
PV}-${PR}"
> >=20
> > Cheers,
> >=20
> > >=20
> > > >> Regards,
> > > >> Kai
> > > >>
> > > >>> If get WORKDIR in this way, I'll update the script with no argume=
nt
> > > >>> because the argument is useless to identify the WORKDIR.
> > > >>>
> > > >>> Regards,
> > > >>> Kai
> > > >>>> since you already call into bitbake in the script in question.
> > > >>>>
> > > >>>> Cheers,
> > > >>>>
> > > >>>> Richard
> > > >>>>
> > > >>>>
> > > >>>
> > > >>> _______________________________________________
> > > >>> bitbake-devel mailing list
> > > >>> bitbake-devel@lists.openembedded.org
> > > >>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > >>
> > > >> _______________________________________________
> > > >> bitbake-devel mailing list
> > > >> bitbake-devel@lists.openembedded.org
> > > >> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > >=20
> >=20
> > --=20
> > Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com
>=20
>=20
>=20
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9i4LAACgkQN1Ujt2V2gBxcQQCbB83XOInJhiNBlaRBrSk5esP8
frEAoJE+FBY5AakKBQ4d6x9B0/LaiHJB
=jwcv
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
