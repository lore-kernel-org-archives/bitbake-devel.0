Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DEAC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 09:42:43 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.7950.1707817361735794963
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 01:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BK3Cucwc;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d10b6c1cfbso3559061fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 01:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707817360; x=1708422160; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c1Dhy+470EBIq2Wu4gEp10XbY8m0Muzqd1jWfckXbs4=;
        b=BK3CucwcnnL8y4k/WvWedb7KOvR/kQ4jkbOIXSWKNhf0+trD+W1II6ESqzgZo52hD/
         Os95uxozjOafGRDdGz41fQtl578fCzKdc3SlSbLHgIZzmmQZgRO+HuBPa89cZ/7YmCUT
         sb3eXu2xFHvsJ2UPzxFRnOW/HYjWgHy16N7X5C7WKq4LUi/mNnQGWDPiRNNTx4Co6c6z
         TnOVJu/n6ZerggXZWlxguSb+50TqoCvroe44As2UJmgM9flGdEhw88bDP7V6pyyIvpQM
         vaEqvxcvxChg4WfabKMNbTifxUsMQo9go95L3WJy1cJckuk71CPCC5UTy7F3J+S+ji4q
         hrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817360; x=1708422160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1Dhy+470EBIq2Wu4gEp10XbY8m0Muzqd1jWfckXbs4=;
        b=Uq1wgEQ5ZYPeWJCHll38vJm2JVMeusw5G3R/rU5wf/OihYjB1QMUTPvmSTJM+iYjmB
         /CUZtV4Qz3xpgozBsdTqTYCeUYr/KiTuTifc4yIggUWgJPi6zryur0KiGOKMfgHpP+9Q
         9rxtrAW1RmgJBj3xZGaffIKJBWnanuB5EupgHPXWJcnafKYiUfIdAGQX7+NiOik8E62J
         s6CBbh8mL6WDNn4tcaywVwIjpsT24JIR0PNMtA2RHbEvEsF0M0xVXQiUoY3CtS8RKKmV
         gD9iruI1/gEoY0n+2tvn4QkSPp+jrfCVjiG1jAPF5nHB9595y3pfdzExPoexvgXWubRt
         zwBQ==
X-Gm-Message-State: AOJu0YxV+NB6aBSzkjRZHklgeMJeq+M2smxvbiEltLrylprRdph5h/vY
	wCuaRo4JLJ7KoJ4JC9Rhh88mfMDbuBBll6jl9vwMZ1EFTJ4HvXNa0JbLOyvE9+JST8yi4UdwLK1
	iv7Jxud98my8i+SKazwNCaPCNwC4=
X-Google-Smtp-Source: AGHT+IHS+qvzB112H53gBMjxx1ZixaJNuQ6apKIqv+9t9ChdmP2As4eeSUzpPkYaDaOXpMfshUY7ogmslyeuJJ4wRcQ=
X-Received: by 2002:ac2:4bd1:0:b0:511:87eb:8dc4 with SMTP id
 o17-20020ac24bd1000000b0051187eb8dc4mr6736107lfq.32.1707817359629; Tue, 13
 Feb 2024 01:42:39 -0800 (PST)
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
 <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com> <b30b09d3a164e2425c8d0d43df495ea8bcb08679.camel@linuxfoundation.org>
In-Reply-To: <b30b09d3a164e2425c8d0d43df495ea8bcb08679.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 13 Feb 2024 10:42:27 +0100
Message-ID: <CANNYZj8qZ4-nyGu53HsV8sJLCfBxmBuDeCD1cq7raSsby-_1=w@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Randy MacLeod <rwmacleod@gmail.com>, 
	Mark Hatle <mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 09:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15884

On Tue, 13 Feb 2024 at 09:57, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> The patches fix low hanging issues but I suspect there is more we
> could/should do in this code.

Thanks, I confirm that after replacing the previous 'return True ->
continue' patch with the latest one, the profile is similar to that
patch:

Tue Feb 13 10:29:59 2024    profile-mainloop.log

         171090640 function calls (170677396 primitive calls) in
1000.777 seconds

   Ordered by: internal time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    35784  301.390    0.008  509.820    0.014
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:225(next_buildable_task)
    34092  164.164    0.005  171.500    0.005
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2438(build_taskdepdata)
    35787  120.062    0.003  120.062    0.003 {method 'difference' of
'set' objects}
    71572   55.117    0.001   55.117    0.001 {method
'difference_update' of 'set' objects}
17639/15964   49.593    0.003   49.869    0.003
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2686(scenequeue_updatecounters)
    34096   44.287    0.001   44.287    0.001 {method 'write' of
'_io.BufferedWriter' objects}
   298936   43.070    0.000   43.070    0.000 {built-in method _pickle.dumps}
    52656   39.374    0.001  936.397    0.018
/srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2150(execute)
    35787   21.456    0.001   21.456    0.001 {method
'intersection_update' of 'set' objects}
    35783   10.646    0.000   10.646    0.000 {method 'index' of 'list' objects}
   314739    7.954    0.000    8.176    0.000 {built-in method io.open}
 90090452    7.660    0.000    7.660    0.000 {method 'append' of
'list' objects}


There's only appending to list which is still done tens of millions of
times, not sure if that's a concern. The bulk of it is in
build_taskdepdata().

I first noticed the issue when working on python 3.12 upgrade by the
way: this version has a higher amount of breaking changes that has
been typical (this was noticeable already in plain oe-core builds), so
as a courtesy to those taking care of meta-oe I've decided to fix
everything there as well. Which meant adding all meta-oe layers, and
running bitbake -k world with that.

Alex

