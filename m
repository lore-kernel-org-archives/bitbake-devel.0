Return-Path: <marciohenriques84@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37771CD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 16:14:12 +0000 (UTC)
Subject: Re: [PATCH 1/1] bitbake: add BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
To: bitbake-devel@lists.openembedded.org
From: "Marcio Henriques" <marciohenriques84@gmail.com>
X-Originating-Location: Porto, PT (213.205.68.220)
X-Originating-Platform: Windows Edge 148
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 11 May 2026 09:14:02 -0700
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com> <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com> <b49490a4a2e1cbbbdd8eb84d3c5bb2af57418488.camel@linuxfoundation.org> <1413912.1777968532263348828@lists.openembedded.org> <7ac8312de40809f14006bfff65143f002543c50b.camel@linuxfoundation.org>
In-Reply-To: <7ac8312de40809f14006bfff65143f002543c50b.camel@linuxfoundation.org>
Message-ID: <1495889.1778516042086994585@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="4OdLrW1IyWgh6koNJrYO"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 16:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19495

--4OdLrW1IyWgh6koNJrYO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 10:41 AM, Richard Purdie wrote:

>=20
> FWIW the git fetcher is specifically coded to avoid removing
> references. It shouldn't remove old revisions or obsolete heads (e.g.
> for repos that changed master -> main). If it is doing that, that is
> something we should fix.

This is also about dealing with force pushes that may remove something that
was previously merged and is no longer available in DL_DIR/git2 or upstream=
.

>=20
> I can see why you might decide to do that but it will be a pretty
> inefficient use of space with an archive for every revision and means
> turning everything into shallow clones, which has its own challenges.

It can actually also be more efficient as the git fetcher fetches all branc=
hes and this may
require more space than just archiving the source code for the revisions=C2=
=A0used in the build.

--4OdLrW1IyWgh6koNJrYO
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, May 5, 2026 at 10:41 AM, Richard Purdie wrote:</div>
<div>
<blockquote>FWIW the git fetcher is specifically coded to avoid removing<br=
 />references. It shouldn't remove old revisions or obsolete heads (e.g.<br=
 />for repos that changed master -&gt; main). If it is doing that, that is<=
br />something we should fix.</blockquote>
</div>
<div>This is also about dealing with force pushes that may remove something=
 that</div>
<div>was previously merged and is no longer available in DL_DIR/git2 or ups=
tream.</div>
<div>
<blockquote>I can see why you might decide to do that but it will be a pret=
ty<br />inefficient use of space with an archive for every revision and mea=
ns<br />turning everything into shallow clones, which has its own challenge=
s.</blockquote>
<!-- obsidian -->
<div>It can actually also be more efficient as the git fetcher fetches all =
branches and this may</div>
<div>require more space than just archiving the source code for the revisio=
ns&nbsp;used in the build.</div>
</div>

--4OdLrW1IyWgh6koNJrYO--

