Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB58C61D97
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 17:20:21 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.108037.1674840015575485657
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jan 2023 09:20:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F99xOKHx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5881001wmb.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 09:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kPn/M64oC6+DqrE+AVvZyKRz0TNgIgiV2q7b7DC3M74=;
        b=F99xOKHxbB6UJ7QTyTRy4hn3lrtHy82Vi4w8Ga4416HpGQX/KZw4uQmjFpUh6L66AY
         pxbEUd9VQcK57fy6fxAu52+ssVn4QjBqDGbBGamgIWTEzpefg2na+YC+JWR3bagT0SxE
         ibjtFu2mxNSO0h7IJZaG1weO6AfAsCw0RTpqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPn/M64oC6+DqrE+AVvZyKRz0TNgIgiV2q7b7DC3M74=;
        b=gtaMhBPR8TO0HSxa/nYaG9CfjC1TrktwFaN8bL9Ri31g53ySbthPHoOi1bP90rI72T
         /1v/jkGdC8FPCCYFNKWllZPLO6hYTYGTbDkOZlPG38krhuYm2Z1Z+2E7xDhztCq4vVxx
         Eo6doWronpgPSez5v/W6Kk63vvU0h+onIGRZ+Z9JzKjeZtXD4/GBbDVXKX80oqRR4JSy
         V1I37w45yh5l0kYL+14XVZ363uSFjZPOEoHEIDGt2Fi8Ry3jfcSlePbcaGV42Ro9yO69
         Ku8PepC59DFmpeD8TTNJAu8qad1NfiZU/RzCX5Fs0Daawu/8HOpk8Zkw53rMaO2ifQry
         kvsg==
X-Gm-Message-State: AO0yUKVstJCfOU4x/HXC9Se6sTpLba5PY1ypNLjwRU69SXIHG0GiOlYD
	kv4//R6NNQT9m6a9k9n4jZj7Ag==
X-Google-Smtp-Source: AK7set/1VkRpdcVZHNrYrjvZ5xr3Q/jqlnRL7CufoJwiFfvq2m5fxoTXAGnWKNU9ONrIoOekiNxMsg==
X-Received: by 2002:a05:600c:35c4:b0:3dc:4313:fc59 with SMTP id r4-20020a05600c35c400b003dc4313fc59mr1044708wmq.28.1674840013937;
        Fri, 27 Jan 2023 09:20:13 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3876:ca46:43a6:4b49? ([2001:8b0:aba:5f3c:3876:ca46:43a6:4b49])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003dab77aa911sm9751278wms.23.2023.01.27.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:20:13 -0800 (PST)
Message-ID: <45d84a3f5003bb58e14d51bbe4134e6aa46acde6.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] Saving off warnings to a separate file
 with Python structured logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	quentin.schulz@theobroma-systems.com, Joshua Watt <JPEWhacker@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Date: Fri, 27 Jan 2023 17:20:12 +0000
In-Reply-To: <9a0d0e43-2620-9a2f-36e6-008094e9dcb4@bootlin.com>
References: <3c606d49-77d9-d89f-4d8d-96cb0a36f620@gmail.com>
	 <d2858712-723b-bb6a-d1a7-6e2a134ced97@theobroma-systems.com>
	 <5d50798e294101e1135f980e7576fa77a72ba844.camel@linuxfoundation.org>
	 <9a0d0e43-2620-9a2f-36e6-008094e9dcb4@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 17:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14361

On Fri, 2023-01-27 at 18:12 +0100, Michael Opdenacker wrote:
> On 27.01.23 at 14:26, Richard Purdie wrote:
> > On Fri, 2023-01-27 at 14:24 +0100, Quentin Schulz via
> > lists.yoctoproject.org wrote:
> > > Hi Joshua,
> > >=20
> > > This seems to be too valuable information to be lost in the mailing l=
ist
> > > archives. Any chance of having this somewhere in the bitbake/yocto do=
cs?
> > >=20
> > > Cc'ing Michael and the docs mailing list on this.
> > The context was that we discussed this in triage yesterday and said
> > making this public was the first step but then we'd document it in the
> > manuals. Michael was on that call so knows about it! :)
>=20
> Actually, there is already documentation about BB_LOGCONFIG in=20
> https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-use=
r-manual-execution.html#logging.=20
> I'll propose an update taking Joshua's guidelines into account. Let me=
=20
> know if you had something else in mind, and if you see obsolete details=
=20
> on this page.
>=20
> The provided JSON file still seems to work, but it serves a different=20
> purpose.

Thanks, I'd forgotten we'd added that example so that makes sense. I
think we should add the warnings one as well, the link to the python
docs also seems useful and perhaps making it clearer how to use
BB_LOGCONFIG?

Cheers,

Richard


