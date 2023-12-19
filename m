Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D8AC46CCD
	for <webhook@archiver.kernel.org>; Tue, 19 Dec 2023 15:08:50 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.15745.1702998525785647678
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Dec 2023 07:08:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f0/oayLf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c2308faedso55490315e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Dec 2023 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702998524; x=1703603324; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrGG4m3Dvnx0JY0UNFf9rGZL5j9bB7jZMq7ONK062Xg=;
        b=f0/oayLfu47LJKwq0mQsy3tUbdbzMiDDay1Fm+JmtTi+5eJubtkRMY+8ALAJ6ZLWCl
         jXM/AjJtp5zE5QrlgF8ZkUtkxdvhgGSvzQAfodllnWJgowuJfaGhf+CV5CTRHAhsx+yg
         MwTess68e7v2CA0SSyQttka7hw24LrQg0H4Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998524; x=1703603324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrGG4m3Dvnx0JY0UNFf9rGZL5j9bB7jZMq7ONK062Xg=;
        b=G8hap2PZkRgHtpL4WlQ3YS3XxrbA5+GaD3L/F9cF2PNkb2+lZZgWv3CtrHEndtcyWq
         6mYgVJv7vxL+0xLeQctyGXLRi9djEyFAEiDsrpBl8QxZ2fuGsEXXw8tX4ovO9vTH4RoV
         xvqa9LmD+t8dmyEUE6kAV6thYkKQ3877JRETw0EvEhFO7zEkOJbbeIRZNmu7nVpcuKGd
         FCLLBlgFglTSzZyd8h81WsQToF7aXPVXsfxKjsx7kIAO7rPhjsbxkjwY1Mp0O9zdidkr
         K4jL77DAw65MLlbgLB6TLsnc+IFB9gwIBqHY0MofV8JpvWjLgTWIADW56pFa54mQpyQ1
         5ejg==
X-Gm-Message-State: AOJu0YzO/ZMxVJCDYHX5Ad0dIsjCBBkitdvMGIH2s5ZFo7S2VeJfS7Gi
	WF0kCqRyasfdkj02VaFZR0MkGf+Lpc8YKBhNFNk=
X-Google-Smtp-Source: AGHT+IHovMdRA+r3U3QhJmeAtIunw1HANtIKlXs8Y8JfmY6VkbARwoGF7DuMUZqmI1mRA8s8vpqIXg==
X-Received: by 2002:a05:600c:4e44:b0:40d:2b9a:85be with SMTP id e4-20020a05600c4e4400b0040d2b9a85bemr501587wmq.30.1702998524129;
        Tue, 19 Dec 2023 07:08:44 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:b87d:537f:7c6:e419? ([2001:8b0:aba:5f3c:b87d:537f:7c6:e419])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b0040c4c9c52a3sm3237118wmb.12.2023.12.19.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:08:43 -0800 (PST)
Message-ID: <05a7209c1684df4bd5c8e83b27742fdd7ba6c9e4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster/test: Bug-fix
 test_functional_basic, delay driver actions
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 19 Dec 2023 15:08:43 +0000
In-Reply-To: <20231218214122.616407-1-alassane.yattara@savoirfairelinux.com>
References: <20231218214122.616407-1-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Dec 2023 15:08:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15695

On Mon, 2023-12-18 at 22:41 +0100, Alassane Yattara wrote:
> The errors causing faileds on functional_basic are d=C3=BB to the delay b=
etween actions,
> increase between driver actions.
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../tests/functional/test_functional_basic.py | 76 +++++++++----------
>  1 file changed, 38 insertions(+), 38 deletions(-)

Thanks for this. I think it helps but there are still some test
failures after applying it (fewer than before):

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/101/step=
s/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/102/step=
s/12/logs/stdio

Cheers,

Richard

