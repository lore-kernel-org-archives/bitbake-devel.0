Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A208C4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 23:02:22 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.58424.1701903735786110532
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 15:02:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KCE15rgN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c19467a63so3777665e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 15:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701903731; x=1702508531; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMFeCT/5c3dJOTngXRl93lB/5Lto3LYmR6c8ftzDUXA=;
        b=KCE15rgNJxRfBYFLE+Uw3mJiZOb1tcuLWhyLEE5hda2wLc0JiC8ZQB2MKxm4z2ftun
         XpWyfC7Z/J/zM11JZzkSf5TvrFCGQXj1cN/fbwcDMCOBGyl4YKARjReiOhWUFkqTfG4+
         tFFvTxDq2zsCGfW1IUtI+1QIkEr2Abkf9qTmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903731; x=1702508531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMFeCT/5c3dJOTngXRl93lB/5Lto3LYmR6c8ftzDUXA=;
        b=IaUUWJREu89Yj77d8bjFYbkm85VEvlwjejmyED3K2xbkZIlAlTc8SulTjfe1+j/7fY
         rMj4QQ2xOSNsCdyv3ppPk2q9yNJtnpwa3ZN/UdeWhVdoeZkogTxuJWGiSyfGCcSTViY/
         8SJ3s1aGaj6vZUq3n/eoQ5uvHr9MflgGL30SxQhi4KzXQGYD9+5ldOFf1lI+9a7ecfE1
         /2FLOb9fqlgZF0GuS0ZfDNHe/elLgEXjdj9U6olkf24BI74rPYwI2ltxCyox72vlvotu
         qIoZgalXBKFm+0Dar7d0JL6hj5LwO3zibJjN81JGOQzujIWjCo9Hm9rjwycIVpjC5iGi
         1wqQ==
X-Gm-Message-State: AOJu0YwiI666cqbuW+7z/XYfP2Vd7QmNip3EQAhIbpJJLgoPQBcbyQkG
	YbYyYhknL8HKy8BydC+7enQkBw==
X-Google-Smtp-Source: AGHT+IGO5RL9x/DwFg895dYRxr3Qp0/pqyf37KYT+7B8qNlpASRfYUtTTSg3MOgAVR5Wolrzef/DbQ==
X-Received: by 2002:a05:600c:1c8f:b0:40b:5e59:e9fc with SMTP id k15-20020a05600c1c8f00b0040b5e59e9fcmr896788wms.155.1701903730982;
        Wed, 06 Dec 2023 15:02:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:30b4:b44a:2cc6:3876? ([2001:8b0:aba:5f3c:30b4:b44a:2cc6:3876])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b004083729fc14sm1066640wmq.20.2023.12.06.15.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:02:10 -0800 (PST)
Message-ID: <9e1be8c6a333fcbb50b7e6fdfab98094a341e025.camel@linuxfoundation.org>
Subject: Re: [toaster][PATCHv3 3/3] toaster: Update eventreplay
 functionality for new eventlog file structure
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Date: Wed, 06 Dec 2023 23:02:09 +0000
In-Reply-To: <20231206224305.34686-4-marlon.rodriguez-garcia@savoirfairelinux.com>
References: 
	<20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
	 <20231206224305.34686-4-marlon.rodriguez-garcia@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 23:02:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15627

On Wed, 2023-12-06 at 17:43 -0500, Marlon Rodriguez Garcia wrote:
> Added class EventPlayer to list of libraries under bitbake/bb/ui/
> Update file read functionality to match new eventlog format
>=20
> Exclude listing of files that don't contain the allvariables definitions =
used to replay builds
> This part of the feature should be revisited. Over a long period of time,=
 the BB_DEFAULT_EVENTLOG
> will exponentially increase the size of the log file and cause bottleneck=
s when importing.
>=20
> Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
> ---
>  lib/bb/ui/eventreplay.py        |  85 +++++++++++++++++++++
>  lib/toaster/toastergui/views.py | 131 ++++++++++++--------------------
>  2 files changed, 132 insertions(+), 84 deletions(-)
>  create mode 100644 lib/bb/ui/eventreplay.py

Our patches overlapped!

I've merged a patch to fix toaster-eventreplay and it is slightly
different to the code below. The major tweaks are handling a second
'allvariables' entry and adding a eventfile.seek(0) to reset the stream
before calling the player.

We should probably have a standalone patch moving that code from
toaster-eventreplay to lib/bb/ui/eventreplay.py and making it use it,
when can then be followed by the patch below to have views.py use it as
well?

Cheers,

Richard


