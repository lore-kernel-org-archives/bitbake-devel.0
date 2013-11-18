Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
	[209.85.215.169])
	by mail.openembedded.org (Postfix) with ESMTP id 8DB296D970
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 18:32:12 +0000 (UTC)
Received: by mail-ea0-f169.google.com with SMTP id l9so2615330eaj.14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=kjdJlSegsoV9PTAx46KxCEDpqsYOe1F6Sp3YvC6PGU8=;
	b=vd5d5hnCFPOreHWn8dexTeSTfiseyZcwlrVPRnbN9pgYK8nKgd3ZVPtUU5vEObtZRF
	Ib3IVAhdqKUa/KORSBr2iOP8Y/XnDziCiBXUX26a6ubN5JUn98efOpZO9rE/wSMdz9Li
	MNrJCQj18A+qDIZgSt7qLjJNxVCWGNQwjcOxWLQDZ9yirf9/J5U3prIGMufWdzp//01+
	k8D5sMJDAXeS4G6C1awpXMPfdPoKWyF3+e2BrQX0PRosoFiJLAy/81ww+M+7pG5985Q8
	wjdrkZXO1CW0PY+CshJxayA70ePkqzJq8xVkAYvP973iK/VnoJ2W68po/zjh5qrZzXKU
	Xb4Q==
X-Received: by 10.14.205.8 with SMTP id i8mr14696434eeo.19.1384799533988;
	Mon, 18 Nov 2013 10:32:13 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id k7sm929049eeg.13.2013.11.18.10.32.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 18 Nov 2013 10:32:13 -0800 (PST)
Date: Mon, 18 Nov 2013 19:32:13 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20131118183213.GI3727@jama>
References: <1384795036.6460.247.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1384795036.6460.247.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] git: Use merge-base instead of log for testing if a commit is present
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
X-List-Received-Date: Mon, 18 Nov 2013 18:32:12 -0000
X-Groupsio-MsgNum: 4116
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9faIjRurCDpBc7U"
Content-Disposition: inline

--+9faIjRurCDpBc7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2013 at 05:17:16PM +0000, Richard Purdie wrote:
> The current use of git log to check if a given revision is present can be
> a little fragile.
>=20
> For example if revision X was on branch A, and then later added to branch
> B, the update checks would not notice this since they just check for X
> being in the repository.
>=20
> We also had some autobuilder corruption where an older packed-refs file
> was copied over a new repository containing newer pack files. There
> was no update to the refs file since the revision was present but
> not accessible in any branch.
>=20
> The correct fix is to check that the required revisions are present
> on the specific branches. This patch does this using merge-base.

I guess that merge-base is probably faster or easier to use, but did you
consider using git branch --contains?

e.g. checking if selected branch is in
git branch --contains ud.revisions[name]

I'm asking only because I'm using "git branch --contains" in some
scripts and maybe there is good reason I should rewrite them to use git
merge-base instead.

Thanks

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 6175e4c..99230c1 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -150,7 +150,7 @@ class Git(FetchMethod):
>              return True
>          os.chdir(ud.clonedir)
>          for name in ud.names:
> -            if not self._contains_ref(ud.revisions[name], d):
> +            if not self._contains_ref(ud.revisions[name], ud.branches[na=
me], d):
>                  return True
>          if ud.write_tarballs and not os.path.exists(ud.fullmirror):
>              return True
> @@ -197,7 +197,7 @@ class Git(FetchMethod):
>          # Update the checkout if needed
>          needupdate =3D False
>          for name in ud.names:
> -            if not self._contains_ref(ud.revisions[name], d):
> +            if not self._contains_ref(ud.revisions[name], ud.branches[na=
me], d):
>                  needupdate =3D True
>          if needupdate:
>              try:=20
> @@ -281,13 +281,14 @@ class Git(FetchMethod):
>      def supports_srcrev(self):
>          return True
> =20
> -    def _contains_ref(self, tag, d):
> +    def _contains_ref(self, tag, branch, d):
>          basecmd =3D data.getVar("FETCHCMD_git", d, True) or "git"
> -        cmd =3D "%s log --pretty=3Doneline -n 1 %s -- 2> /dev/null | wc =
-l" % (basecmd, tag)
> -        output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> -        if len(output.split()) > 1:
> -            raise bb.fetch2.FetchError("The command '%s' gave output wit=
h more then 1 line unexpectedly, output: '%s'" % (cmd, output))
> -        return output.split()[0] !=3D "0"
> +        cmd =3D "%s merge-base --is-ancestorlog %s %s" % (basecmd, tag, =
branch)
> +        try:
> +            output =3D runfetchcmd(cmd, d, quiet=3DTrue)
> +        except bb.fetch2.FetchError:
> +            return False
> +        return True
> =20
>      def _revision_key(self, url, ud, d, name):
>          """
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--+9faIjRurCDpBc7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKKXS0ACgkQN1Ujt2V2gBw+FwCgkZZLgQr9vvUdUfPBZ58QlGJ1
k8kAoKl++d2z+0ioiSfOUfZgLCCfa1AR
=jmpe
-----END PGP SIGNATURE-----

--+9faIjRurCDpBc7U--
