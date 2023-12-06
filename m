Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F4C46CA3
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 23:32:12 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.63503.1701905528573344596
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 15:32:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=EtAOMozW;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3ADF39C4063;
	Wed,  6 Dec 2023 18:32:07 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VOOkxpunFxkd; Wed,  6 Dec 2023 18:32:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8E62B9C4065;
	Wed,  6 Dec 2023 18:32:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8E62B9C4065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701905526; bh=M9M9m+CKadFUmpMZUlBGcsMKQE1CPr6ypYJM7J6SMLw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=EtAOMozW6KIGxUs1yK0FAArfeQK6HsOnkWOge4QQfpbm4VCenCsbuFRqDPZQ1Jyzq
	 9fXPI4ezsCIlsqPzDhJFpcCrHd83oEZarVTd3r8BfF24MFqjoTkmh+uiQh2Dv9d5Yy
	 Q+9b0PcJMVGlLSQ4LhQkTl6PavGQUe9zzMFuphsN5Ubv1xDSjz+1pmK/76Pw1KzVxp
	 K8LsF+bab+YoDK8OS2gaqS8QGhbSdgsp9lCnRT6wZzutlOT3LLUhncsbaFPnFhRGKX
	 dDkjXTSDPOQa0fGzyP/y1ZXkcIxtQmAqE3fH088YNIqKTHYXwyo5cr39uadMe9l1TT
	 Y7i5G6QCPuuow==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ox0vLJKJym13; Wed,  6 Dec 2023 18:32:06 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 753DA9C4063;
	Wed,  6 Dec 2023 18:32:06 -0500 (EST)
Date: Wed, 6 Dec 2023 18:32:06 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: richard purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Message-ID: <1347387869.1559511.1701905526293.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <9e1be8c6a333fcbb50b7e6fdfab98094a341e025.camel@linuxfoundation.org>
References: <20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com> <20231206224305.34686-4-marlon.rodriguez-garcia@savoirfairelinux.com> <9e1be8c6a333fcbb50b7e6fdfab98094a341e025.camel@linuxfoundation.org>
Subject: Re: [toaster][PATCHv3 3/3] toaster: Update eventreplay
 functionality for new eventlog file structure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - FF119 (Linux)/8.8.15_GA_4570)
Thread-Topic: toaster: Update eventreplay functionality for new eventlog file structure
Thread-Index: fCH5raFg59ES4oEjs80AZyAeMinI6w==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 23:32:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15628

I think this could be merge as it is now, and another patch will be added to update the Views and the eventreplay lib, can you share the patch with the new changes ?

----- Original Message -----
From: "richard purdie" <richard.purdie@linuxfoundation.org>
To: "Marlon Rodriguez Garcia" <marlon.rodriguez-garcia@savoirfairelinux.com>, bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Sent: Wednesday, December 6, 2023 6:02:09 PM
Subject: Re: [toaster][PATCHv3 3/3] toaster: Update eventreplay functionality for new eventlog file structure

On Wed, 2023-12-06 at 17:43 -0500, Marlon Rodriguez Garcia wrote:
> Added class EventPlayer to list of libraries under bitbake/bb/ui/
> Update file read functionality to match new eventlog format
> 
> Exclude listing of files that don't contain the allvariables definitions used to replay builds
> This part of the feature should be revisited. Over a long period of time, the BB_DEFAULT_EVENTLOG
> will exponentially increase the size of the log file and cause bottlenecks when importing.
> 
> Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
> ---
>  lib/bb/ui/eventreplay.py        |  85 +++++++++++++++++++++
>  lib/toaster/toastergui/views.py | 131 ++++++++++++--------------------
>  2 files changed, 132 insertions(+), 84 deletions(-)
>  create mode 100644 lib/bb/ui/eventreplay.py

Our patches overlapped!

I've merged a patch to fix toaster-eventreplay and it is slightly
different to the code below. The major tweaks are handling a second
'allvariables' entry and adding a eventfile.seek(0) to reset the stream
before calling the player.

We should probably have a standalone patch moving that code from
toaster-eventreplay to lib/bb/ui/eventreplay.py and making it use it,
when can then be followed by the patch below to have views.py use it as
well?

Cheers,

Richard



-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#6060): https://lists.yoctoproject.org/g/toaster/message/6060
Mute This Topic: https://lists.yoctoproject.org/mt/103023929/7896800
Group Owner: toaster+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [marlon.rodriguez-garcia@savoirfairelinux.com]
-=-=-=-=-=-=-=-=-=-=-=-

