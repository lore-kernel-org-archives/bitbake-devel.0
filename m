Return-Path: <marciohenriques84@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ABFF885A
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 08:09:00 +0000 (UTC)
Subject: Re: [PATCH 1/1] bitbake: add BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
To: bitbake-devel@lists.openembedded.org
From: "Marcio Henriques" <marciohenriques84@gmail.com>
X-Originating-Location: Porto, PT (213.205.68.220)
X-Originating-Platform: Windows Edge 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 05 May 2026 01:08:52 -0700
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com> <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com> <b49490a4a2e1cbbbdd8eb84d3c5bb2af57418488.camel@linuxfoundation.org>
In-Reply-To: <b49490a4a2e1cbbbdd8eb84d3c5bb2af57418488.camel@linuxfoundation.org>
Message-ID: <1413912.1777968532263348828@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="a4Nr60A05W1XTv9dpAc3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 08:09:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19433

--a4Nr60A05W1XTv9dpAc3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We want to create a download mirror to store all sources needed to build a
specific project.

The idea is to use Git shallow tarballs because each tarball has a unique n=
ame.
This prevents files from being overwritten in the mirror. With full Git
tarballs, the name is always the same, so the mirror file gets replaced eac=
h
time. If something is removed from the upstream repository, we might upload=
 a
new tarball that no longer contains a reference used by a recipe that was
already integrated.

With shallow tarballs, we can safely clean DL_DIR since it's not the source=
 of
truth. If something is removed from upstream, we fall back to the mirror an=
d
use the shallow tarball.

For most of the builds, we want to use the bare clone in DL_DIR/git2 and ju=
st
update the repo when bumping a SRCREV. The DL_DIR/git2 repositories are
available on the machine that triggers the build.

The shallow tarball is a fallback for cases where something was removed fro=
m
the repository (for example, after a force push) and is not present in
DL_DIR/git2 or upstream, but was merged at some point. This is why we use G=
it
shallow and set shallow_skip_fast to True.

Best regards,
Marcio

--a4Nr60A05W1XTv9dpAc3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hello,</div>
<div>&nbsp;</div>
<div>We want to create a download mirror to store all sources needed to bui=
ld a &nbsp;<br />specific project.</div>
<div>&nbsp;</div>
<div>The idea is to use Git shallow tarballs because each tarball has a uni=
que name. &nbsp;<br />This prevents files from being overwritten in the mir=
ror. With full Git &nbsp;<br />tarballs, the name is always the same, so th=
e mirror file gets replaced each &nbsp;<br />time. If something is removed =
from the upstream repository, we might upload a &nbsp;<br />new tarball tha=
t no longer contains a reference used by a recipe that was &nbsp;<br />alre=
ady integrated.</div>
<div>&nbsp;</div>
<div>With shallow tarballs, we can safely clean DL_DIR since it's not the s=
ource of &nbsp;<br />truth. If something is removed from upstream, we fall =
back to the mirror and &nbsp;<br />use the shallow tarball.</div>
<div>&nbsp;</div>
<div>For most of the builds, we want to use the bare clone in DL_DIR/git2 a=
nd just &nbsp;<br />update the repo when bumping a SRCREV. The DL_DIR/git2 =
repositories are &nbsp;<br />available on the machine that triggers the bui=
ld.</div>
<div>&nbsp;</div>
<div>The shallow tarball is a fallback for cases where something was remove=
d from &nbsp;<br />the repository (for example, after a force push) and is =
not present in &nbsp;<br />DL_DIR/git2 or upstream, but was merged at some =
point. This is why we use Git &nbsp;<br />shallow and set shallow_skip_fast=
 to True.<br /><br />Best regards,<br />Marcio</div>
</div>

--a4Nr60A05W1XTv9dpAc3--

