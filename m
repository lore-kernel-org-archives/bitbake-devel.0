Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3031C25B08
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 21:44:30 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web12.189.1660081468260946762
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Aug 2022 14:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oVfIy8G+;
 spf=pass (domain: gmail.com, ip: 209.85.208.48,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id b16so16767130edd.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Aug 2022 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eixz5HMCx05WpFx4158VIl9AnqJIPoS3l98wr73LQc4=;
        b=oVfIy8G++ALtRpDdTusmYKQDxxuIJII+zW//aGQBuSJA0Bsv/+KboCxGo7LCmRqSO1
         AH4uSS3dUFV3eIpZ9LP5BnxIsWSteZNYryngwjWoE1VK9QGBMwBwWMIZQjl+JPgljup7
         Rp7R8rqSQsf6V3JSXOBT4mZeTCEs1wgsTgRoGNOu9F6H8bpvO51d+AEBmT7ab9ndCEQi
         5FM5IIxmWYUZXfy2uy709P+07Zk1tbhmmbijhDxYaBOFQJLwBQyoEh2sdYnOj+CEavfM
         QRLYUeF32yv7Y/RK49kBStvqS69rbJbrQpHMsMITIuSli4fW5iosk9gMeHwAukkeA0A3
         rKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eixz5HMCx05WpFx4158VIl9AnqJIPoS3l98wr73LQc4=;
        b=7L5eML7GNgk58M5Qyx4Jpze7yn7Az2HAHp5RVlVW2SYPlcafZ9/92+irFC33b12J5I
         FJSZCpmywsa3JNvZ2e+Ackd+3E1n08/Pumf9A2mbSoK1n1yLE+rzPKxzydPoBd0yCJb6
         ZmXBOQZraXKs4eiN+BbXvKlKRlJeM0OxBDEl/hYl1RJZzwP9H5Ij7rBizuwozqM2AR1Z
         RxQlbizgJzl/TkEPHlRPePFpSH9VPpQQ8uWW1l5z7KMEwFqc69EOLYBOwF6EWBBRIpX4
         GA2TvpB3/K6pUD8lkWlAttb3zOuZ+7lKZJu1jdzkrZsxaN8O+a5V9P/70PDpOErcaQ8T
         0Skw==
X-Gm-Message-State: ACgBeo2gXatThQLC5uq2JJT5i3wxRJd5VQeEi1izw9V2DrZ73SCk9Bpj
	r3+w0/vT+84a4zLyt6vNJdLkBrKx+V2jdxXXUzM=
X-Google-Smtp-Source: 
 AA6agR4ythQGXwgnqAi+PHFtZM1M/OMmH5k9gUECBIcbXEXMhjjsX30TXh4GeLMAMbddTngNV+323BrVLn2D2Vy5AbU=
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id
 j11-20020a05640211cb00b0043cc7a3ff86mr24196987edw.383.1660081466753; Tue, 09
 Aug 2022 14:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220803140441.1196056-1-JPEWhacker@gmail.com>
 <20220804112648.71c80544@booty>
In-Reply-To: <20220804112648.71c80544@booty>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 9 Aug 2022 16:44:15 -0500
Message-ID: 
 <CAJdd5GZRRUOf3ZMSQQnxOgU0oxqW2-ty5P0QKbAKTEitD7HnfA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] siggen: Fix insufficent entropy in sigtask
 file names
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, rasmus.villemoes@prevas.dk,
	Steve Sakoman <steve@sakoman.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Aug 2022 21:44:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13876

On Thu, Aug 4, 2022 at 4:26 AM Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>
> Hi Joshua,
>
> On Wed,  3 Aug 2022 09:04:41 -0500
> "Joshua Watt" <JPEWhacker@gmail.com> wrote:
>
> > Signature generation uses mkstemp() to get a file descriptor to a unique
> > file and then write the signature into it. However, the unique file name
> > generation in glibc is based on the system timestamp, which means that
> > with highly parallel builds it is more likely than one might expect
> > expected that a conflict will occur between two different builder nodes.
>
> s/expect expected/expect/
>
> Taken in my testing branch with the above fix.

Steve, can you please backport this to kirkstone and dunfell? There
may be a context failure backporting it to dunfell, let me know if you
want me to send a new patch with the correct context.

Thanks

>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

