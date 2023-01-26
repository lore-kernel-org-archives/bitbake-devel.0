Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8BC05027
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 16:49:34 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.78829.1674751766808587979
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 08:49:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Xkow7nqF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id b7so2411243wrt.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcX2ma48U7HVmAXlBt5OssRHIzPmImnmjFGKcr6NjLk=;
        b=Xkow7nqF368p97QyTPynkFALXRPJPNhYssbkbPM/VVRNX/xTTbBsiFuoOd0K9glSpf
         OfJ6uBOF5DKOgyzPz9uqxPvAF3w6/TqGZ2WdxvkrSABcNe9gElKE6k8b83md+zxGyZ8p
         jkfw/JUBXK0BvNwiKipMq8+Cy4Tde/Y5HJwr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcX2ma48U7HVmAXlBt5OssRHIzPmImnmjFGKcr6NjLk=;
        b=t+QIDoHVi89yJGUTqIR6jH2mTCwNUYQot/8RUxuWmbnZWCqLELPbPlmAxwHQnr6w8w
         oDL3zMJHOYsP3S8gm7rq5qepS7NDqgZkGieT406htX4NCOUIlkQFpihLIyZUXpjhdBjF
         LD6xyJzE9TAWMgX+G1Kv2cu19a/R1AZ212wM3vkVo3s5gHJ3M0NZnMsCabJj4TRydN+H
         FQYuqsaZaokZPtMZgEeUG6RBMzh2lhVLY8q6lgTGGU9eQmoKcmUkS8XHhZLEiKC65DY+
         sc0QCfvuulZsAPiK8QaFUUf0vk7/VFYPNYpWAJ1ES7CPoAuzSwtBwBxcwO4oPOIRxXJ/
         Jw6g==
X-Gm-Message-State: AFqh2kpGFfUD/ZkbwV85Hw53Yhap/pxbCRY2D0g93i6YPBON+JOrx7ep
	VquCG8yWEEjCHmvcSDHkOdo9Nhggvt285/0m
X-Google-Smtp-Source: AMrXdXvkQwKBtMylhjVcOIofZ5UJgfQ2xJ2WKpfc6kBWxXXKLMEu2GfmMZV1koTGLWEfvYjn6IVldA==
X-Received: by 2002:a5d:61c5:0:b0:2bf:9608:57ee with SMTP id q5-20020a5d61c5000000b002bf960857eemr21480543wrv.21.1674751765284;
        Thu, 26 Jan 2023 08:49:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f2d7:e330:f537:35d8? ([2001:8b0:aba:5f3c:f2d7:e330:f537:35d8])
        by smtp.gmail.com with ESMTPSA id r25-20020adfa159000000b00297dcfdc90fsm1802210wrr.24.2023.01.26.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:49:25 -0800 (PST)
Message-ID: <89da9a63ec23872a2f2bb9d0865fe2547e190855.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] knotty/uihelper: use monotonic time to
 report task duration
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Date: Thu, 26 Jan 2023 16:49:24 +0000
In-Reply-To: <20230125084725.2262388-1-michael.opdenacker@bootlin.com>
References: <20230125084725.2262388-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 16:49:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14351

On Wed, 2023-01-25 at 09:47 +0100, Michael Opdenacker via
lists.openembedded.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
> Without this, if the host machine is suspended to RAM,
> BitBake reports a task duration which includes the time
> the system remained suspended, not actually running the task.
>=20
> This is addressed by getting the time from a monotonic
> clock, which ignores time elapsed during suspend.
>=20
> This fixes [YOCTO 15015]
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
> ---
>=20
> Note that while a successful build was obtained with this change,
> it might have side effects in places I didn't foresee (in logs?).

There was some discussion about this in the bugzilla entry. I'm worried
that two different concepts of time inside bitbake is going to end up
causing a lot of confusion for what is a relatively minor issue. As
such I'd prefer not to do this.

Cheers,

Richard



