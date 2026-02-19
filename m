Return-Path: <srbruno@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C113E9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 10:35:34 +0000 (UTC)
Subject: Re: [bitbake][lib/bb/fetch2/git.py] Re-introducing --prune option in fetch_cmd #bitbake
To: bitbake-devel@lists.openembedded.org
From: "Bruno Ferreira" <srbruno@gmail.com>
X-Originating-Location: Porto, PT (78.137.195.170)
X-Originating-Platform: Mac Firefox 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 19 Feb 2026 02:35:29 -0800
References: <K7wT.1770654725256025131.AKh3@lists.openembedded.org> <CANNYZj-pfZ79Uedy0-SNX5Go_gOWy0XpSQDgp7C1a8=kUAPdLw@mail.gmail.com> <660988.1770722998965341769@lists.openembedded.org> <CANNYZj-+b-mRistOxuaHFGgrLHG61ff-ZpARmfYOtr85zbNFqg@mail.gmail.com>
In-Reply-To: <CANNYZj-+b-mRistOxuaHFGgrLHG61ff-ZpARmfYOtr85zbNFqg@mail.gmail.com>
Message-ID: <991492.1771497329296933851@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="nNupDBUGQ5sjpyxwtt8r"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 10:35:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19066

--nNupDBUGQ5sjpyxwtt8r
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> I'd say you simply have to ask developers to namespace their branches
> properly and don't step on each other; once there is a branch named
> foo, one cannot anymore create a branch foo/bar, and vice versa.
>=20

The problem is not asking but more on the enforcing part specially when dev=
elopers
are able to use this workflow outside bitbake without any issues.

Another upstream branch creation flow that triggers the fetch issue that do=
esn't
involve to explicitly set the branch in the recipe (as the first example th=
at I provided):

* bitbake <recipe> -c do_fetch --no-setscene with branch "main" and SRCREV =
=3D aaa
* Created upstream branch "foo"
* bitbake <recipe> -c do_fetch --no-setscene with branch "main" and SRCREV =
=3D bbb (to double confirm that it fetch all the references upstream)
* Deleted upstream branch "foo"
* Created upstream branch "foo/bar"
* bitbake <recipe> -c do_fetch --no-setscene with branch "main" and SRCREV =
=3D ccc (to double confirm that it fetch all the references upstream)
* Fetch failed with error: cannot lock ref 'refs/heads/foo/bar': 'refs/head=
s/foo' exists; cannot create 'refs/heads/foo/bar'

A developer can create a upstream temporary branch and trigger this even if=
 they are not aware of the issue.

--nNupDBUGQ5sjpyxwtt8r
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote>
<div>I'd say you simply have to ask developers to namespace their branches<=
br />properly and don't step on each other; once there is a branch named<br=
 />foo, one cannot anymore create a branch foo/bar, and vice versa.</div>
</blockquote>
<div>The problem is not asking but more on the enforcing part specially whe=
n developers</div>
<div>are able to use this workflow outside bitbake without any issues.</div=
>
<div>&nbsp;</div>
<div>Another upstream branch creation flow that triggers the fetch issue th=
at doesn't</div>
<div>involve to explicitly set the branch in the recipe (as the first examp=
le that I provided):</div>
<div>&nbsp;</div>
<div>
<ul>
<li>bitbake &lt;recipe&gt; -c do_fetch --no-setscene with branch "main" and=
 SRCREV =3D aaa</li>
<li>Created upstream branch "foo"</li>
<li>bitbake &lt;recipe&gt; -c do_fetch --no-setscene with branch "main" and=
 SRCREV =3D bbb (to double confirm that it fetch all the references upstrea=
m)</li>
<li>Deleted upstream branch "foo"</li>
<li>Created upstream branch "foo/bar"</li>
<li>bitbake &lt;recipe&gt; -c do_fetch --no-setscene with branch "main" and=
 SRCREV =3D ccc (to double confirm that it fetch all the references upstrea=
m)</li>
<li>Fetch failed with error: cannot lock ref 'refs/heads/foo/bar': 'refs/he=
ads/foo' exists; cannot create 'refs/heads/foo/bar'</li>
</ul>
<div>&nbsp;</div>
<div>A developer can create a upstream temporary branch and trigger this ev=
en if they are not aware of the issue.</div>
</div>
<div>&nbsp;</div>

--nNupDBUGQ5sjpyxwtt8r--

