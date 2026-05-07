Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10D5CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 10:52:17 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8940.1778151129621303438
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 03:52:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gX8DKueO;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899d6b7b073so6144206d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 03:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778151129; cv=none;
        d=google.com; s=arc-20240605;
        b=HHNeb1MtSkaP92fHonEUqGVIn7tu0mHqlMa47rFr+LQ/91YxYOx5pbENGczZV7G/99
         ZWIusADSsaPMwbW5kPjBHVtCpEutwhf25ceM3hGWYYwqw5iwpqS4KuPEu9wk1ixqcc38
         FVlCChNdF68qDw0O3ZCwX8qFJQU+xtutDlh0aOSYCWMD7wT/2Qorm+5DpwC3JfxD8shL
         7M9jtM842uj4mifPY+2NXJK3tfs8AXuK/+9XoS0WNNUlo4oka98Do6TuvUEbyYv2stTk
         8fUzqV41uzmQPJslxZVDel57OQMMkLZ5vwp4paw0jV8Xaqu7sO0jhmfXzCIda1YwxFCl
         SYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oPTaAKyagcz3jDQM+9BKN2BuQ37TCo9PRxmptHL5Ur8=;
        fh=dgzQfTLjzSgWVmQrNoc/yMagAB/pjHol9ZsAWrRYMX0=;
        b=MKgNrH6lIMA5gXswsKLUXjVS1snCExHULzkh2DLNrbozr6JFtX+ifn3uYkz74J0DtW
         xJ+LcGSckpQqMXLNBz41m9KQ0w1thsC5ONthsd6RqYnbfzf71fvweE31e/3DUcJbKSwt
         ybjfcr4VEpTMOg/3kAV9LosvKhQ5xPtCO9O4iqm1EGGFvHMVdH3RqQRjCS3lPwCR1brQ
         HkCl4i1vXD1eenMEIKEZ8ewhLO7ip8vYlxmtf6zsTYsAj9JuwOkgVrBC+1FTsqJCHLXO
         qUBnSuMaHfaBOZEh7FP5PJPVvWtOPZ9/I5PedH48HKCqpVpPw6WgW9HRXbtktetDhaB2
         BY8w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151129; x=1778755929; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oPTaAKyagcz3jDQM+9BKN2BuQ37TCo9PRxmptHL5Ur8=;
        b=gX8DKueOGB4bllycCvXTW+F3DyAV6CM5wOVvG0ZHshd8sSdSG6bke6LeiNILyQIboS
         QgAqWP/kUEoV1jCEGJF/T3yqCU6rgTn4d8o+1ygr99g7KF2P7HCadHDNohHHtS9FjXuC
         SyiWjhATqk8zzkGTHJQhD4L40rCb5oxZtNJ8RQv41oVFrDCba1xmIRnvjCwpmtfC1Mo6
         PftdB1Ev6Qcc1YAjHXBDSQ4kZ4fPLb15l1wG0qz6sx6INJuQ76x61RUg42LhweKTeiVo
         1xSOzQEsdqebXDtp9Uyu9sBZwxKBieNlUa4z8JBjIoz1dbkqfy1v8pjmdC3uuRsPXvU1
         uV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151129; x=1778755929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPTaAKyagcz3jDQM+9BKN2BuQ37TCo9PRxmptHL5Ur8=;
        b=irNk5EQUrKgbrriXc/zXh6wrykREMJRxChc/b7VzaTMhgy/q85eaXcGOQxJP5RUsWN
         /Dzd5S/0QwxeHBCRm8qNS/w2UECr7cQFQyY8kLVp7YAPDA2scoWEXn1LUWV8pwI5Tclb
         X9jlhAiuWQKuBOhzGqBJXmIHGcRzq/YkG/fGDL3I0GXXveg6tK6l2S0v277Gw6GN49kE
         j77btqFqaMuigXya0eKUnOhAT7XvM/0lZnG+hZl30FiQ3IzNMxsFa5XiuQ+BWZM5EUPS
         6MDy7ReYbrE7HqwwI37LC2yNX4uIFYJd35rm52j9Ba3TARBwdeOjMU7gQbxIXhb1I/0i
         M1Pw==
X-Gm-Message-State: AOJu0YwXnvtrucjDDzXC2ojXn9Jted3q1RzLYhMvMKotcyvvKUxpZvBa
	mrc/rhqYbyQKH46ienbVVl856AbBsMmy5UCje4DPrRDGD46tvniSRLv5Ka+QyY98P+2zqYNQQK/
	gzMrc3HwjtJuZNCOJBuqV0Y4BdjENrlgZpcwy
X-Gm-Gg: AeBDiesXo1lksumCb+xeM7YJNKvcYm9G2L4tFU5sewECk4X7FyXh61I8FrU/bj++SH8
	XJ+sS4bSKKzmVta8XxLIyecZRAePNNXT8RHxU6/XFb3TB3JgoklGIu4NwKxvZQHoUfYU/Q1YliA
	6Yb4hSbvbHpcmCJt6+t3S4bLEyi6rb5oeyyZeyPem7JNVqX6ungJ6XR5GY+SjE52kikiDrBvTm3
	LlRAOQDJ1hu5z3Gt4T775pe6rum+BO4NPcpu/3mtaRq87vqJ9iNMAhg7js1p1FEFKBBdI2diNQW
	wPKZPodK+69/SEYNT1tKHQUa9xs+xg4smIH6dN0JCf4sAzXJb21M
X-Received: by 2002:a05:6214:5008:b0:8bd:59a6:41f4 with SMTP id
 6a1803df08f44-8bd59a64732mr58087396d6.9.1778151128596; Thu, 07 May 2026
 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260507061845.1460893-1-Qi.Chen@windriver.com> <20260507061845.1460893-3-Qi.Chen@windriver.com>
In-Reply-To: <20260507061845.1460893-3-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 7 May 2026 12:51:57 +0200
X-Gm-Features: AVHnY4LjQCP3pMN8PnS4-7DcclCBErEALI1Q1N1iau3hq2bY0LF-1q-ZFt7utGg
Message-ID: <CANNYZj_=Zo78eVodPtrAuRtkNyb1sMkmVjxf-VA43fpPBYFRRA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V2 3/5] fetch2/crate.py: add filter_regex
 parameter to latest_versionstring
To: Qi.Chen@windriver.com
Cc: bitbake-devel@lists.openembedded.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 10:52:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19457

On Thu, 7 May 2026 at 08:19, <Qi.Chen@windriver.com> wrote:
>          versions = [(0, i["num"], "") for i in json_data["versions"]]
> +        if filter_regex
> +            filtered_versions = []
> +            for v in versions:
> +                if re.match(filter_regex, v[1]):
> +                    filtered_versions.append(v)
> +            versions = filtered_versions

This could also use list comprehension:

if filter_regex:
    versions = [v for v in versions if re.match(filter_regex, v[1])]

You can even form the list with a single statement by setting the
condition like this:

... if not filter_regex or re.match...

but doing list comprehension twice is perhaps more clear.

Alex

