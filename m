Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB1DC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:47:12 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.5366.1685965623832336086
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Jun 2023 04:47:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=TUbBl59R;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: michalwsieron@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso6916243a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Jun 2023 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685965622; x=1688557622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bi1fwTYs6UeqnOiae0Z+1tRGBBaTyzr1i7cf3pSlMY=;
        b=TUbBl59RlH2cn5IgzBnyIxeAWbYWy3SzPwe95sO6nP+hGrMxHZIpmtGGP8qTRhvRJf
         11TwyWLJD+OyVbKzUpDUW1juR5vVsYekM/l8VVN9kx7kgRBG381gFNO5flsvT8r8IxJE
         qioiHzJHRoIUYIF0pKbWAjH+qqQ+788vX0mqOEXWxyrbtEe4D7UOsiWFaWHnMDIqzBkb
         F27tfo3pdRDfTIJDPk7l7ptuCARoyMlEAIo0dp/OLRbtRDbJzheVcQSMhzk3mV0jrRVC
         1DMVvVm9PajLDlS3mHYC1V602yqWt1Fc98N+6/cWr8ZMsGv6aHDtGRpH8Nc2inLtB6mc
         FDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965622; x=1688557622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bi1fwTYs6UeqnOiae0Z+1tRGBBaTyzr1i7cf3pSlMY=;
        b=UXODaUrIk/0//6UrfaRMJFivuAjlY/Sd1jNIT2fQADpzILbMlMlbrazYGbKhc4VjT7
         vvEuYYxMa5REfAfVyHn8yqZ1u0mGYcOtjp4w9ry2inmIWPImAE16i/xc/+9O+WOOZJj6
         E+E5T0/xQYKu39Ldw+TTsq+Y9XcdH9dByV4UzpRaKmc6S2yyikHCnFcbV+bR/3Bsg4Qp
         4JW1C4X/811JiXEbLk3MeOYd+tjb2u2G0WxNxB8CPovJ54ofuELcB3vYvTkhS/LIWXn5
         X/+NVrzPWAL1RfsoCHcHprTjE25JdCk7aKFIXZ9ZYHpPcNySnv61CVxWX/q9cP1/7MdI
         Ve7w==
X-Gm-Message-State: AC+VfDxZ9kNHuUfVP6nzjhOcMRFFrGpzmm0kRQWUTHShGLLai1Tq8el7
	CdIgZPAbHOfY+W88RSvRvaI=
X-Google-Smtp-Source: ACHHUZ650Voy3gI5gCP+1K4Vox1p/lie5eIqbTLqaA826ABIAjr/m1Bt97Vf/pOmuZrpJc03GcsNXg==
X-Received: by 2002:aa7:cd50:0:b0:514:9eae:b0a8 with SMTP id v16-20020aa7cd50000000b005149eaeb0a8mr7298388edw.17.1685965621832;
        Mon, 05 Jun 2023 04:47:01 -0700 (PDT)
Received: from elitebook (77-254-244-102.dynamic.inetia.pl. [77.254.244.102])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b00510d110db58sm3806538edx.80.2023.06.05.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:47:01 -0700 (PDT)
Date: Mon, 5 Jun 2023 13:46:55 +0200
From: Michal Sieron <michalwsieron@gmail.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, Alexander Kanavin
 <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org, Mateusz
 Marciniec <mateuszmar2@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
Message-ID: <20230605134655.3b5313d5@elitebook>
In-Reply-To: <ZG9bKB8yLRMKqZYT@nuoska>
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
	<ZG88JxkZkP4z3kR5@nuoska>
	<CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
	<CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
	<CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com>
	<CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com>
	<ZG9bKB8yLRMKqZYT@nuoska>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Jun 2023 11:47:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14830

Hi,

On Thu, 25 May 2023 15:57:12 +0300
Mikko Rapeli <mikko.rapeli@linaro.org> wrote:

> git uses curl, can't we shorten the timeouts or even add retries
> there? Maybe even specific ones for the lfs support?
> 
> I've also seen a lot of problematic artifactory and gerrit instances,
> in addition to maven, npm etc...

I checked this and couldn't find any environment variables that would
control timeout for the whole operation.

The only solution I found (which doesn't require patching/recompiling)
was using previously mentioned timeout command like so:

```
FETCHCMD_git = "git \
    -c core.fsyncobjectfiles=0 \
    -c filter.lfs.clean='/usr/bin/timeout 300 git-lfs clean -- %f' \
    -c filter.lfs.smudge='/usr/bin/timeout 300 git-lfs smudge -- %f' \
    -c filter.lfs.process='/usr/bin/timeout 300 git-lfs filter-process' \
"
```

You can of course put those settings in your gitconfig file instead.

However, this method is not so nice, as when the fetch task ends, and
prints error message from git, we get "fatal: the remote end hung up
unexpectedly", which doesn't really explain what went wrong.

Michal

