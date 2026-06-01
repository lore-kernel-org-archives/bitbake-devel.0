Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758FDCD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 13:31:10 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28733.1780320661164919610
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 06:31:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YoxTdx9m;
 spf=pass (domain: gmail.com, ip: 209.85.128.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e1916922b9so15990537b3.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 06:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320660; cv=none;
        d=google.com; s=arc-20240605;
        b=c4UtmNeRDkeDVW4RvIU3FamHmxcnTNLYbedpyQsM+rUa8Fjvq21R1P4bRZVO8UoQot
         srg0QieaSJe/tdPgoSwqxx++4yUWuNbJPld2JK4SmP0mKlAlZtEjUEB+kpTVbstyEm/i
         TFkovDjPcANWSloGGza0YnI4MTt2eNxlCEENn7fHP8eyBI1h9yfmgeTtVeus129zDEVC
         MbRHDpMH42aSDE4a2vH2q+kRnACNYhEFZUurcmXXW+XG/o15aDFEVJfDJmzR7sWeB+O4
         D000OSJfO8WrF69gqe7MtUOw5bnCdtxz1JVC7puymt5KYnglZ1m5gz6CzFAlg5TjQtMu
         Fl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rx0qeAhYPl3GXaFN07BHks95TydvlEkG6uOdr/3uFyQ=;
        fh=Ycj+feykXR5zpu3uQ9TqbI89XB3RYofe7rHcJDyviQY=;
        b=VNsLxh3eie1oOznec0fGhSogJA7Lq/AglOPY+T8/c7kTCK9aSHMCHUK2dceChsMFjZ
         aQCHHvkN1zUDEpz5I2DvMm+91ZvK86LroCmnkP9K1/wVZduBniYFXMH5nxqLYKZY6iis
         E/rRqS+aMYIvul90/yl5Tt00mRXsodlCYJ50gLnV4ZtFdaJbWUQ2dDHutW9wmPiPgjTt
         Vhd5ZG5kmZ0uws0uqPe8tv7wyjAtgfctNiHKFTE8Z7GujDpgywzCucIGq6ZcGt8xJwC+
         0ydWnQiLPkJw04gL7d17oX+Dz4YvXUZvJ3hbuqKH2E8obSG+2/dRcjNwzhHE4KzXoKSl
         524g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780320660; x=1780925460; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx0qeAhYPl3GXaFN07BHks95TydvlEkG6uOdr/3uFyQ=;
        b=YoxTdx9mTU5Q38aZh28bD9T+Yh81kZWMQG6RZvCZeHtoq+5ipVdnD1yS17nuk5cXzQ
         mZPxFU+jiSztP8gZB2lULkH1HgBgqyR32vXlfIjYFuswRHpMS4sbd/HvCr00+H872XTV
         XKgauWFPy5iYCDyjXuhPcPiuQXX1utMubanzaHqs1CgKhhj+sYxLxG3jhwFmBZkYCOsd
         xth/JUDjHYaHNpZKucXK1EyD/j//u0qBBbCfFIOROZnLGtEHCJFFoRp0TB2lDLuVX5Ev
         eIIbuC9HtvHhDIfNolT26jXTXAcukBvJgWdOqBnp+KEecNRvFhUQ4gCP8C8+D/Z/uvbJ
         OKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320660; x=1780925460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx0qeAhYPl3GXaFN07BHks95TydvlEkG6uOdr/3uFyQ=;
        b=EfWA53mlCqK7e2jUXRdPBeNdI2lPzBt+SR6XmbpBEAR1F/lAat+O2W92Fo3zUw+Wiv
         KFpRw7Xzh1qn9JDeSWfs1aJ8sQBK4y8k5O1rNn6KCrTgfbSIB93+uUvmvuHNnHkR0Ov3
         /OvTcQES+nQ1MXSVGleYI/hlOCSH5q8R7OorBimgCk8chXdjjKON7ptWEEJ2cg5aCLpY
         NSKrkLKjN21YlIQptT6433dEh0yEQaHJmAwjMBvLtNVzTcS/sLQGsiR1oo7L7URfDS+4
         T+hkYvuzr9doVmCKpCel1LDhczY6A1jec9OIkc7It1MaCqetsXVGCyIOkQTxf6SgjkIv
         p2Kw==
X-Forwarded-Encrypted: i=1; AFNElJ+/x6SfwpTFov/16g/tpIFw+bcl6yPInd0537M3NSVTVNYPrUivIbTQMLflvRAzxza2a1IOm3IZA/3PP3+F@lists.openembedded.org
X-Gm-Message-State: AOJu0YyQhUUYVxbpMp1SMMBtrjfgtNyvYS/+c1UodOzdqra57HLEMgs3
	PVzw4xuWV/AFizlK5HOgvv/EYQQbxAWK4uF7LvS4v7ne/HciYVra2ZFrtP99mb88YLGTonrxobq
	zTlTgE8fEIBTdYJCZg7zcBSHlRSc3WHIGUA==
X-Gm-Gg: Acq92OEaWDpNwdTECdVJ6YgT+/TzEdW0G5lBB4ZhUCuqofP91KfIiHwxwBBSsjbsk9m
	D3wwURL1Uh82+5mEkjyyVH2WybY8x5VfuCHrKdd3quv6T094LjL6OVG5fYvlIOqLgfXEA+nn4RJ
	RGqAPNffi7HaIlsdV6ycLL+bgUbHkDmEZrbA8wBY3YO624rIdqiEM/vMV3jKQoJ/eYgWMwnzK4m
	3YHxj3hPXSU/PigKEX+7TRBANDtSqSoKVmfj7CJe17t7SQo/rc3iIFRKKdqDlkkh+1rsIQeA5XX
	ywbD8Q8JWPDM8QevyLjgJvECIsRF1tprM/HrVGEMRPvd/Qpe73D4
X-Received: by 2002:a05:690c:4b90:b0:7b3:18ff:1060 with SMTP id
 00721157ae682-7e05c94e1a8mr103934247b3.27.1780320660048; Mon, 01 Jun 2026
 06:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
 <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com> <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
 <3kgay5cukb3dd6ojc7ysbtd5jgglbe7i4shvcksa2wb3kh2zyc@3oegr7dacucw>
In-Reply-To: <3kgay5cukb3dd6ojc7ysbtd5jgglbe7i4shvcksa2wb3kh2zyc@3oegr7dacucw>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 1 Jun 2026 15:30:48 +0200
X-Gm-Features: AVHnY4IMMmf8o6qLHOjplFQAxL3zkVKdEOpRqG2YlKHCwRgcT9ulnNQ3eUTv7Bc
Message-ID: <CANNYZj8+ToTjrpgXMzFfDB5k4Xc637ORzY7LdzW0Kn6fBGs_BA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
To: ernestvanhoecke@gmail.com
Cc: Antonin Godard <antonin.godard@bootlin.com>, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 13:31:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19584

On Mon, 1 Jun 2026 at 14:53, Ernest Van Hoecke via
lists.openembedded.org
<ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:

> Yes, I tested with some newlines explicitly written and this worked fine.
> Since it just comes from a json string and is passed to `f.write()` I
> don't believe any special escaping is necessary, just "\n" is fine.
>
> My understanding is that the Python json library should handle this well
> and converts it to a real newline in the python string.

I need to ask though: how practical and readable is it going to be,
when written into the json? Notes are meant as multiple paragraphs of
text, and it would be good to be able to write them that way, instead
of some specially-formatted single string.

Alex

