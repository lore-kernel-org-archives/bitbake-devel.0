Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F2FFC6175
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 20:13:22 +0000 (UTC)
Subject: Re: [PATCH] fetch2/gomod: Support URIs with only a hostname
To: bitbake-devel@lists.openembedded.org
From: "Christian Lindeberg" <christian.lindeberg@axis.com>
X-Originating-Location: US (165.85.67.170)
X-Originating-Platform: Linux Chrome 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 13:13:21 -0700
References: <20240912210614.1042592-1-pkj@axis.com>
In-Reply-To: <20240912210614.1042592-1-pkj@axis.com>
Message-ID: <18338.1726258401264909056@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="f3H54oSP1feR3mf4Ao2S"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Sep 2024 20:13:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16560

--f3H54oSP1feR3mf4Ao2S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:06 PM, Peter Kjellerstedt wrote:

>=20
> When calculating the module name for a gomod URI with only a hostname,
> e.g.:
>=20
> gomod://go.opencensus.io;version=3Dv0.24.0;sha256sum=3D203a767d7f8e7c1ebe=
5588220ad168d1e15b14ae70a636de7ca9a4a88a7e0d0c
>=20
>=20
> the non-existing path would actually be treated as "/", which resulted
> in a trailing slash being added to the module name preventing the unpack
> method from correctly locating the go.mod file.

Good catch. I hadn't come across a module path only consisting of the host =
part before. The crucible recipe was a good exercise.

Thanks,
Christian

>=20
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
> bitbake/lib/bb/fetch2/gomod.py | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/gomod.py
> b/bitbake/lib/bb/fetch2/gomod.py
> index 1b532d03ff..21fbe80f56 100644
> --- a/bitbake/lib/bb/fetch2/gomod.py
> +++ b/bitbake/lib/bb/fetch2/gomod.py
> @@ -103,7 +103,9 @@ class GoMod(Wget):
> if 'version' not in ud.parm:
> raise MissingParameterError('version', ud.url)
>=20
> - module =3D ud.host + ud.path
> + module =3D ud.host
> + if ud.path !=3D '/':
> + module +=3D ud.path
> ud.parm['module'] =3D module
>=20
> # Set URL and filename for wget download
> @@ -174,7 +176,9 @@ class GoModGit(Git):
> if 'version' not in ud.parm:
> raise MissingParameterError('version', ud.url)
>=20
> - module =3D ud.host + ud.path
> + module =3D ud.host
> + if ud.path !=3D '/':
> + module +=3D ud.path
> ud.parm['module'] =3D module
>=20
> # Set host, path and srcrev for git download

--f3H54oSP1feR3mf4Ao2S
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Thu, Sep 12, 2024 at 11:06 PM, Peter Kjellerstedt wrote:</div>
<div>
<blockquote>When calculating the module name for a gomod URI with only a ho=
stname,<br />e.g.:<br /><br />gomod://go.opencensus.io;version=3Dv0.24.0;sh=
a256sum=3D203a767d7f8e7c1ebe5588220ad168d1e15b14ae70a636de7ca9a4a88a7e0d0c<=
br /><br />the non-existing path would actually be treated as "/", which re=
sulted<br />in a trailing slash being added to the module name preventing t=
he unpack<br />method from correctly locating the go.mod file.</blockquote>
Good catch. I hadn't come across a module path only consisting of the host =
part before. The crucible recipe was a good exercise.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Christian</div>
<div><br />
<blockquote><br />Signed-off-by: Peter Kjellerstedt &lt;peter.kjellerstedt@=
axis.com&gt;<br />---<br />bitbake/lib/bb/fetch2/gomod.py | 8 ++++++--<br /=
>1 file changed, 6 insertions(+), 2 deletions(-)<br /><br />diff --git a/bi=
tbake/lib/bb/fetch2/gomod.py b/bitbake/lib/bb/fetch2/gomod.py<br />index 1b=
532d03ff..21fbe80f56 100644<br />--- a/bitbake/lib/bb/fetch2/gomod.py<br />=
+++ b/bitbake/lib/bb/fetch2/gomod.py<br />@@ -103,7 +103,9 @@ class GoMod(W=
get):<br />if 'version' not in ud.parm:<br />raise MissingParameterError('v=
ersion', ud.url)<br /><br />- module =3D ud.host + ud.path<br />+ module =
=3D ud.host<br />+ if ud.path !=3D '/':<br />+ module +=3D ud.path<br />ud.=
parm['module'] =3D module<br /><br /># Set URL and filename for wget downlo=
ad<br />@@ -174,7 +176,9 @@ class GoModGit(Git):<br />if 'version' not in u=
d.parm:<br />raise MissingParameterError('version', ud.url)<br /><br />- mo=
dule =3D ud.host + ud.path<br />+ module =3D ud.host<br />+ if ud.path !=3D=
 '/':<br />+ module +=3D ud.path<br />ud.parm['module'] =3D module<br /><br=
 /># Set host, path and srcrev for git download</blockquote>
</div>

--f3H54oSP1feR3mf4Ao2S--

