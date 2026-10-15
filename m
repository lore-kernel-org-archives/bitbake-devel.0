Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC5DCC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 10:25:18 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36669.1792059917230425619
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 03:25:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hxgMZsJU;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2BB464E4124B;
	Thu, 15 Oct 2026 10:25:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00ABA60360;
	Thu, 15 Oct 2026 10:25:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D6D910328B6D;
	Thu, 15 Oct 2026 12:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792059914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cPq3SDSJNT5R6A5XmTtMFigUomyfeeqvDWO+2DOkjjc=;
	b=hxgMZsJUjYdnmvrADGdaj83Mjaycdh6iTqV2Xw8bKTv5HfyvqU0hKfUIEqPJv0KV02Uj8R
	qLiAFYLQJomXLfmSCVqtXPVxDMexfDH+3RnmFth2PlRBf1RwkWBL3/ncH7YYRkZR4/DdQv
	043MS0vtOQRYmdyur6kjFMwHUb7Og3n2dvIl8noGUmJpi8e3fcOus33v9J7s3fH/zFX2zZ
	bWwXwDUotGXGwrCFq4SlQ+hp81lZhaQ2qJc43Q7EI16G7/kWabEoAmLeWyVLjtD4N+w8Z2
	uWCQs1CbfimLPyUL6jtaJfglUGVK+kHozW8zM+dYzt1xpp/jekLRwkdSRHWxYA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 12:25:13 +0200
Message-Id: <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
In-Reply-To: <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 10:25:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20344

On Thu Oct 15, 2026 at 10:58 AM CEST, Richard Purdie via lists.yoctoproject=
.org wrote:
> On Tue, 2026-10-13 at 14:13 +0200, Antonin Godard via lists.openembedded.=
org wrote:
>> When -W is passed, modify the handlers to show warnings in red and set
>> the return value to 1. Add a summary line informing the user that the -W
>> option was used as it might not be obvious when looking at the bottom
>> the end of the console log.
>
> The trouble is this doesn't make warnings behave exactly as errors and
> I think that is going to confuse people :/.
>
> Specifically, if an error is encountered in a task, it will error and
> fail. The warning will show an error but continue anyway. I also
> suspect the warnings will still show as warnings in the log files and
> only appear as errors on the console.

Good point. So there's two directions this could take (if we want that feat=
ure):

- Make this option change the behavior of warnings, and make them _act_ (no=
t
  just look) like errors, so a given task would stop in case of warning.

- Rename the option and make it clearer: warnings are still warnings but th=
e
  return code will be 1 if there are any.

  Maybe "-W,--fail-on-warnings: Make bitbake return 1 if any warning is
  emitted"?

I feel like the second option might be best as the first one is changing th=
e
behavior of tasks and I also think this might not be desirable.

With the second option it allows having a positive exit code on warnings wh=
ile
still being able to have a look at all of them (not only the single one tha=
t
stopped the build as would happen with the first option), just as you would=
 with
a normal bitbake execution.

Antonin

