Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f173.google.com (mail-ea0-f173.google.com
	[209.85.215.173])
	by mail.openembedded.org (Postfix) with ESMTP id 724D360D2D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 09:12:37 +0000 (UTC)
Received: by mail-ea0-f173.google.com with SMTP id o10so7765466eaj.32
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jan 2014 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=4U/OizZ2DvKn4dikmsJblXyWVkjh27ovJTKmrR6MBpY=;
	b=eLcjucnmPT+L5ujOUbhisMnZ1JX5PNArXXjeIqgaJnm/45vYCd5IjsHUMWlScX5ka0
	W3+GoIODJniEuRG0lkCzeDwjsA/Q4xzbFd0/3xtIlMMn4oQ2OmU7VDvX0qco6bgoyOyl
	3SueuxdxKSqk3ibJUYtHCRdE8d8iaEIQOeG59sB7agyOmyzv2mqEVG4nW3qTlVBCKUif
	c7z3ok6JKx5LABAFASkM4QAfEl9qOXod0CU+UEpribSYSeqaBtxTfcdNT0VkAP0hzxfE
	r8M6Lj4dIdJSIGx1amu77nPjkwL5321YnrK9/u2l6mlWI9a9WfvrZAVrX0nwD3DfFA84
	LM5A==
X-Received: by 10.15.54.72 with SMTP id s48mr86013021eew.3.1388999557948;
	Mon, 06 Jan 2014 01:12:37 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id 1sm169116358eeg.4.2014.01.06.01.12.36
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 Jan 2014 01:12:37 -0800 (PST)
Date: Mon, 6 Jan 2014 10:12:45 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: "zhenhua.luo@freescale.com" <zhenhua.luo@freescale.com>
Message-ID: <20140106091245.GE3709@jama>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
	<566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
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
X-List-Received-Date: Mon, 06 Jan 2014 09:12:38 -0000
X-Groupsio-MsgNum: 4281
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline

--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 04:25:00AM +0000, zhenhua.luo@freescale.com wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-deve=
l-
> > bounces@lists.openembedded.org] On Behalf Of Martin Jansa
> > Sent: Friday, January 03, 2014 9:44 PM
> >=20
> > On Tue, Dec 24, 2013 at 04:06:32PM +0800, Zhenhua Luo wrote:
> > > The change add the sanity check for SHA valididy when tag is defined
> > > in SRC_URI, the check is useful for rebased git tree in which the
> > > referred commit is not valid in branch and is saved in tag.
> >=20
> > I've tested this patch with corner case reported in:
> > http://lists.openembedded.org/pipermail/openembedded-core/2013-
> > December/087486.html
> >=20
> > and now I can "fix" yajl recipe fetch just by adding "tag=3D1.0.12" into
> > the SRC_URI.
> >=20
> > But it's still a bit confusing for SRCREVs which are accessible from so=
me
> > tag, but aren't corresponding to that tag directly, people will assume
> > that tag=3Dfoo in SRC_URI is really what will be used, but instead some
> > older SRCREV can be used.
> >=20
> > Maybe we need 3rd option to prevent default "master" branch and handle
> > SRCREVs not included in any branch and not matching any tag differently?
> [Luo Zhenhua-B19537] Do you mean adding a new option to skip the validity=
 check of SHA?

Yes, I was thinking about something like nobranch parameter which will
explicitly say that selected SRCREV is known to be not included in any
branch or any tag.

In most cases it shouldn't be needed but still such corner cases exist
(e.g. rebased repos).
=20
> > Then we can add sanity check that when tag=3D and SRCREV are both used =
than
> > SRCREV should point to SHA-1 of annotated tag or dereferrenced tag.
> [Luo Zhenhua-B19537] I submitted another patch to adjust the revision def=
inition priority(http://patches.openembedded.org/patch/63703/).=20
> 	SHA define priority sequence.=20
> 	a) a source revision if SHA is specified by SRCREV
> 	b) a source revision if revision is specified in SRC_URI
> 	c) latest revision if SRCREV=3D"AUTOINC"
> 	d) None if not specified
>=20
> 	When tag is defined in SRC_URI, there are three SHA definition scenarios=
:=20
> 	* SRCREV is set to SHA corresponding to the tag, commit corresponding to=
 the tag will be used

This is OK, but you cannot check that it really corresponds and show
warning if not, because it could be now allowed variant with older SHA
as bellow.

> 	* SRCREV is set to an older SHA in the tag, the older commit in the tag =
will be used

This one is IMHO a bit confusing, because people can notice
SRC_URI=3D.*;tag=3Dfoo

and then they don't notice SRCREV in the recipe (or don't expect it to
be older commit in foo tag) and they just assume that tag=3Dfoo means the
tip of the tag will be used in build.

In most cases such commit is also included in some branch and using just
SRC_URI=3D.*;branch=3Dfoo + SRCREV would be less confusing.

So I would show warning in this case.

In very few exceptions (if any) where you really want SRCREV not
included in any branch and included in some tag, but not corresponding
to that tag you would use
SRC_URI=3D.*;nobranch + SRCREV

> 	* SRCREV is not set, commit corresponding to the tag will be used.=20
> 	Does above implementation make sense? Or any other better method?=20

We're doing something similar
https://github.com/openwebos/meta-webos/blob/master/classes/webos_enhanced_=
submissions.bbclass
with the advantage that we can say that all our components which inherit
this class have to use annotated tags (with lightweight tags you can use
SRCREV corresponding with tag which exists only in remote repository,
but isn't in your downloads/premirror version, even when the SRCREV
exists already - annotated tag has always new SRCREV so fetcher will
always update the repo and we don't need to use git ls-remote to verify
that SRCREV is matching the tag.

> > > Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> > > ---
> > >  lib/bb/fetch2/git.py | 29 +++++++++++++++++++++++++++--
> > >  1 file changed, 27 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py index
> > > bd107db..1c2d5d3 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -116,6 +116,15 @@ class Git(FetchMethod):
> > >              ud.branches[name] =3D branch
> > >              ud.unresolvedrev[name] =3D branch
> > >
> > > +        tags =3D ud.parm.get("tag", "").split(',')
> > > +        if len(tags) !=3D len(ud.names):
> > > +            raise bb.fetch2.ParameterError("The number of name and t=
ag
> > parameters is not balanced", ud.url)
> > > +        ud.tags =3D {}
> > > +        for name in ud.names:
> > > +            tag =3D tags[ud.names.index(name)]
> > > +            ud.tags[name] =3D tag
> > > +            ud.unresolvedrev[name] =3D tag
> > > +
> > >          ud.basecmd =3D data.getVar("FETCHCMD_git", d, True) or "git"
> > >
> > >          ud.write_tarballs =3D
> > > ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") !=3D "0=
")
> > or ud.rebaseable @@ -218,7 +227,10 @@ class Git(FetchMethod):
> > >          os.chdir(ud.clonedir)
> > >          for name in ud.names:
> > >              if not self._contains_ref(ud, d, name):
> > > -                raise bb.fetch2.FetchError("Unable to find revision =
%s
> > in branch %s even from upstream" % (ud.revisions[name],
> > ud.branches[name]))
> > > +                if ud.tags[name]:
> > > +                    raise bb.fetch2.FetchError("Unable to find
> > revision %s in tag %s even from upstream" % (ud.revisions[name],
> > ud.tags[name]))
> > > +                else:
> > > +                    raise bb.fetch2.FetchError("Unable to find
> > > + revision %s in branch %s even from upstream" % (ud.revisions[name],
> > > + ud.branches[name]))
> > >
> > >      def build_mirror_data(self, ud, d):
> > >          # Generate a mirror tarball if needed @@ -288,6 +300,18 @@
> > > class Git(FetchMethod):
> > >          return True
> > >
> > >      def _contains_ref(self, ud, d, name):
> > > +        if len(ud.tags[name]) !=3D 0:
> > > +            cmd =3D  "%s tag --contains %s --list %s 2> /dev/null | =
wc -
> > l" % (
> > > +                ud.basecmd, ud.revisions[name], ud.tags[name])
> > > +            try:
> > > +                output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> > > +            except bb.fetch2.FetchError:
> > > +                return False
> > > +            if len(output.split()) > 1:
> > > +                raise bb.fetch2.FetchError("The command '%s' gave
> > output with more then 1 line unexpectedly, output: '%s'" % (cmd, output=
))
> > > +            else:
> > > +                return output.split()[0] !=3D "0"
> > > +
> > >          cmd =3D  "%s branch --contains %s --list %s 2> /dev/null | w=
c -
> > l" % (
> > >              ud.basecmd, ud.revisions[name], ud.branches[name])
> > >          try:
> > > @@ -296,7 +320,8 @@ class Git(FetchMethod):
> > >              return False
> > >          if len(output.split()) > 1:
> > >              raise bb.fetch2.FetchError("The command '%s' gave output
> > with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> > > -        return output.split()[0] !=3D "0"
> > > +        else:
> > > +            return output.split()[0] !=3D "0"
> > >
> > >      def _revision_key(self, ud, d, name):
> > >          """
> > > --
> > > 1.8.4.2
> > >
> > >
> > > _______________________________________________
> > > bitbake-devel mailing list
> > > bitbake-devel@lists.openembedded.org
> > > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> >=20
> > --
> > Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLKc40ACgkQN1Ujt2V2gBy7XQCeM2fu5F1nlBQKimRljrAHx5XQ
A90AnjS9LMXn8qLHo/+IHSBZBh24/+IM
=R/Cf
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
