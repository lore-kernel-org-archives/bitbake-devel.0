Return-Path: <pedro.ms.ferreira@ctw.bmwgroup.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB39F8A15A
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 10:35:42 +0000 (UTC)
Subject: Re: [PATCH v2] fetch2: avoid reuse download filenames
To: bitbake-devel@lists.openembedded.org
From: pedro.ms.ferreira@ctw.bmwgroup.com
X-Originating-Location: Porto, PT (213.205.68.221)
X-Originating-Platform: Linux Chrome 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 16 Apr 2026 03:35:32 -0700
References: <20260305151941.835215-1-pedro.ms.ferreira@ctw.bmwgroup.com> <0a020414e031e626bc57d61c49e839994202718c.camel@linuxfoundation.org>
In-Reply-To: <0a020414e031e626bc57d61c49e839994202718c.camel@linuxfoundation.org>
Message-ID: <1451444.1776335732977421820@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="UPfJctfFI1cjitj9FFqY"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2026 10:35:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19370

--UPfJctfFI1cjitj9FFqY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hey Richard,

Yes it is true that this changes the behaviour of one use case, but imho th=
is has a unique context related to the other calls of this function.
I do see this as a mechanism to detect that something nasty is being done.
In the context that i'm using this, this will invalidate the download cache=
, making the source file names not being unique.

Best regards,

Pedro

--UPfJctfFI1cjitj9FFqY
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hey Richard,</div>
<div>&nbsp;</div>
<div>Yes it is true that this changes the behaviour of one use case, but im=
ho this has a unique context related to the other calls of this function.</=
div>
<div>I do see this as a mechanism to detect that something nasty is being d=
one.</div>
<div>In the context that i'm using this, this will invalidate the download =
cache, making the source file names not being unique.</div>
<div>&nbsp;</div>
<div>Best regards,</div>
<div>&nbsp;</div>
<div>Pedro</div>

--UPfJctfFI1cjitj9FFqY--

