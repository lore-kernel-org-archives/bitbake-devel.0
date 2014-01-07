Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f53.google.com (mail-ee0-f53.google.com [74.125.83.53])
	by mail.openembedded.org (Postfix) with ESMTP id 5CDFD6C959
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 14:46:50 +0000 (UTC)
Received: by mail-ee0-f53.google.com with SMTP id b57so116810eek.40
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Jan 2014 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=ccsKq/2sXUo/+yaCa9qIcgUkmbTYbGw764cNZjO6voY=;
	b=cL5rLfHXFinHkkmalSbPlrl0kwC4KMlMk+IMJLuaLnJrCLkkN0xSramPXKu6as4C6v
	aqRWWnAVwJFjUCNhx/nmxMsk4+eYywCrn2ViGe3xrMOggLfcf3WHZ7tcx3nnTYVDpZCf
	hJ4u5bpq/6gv0a94ezOT5rgsK1QwdeHkvc8aOEnWNJQy0jEHtciBZrYeg1OodjiLAvUs
	YElnZYuo/ZkJ5drmbwsiooc/b5Sv6Xni13fW9XiV7nv/muUQhnn/SpDdrmTWbzE7K/ey
	pWeW821pUkxTdoZSwumCMw25f4NDNDFyX5h1LQ+EwARojvLVcbNQqMViN7UWruONRF8D
	p2BQ==
X-Received: by 10.15.51.75 with SMTP id m51mr59973eew.113.1389106011078;
	Tue, 07 Jan 2014 06:46:51 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id v1sm180622516eef.9.2014.01.07.06.46.49
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Jan 2014 06:46:50 -0800 (PST)
Date: Tue, 7 Jan 2014 15:46:59 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
Message-ID: <20140107144659.GR3709@jama>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
	<566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140106091245.GE3709@jama>
	<c4d074a69c9d4c29b77cdf0bd01f7f20@DM2PR03MB399.namprd03.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <c4d074a69c9d4c29b77cdf0bd01f7f20@DM2PR03MB399.namprd03.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: "Zongchun.Yu@freescale.com" <Zongchun.Yu@freescale.com>,
	"B40290@freescale.com" <B40290@freescale.com>,
	"ting.liu@freescale.com" <ting.liu@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Richard Schmitt <richard.schmitt@freescale.com>
Subject: Re: [PATCH 1/2] bitbake: fetch2/git: Add sanity check for SHA validity of tag
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
X-List-Received-Date: Tue, 07 Jan 2014 14:46:51 -0000
X-Groupsio-MsgNum: 4296
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Content-Disposition: inline

--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 03:29:22AM +0000, zhenhua.luo@freescale.com wrote:
> It is a simple way to add "nobranch" option to skip the SHA validity chec=
k. I have posted a patch, please review.=20
>=20
> http://patches.openembedded.org/patch/64197/

The v2 looks good and it's already merged :).

> > > > Then we can add sanity check that when tag=3D and SRCREV are both u=
sed
> > > > than SRCREV should point to SHA-1 of annotated tag or dereferrenced
> > tag.
> > > [Luo Zhenhua-B19537] I submitted another patch to adjust the revision
> > definition priority(http://patches.openembedded.org/patch/63703/).
> > > 	SHA define priority sequence.
> > > 	a) a source revision if SHA is specified by SRCREV
> > > 	b) a source revision if revision is specified in SRC_URI
> > > 	c) latest revision if SRCREV=3D"AUTOINC"
> > > 	d) None if not specified
> > >
> > > 	When tag is defined in SRC_URI, there are three SHA definition
> > scenarios:
> > > 	* SRCREV is set to SHA corresponding to the tag, commit
> > corresponding
> > > to the tag will be used
> >=20
> > This is OK, but you cannot check that it really corresponds and show
> > warning if not, because it could be now allowed variant with older SHA =
as
> > bellow.

Be aware that for this to work correctly you need to run
"git fetch --tags" or equivalent, because with lightweight tags you can
have repo like this:

SHA-1
A123  <- tag-1.0
B123
C123  <- master HEAD

You're building C123 or tag-1.0 when C123 revision already exists, so
fetcher creates clone including all 3 SHA-1s, it creates tarball with
checkout and puts it on PREMIRROR.

Someone in upstream adds tag-1.1 pointing to B123

SHA-1
A123  <- tag-1.0
B123  <- tag-1.1
C123  <- master HEAD

Someone changes recipe to use:
SRCREV =3D "B123"
SRC_URI =3D "git://foo;tag=3Dtag-1.1"

Current fetcher starts by checking if "B123" SHA-1 exists in checkout
in downloads directory (or even downloaded from PREMIRROR) and it
returns yes, so it doesn't try to update it, but then if you try to
check that B123 corresponds with "tag-1.1" it fails, because tag-1.1
doesn't exist yet in current checkout/premirror.

With annotated tags it's not problem because every new tag has new
SHA-1, so fetcher always updates the checkout first when checking for
new tag.

> > > 	* SRCREV is set to an older SHA in the tag, the older commit in the
> > > tag will be used
> >=20
> > This one is IMHO a bit confusing, because people can notice
> > SRC_URI=3D.*;tag=3Dfoo
> >=20
> > and then they don't notice SRCREV in the recipe (or don't expect it to =
be
> > older commit in foo tag) and they just assume that tag=3Dfoo means the =
tip
> > of the tag will be used in build.
> >=20
> > In most cases such commit is also included in some branch and using just
> > SRC_URI=3D.*;branch=3Dfoo + SRCREV would be less confusing.
> >=20
> > So I would show warning in this case.
> >=20
> > In very few exceptions (if any) where you really want SRCREV not includ=
ed
> > in any branch and included in some tag, but not corresponding to that t=
ag
> > you would use SRC_URI=3D.*;nobranch + SRCREV

I think that with nobranch patch now merged we should show warning when
this case happens, people shouldn't use tag parameter when they don't
want exactly that tag.

> > > 	* SRCREV is not set, commit corresponding to the tag will be used.
> > > 	Does above implementation make sense? Or any other better method?
> >=20
> > We're doing something similar
> > https://github.com/openwebos/meta-
> > webos/blob/master/classes/webos_enhanced_submissions.bbclass
> > with the advantage that we can say that all our components which inherit
> > this class have to use annotated tags (with lightweight tags you can use
> > SRCREV corresponding with tag which exists only in remote repository, b=
ut
> > isn't in your downloads/premirror version, even when the SRCREV exists
> > already - annotated tag has always new SRCREV so fetcher will always
> > update the repo and we don't need to use git ls-remote to verify that
> > SRCREV is matching the tag.
> >=20
> > > > > Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> > > > > ---
> > > > >  lib/bb/fetch2/git.py | 29 +++++++++++++++++++++++++++--
> > > > >  1 file changed, 27 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py index
> > > > > bd107db..1c2d5d3 100644
> > > > > --- a/lib/bb/fetch2/git.py
> > > > > +++ b/lib/bb/fetch2/git.py
> > > > > @@ -116,6 +116,15 @@ class Git(FetchMethod):
> > > > >              ud.branches[name] =3D branch
> > > > >              ud.unresolvedrev[name] =3D branch
> > > > >
> > > > > +        tags =3D ud.parm.get("tag", "").split(',')
> > > > > +        if len(tags) !=3D len(ud.names):
> > > > > +            raise bb.fetch2.ParameterError("The number of name
> > > > > + and tag
> > > > parameters is not balanced", ud.url)
> > > > > +        ud.tags =3D {}
> > > > > +        for name in ud.names:
> > > > > +            tag =3D tags[ud.names.index(name)]
> > > > > +            ud.tags[name] =3D tag
> > > > > +            ud.unresolvedrev[name] =3D tag
> > > > > +
> > > > >          ud.basecmd =3D data.getVar("FETCHCMD_git", d, True) or "=
git"
> > > > >
> > > > >          ud.write_tarballs =3D
> > > > > ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") !=3D
> > > > > "0")
> > > > or ud.rebaseable @@ -218,7 +227,10 @@ class Git(FetchMethod):
> > > > >          os.chdir(ud.clonedir)
> > > > >          for name in ud.names:
> > > > >              if not self._contains_ref(ud, d, name):
> > > > > -                raise bb.fetch2.FetchError("Unable to find
> > revision %s
> > > > in branch %s even from upstream" % (ud.revisions[name],
> > > > ud.branches[name]))
> > > > > +                if ud.tags[name]:
> > > > > +                    raise bb.fetch2.FetchError("Unable to find
> > > > revision %s in tag %s even from upstream" % (ud.revisions[name],
> > > > ud.tags[name]))
> > > > > +                else:
> > > > > +                    raise bb.fetch2.FetchError("Unable to find
> > > > > + revision %s in branch %s even from upstream" %
> > > > > + (ud.revisions[name],
> > > > > + ud.branches[name]))
> > > > >
> > > > >      def build_mirror_data(self, ud, d):
> > > > >          # Generate a mirror tarball if needed @@ -288,6 +300,18
> > > > > @@ class Git(FetchMethod):
> > > > >          return True
> > > > >
> > > > >      def _contains_ref(self, ud, d, name):
> > > > > +        if len(ud.tags[name]) !=3D 0:
> > > > > +            cmd =3D  "%s tag --contains %s --list %s 2> /dev/nul=
l |
> > > > > + wc -
> > > > l" % (
> > > > > +                ud.basecmd, ud.revisions[name], ud.tags[name])
> > > > > +            try:
> > > > > +                output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> > > > > +            except bb.fetch2.FetchError:
> > > > > +                return False
> > > > > +            if len(output.split()) > 1:
> > > > > +                raise bb.fetch2.FetchError("The command '%s' gave
> > > > output with more then 1 line unexpectedly, output: '%s'" % (cmd,
> > > > output))
> > > > > +            else:
> > > > > +                return output.split()[0] !=3D "0"
> > > > > +
> > > > >          cmd =3D  "%s branch --contains %s --list %s 2> /dev/null=
 |
> > > > > wc -
> > > > l" % (
> > > > >              ud.basecmd, ud.revisions[name], ud.branches[name])
> > > > >          try:
> > > > > @@ -296,7 +320,8 @@ class Git(FetchMethod):
> > > > >              return False
> > > > >          if len(output.split()) > 1:
> > > > >              raise bb.fetch2.FetchError("The command '%s' gave
> > > > > output
> > > > with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> > > > > -        return output.split()[0] !=3D "0"
> > > > > +        else:
> > > > > +            return output.split()[0] !=3D "0"
> > > > >
> > > > >      def _revision_key(self, ud, d, name):
> > > > >          """
> > > > > --
> > > > > 1.8.4.2
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > bitbake-devel mailing list
> > > > > bitbake-devel@lists.openembedded.org
> > > > > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> > > >
> > > > --
> > > > Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com
> >=20
> > --
> > Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLME2MACgkQN1Ujt2V2gBzsBQCgo3uQr3jwS686kqqa8vyW6T7t
m/MAn2Ixz2qmqeHzwIMsswkngycMM0C4
=d70Y
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
