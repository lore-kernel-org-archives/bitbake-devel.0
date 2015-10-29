Return-Path: <rehsack@gmail.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id D76EC75A38
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Oct 2015 13:00:52 +0000 (UTC)
Received: by wmff134 with SMTP id f134so23940489wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Oct 2015 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=content-type:mime-version:subject:from:in-reply-to:date
	:content-transfer-encoding:message-id:references:to;
	bh=yG277jZ8PXo+lTTaPTJuHll8u4iGDguo/UAVzkBhw6E=;
	b=oKiSnpmb2bybreOlNNMLjaNVsjeFk0SHEroWU8RufOu209rLBxhgdg3ldesXpmo2No
	0rlr6eWJlxFU27XZr01MA9Ej3lhj0lX+YpU7o+A35MS0zmtMdjIz8NNn/OoADqig+z7H
	0mnGBPwYbPbjX/hKbrdQgJgooWtd1NoLr3zDwHXBqto0gNFYPwuAxIMqBt30fwGMVjNY
	H7sIiCFsKmSx8wL5e2P+PFv5parpiYZWPoFsYnCeP2rl9pH9Tb6rQZX1BFFB5pdSMeOY
	oYmjv1fbrmSXSe5BreNQuInwiuB5uxqBR1spTU27Va7Y7uV5d7oq603uKRhRpptf3tBN
	rE6w==
X-Received: by 10.28.5.208 with SMTP id 199mr3582107wmf.40.1446123652037;
	Thu, 29 Oct 2015 06:00:52 -0700 (PDT)
Received: from ernie.muppets.liwing.de (p578b540c.dip0.t-ipconnect.de.
	[87.139.84.12])
	by smtp.gmail.com with ESMTPSA id v9sm1682021wjv.45.2015.10.29.06.00.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 29 Oct 2015 06:00:51 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
From: Jens Rehsack <rehsack@gmail.com>
In-Reply-To: <2BE45156-5280-4DFC-9773-F761B9F4B48B@gmail.com>
Date: Thu, 29 Oct 2015 14:00:50 +0100
Message-Id: <1E04A439-8ACF-42D3-A910-086C750001E2@gmail.com>
References: <2BE45156-5280-4DFC-9773-F761B9F4B48B@gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.2104)
Subject: Re: [PATCH] fetcher: svn: Add support for checkout to a custom path
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
X-List-Received-Date: Thu, 29 Oct 2015 13:00:53 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 16.10.2015 um 19:14 schrieb Jens Rehsack <rehsack@gmail.com>:
>=20
>=20
> Add support for the Subversion fetcher to checkout modules to a custom =
path
> than the module name to avoid checkout is always module - svn is path
> based and tag/branch-checkout might break builds because of invaid =
path specs.
>=20
> Signed-off-by: Jens Rehsack <sno@netbsd.org>
> ---
> bitbake/lib/bb/fetch2/svn.py | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/svn.py =
b/bitbake/lib/bb/fetch2/svn.py
> index 1733c2b..8a29193 100644
> --- a/bitbake/lib/bb/fetch2/svn.py
> +++ b/bitbake/lib/bb/fetch2/svn.py
> @@ -54,6 +54,11 @@ class Svn(FetchMethod):
>=20
>         ud.module =3D ud.parm["module"]
>=20
> +        if not "path_spec" in ud.parm:
> +            ud.path_spec =3D ud.module
> +        else:
> +            ud.path_spec =3D ud.parm["path_spec"]
> +
>         # Create paths to svn checkouts
>         relpath =3D self._strip_leading_slashes(ud.path)
>         ud.pkgdir =3D os.path.join(data.expand('${SVNDIR}', d), =
ud.host, relpath)
> @@ -102,7 +107,7 @@ class Svn(FetchMethod):
>=20
>             if command =3D=3D "fetch":
>                 transportuser =3D ud.parm.get("transportuser", "")
> -                svncmd =3D "%s co %s %s://%s%s/%s%s %s" % =
(ud.basecmd, " ".join(options), proto, transportuser, svnroot, =
ud.module, suffix, ud.module)
> +                svncmd =3D "%s co %s %s://%s%s/%s%s %s" % =
(ud.basecmd, " ".join(options), proto, transportuser, svnroot, =
ud.module, suffix, ud.path_spec)
>             elif command =3D=3D "update":
>                 svncmd =3D "%s update %s" % (ud.basecmd, " =
".join(options))
>             else:
> @@ -149,7 +154,7 @@ class Svn(FetchMethod):
>=20
>         os.chdir(ud.pkgdir)
>         # tar them up to a defined filename
> -        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, =
ud.module), d, cleanup =3D [ud.localpath])
> +        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, =
ud.path_spec), d, cleanup =3D [ud.localpath])
>=20
>     def clean(self, ud, d):
>         """ Clean SVN specific files and dirs """
> --=20
> 2.4.3

Ping :)

--=20
Jens Rehsack - rehsack@gmail.com


