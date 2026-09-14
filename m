Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB80C88E6E
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 15:49:38 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.848.1789400968928248214
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 08:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ogl0G/mg;
 spf=pass (domain: gmail.com, ip: 74.125.230.140, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso24980886d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 08:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789400968; cv=none;
        d=google.com; s=arc-20260327;
        b=e6OeyiVavB3ux1AQIm5tEgU36nUnNHZTsypK8xr1SdkxsyodundvHahsFLji5GXNPi
         k7DDDqrcRJkA6HePjPPEvmo5MnnvUzW3y2AiOM/sjR8JBTWlZSpqrRk4WiqUnTa+Wp6X
         eN6WKMyFCxq6JRXNDRrp/DNbcZKD+Ov1fDn71R0yDC8Byf/ZXmA3hxfN5dY0+qQbFymc
         H74eCWidpA53eliJaA/Vpj2pset4ZBLZfI7LkVDkxVlXHpfqjT6gd349zoZv2boFd2pH
         zKXH0aANX9pQkGxlQFv72Bu4G6ALlO811Hg8AxzRQUlr1O2rrmZONoHnweEc+GaXvQ8C
         a3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ddlMFN/lu8YDSg/AyvW4ztIzTDGVBO0eNYlQxXwyPPk=;
        fh=JSodkXak9TFeBmCRo8aJi2y3Tmm6w2abjcL/sSDHoSg=;
        b=fJtUqUYA6CRfImy+m3dlylPgQac7vBQyXUf5edHamwBo2sxzsJMJUUBkMnlLUMOQrt
         l4PqFdSj55FUAfl7CqCdLV4bXqJ7LxFnPqcRDRZCz+wBPPtQeNOwrtLRCGgm5q5t11Dg
         cW/3WnoBmAq4QOTp2pL8Yun1rfZN8YccIKtLTlUnoXuDGcB1hdEOjd8HC4KgGz8287Hw
         lDCxEOZ67S4ZDPJDJi0+2Egod6Hg8jucGmRNMupiZr9mvpCRewyB4VTUag2yi/0k9hMV
         gewU4kZy3/gzs6Zc0bt2DXsuJbinh9g2ZCEE/x1JFtBFMtaqHsy07Q0IvdYsbMlZA5Z+
         ra6w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789400968; x=1790005768; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddlMFN/lu8YDSg/AyvW4ztIzTDGVBO0eNYlQxXwyPPk=;
        b=Ogl0G/mgo1TK4thZKDQqekvZN31cW702duhXjQw6WuuZeYSfoMwdX9vpe1iq1/9Hpx
         p4zpDKDc6m0em6KWgtnLT9TciAD8RydnZ8Q6br2E244PKtgZGvx7xVKAsIvzhSqxub99
         MJxIEUGf3e3ymV7Knx8oz6vXTlajc2DkOezYKixF+cP6Kd+ID8hjhIo7lcSyN4vCMl/6
         kCP3r/qCGV1UHJqL2LT/iGPYBwWeVHBOBPz0xgnvDPTCB47c+DfSn2a6cPYcbtpGsSMO
         cLCy8RIEPiYeE7XjrIpDz3qvJC6305qcCyQFt7YMQvhoBa4kGbP2NUPAzH5u8MwRewU4
         S/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789400968; x=1790005768;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ddlMFN/lu8YDSg/AyvW4ztIzTDGVBO0eNYlQxXwyPPk=;
        b=XpYsSPdCqqsKm1dXYJQmPN8CeTEzspabiGhat1oSm99yuLb/MGWgvgkaGNsJhB82EQ
         kvYr9p9O3KquP6PBlOx8krMBiO8hGzGIsDzrM8ZFBtVy81zZJS5SbgQvvoTr8Ydu32CO
         uIUoX1DZfdBFuMIq9alRBO0eGBBOZH2zrb2dnX1DjArG4dygMooQ/Gl5Ay5XK3bVyxMK
         99NMWRBgG64IbJLzcYttNjCgPWrNOMR663E869E/j3m33+wPnxpubW4PHfylw/CcLXjz
         FFyNF6datZ03ap3uygehd+7nWYStvK/4bYrN3qZC87bpzuXqo6eFQD0fAwmhVHbH0Nc7
         tTHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwE1xJkryzuCHimelXz3IUrU3hgAqOyZoeorWscd/MuD/o7vApwM2/BYA/F13GW63kfRzYeNzjfH4oBZzGd@lists.openembedded.org
X-Gm-Message-State: AFuF++l/KDcoc6pDYEfLL4Mmz93pll+u0C169+kodqUNUDkZVBxV/7dw
	QBXwkedVpabHwK00dNufTcGtG8krjEx4aIczUo6YqVsmZFG26qCAUbB35iCHPDb9N6V0EGl1Tty
	bKxEqw76rfbWgNF6fXgZRFU0VJ3NaWPM=
X-Gm-Gg: AYBFou2ULyFdcqts/VsUL/4oBjBErlJQ6M7OfvQFu+nCivjGBIF0Stfhpb+w29XDe5j
	s94SKX/ZWOh4WvDSi4Awo1xlI6yNhaF6n8DYce4E7ZHzG2s4ctwOrB91oGBfUsieUYX5e3OJ6hT
	vtUIHlvtNcszgDGj31odn+c+4XKYK8bmnYWB/GaSoYm9PAklnopODgiRAwp1mnyJmupwZT07SE4
	tpE6kBaF8anHtZlYypYbFpweHCcZmKEedDkNsNEIM+iAdDNOTklfRaCothazpmPnPEUF8HcbQwt
	4As3VlFmnGivvDod/CA7NK7rgQtK2oJS1OGRZKAVejhAJ89IwoD1HS0dVxNXMnWvMD0231Q3qsK
	WR1LTDfYFr0mDW45xmrEkk7Sz
X-Received: by 2002:a05:6214:2b8a:b0:910:63b6:fc63 with SMTP id
 6a1803df08f44-9122e511ea4mr45111076d6.15.1789400967820; Mon, 14 Sep 2026
 08:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260828162612.753815-1-chris.laplante@agilent.com> <d8eedd54-51b2-4d71-a8c8-4dabe0437c63@cherry.de>
In-Reply-To: <d8eedd54-51b2-4d71-a8c8-4dabe0437c63@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 14 Sep 2026 17:49:16 +0200
X-Gm-Features: AcwNN1WxG9OLL3FeMgYXK6N6nuhcsy2_h8wnCarl09bhaKJ_nTmfuQyyya2y000
Message-ID: <CANNYZj96bFyuvNrTtF+pk8zzn1up98o4MwoB7sRai1GxKV7HsA@mail.gmail.com>
Subject: Re: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
To: quentin.schulz@cherry.de
Cc: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 15:49:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20199

On Mon, 14 Sept 2026 at 17:21, Quentin Schulz via
lists.yoctoproject.org
<quentin.schulz=cherry.de@lists.yoctoproject.org> wrote:
> I see this has merged already but I cannot help but ask "why". You don't
> explain what is the issue with having fetch2 instead of fetch or what
> this is helping with. The only thing I see this changing is adding a
> deprecation warning if you're using bb.fetch2 in a third-party layer,
> and I'm assuming at some point it'll be removed and layers will need to
> adapt or be broken. What's the context? If it works, why "fix" it and
> potentially introduce issues?

Personally I can't stand having those unnecessary numbers. We're stuck
with things like python3, and gstreamer1.0, and it's just eyesore and
extra characters to type for no good reason. That's why I always
resist introducing those version appendages, not always successfully
unfortunately.

Alex

