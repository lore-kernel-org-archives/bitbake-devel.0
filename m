Return-Path: <srbruno@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8AE9462E
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 11:30:04 +0000 (UTC)
Subject: Re: [bitbake][lib/bb/fetch2/git.py] Re-introducing --prune option in fetch_cmd #bitbake
To: bitbake-devel@lists.openembedded.org
From: "Bruno Ferreira" <srbruno@gmail.com>
X-Originating-Location: Porto, PT (78.137.195.170)
X-Originating-Platform: Mac Firefox 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 03:29:58 -0800
References: <K7wT.1770654725256025131.AKh3@lists.openembedded.org> <CANNYZj-pfZ79Uedy0-SNX5Go_gOWy0XpSQDgp7C1a8=kUAPdLw@mail.gmail.com>
In-Reply-To: <CANNYZj-pfZ79Uedy0-SNX5Go_gOWy0XpSQDgp7C1a8=kUAPdLw@mail.gmail.com>
Message-ID: <660988.1770722998965341769@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Wrwxa8R4zoYw2gIj9Ami"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 11:30:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18997

--Wrwxa8R4zoYw2gIj9Ami
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> New fetcher configuration options aren't particularly welcome, as they
> need documentation, tests, and create alternative code paths and
> complexity.
>=20

That confirms my initial expectations, thanks for clarifying it.

>=20
> Perhaps it would help if you show the sequence of steps that leads to
> breakage, as it's hard to tell from just the description above what
> the problem is exactly.
>=20
>=20

Sure. So first of all this is a git "problem" not a bitbake fetcher git.py =
lib "problem".

A developer created an upstream branch named "foo" with code changes
and changed a recipe SRC_URI to use the following:

SRC_URI =3D git://github.com/org/random-repo.git;protocol=3Dhttps;branch=3D=
foo

do_fetch task was able to fetch everything properly during recipe build, st=
oring it in DL_DIR as expected.

Second developer created the upstream branch "foo/bar" with code changes.
Meanwhile the first developer deleted the branch "foo" upstream.

The second developer updated the recipe to use the new branch:

SRC_URI =3D git://github.com/org/random-repo.git;protocol=3Dhttps;branch=3D=
foo/bar

During do_fetch, git is not able to fetch the "foo/bar" branch as the paren=
t reference "foo"
no longer exists in the upstream repo (only exists on local) triggering the=
 error visible in the log.do_fetch

>=20
> error: cannot lock ref 'refs/heads/foo/bar': 'refs/heads/foo' exists;
> cannot create 'refs/heads/foo/bar'
> From https://github.com/org/random-repo
> ! [new branch] =C2=A0 =C2=A0 =C2=A0foo/bar -> foo/bar =C2=A0(unable to up=
date local ref)
>=20

If I add back the --prune option that was removed here ( https://git.yoctop=
roject.org/poky/commit/?id=3D61931d14df3be5273a38008ae2dff2a60a7d9b02 ) , "=
git fetch" will work with the following message
will appear in log.do_fetch

>=20
> From https://github.com/org/random-repo
> - [deleted] =C2=A0 =C2=A0 =C2=A0 =C2=A0 (none) =C2=A0 =C2=A0 -> foo
> * [new branch] =C2=A0 =C2=A0 =C2=A0foo/bar -> foo/bar
>

--Wrwxa8R4zoYw2gIj9Ami
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote>
<div>New fetcher configuration options aren't particularly welcome, as they=
<br />need documentation, tests, and create alternative code paths and<br /=
>complexity.</div>
</blockquote>
<div>&nbsp;</div>
<div>That confirms my initial expectations, thanks for clarifying it.</div>
<div>&nbsp;</div>
<blockquote>
<div>Perhaps it would help if you show the sequence of steps that leads to<=
br />breakage, as it's hard to tell from just the description above what<br=
 />the problem is exactly.</div>
<div>&nbsp;</div>
</blockquote>
<div>&nbsp;</div>
<div>
<div>Sure. So first of all this is a git "problem" not a bitbake fetcher gi=
t.py lib "problem".</div>
<div>&nbsp;</div>
<div>A developer created an upstream branch named "foo" with code changes<b=
r />and changed a recipe SRC_URI to use the following:</div>
<div>&nbsp;</div>
<div>SRC_URI =3D <a href=3D"git://github.com/org/random-repo.git;protocol=
=3Dhttps;branch=3Dfoo" target=3D"_blank" rel=3D"noopener">git://github.com/=
org/random-repo.git;protocol=3Dhttps;branch=3Dfoo</a></div>
<div>&nbsp;</div>
<div>do_fetch task was able to fetch everything properly during recipe buil=
d, storing it in DL_DIR as expected.</div>
<div>&nbsp;</div>
<div>
<div>Second developer created the upstream branch "foo/bar" with code chang=
es.<br />Meanwhile the first developer deleted the branch "foo" upstream.</=
div>
<div>&nbsp;</div>
<div>The second developer updated the recipe to use the new branch:</div>
<div><br />SRC_URI =3D <a href=3D"git://github.com/org/random-repo.git;prot=
ocol=3Dhttps;branch=3Dfoo/bar" target=3D"_blank" rel=3D"noopener">git://git=
hub.com/org/random-repo.git;protocol=3Dhttps;branch=3Dfoo/bar</a></div>
<div>&nbsp;</div>
<div>During do_fetch, git is not able to fetch the "foo/bar" branch as the =
parent reference "foo"<br />no longer exists in the upstream repo (only exi=
sts on local) triggering the error visible in the log.do_fetch</div>
<div>&nbsp;</div>
<blockquote>
<div>error: cannot lock ref 'refs/heads/foo/bar': 'refs/heads/foo' exists; =
cannot create 'refs/heads/foo/bar'<br />From https://github.com/org/random-=
repo<br />! [new branch] &nbsp; &nbsp; &nbsp;foo/bar -&gt; foo/bar &nbsp;(u=
nable to update local ref)</div>
</blockquote>
<div><br />If I add back the --prune option that was removed <a href=3D"htt=
ps://git.yoctoproject.org/poky/commit/?id=3D61931d14df3be5273a38008ae2dff2a=
60a7d9b02" target=3D"_blank" rel=3D"noopener">here</a>, "git fetch" will wo=
rk with the following message<br />will appear in log.do_fetch</div>
<blockquote>
<div>From https://github.com/org/random-repo<br />- [deleted] &nbsp; &nbsp;=
 &nbsp; &nbsp; (none) &nbsp; &nbsp; -&gt; foo<br />* [new branch] &nbsp; &n=
bsp; &nbsp;foo/bar -&gt; foo/bar</div>
</blockquote>
</div>
</div>

--Wrwxa8R4zoYw2gIj9Ami--

