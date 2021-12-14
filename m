Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AB2C433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 21:55:09 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.32395.1639518908486209850
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 13:55:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ODU2e/4X;
 spf=pass (domain: gmail.com, ip: 209.85.221.46,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id u17so34812686wrt.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 13:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBY/FeOcZ/vDpmCetgPziLKtL57qUoAsZmWDEkSJsYo=;
        b=ODU2e/4XJ5TtnaxebFCWO1VBN0wIAAAz13xYpQXPifa23meSAbuf8m9gOxa49WcXqm
         TiMYp08EVZnfmfMdsyfqU71GGoF1aZPU+fkghQioi137PJDoyAbV+dvtSWdMFsrxxSaf
         B2lWLdYl+ARZjfnBCBYPixDUrokAMGgK/MGHG8khmvEGTB4JJSHlj2dGgGiXRIrnPMru
         FtAnT38N/4zK1zmWAgwvuXRRil3TRq9TCecXNzZT7M/ANNngvx2qAFpJDFBVYmOoP+3k
         453XTGQsLw2V816ea/fDvNeIuM1bVXKjo2qy0p838pOCsdmr9FfpBJHwnslUH2A3HQhT
         eObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBY/FeOcZ/vDpmCetgPziLKtL57qUoAsZmWDEkSJsYo=;
        b=r7YIYliXic9Qf/2aXeMiSfAO3zKRI4fa17bGxpp1yCKkIPkJdK9TY8dpl/jeonLLnk
         fnfthKGe4+2h0c7vN27/xetSrHMjr6vCKE53zonBqt7pcKL1iWfT3bpwy+nXGrRcT1eQ
         biJcpum6Lxx7NrtopkCWqt5nKmpjTFs21m/9GsHUONwCJQS/1cMOEJf+CwghNzaogXAp
         YOJOBVv/HP/ksRXi/m//8LCEUW8wwjkD8Vh8S+V/yD+160awgR6nZeplhY4vGhN96upP
         R/mb7psQ/meo2OizWSVu30XIyRX+pDaoU8RkArbOd78Y90Aq+DzhMMbyG6khFG4Vow3s
         Vhcw==
X-Gm-Message-State: AOAM530mq3zI/C5fVAsU6TyfpnOX3pflQmgwJMGSMrdUe/6/2kNSoMGN
	A6KUxgfnWEFkIpsnbvZ6b+DEpfI6Um4ailCPmYU=
X-Google-Smtp-Source: 
 ABdhPJxxazLurWnCnP+bRl+UtDeGQ6kYwMI05W4PmmPRrvZeLya9sNPnDFpHBb3dIKXpRuRY6KKhpSkilhCrJkC9Fao=
X-Received: by 2002:adf:9d84:: with SMTP id p4mr1662455wre.188.1639518906949;
 Tue, 14 Dec 2021 13:55:06 -0800 (PST)
MIME-Version: 1.0
References: <01318822-37b6-b1aa-6235-ce0f6e6e28c3@bootlin.com>
In-Reply-To: <01318822-37b6-b1aa-6235-ce0f6e6e28c3@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 14 Dec 2021 15:54:56 -0600
Message-ID: 
 <CAJdd5GbLevnrtyN1JndsHjJHbzpHrS-nh7TjYFpfD8r2n54BhQ@mail.gmail.com>
Subject: Re: [bitbake-devel] How to start a read-only hash server?
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>,
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 21:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13161

On Tue, Dec 14, 2021 at 3:42 PM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hello,
>
> In
> https://git.openembedded.org/bitbake/tree/lib/hashserv/server.py#n514, I
> see that it's possible to have a read-only hash server.
>
> Is running "bin/bitbake-hashserv --read-only" from the command-line the
> only way? I expected this to be possible through a BitBake variable too.

There is no reason to allow it from a bitbake variable because a
read-only local server isn't really useful

You would only start a read-only hash server if you are running it
standalone instead of having bitbake start it for you

>
> Anyway, this should be documented, right?
>
> Thanks in advance
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13159): https://lists.openembedded.org/g/bitbake-devel/message/13159
> Mute This Topic: https://lists.openembedded.org/mt/87731843/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

