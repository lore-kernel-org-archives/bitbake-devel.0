Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5ADC433FE
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 22:11:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web08.32564.1639519882650507641
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 14:11:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Rkb9w8kK;
 spf=pass (domain: gmail.com, ip: 209.85.128.43,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id
 p27-20020a05600c1d9b00b0033bf8532855so14755152wms.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 14:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXLVLqxZ0wxmMdZqU8J6pFXXPOOudXSqBWLlkQ/VrmY=;
        b=Rkb9w8kKrwKnJNXYIWZgm/ES+pDbLvbOxOvcp3Upjt0ISmVAAVDYZ7FukRmX5Eo9al
         9SB00PaYVtuqpF9Pa158nL7nnXIU6p0myeJcW4z5a6X4Avj25ys9sPVQ5oUEaOWJhEZC
         eZoBc93NZRLPJ5kupjzSX7KIjUHU9g/qtxGMJqaY4BCcsbxDYSvFyWDWkjnI/QEuy2if
         7yfr54xoXdCLZh6P3rPr9svM2jQqbGcyUAfILWJKKGg/+0B2kOHlkPV2lxNhJeEJHdl2
         kIq4jxsTjnfREqs5ln/R1fAYRQw/sf0gVzkMKvToZvstlCkSqftlf1Au2r4Za5vzH5XR
         YPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXLVLqxZ0wxmMdZqU8J6pFXXPOOudXSqBWLlkQ/VrmY=;
        b=5mW+/cbyhHO6wG4pCsb0zrGqK8Yd796sDqyQ9j+6RBoCeXfGiVhIn0SYRUea6Gl6Ek
         lWGjVBiJT3Fwv9ih87woLNZWaxJo7ck0MuoL5+XiuD1CrtbV/k3eKAI22orE9GHqu3hZ
         qUxwuBcsCAJGlJ5aBZTXuy7Bs9rrFYnzcUr7T0oY9prpx9cuGiKB9ltXae5ytILGMFRK
         Gxgyk4yDsJIFIo4kv69VXUeEQWkUtRm8ZA1aubmVAuya67VTKlCnvIWSXC9GeCyZdNKA
         ROv5YthS9x9aUGCv5a6FutPRujKgL2Lw/RJ4+B3IC0/d66NSHZJTbp3mFFNs8Op8F3YK
         9RnQ==
X-Gm-Message-State: AOAM530gHbmZgDsLsWo4YSuHefLQX2VFn1VgnRTk8zcfnXzp3+1HmZXW
	ECXphWPzECGz+qpAOe/P+HDeURFpx34wTimOnns=
X-Google-Smtp-Source: 
 ABdhPJy6k61AVGKmHmS7qGA96ehIP180g0aTSy/EPU9KI0+oIWOx8qAs8g3QUTj6KYdKVFWbcVp10gKwNxMLZUgMGWo=
X-Received: by 2002:a1c:5409:: with SMTP id i9mr1785818wmb.146.1639519881107;
 Tue, 14 Dec 2021 14:11:21 -0800 (PST)
MIME-Version: 1.0
References: <9234471a-8cb1-429a-0dd9-6820cdf62616@bootlin.com>
In-Reply-To: <9234471a-8cb1-429a-0dd9-6820cdf62616@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 14 Dec 2021 16:11:10 -0600
Message-ID: 
 <CAJdd5GbRMTVhm9rZHOEmX3a-14cZsby_RuAX2SRjhv6cvvAq9w@mail.gmail.com>
Subject: Re: [docs] Can BB_HASHSERVE still take a 'host:port' value?
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>,
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 22:11:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13162

On Tue, Dec 14, 2021 at 2:54 PM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Greetings,
>
> I'm trying to propose more details and updates to the documentation
> about the Hash Equivalence topic.
>
> Looking at the code, especially at
> https://git.openembedded.org/bitbake/tree/lib/bb/cooker.py#n387, I'm
> wondering whether BB_HASHSERVE can still take a 'host:port' value as the
> current BitBake documentation says.
>
> From what I've read so far, it seems to me that if BB_HASHSERVE ==
> "auto", a local server is started using a UNIX socket, possibly tied to
> a remote upstream server specified through BB_HASHSERVE_UPSTREAM.
>
> The other pieces of code where I found BB_HASHSERVE don't seem to show
> any use of a 'host:port' value either.

BB_HASHSERVE can be one of:
 1) "auto" to automatically start a local hash server, optionally
using BB_HASHSERVE_UPSTREAM as the upstream
 2) HOST:PORT to connect to an existing hash server over TCP
 3) unix://PATH to connect to an existing hash server over a UNIX domain socket

>
> Am I right?
>
> Thanks in advance,
>
> Michael.
>
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2258): https://lists.yoctoproject.org/g/docs/message/2258
> Mute This Topic: https://lists.yoctoproject.org/mt/87730814/3616693
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

