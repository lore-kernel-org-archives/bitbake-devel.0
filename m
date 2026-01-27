Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698DD2D8F6
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:44:18 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7673.1769510651315253642
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:44:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Miw++UWU;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-503347dea84so192101cf.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 02:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510650; cv=none;
        d=google.com; s=arc-20240605;
        b=RmlxwasTQfMzhdi4XhsdOjxQUhZlL8ThkQkXqcoHOCQ54RWelnnw4TpnaTyyK0+ihp
         8eLTmH8VcKk8lWKHWJ5eRb8sj9QgUGHwdcfxsEjpX8aGBk2QJSTtckUTN2zh9LNQzgx4
         y3AQws8XyG6URyilF0SVBEm/8WS6c3nE/fSpjA6LotAoPchufA9Q1FqfOHShclgM0UtW
         1jCj0MxiPBKOiTnU85TW/DOJbaEkFqhUbmkQA03w84Kz5+PIrM2v+DqRRnAm9wD+lDHT
         SBvjL1g+/75e8MVGJz60ko9aYZScoigB7ACvlPoOkeodlg1myG5W+euSkHKwgP/TbhvT
         mDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O1dRrqSjAfpuALSlYBmNstyRYp69oeSQCakXU844s4M=;
        fh=fgeOaIk/qQG7/UHDHYidsJY0ruIp9MeIKtSfkGgxb/U=;
        b=YpnMT98eWFdP6AW+Nrzl/yV1kRtJFhDwwaFpok5xo0eZVRTwNhw+uzgKbmhywwuPSC
         ky5tjfPkiXfzKf0KmEnKxwMPoxDes/7w/t7VGILoO1t+5QnJ0U8rQ1vze05+CSF2/bHW
         Hn2lO77ccCEnZhm6bV2uypWOc6zyiBwd80zogjrP1sZDyZ5vq0bl4475qCyT1keoclZ9
         HuJ85VkO46aRyZhgluGx3zGdyebbXnEi+Rk2mJfCGJRwD28ftzO4vdtK31S9kf8aPqjj
         Tpj1QET+4HSjmqHEseFOdVYfwITcY4RMDxPQpteoJyiMkdshH25kOYpJVNif72+4Ntml
         57PA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510650; x=1770115450; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O1dRrqSjAfpuALSlYBmNstyRYp69oeSQCakXU844s4M=;
        b=Miw++UWUpw17lBVV0C9xZqgapBNSA4M9wEBrciWXbjbdDxFKxLYsYVlLG4r4BZhL6P
         cJ66myyZFdieaYfStGbGj1WeZIGubkybFbKjhMUiZY71tQNR0sP3daGKCknVYVLktFsf
         O2bL7dZ5jHRD1/YS17ugJbe56Bli68aYrMQzgIy3ZiYVrYlt8f0i5tR7PcyVxGNWdShW
         +Nne73mM+GB0cMoJyEifMPyECfAG/U6JaHMpNMfuu05Yaw25fd1toc1Xwq1tF9fhgybT
         p+q64bbA2lXtLDnrH4GoGtLw+ptiXqEnwRl3RfJ6A3s00XZOOaK7twMk0SkNzqurSBIO
         emMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510650; x=1770115450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1dRrqSjAfpuALSlYBmNstyRYp69oeSQCakXU844s4M=;
        b=woOz/h3DvAW76uKcjz+MumqLlHhH9p1q9uylRN8xJMvnYi++CF4mtB6MX5iaeiUs5x
         Fz7VufD2NiJcF0tvaaNQSaGbqnkfXEy5s5HPXPVQVyGjpq+f7AdoEUt2nLxrJ2tmwM7d
         jTiHG4SVSiC9SjXw+EN7v7NDcXm1D8I/eQsuyoCJk3eRHPk8isEsYO6rN68paMQgWMj5
         IyvBtDbo/4puvrrNPgtLWrZn0ZMRoOhN3w73AzrxGBu+gEF4l3nAYyA7v26Si9lqvaPi
         2x4LeamktYb/yZpl2tFnxNnWbYkiW6iDK3EIi91ZO9mYQZytzItrNWY/ZXE8TdRfPKD/
         o4+w==
X-Forwarded-Encrypted: i=1; AJvYcCXn9INNHyXshBapugrUy+3OBL7OOvZE2QtjQ09JhGzVLcIHzJ8Bv79PcEOg0k6MeRe6QqEO1IB87OAk6R7J@lists.openembedded.org
X-Gm-Message-State: AOJu0YyE8WHH7cdLcTIG763a4KdG6YB6nUtT3kmxXRcasQmdOrs6OMVU
	cZGztDICr2lhRXS1lUepg/dvjGKc6Vu5AHTlx0sOeOkGWD3+kvZYKtJzx7Ua30sYU18zuPR2kuo
	uFq8RzstSU3vYNhdJwJG8h2kou2LvhyU=
X-Gm-Gg: AZuq6aKClD5FzooSQVExt+qOYxocXOy0XVTA7Gt7439H6YjF74fjYGM3C06P6vueIYf
	6crLYdSc17Re+YcOXsGHVLi5Q2ly8qxK++J9wEip4wCJ+pK/m39LHcdYkZJyOWHiN1OcwE2V5Xe
	caexVdlsvrZxaYqQKsbzmFfSPWCefC+XFqG2tHcmqZbWH+Pxt8siOe7oXOaPZ1scM2OCY47DW/I
	juYs5vz/q2Z8vrC45/wRgWFHH3gJNNq6SXmgs4Sx/W1RJdxwcSHTdrFpPt9yMnTQO8VfXfOFHr/
	cfy7jhsm939TL86l/3eEWNbx8z7LiUbvLLla3WBo
X-Received: by 2002:ac8:5f52:0:b0:502:f7d2:23f9 with SMTP id
 d75a77b69052e-5032fc19eb2mr10597301cf.83.1769510650394; Tue, 27 Jan 2026
 02:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-3-daiane.angolini@foundries.io> <DFZAUOEWOS1H.14T46F1J7RX3A@bootlin.com>
In-Reply-To: <DFZAUOEWOS1H.14T46F1J7RX3A@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 11:43:59 +0100
X-Gm-Features: AZwV_Qi7AwNMO2JU4xfOIC3doHvf-w38HfMZCMiXEpdPDu-IHFgQZfTmeoPS-Mk
Message-ID: <CANNYZj8-_0eiZpzYqH3Rw-kzjoB5jd873coJ-saO5hkDNwUCKw@mail.gmail.com>
Subject: Re: [docs][PATCH 3/5] docs: Fix leading text for bitbake-setup init
To: antonin.godard@bootlin.com
Cc: daiane.angolini@foundries.io, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:44:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18884

On Tue, 27 Jan 2026 at 11:29, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> > -#. With the default choices, the ``bitbake-setup init`` command creates the
> > +#. One example of ``bitbake-setup init`` possible command creates the
> >     following files and directories::

"One example of 'bitbake-setup init' possible command creates ...' is
very clumsy.

Better:
Here is a example of a directory/file tree structure created by
'bitbake-setup init'

Alex

