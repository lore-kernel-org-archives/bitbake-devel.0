Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3079C05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:08:14 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.8519.1676646489377772174
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 07:08:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IK89Z0NP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id r25so2371317wrr.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP0CqqorBx4Q1GKhAJ5wf0tXAWtQXvWvRu2rbr1PioA=;
        b=IK89Z0NPuLHrL76qU4cClrguOv9o0rjT63O09Hit5OA3+adDLoX40oeXt6PJaX1aol
         6phM0cdRQpbbhWWYyuL2YoYu7/LY5K7Hi/CwpWTC4mUlZ9R6tDbRaAl0u3mrWPhVQUSa
         9ScCAzjz3JhHf7j90tHiwwg+WugoVT/rTv+oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RP0CqqorBx4Q1GKhAJ5wf0tXAWtQXvWvRu2rbr1PioA=;
        b=cdIPxGIqCzpkg+sk3BSmEGkxOnT/89ilnV3aiKRCdt2GAZUs8fP+Hb5P8ZgwtAZCu3
         xYXMmdQGDKo8He1TFAJ3Tu7dp3fFE9wAu80a7/H3hvNcHzJJgbQ3yfh3x5sJJUF9SAMF
         utQ+VLspyv0EA1mI1k7/IAZ5WqaPquzBFDeyhSrE7dFIepU6xNgtQxIarEoab1Vpdyvl
         spEoM1wc63VBnPLaA56AvSuJo/dzmCv5hlW+b487q28dC5kvQyhiyv5UpJ5jSZHgF7Ot
         N6VsJ+Ok0BR8odt4CHL0CwxtdxKs4ooLCzI/v77Wx0pPWfyxBSbDRfl82/VdyzrBp32P
         me8A==
X-Gm-Message-State: AO0yUKWDhRpUKZbg9bMDtX7wI0k/pJV4yt2yBm0g8HUWGnaLAysvM1MJ
	cZcOx22X6IPFpR6++gzNiwxzdetlG1O75Crx
X-Google-Smtp-Source: AK7set89rS4Dgi/FEoiDJFKZy9AxDjrO01cRajWN0xlOg8qXiE9tOjGJeVfnTkL5ph/2XSaENo9qDA==
X-Received: by 2002:a05:6000:1864:b0:2c5:4ca3:d56c with SMTP id d4-20020a056000186400b002c54ca3d56cmr5569964wri.0.1676646487868;
        Fri, 17 Feb 2023 07:08:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab? ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b002c558228b6dsm4377426wru.12.2023.02.17.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:08:07 -0800 (PST)
Message-ID: <4abb802d890f3b69e54d2d590c7a2dc613d46c6e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [1.46][PATCH 0/6] Backport multiconfig deferred
 fixes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Fabio.Berton@criticaltechworks.com, bitbake-devel@lists.openembedded.org
Date: Fri, 17 Feb 2023 15:08:06 +0000
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 15:08:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14457

On Wed, 2023-02-15 at 10:43 +0000, Fabio Berton via
lists.openembedded.org wrote:
> This series is a backport to improve multiconfig builds in 1.46 branch. W=
ithout
> these patches, some tasks run more than once for the native recipe, for e=
xample,
> the do_patch task tries to apply the same patch to each machine.  With th=
ese
> patches I can't see any duplicate tasks, and it looks like the task was p=
roperly
> deferred by bitbake.
>=20
> Richard Purdie (6):
>   runqueue: Fix multiconfig deferred task sstate validity caching issue
>   runqueue: Handle deferred task rehashing in multiconfig builds
>   runqueue: Improve multiconfig deferred task issues
>   runqueue: Avoid deadlock avoidance task graph corruption
>   runqueue: Fix issues with multiconfig deferred task deadlock messages
>   runqueue: Ensure deferred tasks are sorted by multiconfig
>=20
>  lib/bb/runqueue.py | 88 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 33 deletions(-)
>=20


For the record, I'm happier fixing this in 1.46 now that we tracked
down that last issue ("Ensure deferred tasks are sorted by
multiconfig") since that was the real bug that was causing a lot of the
problems.

Cheers,

Richard

