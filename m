Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
	by mail.openembedded.org (Postfix) with ESMTP id 61991610D8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 13:43:39 +0000 (UTC)
Received: by mail-ee0-f41.google.com with SMTP id t10so6800610eei.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2014 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=qK6Xkht8+pK/Q47R5b7i+a7rTqPZSK2h+rWvcSNwuJo=;
	b=ILx9ND27JvPnvbBOG3C5T2KCu0+/K6tkkErXNbdVbHYzXPSzpOBh8WIZHVWYyFKUcD
	m3vODK9yhOMO3+A1xbQjAEevBuJVlKvt5GuqicjvCi4ChaE46O9hKdEqmmgHh8A6a6mz
	oxXj9E16HCccFSekH91WYUVZmEfod1VWCm+fGfPb3d0t6GCf27itB8HsBsHzNnTq1AQs
	BzwXLZ2UnsZgVSA5g4Tddoe92VRXh399Ic0tVx1HL9em9+qAaxFsy9pfOKTxrki0+ttu
	E36B+xy3gnSsC21a7uJ2DLH5OAhVC169CWwCI/o2ucSIq77ouuVHECpBIODsHfKusV3d
	LJWg==
X-Received: by 10.14.204.70 with SMTP id g46mr2385375eeo.84.1388756620053;
	Fri, 03 Jan 2014 05:43:40 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107]) by mx.google.com with ESMTPSA id
	h3sm145080954eem.15.2014.01.03.05.43.38 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Jan 2014 05:43:39 -0800 (PST)
Date: Fri, 3 Jan 2014 14:43:43 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Zhenhua Luo <zhenhua.luo@freescale.com>
Message-ID: <20140103134343.GF3707@jama>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
In-Reply-To: <1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: b40290@freescale.com, bitbake-devel@lists.openembedded.org,
	b40527@freescale.com
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
X-List-Received-Date: Fri, 03 Jan 2014 13:43:41 -0000
X-Groupsio-MsgNum: 4274
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline

--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2013 at 04:06:32PM +0800, Zhenhua Luo wrote:
> The change add the sanity check for SHA valididy when tag is defined in S=
RC_URI,
> the check is useful for rebased git tree in which the referred commit is =
not valid
> in branch and is saved in tag.

I've tested this patch with corner case reported in:
http://lists.openembedded.org/pipermail/openembedded-core/2013-December/087=
486.html

and now I can "fix" yajl recipe fetch just by adding "tag=3D1.0.12" into the
SRC_URI.

But it's still a bit confusing for SRCREVs which are accessible from
some tag, but aren't corresponding to that tag directly, people will
assume that tag=3Dfoo in SRC_URI is really what will be used, but instead
some older SRCREV can be used.

Maybe we need 3rd option to prevent default "master" branch and handle
SRCREVs not included in any branch and not matching any tag differently?

Then we can add sanity check that when tag=3D and SRCREV are both used than
SRCREV should point to SHA-1 of annotated tag or dereferrenced tag.

> Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> ---
>  lib/bb/fetch2/git.py | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index bd107db..1c2d5d3 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -116,6 +116,15 @@ class Git(FetchMethod):
>              ud.branches[name] =3D branch
>              ud.unresolvedrev[name] =3D branch
> =20
> +        tags =3D ud.parm.get("tag", "").split(',')
> +        if len(tags) !=3D len(ud.names):
> +            raise bb.fetch2.ParameterError("The number of name and tag p=
arameters is not balanced", ud.url)
> +        ud.tags =3D {}
> +        for name in ud.names:
> +            tag =3D tags[ud.names.index(name)]
> +            ud.tags[name] =3D tag
> +            ud.unresolvedrev[name] =3D tag
> +
>          ud.basecmd =3D data.getVar("FETCHCMD_git", d, True) or "git"
> =20
>          ud.write_tarballs =3D ((data.getVar("BB_GENERATE_MIRROR_TARBALLS=
", d, True) or "0") !=3D "0") or ud.rebaseable
> @@ -218,7 +227,10 @@ class Git(FetchMethod):
>          os.chdir(ud.clonedir)
>          for name in ud.names:
>              if not self._contains_ref(ud, d, name):
> -                raise bb.fetch2.FetchError("Unable to find revision %s i=
n branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
> +                if ud.tags[name]:=20
> +                    raise bb.fetch2.FetchError("Unable to find revision =
%s in tag %s even from upstream" % (ud.revisions[name], ud.tags[name]))
> +                else:
> +                    raise bb.fetch2.FetchError("Unable to find revision =
%s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name=
]))
> =20
>      def build_mirror_data(self, ud, d):
>          # Generate a mirror tarball if needed
> @@ -288,6 +300,18 @@ class Git(FetchMethod):
>          return True
> =20
>      def _contains_ref(self, ud, d, name):
> +        if len(ud.tags[name]) !=3D 0:
> +            cmd =3D  "%s tag --contains %s --list %s 2> /dev/null | wc -=
l" % (
> +                ud.basecmd, ud.revisions[name], ud.tags[name])
> +            try:
> +                output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> +            except bb.fetch2.FetchError:
> +                return False
> +            if len(output.split()) > 1:
> +                raise bb.fetch2.FetchError("The command '%s' gave output=
 with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> +            else:
> +                return output.split()[0] !=3D "0"
> +
>          cmd =3D  "%s branch --contains %s --list %s 2> /dev/null | wc -l=
" % (
>              ud.basecmd, ud.revisions[name], ud.branches[name])
>          try:
> @@ -296,7 +320,8 @@ class Git(FetchMethod):
>              return False
>          if len(output.split()) > 1:
>              raise bb.fetch2.FetchError("The command '%s' gave output wit=
h more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> -        return output.split()[0] !=3D "0"
> +        else:
> +            return output.split()[0] !=3D "0"
> =20
>      def _revision_key(self, ud, d, name):
>          """
> --=20
> 1.8.4.2
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLGvo8ACgkQN1Ujt2V2gBx2iACfbfY8iGRUMp9H1zT8r3DWdMX/
fHsAoLTwunzqpdKhwiRZNPkRjD6Kopv1
=ekGO
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
