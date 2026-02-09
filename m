Return-Path: <srbruno@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F661E7E0BC
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 16:32:10 +0000 (UTC)
Subject: [bitbake][lib/bb/fetch2/git.py] Re-introducing --prune option in fetch_cmd #bitbake
To: bitbake-devel@lists.openembedded.org
From: "Bruno Ferreira" <srbruno@gmail.com>
X-Originating-Location: Porto, PT (213.205.68.220)
X-Originating-Platform: Mac Firefox 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 09 Feb 2026 08:32:05 -0800
Message-ID: <K7wT.1770654725256025131.AKh3@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="uyMd3JKcO6aMpbJFpv19"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 16:32:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18992

--uyMd3JKcO6aMpbJFpv19
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

In my current project we have several repositories where developers use git=
 branch references in the format:

>=20
> /remotes/origin/foo
> /remotes/origin/foo/bar
>=20

And sometimes parent references, e.g: "/remotes/origin/foo" get deleted fro=
m the upstream repository leading to git fetch issues.

>=20
> error: cannot lock ref 'refs/heads/foo/bar': 'refs/heads/foo' exists;
> cannot create 'refs/heads/foo/bar'
>=20

Typically, the way git handles these cases is by adding the *--prune* optio=
n to delete the stale references from the local references and fetching wou=
ld work.

While investigating what bitbake currently does during fetching for git rep=
ositories I've found the current fetch command ( https://git.yoctoproject.o=
rg/poky/tree/bitbake/lib/bb/fetch2/git.py?h=3Dscarthgap#n459 ) in the past =
had the --prune option ( https://git.yoctoproject.org/poky/commit/?id=3D619=
31d14df3be5273a38008ae2dff2a60a7d9b02 )
but it was removed due to breaking old releases.

My first question is, is it ok to bring back the *--prune* option to *fetch=
_cmd* or this will still be an issue and it will brake old releases?

Second question, if introducing *--prune* again is not an option, what woul=
d be the recommend approach to introduce this setting via a configuration o=
ption on git.py lib?

Thank you,
B.

--uyMd3JKcO6aMpbJFpv19
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div><span data-teams=3D"true">In my current project we have several reposi=
tories where developers use git branch references in the format:</span></di=
v>
<div>&nbsp;</div>
<blockquote>
<div><span data-teams=3D"true"><span data-teams=3D"true">/remotes/origin/fo=
o<br />/remotes/origin/foo/bar</span></span></div>
</blockquote>
<div>&nbsp;</div>
<div><span data-teams=3D"true">And sometimes parent references, e.g: "/remo=
tes/origin/foo" get deleted from the upstream repository leading to git fet=
ch issues.</span></div>
<div>&nbsp;</div>
<blockquote>
<div><span data-teams=3D"true"><span data-teams=3D"true">error: cannot lock=
 ref 'refs/heads/foo/bar': 'refs/heads/foo' exists; cannot create 'refs/hea=
ds/foo/bar'</span></span></div>
</blockquote>
<div>&nbsp;</div>
<div><span data-teams=3D"true">Typically, the way git handles these cases i=
s by adding the <strong>--prune</strong> option to delete the stale referen=
ces from the local references and fetching would work.</span></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true"><span data-teams=3D"true">While investigatin=
g what bitbake currently does during fetching for git repositories I've fou=
nd the current <a href=3D"https://git.yoctoproject.org/poky/tree/bitbake/li=
b/bb/fetch2/git.py?h=3Dscarthgap#n459" target=3D"_blank" rel=3D"noopener">f=
etch command</a> in<span data-teams=3D"true">&nbsp;the past had the <a href=
=3D"https://git.yoctoproject.org/poky/commit/?id=3D61931d14df3be5273a38008a=
e2dff2a60a7d9b02" target=3D"_blank" rel=3D"noopener">--prune option</a></sp=
an></span></span></div>
<div><span data-teams=3D"true"><span data-teams=3D"true"><span data-teams=
=3D"true">but it was removed due to breaking old releases.</span></span></s=
pan></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true"><span data-teams=3D"true"><span data-teams=
=3D"true"><span data-teams=3D"true"><span data-teams=3D"true"><span data-te=
ams=3D"true">My first question is, is it ok to bring back the <strong>--pru=
ne</strong> option to <strong>fetch_cmd</strong> or this will still be an i=
ssue and it will brake old releases?</span></span></span></span></span></sp=
an></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true"><span data-teams=3D"true"><span data-teams=
=3D"true"><span data-teams=3D"true">Second question, if introducing <strong=
>--prune</strong> again is not an option, what would be the recommend appro=
ach to introduce this setting via a configuration option on git.py lib?</sp=
an></span></span></span></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true"><span data-teams=3D"true"><span data-teams=
=3D"true"><span data-teams=3D"true">Thank you,</span></span></span></span><=
/div>
<div><span data-teams=3D"true"><span data-teams=3D"true"><span data-teams=
=3D"true"><span data-teams=3D"true">B.</span></span></span></span></div>

--uyMd3JKcO6aMpbJFpv19--

