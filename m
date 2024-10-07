Return-Path: <git@oliver-kaestner.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8200FCED241
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 21:44:09 +0000 (UTC)
Subject: Re: [PATCH] fetch2: add GitHub Codespaces support
To: bitbake-devel@lists.openembedded.org
From: =?UTF-8?B?T2xpdmVyIEvDpHN0bmVy?= <git@oliver-kaestner.de>
X-Originating-Location: Lingen, Lower Saxony, DE (93.231.84.53)
X-Originating-Platform: ChromeOS Chrome 130
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 14:44:02 -0700
References: <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
In-Reply-To: <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
Message-ID: <17710.1728337442729823697@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="SFv242RrRaNbHOHzIjiC"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Oct 2024 21:44:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16650

--SFv242RrRaNbHOHzIjiC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:24 PM, Alexander Kanavin wrote:

>=20
> On Mon, 7 Oct 2024 at 00:27, Oliver K=C3=A4stner via lists.openembedded.o=
rg
> <git=3Doliver-kaestner.de@lists.openembedded.org> wrote:
>=20
>> GitHub Codespaces use a Git credential helper that provides access to
>> authorized private GitHub repos. To do this, it requires access to the
>> `GITHUB_TOKEN` env var, so add it to FETCH_EXPORT_VARS.
>=20
> Which fetcher would be using this environment variable? Presumably it
> would be picked up by some external executable run by one of the
> fetchers, which one is that?
>=20
> Alex

You're right, it's the git fetcher calling the host system's git executable=
, which uses the configured `credential.helper=3D/.codespaces/bin/gitcreden=
tial_github.sh`. This script only contains:

#!/bin/sh
echo protocol=3Dhttps
echo host=3Dgithub.com
echo path=3D
echo username=3DPersonalAccessToken
echo password=3D$GITHUB_TOKEN

That's why we need to retain the GITHUB_TOKEN env var.

Oliver

--SFv242RrRaNbHOHzIjiC
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Oct 7, 2024 at 12:24 PM, Alexander Kanavin wrote:</div>
<div>
<blockquote>On Mon, 7 Oct 2024 at 00:27, Oliver K&auml;stner via lists.open=
embedded.org<br />&lt;git=3Doliver-kaestner.de@lists.openembedded.org&gt; w=
rote:<br />
<blockquote>GitHub Codespaces use a Git credential helper that provides acc=
ess to<br />authorized private GitHub repos. To do this, it requires access=
 to the<br />`GITHUB_TOKEN` env var, so add it to FETCH_EXPORT_VARS.</block=
quote>
Which fetcher would be using this environment variable? Presumably it<br />=
would be picked up by some external executable run by one of the<br />fetch=
ers, which one is that?<br /><br />Alex</blockquote>
You're right, it's the git fetcher calling the host system's git executable=
, which uses the configured `credential.helper=3D/.codespaces/bin/gitcreden=
tial_github.sh`. This script only contains:</div>
<div>&nbsp;</div>
<div>#!/bin/sh<br />echo protocol=3Dhttps<br />echo host=3Dgithub.com<br />=
echo path=3D<br />echo username=3DPersonalAccessToken<br />echo password=3D=
$GITHUB_TOKEN</div>
<div>&nbsp;</div>
<div>That's why we need to retain the GITHUB_TOKEN env var.</div>
<div>&nbsp;</div>
<div>Oliver</div>

--SFv242RrRaNbHOHzIjiC--

