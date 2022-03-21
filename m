Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDADC433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 21:39:58 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.1776.1647898797040134015
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 14:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20210112.gappssmtp.com header.s=20210112
 header.b=G9MD4uTn;
 spf=pass (domain: burtonini.com, ip: 209.85.128.42,
 mailfrom: ross@burtonini.com)
Received: by mail-wm1-f42.google.com with SMTP id
 l7-20020a05600c1d0700b0038c99618859so352552wms.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TlsPyKp2urZkNLtdEoGtAxwo9JWRj19RYWsjuK/FKhw=;
        b=G9MD4uTnK+dlxOU6huQRmG+l+4jXolA2clww8dyESnXngc0OFtQhjc9zPSfcnrZgjV
         +dIctoZdAPdfi0vJL2uxty8MiDkjLFHCxBa+geytYmdKRE+8EPCbt2bG0uO5b2HATyYL
         w3pGe6LlVu+dCirGUxJIa8NsW+XSMfKt4Jl4DG9NlcBmJzgOHI/JOYplWRO6DQj5iK89
         xQPNzzjDxNkQ4hQnezXOrj3SDcttEA1wjERkn4cbSW0ZVFaHbIuGAiGD8o9k4iN2vcMK
         bykMJfxpmPBRqu9aIjzlBBoHJLQC8nbe2R11W6V4qa5NmqAP9BZR3vqnA6+3mAfOkQDN
         z97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TlsPyKp2urZkNLtdEoGtAxwo9JWRj19RYWsjuK/FKhw=;
        b=7BCXC8TA3j8oOWn1OnuCCO7ZOUhrkp20UddlF3ygZtRvcliKTMrcSov0rh1uH6zZYI
         /CTQC2G+y6U8qQZ6i+3PQwCQTb5lBeVMn6wO3en5Iayar1Ufnfne8TwYiEC04X2S6X3U
         EcBqecoEfh2RMWY/2LY8AHNXklMKzK7VoTul/5HGzeSlacItzzrLFKD0JcJX4NBJS+JF
         cNYxbcmSGn20bfG5GqLrNUqXywl4tugb/G7bNKr4wrXdqGzuf6cLJUJrB6X/RUjqWNKi
         33pdnlXoJ0qny0O7Rg3XAIP+wTbuiQVK4BIyc1IragO7d8vNEFWhGpPFUo9FabVsPxCr
         yJXQ==
X-Gm-Message-State: AOAM5309KsUrNbXImcEJQSL76JIOsNwZbWYc3lG6hhiXvZPoBKwYdR/8
	tFfr6S0D9pCOD4XlR5V3AyF36qNivbJz7g9aMoDo/I3Xhal4Uw==
X-Google-Smtp-Source: 
 ABdhPJzYOK9jjfNmzLmp2JYQComd+R3YkYVIDr3IJAi2OqMrGqRslugUfOrGHktSBCy5ZMRKT8/P02uY5YJwKePHnFY=
X-Received: by 2002:a7b:c841:0:b0:389:864c:e715 with SMTP id
 c1-20020a7bc841000000b00389864ce715mr960830wml.72.1647898795483; Mon, 21 Mar
 2022 14:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220321170104.3371476-1-ross.burton@arm.com>
 <CA+chaQfYrpNihF_BNx66f3cSoRbhfRTy2wLOjekq00G=Q=tE9A@mail.gmail.com>
In-Reply-To: 
 <CA+chaQfYrpNihF_BNx66f3cSoRbhfRTy2wLOjekq00G=Q=tE9A@mail.gmail.com>
From: Ross Burton <ross@burtonini.com>
Date: Mon, 21 Mar 2022 21:39:44 +0000
Message-ID: 
 <CAAnfSTtngc0VRoncMXf1WwfpuubvAZE0Hdj=iaHY0=Pfbce7Vg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] knotty: display active tasks when
 printing keepAlive() message
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 21:39:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13494

On Mon, 21 Mar 2022 at 17:20, Martin Jansa <martin.jansa@gmail.com> wrote:
> I like this idea and with this implemented, it might be useful to lower p=
rintinterval 5000s to something a bit shorter as well (or make it configura=
ble)
>
> No output at all for 10+ minutes always looks strange and if I have a she=
ll on the builder I would check top/htop to see what's still running (if it=
's something expected like chromium do_compile or something less expected l=
ike linux-yocto do_fetch when the premirror should already be populated). P=
rinting this directly in knotty log file would very convenient for people w=
ho cannot just run htop or similar on builder and tens extra lines in the l=
og file doesn't seem too bad.

I actually agree.  How about five or ten minutes?  This only happens
for non-interactive builds so most interactive users won't even
notice.

Ross

