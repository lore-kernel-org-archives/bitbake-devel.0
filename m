Return-Path: <andrew.bradford@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DF9CCA464
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 18:24:03 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4303.1792088636406121026
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 11:23:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=r9Br9ETp;
 spf=pass (domain: konsulko.com, ip: 209.85.128.49, mailfrom: andrew.bradford@konsulko.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a061a13884so46806805e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 11:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792088634; cv=none;
        d=google.com; s=arc-20260327;
        b=m1oj/qeBgFlRC7kOOG2KjQCqqFo4OWTwvsehb3kpOqkJiwaTaUcyjr0WIUyr6BSPhJ
         ueDGEOlORd86mn2L+RxXnzt1+cTUkdiRX670qwX48dLL6+qVZrpNOtLKce49eeTWWSmA
         DkJObXtF8lppN7V/+LFEecAdza4tdOWgMzM0ID6OiRJwAIhG24QRvsaK60sG74guyzu8
         Kbazi5KCPeRVzRSBso3jh8lZpPoHk4XEyZg6hcFAlcj9JFd83IvkKYA0yrYhTA4s5M9u
         RDaF4y0KE82cyqu6KkTk0w9OrpvvA/DzlJ2In1gcoR4zSqbV7tAT5TN0KxtTWfSqz2As
         BI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csxERgY9fOGIE4I8hM4yr+avdV887+EhenkBcN1WVA8=;
        fh=faEMGBcBeK2I1g6HcbPag8in7il2o9hwfjPFl47s44o=;
        b=ksCO3va5wFagp7FBSZ0DAVLncWTOLngAYeqWxAzgYcpOOncStnR46WbQgENKWJM0JU
         lCWu54RmzkA8lpSLqJIaemWB82fgfQykoSj8ppAX4tqR5Zhm7JmD1P+BWlG77LpE639D
         Ja+rr5IkBo1V+OmQFssFMDsyqLe3K84Sa0hYEZ1lQD4ybIyx5He8T7uLZ9uEWdmyiuuj
         wRrDBLlAgrsgslA2CI5MXLsTh6Ihb1B+W8/6emVqTr8Ld4vn9OaUiE56wMd0VRWEHdAw
         smn0eSlyGY7/ZoHVQLFDkCHw2/eHEVEqjSDMgVrCuHeOKvBbbq5Vc6znkV+Ta/g7ZEr7
         d2ww==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1792088634; x=1792693434; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csxERgY9fOGIE4I8hM4yr+avdV887+EhenkBcN1WVA8=;
        b=r9Br9ETpLAcQJXYO7+jqnX2KEeIXl47I2gjyFUNXhrQXkRAFef7VctirQjAwywwN/m
         1s3QYnjjYWRe3nR22Cf47gvglXI/4xdXB+/Amrc2ko2EnYPSWTedkY06+9FoxoOA6nfo
         zwmWMi6+i0GFt9JioQrBfoIJn/QvrQH0acttc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792088634; x=1792693434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csxERgY9fOGIE4I8hM4yr+avdV887+EhenkBcN1WVA8=;
        b=SMCv5gaYF8WJoywFSDH36y641JnDt8miayro8iwRUyr5gIU1eTMWWPnBit6RRVwK5K
         02rTdpJUOFGwPF4rY9xt/xC/ygkhLFBJg2ODJnt6BcIwrBtYa8o36Y7rMsb5uMEtMqES
         JI3qosWDbYTBLwcSzIx9bod6kul3hiCtns9vY4DaHwSg7Ie2c+g6VwW83dVzVkQ/I2r1
         vLr0ChTtHWdsk9XmPJ658/JiXozSG4+Cu8ZwCkG4PCFtRPvYgnxvJz9HvRLzl8awdYCN
         VYjNEwvwdQuT523lJs1GNkakC9Xv+WahH5weHFlVGPfHzrPqOp8vMPowzUCCqwtLN8M4
         UydQ==
X-Gm-Message-State: AFq9FYKn0uE0uuMDntPAugH6xwCN+5qZVxS9YP43ZD1avqehA4e+DSd0
	Q95h5sbrA4B6h7oNah+anfsK0EBkoBblcXXuC0RXP4xESKZ0VeanLbJX2+FxmHe5ahoatCf0GFC
	Wlqdc/EisRwVjm82KnZP3fGtnygD6qoXKJLB6BepkJw==
X-Gm-Gg: AYBFou2iEfuLRHU52JYhHQ3LhXNYlTrSQRpYTeKJSOGuxV8sMVseKkbkUGN7jVu3Prw
	cJLvdT2LXMzjVcmqwUxzdZxnW1ClmTTUdDJrgDsANuFr+xYdziaCYWh2+DCZKOu1VMOVnMHREQL
	NYNvuv5ncVOXQopK0BJCkeoqLQW9CVj/VzeNIM/0D5ojqf3V0qltA30Lx5jv4V4zLFx4aQCxUC8
	sa7jCqZUKvA7A/4uLZcvDqRwsGnBkRL0Uo1QYy+sdJsQhirKFOK1pGiukgbDpbgqZJ8gQ4A5UI+
	DzuqsostRB+7FClXYbgmlOyWg9L3c/hTx5qZvw4bDJq1O1P+qQppzbih
X-Received: by 2002:a05:600c:8b64:b0:4a1:7703:e537 with SMTP id
 5b1f17b1804b1-4a18e49302emr406792435e9.10.1792088634403; Thu, 15 Oct 2026
 11:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260930194306.8490-1-eng.redamaher@gmail.com>
In-Reply-To: <20260930194306.8490-1-eng.redamaher@gmail.com>
From: Andrew Bradford <andrew.bradford@konsulko.com>
Date: Thu, 15 Oct 2026 14:23:37 -0400
X-Gm-Features: AclHuK-87jnX684aE_nP-vtizu9Ztu4HuW_ITISLLKJtwgCddUl7FPO8iffuG7c
Message-ID: <CAJ41yg=SkwmYneGu75PhoibqLTu3axwNpCn2eAcr+brGwPYmBw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] server/process: Fix lock owner prefix
 check during shutdown
To: eng.redamaher@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 18:24:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20349

Hi Reda,

On Wed, Sep 30, 2026 at 3:43=E2=80=AFPM Reda Maher via lists.openembedded.o=
rg
<eng.redamaher=3Dgmail.com@lists.openembedded.org> wrote:

> Pass a tuple to str.startswith() when checking a contended lock during sh=
utdown. The list raises TypeError before the server can retry its own lock =
or recognize a replacement server.

<snip>

> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index d0f73590c..a103b0987 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -377,7 +377,7 @@ class ProcessServer():
>                  lock =3D bb.utils.lockfile(lockfile, shared=3DFalse, ret=
ry=3DFalse, block=3DFalse)
>                  if not lock:
>                      newlockcontents =3D get_lock_contents(lockfile)
> -                    if not newlockcontents[0].startswith([f"{os.getpid()=
}\n", f"{os.getpid()} "]):
> +                    if not newlockcontents[0].startswith((f"{os.getpid()=
}\n", f"{os.getpid()} ")):
>                          # A new server was started, the lockfile content=
s changed, we can exit
>                          serverlog("Lockfile now contains different conte=
nts, exiting: " + str(newlockcontents))
>                          return

Would it also be worth handling the situation where the lockfile is
missing or empty, here?  By checking `if not newlockcontents` itself,
too?

I think there may be edge cases where the lock is gone or empty and at
exit this will also throw the traceback instead of a clean exit.  When
using the profiler this can induce a loss of some profiling data as
the profiler appears to only write out its data on a clean exit.

If you add handling the missing/empty lockfile check, it may also be
good to add such tests to your testing implementation.

Thanks,
Andrew

