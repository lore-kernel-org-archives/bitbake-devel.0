Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10774C48297
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 12:58:59 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.5770.1707742736072938649
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Feb 2024 04:58:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jLzR+/Lo;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so3518865e87.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Feb 2024 04:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707742734; x=1708347534; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1O+zS/lEpaTboa1AsXc2/gS6HsCAFB1KW1jtpQt/SrU=;
        b=jLzR+/Lo6AMRys++U0vFPw5kDmphZf8CI3yiB5ePrqjUab6n1FQgPxuHn/B8R6Uhui
         9hs8UF3xqdu8nNnSFryJ1//i7ksGCK/5XhNgeGTgj9VCsRa8STHAHPEymGosP5TrPoqV
         +o+m4RqSp0Up6401dsVVeYC8awUH4jh0oMOyz4TDNLFzbrVsNrDOHuO2JRzM38M6Uv/B
         hGLPRxFygKTlvxKscNIO5RAuqbKCF5k2rQHFm5rHk25l9ux+Z+u5s+G7bqxw47ou3frm
         eLBEf5/jt9BTtOLDiLLQrVj4MUgiWJZ/5lFg9igBDXg1w0MvT5nhIsTQ1JOpFCo78/06
         6MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707742734; x=1708347534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O+zS/lEpaTboa1AsXc2/gS6HsCAFB1KW1jtpQt/SrU=;
        b=HECs55y1MkCLxBKKFMaDI0U4XlzK1fvCHI79Nfj4bfUDkbZPfQYU5HVrik44T90fqX
         MaxPtxIza6BslR2oQY1jpAAU9jmGSmDwDyjqV8hDuyNnB00P0vK/0LqGMY/nqn1fHd9g
         v+nO6Pr8xUAkAm62oYp0EGTW7O+OYDJb0HRnVv3XMurFaKmdsLDXyEky0CijShlDVL68
         YH6Een1osc77T6p42T9XKZIWlpllQZc3tbumRmr6zo5Wpoj2JqSoWYFhtwKSpIGCgcea
         Qx6aG+7V0F9RNlyAn+z5SU6D+bFzocCs9BAwaGiYLHtM5eDb8HaXHBxwsi0og1OypY8I
         rp5Q==
X-Gm-Message-State: AOJu0Yxe9oWSpM1YuXK1DSeJ2UilX7tJ1JDOgD0gzVXsssT3IXLmalJ6
	MrF14JkBXSn9Hsw0ElRlJSlpJxWy8oemMOdlIZm2hAvgRiZk87EXcUSq/nxGKtpd7icVMF1N7gW
	9lgo1jhYAiJlbKFGAFlbNbtz/TBg=
X-Google-Smtp-Source: AGHT+IG4UlaMByyd6jdHCz3lZNwqkvEKkVZ4kSm1l8nTEBWxDpDQjUewSZfpy/M4bIgN4Gm46Sbj2ysSBgjsXstweGY=
X-Received: by 2002:a05:6512:52c:b0:511:8d6c:3af9 with SMTP id
 o12-20020a056512052c00b005118d6c3af9mr2101457lfc.0.1707742733790; Mon, 12 Feb
 2024 04:58:53 -0800 (PST)
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
In-Reply-To: <7bb8798da40488ad8f79f472775e2ee2c2a9c8e2.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 12 Feb 2024 13:58:42 +0100
Message-ID: <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Randy MacLeod <rwmacleod@gmail.com>, 
	Mark Hatle <mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Feb 2024 12:58:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15880

On Sat, 10 Feb 2024 at 21:53, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> Looking at the code, people have altered next_buildable_task() to add
> per task thread limits and pressure regulation and they don't realise
> how often that function can be called or how fast it really needs to
> be. Note that the profile above doesn't include pressure regulation but
> if it did, it would be much worse.
>
> It can be reworked but it isn't trivial.

Thanks for working on this, over the weekend. I just re-run profiling
with the fix for the mainloop, and here's what I see:

1. There are three performance fixes in master-next. Without any of
them, profile shows this (pressed ctrl-c while it was still not
running any tasks):

Mon Feb 12 12:32:56 2024    profile-mainloop.log

         71983446 function calls (71606940 primitive calls) in 1546.118 seconds

   Ordered by: internal time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     9448 1461.507    0.155 1491.991    0.158
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2147(execute)
9510/9448   14.437    0.002   14.530    0.002
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2672(scenequeue_updatecounters)
  5250612    7.414    0.000    7.414    0.000
/srv/work/alex/poky/bitbake/lib/bb/__init__.py:63(bbdebug)
  5219489    6.090    0.000   13.472    0.000
/srv/work/alex/poky/bitbake/lib/bb/__init__.py:57(debug2)
        1    5.906    5.906   18.979   18.979
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:644(prepare)
43827/23463    1.662    0.000    4.198    0.000
/usr/lib/python3.11/re/_parser.py:507(_parse)

So it is indeed the execute() loop itself which is slow. It's only
logical then that with the first two performance fixes applied,
nothing changes:

Mon Feb 12 13:03:42 2024    profile-mainloop.log

         67576990 function calls (67201484 primitive calls) in 1226.143 seconds

   Ordered by: internal time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     8711 1147.496    0.132 1173.321    0.135
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2149(execute)
8773/8711   12.261    0.001   12.347    0.001
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2683(scenequeue_updatecounters)
  4498537    6.303    0.000    6.303    0.000
/srv/work/alex/poky/bitbake/lib/bb/__init__.py:63(bbdebug)
        1    6.238    6.238   16.135   16.135
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:644(prepare)
  4467414    5.149    0.000   11.418    0.000
/srv/work/alex/poky/bitbake/lib/bb/__init__.py:57(debug2)
43827/23463    1.662    0.000    4.239    0.000
/usr/lib/python3.11/re/_parser.py:507(_parse)

Do note the quadratic growth in tottime though: 9448/8711 = 1.08, but
1461/1148 = 1.27

2. With the third fix (allow the loop to work through all items), I
finally didn't have to press ctrl-c, and the dry world run completed,
with the following picture:

Mon Feb 12 13:21:51 2024    profile-mainloop.log

         158073071 function calls (157658186 primitive calls) in 972.810 seconds

   Ordered by: internal time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    35784  307.013    0.009  513.933    0.014
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:225(next_buildable_task)
    34092  160.895    0.005  168.126    0.005
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2438(build_taskdepdata)
    35807  118.265    0.003  118.265    0.003 {method 'difference' of
'set' objects}
    71592   54.910    0.001   54.910    0.001 {method
'difference_update' of 'set' objects}
    34096   50.010    0.001   50.010    0.001 {method 'write' of
'_io.BufferedWriter' objects}
17639/15964   48.203    0.003   48.480    0.003
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2685(scenequeue_updatecounters)
   298834   45.690    0.000   45.691    0.000 {built-in method _pickle.dumps}
    35827   22.092    0.001   22.092    0.001 {method
'intersection_update' of 'set' objects}
    35783   10.610    0.000   10.610    0.000 {method 'index' of 'list' objects}
    35957    9.649    0.000  916.610    0.025
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2149(execute)

execute() moves to the 10th place, and the time starts to be dominated
by other items

3. I'm not seeing anything obviously inefficient in the execute() loop
itself: it's mostly doing standard data structure lookups.
So I'd say execute() should be allowed to handle all the items in a
batch or otherwise make its own decisions about when to return. This
results in fails elsewhere as you've commented, I didn't yet look into
that.

Alex

