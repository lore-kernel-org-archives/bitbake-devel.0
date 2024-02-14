Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD36C4829F
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 06:59:20 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.36765.1707893957757148215
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 22:59:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L30rmmc+;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101cd91017so2319460e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 22:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707893956; x=1708498756; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iUN0FxGvRnaaSBMiZ8pzfds0oVLh2Los6JZsmOr+uU=;
        b=L30rmmc+2312fg0chBcpRDCgoA0B7Jgq6ZUktF18EfrQQUjySr58ztKl9lfKrJipag
         1IID2Q96mp3lW/BrRCpJzJhbCNM4iozexgGG6k9NZNqQR58d6bBEW8e6cNdgM/Rm8ISD
         SW7uF6oFVFsvdBJI9wgxAZFHpH49M/Aiqw0YMUsP1mR/bxTXgiu34Uhm23uk1IIecpNS
         mthDKyF6A5bPWo2Fk09PL51Ha6kggpdn2nQ8lqmN5erwjt576FhYN9d+cPiluRQ69Rdb
         P40lIwYtLtA1O9zjzm03lWvZkVnVxbZZhEBTaAH2EiztprNa+3F1ucmBBrC3XnemwcB/
         GmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707893956; x=1708498756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iUN0FxGvRnaaSBMiZ8pzfds0oVLh2Los6JZsmOr+uU=;
        b=Sxm6fTSsaba/TxHP9vN2sl3suJV4hvlQRac5mio+3l1QLNvk9VcNj0uoyfpx3njUCg
         2wY83VFR4N/vyuXuvamtl4TONl9GqKWErgCYEjTCk3CC5uAMUSukblztH/fT23ihDgqo
         f5IzdC3rUQOSCp+BCd5Uns7Eo4KmNJmv+OlwxL8zNgZzuuduDbBj3XjNPH13Gu3rLolm
         ufkyhJDR1xCfh5HA9YlRLLwgbeZK/20PlGlIXziVpOIFwUeSew9r5Duf2+MbaZd0WCDt
         4YW5aDgH02iZc1PL/n9FIYwO6FHwFrT1fdNrfBfbUfG6e4lmJIkBmf2AvuEXzQ54gQah
         f2/g==
X-Forwarded-Encrypted: i=1; AJvYcCVfTS6TFx1eJ+olCicbVR5+PRigDa0NdCzR2GpopDC72tXXdotBHwzqLc78yd2gBZedwG07KFjR48+0YEuzw4LnBU8YKsCP51KRKiMGKMsHgWWkxsY=
X-Gm-Message-State: AOJu0YwPbj3+dE7A9GsCzEdXIoKfk4bN9vvIrsj/ABysMerlFgH29yoW
	rCbw6ctlTwtAE+SrUqg8Q8XYvDStpZPXfiVZ3KAa0E6VMk/BwEZ0Jp/6YVLMq10GuNibyfEbwiK
	PLQMzHw6Xyld7rOJ83gMYABQt4jE=
X-Google-Smtp-Source: AGHT+IFLabJGcjrLIjSYX52IvZt1rwGEshXucL9jXHF/s3bGvfmW/I+KsAAg7ridPd70ofdhkFj0IG6beUjGTs3ZRrY=
X-Received: by 2002:ac2:46fc:0:b0:511:970b:2cdc with SMTP id
 q28-20020ac246fc000000b00511970b2cdcmr1115771lfo.35.1707893955453; Tue, 13
 Feb 2024 22:59:15 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
 <17B24084174823DE.15017@lists.openembedded.org> <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
 <17B255DB2CE33879.588@lists.openembedded.org> <17B257441406400D.588@lists.openembedded.org>
 <17B2894C95E031D0.14481@lists.openembedded.org> <17B29B2072FF51A8.14481@lists.openembedded.org>
 <7bb8798da40488ad8f79f472775e2ee2c2a9c8e2.camel@linuxfoundation.org>
 <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
 <b30b09d3a164e2425c8d0d43df495ea8bcb08679.camel@linuxfoundation.org>
 <CANNYZj8qZ4-nyGu53HsV8sJLCfBxmBuDeCD1cq7raSsby-_1=w@mail.gmail.com> <6f3ad1da428dc3023c30daa521ae97b89c21abd9.camel@linuxfoundation.org>
In-Reply-To: <6f3ad1da428dc3023c30daa521ae97b89c21abd9.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 14 Feb 2024 07:59:03 +0100
Message-ID: <CANNYZj83d9i0prBSDBwLu=SSS57p7YQVyWKvXphBts_yHBghCg@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Randy MacLeod <rwmacleod@gmail.com>, 
	Mark Hatle <mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Feb 2024 06:59:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15890

On Tue, 13 Feb 2024 at 13:41, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> We can work out how it compares to what we'd expect. If you generate
> task-depends.dot and count the number of dependencies between tasks,
> I'd expect the number of appends in build_taskdepdata to be be
> approximately:
>
> No. Tasks * No. Dependencies * 0.5
>
> The half is assuming that the number of dependencies a task as scales
> linearly which it doesn't but should give a rough number. It certainly
> shouldn't be more than tasks * dependencies as an upper bound.

Here's what task-depends.dot contains:

alex@Zen2:/srv/storage/alex/yocto/build-metaoe$ grep label task-depends.dot |wc
  35783  107349 5655551
alex@Zen2:/srv/storage/alex/yocto/build-metaoe$ grep -v label
task-depends.dot |wc
 145771  437311 9299716

So 35000 tasks, and 145000 dependencies. If one is multiplied by the
other it becomes 5 billion, which is much higher than 90 million
appends. Not sure what to make of that.

Alex

