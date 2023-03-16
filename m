Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F24C6FD19
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 17:42:42 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.518.1678988553854753911
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 10:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NIj7niTx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id x22so1819518wmj.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678988552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPe7X3gTZEaGz/aH66zPTuc1BNo3Rp7NgU57LzgW6II=;
        b=NIj7niTxX9Nryfv/CVM1lEq2KnHAS6t8tIzWSnLKf6P0nyJ99TqIoz1Ig4a6qU2IP1
         oe8bfE0I/ARbfjtz2r+eTsM5Ddns/P5/BWLYrlbO/OjKqtfGCKRX3fgJapoyCJEJDcHp
         0RuAANHXTDxnMvVnQ+gko0mZqFhqydpH4ZwnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPe7X3gTZEaGz/aH66zPTuc1BNo3Rp7NgU57LzgW6II=;
        b=VrN7nhQ+/bNEIwQB00ORH7WjbArbaM+hexzDjxdjdP2cRj428blIUReClNZqX5V7YC
         k+n6e6gOgP1U3Y5j5Oig0M4r8omSkWWQpBmjnbVBjro3TqNcbyzGe9DIF/EbuoJROhC5
         87ZZQqFjdIVWeMs3zZkUOE283u1/mxd+ZpYpsAseql7JEx+KcDcJklp0pD17EUjwniGk
         3FNSjKypARKgZmxfIqU+U4ELxEPELnizZptewZU98CrW4Zmx88Ksp0GgjfDoAfkxzI6l
         mSsqL88XjIs5Hgg4zzvIbfnl9vaoT0fsPWBEBpuWiQJNdLNnzEgnJ99XId2UjUHTA/XH
         RnvQ==
X-Gm-Message-State: AO0yUKUme+01AOcL5rw5Hz0uSxolVvO3FbERnVxxwg5EXhKFY5veTNwe
	CRK14kdrwSGcxJzSfpc3wlvlPrdizey/rTDJ/18=
X-Google-Smtp-Source: AK7set/EuInATwgHNvGr+93BuEWgNJDjC0gfXUfshBcQv6+9qxIFljksp3X+w61bXHKrYjnvJQK5rQ==
X-Received: by 2002:a05:600c:474c:b0:3ed:355c:4610 with SMTP id w12-20020a05600c474c00b003ed355c4610mr5915418wmo.35.1678988552284;
        Thu, 16 Mar 2023 10:42:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4181:67:6e43:6a9? ([2001:8b0:aba:5f3c:4181:67:6e43:6a9])
        by smtp.gmail.com with ESMTPSA id bh10-20020a05600c3d0a00b003ed23e9e03bsm5623849wmb.46.2023.03.16.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:42:31 -0700 (PDT)
Message-ID: <4a646f8e56f63a29fa11226a7e24037214a8a0ea.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] ConfHandler: Allow the '@' character
 in variable flag names
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: James R T <jamestiotio@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 16 Mar 2023 17:42:31 +0000
In-Reply-To: <20230316165705.58445-1-jamestiotio@gmail.com>
References: <20230316165705.58445-1-jamestiotio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 17:42:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14594

On Fri, 2023-03-17 at 00:57 +0800, James R T wrote:
> This patch enables the usage of the '@' character in variable flag
> names.
>=20
> One use case of variable flags is to assign the network namespaces of
> some systemd services/targets to configure other parts of the build
> process of some system. The filenames of systemd services/targets might
> contain the '@' character if they are template unit files that can take
> in a single parameter/argument and be instanced multiple times, as
> indicated by systemd's official manual page.
>=20
> This patch is successfully verified by creating a custom BitBake recipe
> that sets and unsets the value of a variable flag with the '@' character
> in its name and ensuring that no ParseError is being thrown. A
> regression test has also been added to `bb.parse`.
>=20
> `bin/bitbake-selftest` has also been successfully executed and all tests
> passed.
>=20
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>


I'm torn on this. I can see why some people would like it, equally,
restricting the character set does sometimes make parsing easier and
gives us options in future to extend the syntax.

After some though, I did wonder if we should change things so that the
first character has more restriction and @ is only allowed mid string
as a compromise?

Cheers,

Richard


