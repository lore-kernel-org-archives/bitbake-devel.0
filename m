Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA57CC77B7A
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 10:59:28 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.8824.1685012361863889263
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 03:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=Be8zmVW2;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2af28a07be9so4343151fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685012360; x=1687604360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4OA4tvnz3gZuxSeuCcY2K27EdWpzzFzycZ9mQOVo06s=;
        b=Be8zmVW21sj7GiHrn9455KOhiIJGw3l6x/hddDybScyISq0KR6zgIPVStt07WXK9C9
         8d524ou1IGTp1akt9T3IfzvFBEqzGMAX+OfIZSmUQHVXCeZ+0AigN7URIdimIcIzN31P
         8FngtH2ZnjIXqI9E8a/nQloGGQFp1l5UNpt7BB7/OM98bONZbAFL+s2TflWqx5jUMAKT
         uyJrbqp9gPE5htSoMv1tuD1BNhyl3mmIqxE7ElFGbKu80rDWUSVfWmFcAyxBGopYE2SV
         wlJ0z4029yK7+RoXG3F0niMY3bZty6pEOzS0aFtWY8/esHHw5/Ok+Gbi88y4BMiUNNz1
         Bf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685012360; x=1687604360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OA4tvnz3gZuxSeuCcY2K27EdWpzzFzycZ9mQOVo06s=;
        b=D/c/M7Wa0VTXaaG89mhOSveYKLn8O8EojBDPhNzojmSNZTGw0yfXSx9f9JX2dD3I56
         aRyGqrVaGaVFbqCMSIZn5bFyndj2v2PhmYGlIALxe6sRtB2v1TppT2Mf5TrEWhFax45m
         lc0fizoMufwYPPvriNH7ClrZnZ2scCKxc8r2OYWmUDmQ6M4GVlzPak10ZVfPs402f/+N
         /xOkwF3FETp592fYRhSVBgQlcM6BvMbOq2YypdZ41emjtKIM6PLCeAjuzXvrx7squ1o3
         /Cfsbx3v8i/OhyrW7B05GSIsGFkzg9MHyUiPZ5SsClC9PPRAHXzaWKrmtPi8Sb+/QLB9
         xc9g==
X-Gm-Message-State: AC+VfDxkizRO4Exu5CauW82myFCzpgvcyzZSfh8AAMb/D5HECfqKcDYq
	qEa0ROQP+lk0oyiyiw3wrVYjWTF53C/DmAS94DQ=
X-Google-Smtp-Source: ACHHUZ6h2CL1JwGhe/4yQF0fPsV2sZrrhfrJG7iMw+jFJzvKzaGaQeyLAzd/4UgUXrkPiyCoAZXIgAg8jzrtYyau6H4=
X-Received: by 2002:a2e:8890:0:b0:2ac:8e5a:1054 with SMTP id
 k16-20020a2e8890000000b002ac8e5a1054mr878257lji.0.1685012359843; Thu, 25 May
 2023 03:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102105.1480610-1-michalwsieron@gmail.com> <ZG88JxkZkP4z3kR5@nuoska>
In-Reply-To: <ZG88JxkZkP4z3kR5@nuoska>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 25 May 2023 12:59:08 +0200
Message-ID: <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Michal Sieron <michalwsieron@gmail.com>, bitbake-devel@lists.openembedded.org, 
	Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, Mateusz Marciniec <mateuszmar2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 10:59:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14808

I tend to agree, if the problem is that some server is too slow, or
unresponsive, this does not solve the problem. If you want to forcibly
terminate stuff (which is still not a good idea - you should look into
why something 'doesn't work properly', not work around it), you can
terminate the whole bitbake process instead.

Alex

On Thu, 25 May 2023 at 12:45, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Thu, May 25, 2023 at 12:21:05PM +0200, Michal Sieron wrote:
> > By setting `BB_TASK_TIMEOUT` you can control timeout of for tasks.
> > Using flags `BB_TASK_TIMEOUT[do_mytask]` you can override timeout
> > settings for specific tasks.
> >
> > This is especially useful when some server doesn't work properly and
> > `do_fetch` task takes too long. We may want to kill it early instead
> > of waiting for a fetch that won't happen.
>
> Is the problem related some tools and network protocols? Which?
>
> An alternative would be to configure the tool (git, svn, curl etc) specific
> settings, or even the default socket timeouts on the running system.
>
> I've seen this kind of problems too, but I'm not sure this task timeout is the
> correct way to solve it. Time is too relative :)
>
> Cheers,
>
> -Mikko
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14807): https://lists.openembedded.org/g/bitbake-devel/message/14807
> Mute This Topic: https://lists.openembedded.org/mt/99127010/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

