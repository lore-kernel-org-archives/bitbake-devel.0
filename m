Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E74C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 12:32:48 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.20911.1702557163381819232
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 04:32:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hKEx90gY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c32df9174so72316105e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 04:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702557162; x=1703161962; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5HfiuxlbKf0Ag2BY9diIKHUkshNr55nv6WRLFiZkSM=;
        b=hKEx90gYC0+pWDyz6KeONLNDkUc0gHpBBS2MmH3I2BZfTX00pg42RRSoUoHne5ehbT
         sPjXLRPkLumvZmN4ZS8p6wCsR8+PwLXFrTPQPJMXLZRkfK1xNLU/QzOt+orock35BfoM
         xbGc0ATSLZDOeJ1zlW92Pkkm0IJdoebk6dkT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557162; x=1703161962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5HfiuxlbKf0Ag2BY9diIKHUkshNr55nv6WRLFiZkSM=;
        b=QpQLFItzT1NI6yrzBsbZNhf5Nj0sQ99TJo4gQNYRaC36sd+R6QL8kJvpSLBTXh1iDA
         qkVWL4lhKoJafLOzsibiXJDjQmSXfU+bsZogP6sSy7e0T4X+Gm6sfFRk0Q2z2Wh6RqT/
         B9tM2vL3hFev9cVbcRP/+1VV6V49gOCK0HIs8SzRPNgutfDB+1681BruyMznce4VMkOh
         wDPv+agkBxzqPrOiFcxpr4KBae03mvMKBLa+sRqsdF50ah7OYB6OKiao1AFiKBWmUWNs
         4A7ddqat4BBkUuOEjwMPLlenftDCv8xREZfQDt9yYgH1Q65ypzefIVDfqFsgQ95NVe96
         Fxsw==
X-Gm-Message-State: AOJu0YwMEBnWDP/bg4i/0JSPfqSTTHhX0v/wsw+kwHOIASbzJfCV3uwS
	8ZH27vbDvPQIYA2MiCy+nDBDYfzdAktDg6PAG/Y=
X-Google-Smtp-Source: AGHT+IHcB/Px131thLK15EUoZG19K6l1LBNshRzgwR/1lc78rDjLbHZ0teroplR/wP3nORQ1Ncng+w==
X-Received: by 2002:a05:600c:524b:b0:40c:4857:e012 with SMTP id fc11-20020a05600c524b00b0040c4857e012mr2152695wmb.85.1702557161783;
        Thu, 14 Dec 2023 04:32:41 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e972:7f32:1182:98d2? ([2001:8b0:aba:5f3c:e972:7f32:1182:98d2])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm24802623wmb.8.2023.12.14.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:32:41 -0800 (PST)
Message-ID: <08612b947964d6b22c8dbe6d3cc7188a1ae4b01d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake.conf remove duplicate
 PERSISTENT_DIR
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Jose Quaresma
	 <jose.quaresma@foundries.io>
Date: Thu, 14 Dec 2023 12:32:40 +0000
In-Reply-To: <CANPvuRntahuGpsSVeFXRWSfna2o=hVuqZ2my_iUrAKeu+sAXLw@mail.gmail.com>
References: <17A012684A72999E.8967@lists.openembedded.org>
	 <CANPvuRntahuGpsSVeFXRWSfna2o=hVuqZ2my_iUrAKeu+sAXLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 12:32:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15667

On Thu, 2023-12-14 at 09:13 +0000, Jose Quaresma wrote:
> Hi,
>=20
> This patch was merged in bitbake master:
>=20
> f88f314c toaster: Commandline build import table improvements
> -> 13cbc987 bitbake.conf remove duplicate PERSISTENT_DIR
> da7f91d6 bitbake: toaster: add functional testing toaster error
> details
>=20
> but I can't see it on poky master:
>=20
> 524255ad26 bitbake: toaster: Commandline build import table
> improvements
> dc608a5bbe bitbake: bitbake: toaster: add functional testing toaster
> error details
> 799c131d92 bitbake: toaster: remove test and update setup to avoid
> rebuilding image
>=20
> Is there a bug somewhere?

That file doesn't exist in poky since historically, two bitbake.conf
files was considered confusing.

https://git.yoctoproject.org/poky-config/tree/combo-layer.conf#n8

Cheers,

Richard

