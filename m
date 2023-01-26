Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69450C54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 08:41:52 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.69475.1674722503957820882
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 00:41:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=k8E+Ajcb;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id cf42so2034186lfb.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 00:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOQwBqA2BA6koEkDvPvvnwciCDbSjRID3//l3kA4AVY=;
        b=k8E+Ajcbln838QRvHZgAeEJYcQKAEbFn2Y2xwkVgV/ywfzq5ogUgpgmXZcwLuHUfeS
         ZSYlw9IKvngr3xDjkThZFpknYv0InveKFn4nZzd5zj6RyjQbuRAVQrAWincOlXAZSv3t
         jidH3iOMFaiJuBctr/dltuLvk+Jf7lKxfag8/DzwGgynb1cKD0GuWUNmUdwwC64wpjHy
         Xn2mGlS1/oBHwfjy/uoyaOhYY24MwzmtNVv5vgqdg5SewHaA4Ar7imDzT7VBU6Rn2V6M
         X1yG/VcoaRbatBBYdDySwUTQzD8zsEWERICWtJiafOjNsw+YUo2sAxac/Rw3ex0AtsUo
         2yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOQwBqA2BA6koEkDvPvvnwciCDbSjRID3//l3kA4AVY=;
        b=Fbgrn39oN5API2HZfYYkyx0toCJrOu4yQrRn74VtKuudjSVWwvawcGN3gajiKSgeMn
         1KBI21nQZoY7GRJzUbvY/wEs6VzIyLnN5LkRnmcH5UMFvjPTAu49uacBysmn945GoRB0
         7CKzPhGIRuZEGnAVENrS/8N7VKaPAlMrYcQsBggKEnt0DqyL8Y39jEvb9fmG9dCvARaF
         2XyoICLd31Bj/VQFNFgGd4Vr7dSyt2UJR9BIKkVn8uKJrgHb6Kk+xxJkn6SU+lOkcv4C
         hOjVva10B2tHp8dObxcFv2G82snSozCK6KMYm0W9whwYIVS1CNfZn8t5JqFQflISWg43
         kJKg==
X-Gm-Message-State: AFqh2koeBfxo2T/PKJq3RU0Ks1PxQ4/FR0U796k6c5cypJT19hk8yolM
	dygI1fDeXEc1sJGjOOMEjALuY8pB2UdYRJmf2TI=
X-Google-Smtp-Source: AMrXdXsng1Zb77nIVdA2bf3I+1KpCSITHeGbcoaMvgtZCh+TsPyqT4kn7Auu9S0sZaZ+gBeU4BjKzW3mi2YmLIvNyWc=
X-Received: by 2002:ac2:48b9:0:b0:4d3:b528:99e8 with SMTP id
 u25-20020ac248b9000000b004d3b52899e8mr4073612lfg.2.1674722502039; Thu, 26 Jan
 2023 00:41:42 -0800 (PST)
MIME-Version: 1.0
References: <Yyvr.1674722117946957577.GL4y@lists.openembedded.org>
In-Reply-To: <Yyvr.1674722117946957577.GL4y@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Jan 2023 09:41:30 +0100
Message-ID: <CANNYZj_ZrA5XzBkDDZa+6QoYYtizQAnu1VAMCZuh1ZVUic6gUg@mail.gmail.com>
Subject: Re: [bitbake-devel] Using bitbake as a native standalone package-manager
To: aw@pionix.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 08:41:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14345

You can certainly do it, but it's not a use case that is supported
through the core layer. You need to make a minimal replacement for
oe-core.

Alex

On Thu, 26 Jan 2023 at 09:35, aw via lists.openembedded.org
<aw=3Dpionix.de@lists.openembedded.org> wrote:
>
> Hi there,
>
> is it possible to use bitbake as a standalone package-manager? Like a rep=
lacement for tools like conan or vcpkg? Imagine having a software, which de=
pends on a few other c/c++ libraries and you want to compile it natively on=
 a host system for the host system (so no cross-compilation). And for some =
of the dependencies (like openssl) you want it to use the host libraries.
> It that possible?
>
> Thanks for this piece of software!
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14344): https://lists.openembedded.org/g/bitbake-deve=
l/message/14344
> Mute This Topic: https://lists.openembedded.org/mt/96539650/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

