Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7219C624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 12:43:06 +0000 (UTC)
Subject: Re: [RFC PATCH] fetch: `touch` mirror tarball stamp files on download
To: bitbake-devel@lists.openembedded.org
From: "Philip Lorenz" <philip.lorenz@bmw.de>
X-Originating-Location: Augsburg, Bavaria, DE (212.118.206.70)
X-Originating-Platform: Mac Firefox 154
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 02 Sep 2026 05:43:05 -0700
References: <20260902083232.825826-1-philip.lorenz@bmw.de> <ad4a8405a86e9c243dd2748a82f3cb0535f02b8a.camel@linuxfoundation.org>
In-Reply-To: <ad4a8405a86e9c243dd2748a82f3cb0535f02b8a.camel@linuxfoundation.org>
Message-ID: <2527846.1788352985580782981@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="pL0qWRtUYQgTlgiP9Oly"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 12:43:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20156

--pL0qWRtUYQgTlgiP9Oly
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, Sep 2, 2026 at 11:06 AM, Richard Purdie wrote:

>=20
> On Wed, 2026-09-02 at 10:32 +0200, Philip Lorenz via
> lists.openembedded.org wrote:
>=20
>> The mirror tarball stamp file's mtime is currently only updated on
>> creation / initial download. This makes it difficult to detect whether a
>> mirror tarball is still relevant in a given build.
>>=20
>> Improve this by also `touch`ing the mirror tarball stamp files alongside
>> the sources primary stamp file.
>=20
> This gets a bit tricky as we don't touch every download file at every
> download, we only touch the end stamp file.
>=20
> This would mean we touch mirror files and stamp files but not main
> download files and I think brings things into more disparity?

This patch extends bitbake to touch the mirror tarball's `.done` file (not =
the mirror tarball itself) to bring it inline with regular stamp file handl=
ing.
>=20
>=20
> I can also think of cases where updating the timestamp may cause things
> to re-download the tarballs too since you can't know the content in
> advance with many of them. This is perhaps the stronger reason not to
> do this.

I'm not completely familiar with all of the fetcher details (and also could=
n't find anything obvious) but in which cases would changing the mtime lead=
 to a redownload? I'm not sure if this is still an issue given that this on=
ly updates the `.done` files of the mirror tarballs though.

The rationale behind this change is that we'd like to clean up our download=
 caches and only keep the inputs relevant to the latest build configuration=
 around. Using `.done` files (after executing a `bitbake --runall=3Dfetch`)=
 works for this as long as the mirror tarballs are freshly created. On cons=
ecutive runs their `.done` file is not touched and they are therefore deeme=
d out of date.

Philip

--pL0qWRtUYQgTlgiP9Oly
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Richard,</div>
<div>&nbsp;</div>
<div>On Wed, Sep 2, 2026 at 11:06 AM, Richard Purdie wrote:</div>
<div>
<blockquote>On Wed, 2026-09-02 at 10:32 +0200, Philip Lorenz via lists.open=
embedded.org wrote:<br />
<blockquote>The mirror tarball stamp file's mtime is currently only updated=
 on<br />creation / initial download. This makes it difficult to detect whe=
ther a<br />mirror tarball is still relevant in a given build.<br /><br />I=
mprove this by also `touch`ing the mirror tarball stamp files alongside<br =
/>the sources primary stamp file.</blockquote>
This gets a bit tricky as we don't touch every download file at every<br />=
download, we only touch the end stamp file.<br /><br />This would mean we t=
ouch mirror files and stamp files but not main<br />download files and I th=
ink brings things into more disparity?</blockquote>
</div>
<div>This patch extends bitbake to touch the mirror tarball's `.done` file =
(not the mirror tarball itself) to bring it inline with regular stamp file =
handling.
<blockquote>I can also think of cases where updating the timestamp may caus=
e things<br />to re-download the tarballs too since you can't know the cont=
ent in<br />advance with many of them. This is perhaps the stronger reason =
not to<br />do this.</blockquote>
I'm not completely familiar with all of the fetcher details (and also could=
n't find anything obvious) but in which cases would changing the mtime lead=
 to a redownload? I'm not sure if this is still an issue given that this on=
ly updates the `.done` files of the mirror tarballs though.</div>
<div>&nbsp;</div>
<div>The rationale behind this change is that we'd like to clean up our dow=
nload caches and only keep the inputs relevant to the latest build configur=
ation around. Using `.done` files (after executing a `bitbake --runall=3Dfe=
tch`) works for this as long as the mirror tarballs are freshly created. On=
 consecutive runs their `.done` file is not touched and they are therefore =
deemed out of date.</div>
<div>&nbsp;</div>
<div>Philip</div>

--pL0qWRtUYQgTlgiP9Oly--

