Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B186910A3D8B
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 12:28:15 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46192.1774528094780596073
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 05:28:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Q5slAjUD;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so7636106d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 05:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528094; cv=none;
        d=google.com; s=arc-20240605;
        b=YC+fpseSzE+fzNou/4hXazbzGjKaHprxSDmYJtjR1+UEHmy1QFIgQfeeK15qhvxmUz
         5fSTA+e1B05Iz2xibxUHejYJCxEXOuITXiEw1vq3dCzNUhMkL4aAKRMX3P3pAojencj5
         UoFbt+907sNOdFyq1oGJzXIHH3zSQ7TxHc1DYJGUw/sR5dNOSv/PEv9QIA1uTpViCHMq
         P7i4ByXh64l07RFgbTnB5WvSosUvHXuSnpPi+QSeMO/+EfwIidIu0/iPXPW5oVlTBWg2
         c6ebLu2+scJ67ertcXt3OBYmWMkqmBuvxmxm6druryr9Qw9/GfT8L7XhNfDKiXCv8VIW
         /zRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bNHO2I7Om1ttNNeaASuKp85+CPaLPUAEZ58EDrcx9hU=;
        fh=GpRIbWmFy44arM9RmXLNopuumLCxi793R0r/a21RpFk=;
        b=jaqooMXCQ0p34B7eFMcVnSfuMFdeiiYB4bTCx1kbqZT+fYXzbcONfV0DrbP5YMyF4I
         lNKoAbtkLsPAFNdH3Ki6ijvJH+Ht4Hn0mQi34ZXIq+3xBUiZDnPP+8hDotL/AFFttrns
         KlglvjB+uR+sXLlQoG4QyITeKbA+sKhEN3Irsl7NaLr2ZhkLyT39uieeYFEE6hozIrFB
         McIO+PHo/AoPgqZsu+Nt1WQKfwpX2pm0ngJtkILPfxsgvqW0zQyn6WRCU1KDr19YFjwf
         vxBdl9rUk7TVSoCvEF89OZNNoExwpxm07ANuEYfR9NtcrMlnwZG24txQ8Lsx5tQOCK+P
         EgkQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774528094; x=1775132894; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNHO2I7Om1ttNNeaASuKp85+CPaLPUAEZ58EDrcx9hU=;
        b=Q5slAjUDHphE0GLk2wPjLz3N8B7znWwbYcYIFQfbeL7Os7JCEAu5u8MNsdYdQtj/dY
         bwzcx5dan9pvdWuHfpXKpS7sVCoD8FV9Fjdls0PSJloxlFYoiozkHpNLTFVgRka5Bv1W
         wFu16cR+00noza1ZXmGV9SnctS4qP4D2+IQLGFzf7NIO2O9Pe8nPgkVsctH1ZHNoSKV4
         obyxbaQWxPxi9tDv7WHHAaxjjr9DFdVanzjQ14OTrTSFoSn+avxYLW4fv86GkEorXgjk
         +jknX0hLJPHL085DeWySQ7Cw1vH/7C+3JWswwv9ooNwRKmu0RVNlj4OEIiXNk2p0FSZx
         UeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528094; x=1775132894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNHO2I7Om1ttNNeaASuKp85+CPaLPUAEZ58EDrcx9hU=;
        b=ERWbtf3GiD+jfA55JZH/NC4LHtJto0nLgdWPPTYRSx13LBiC/cxAWNMmX3sUFW8kTg
         RvEN220TyUN2xYiRKGlhjKpCzxRaGwJEXoJ3mQsI855pIUqf4AZRjlUpiWeV3iNqRr2D
         EZKeZtX/t5eaJ8q27PLGtyUjo51eMKGbqzauTzt579LBeehwjUE+KiEyZgRsYPWKl0FJ
         txzh7j6Dwicl/X3d7cBRRiWnCg7McDGyaqbipeL7sLODzrWmEDAx0ToPNl3a7+mbDAME
         1WiAc8g84WMKZ+yugRzH/cRptI9lJcPnkJUSxl/oPPYg7i9hGxSOSDZ1twPrWeXXuMJh
         w60w==
X-Forwarded-Encrypted: i=1; AJvYcCUE8drkONkQJyrJrf7VhSpjl1rtXpP0lts8rHvO33rofIzRSE5/uhtUB4l464kW+DmWR6RL3+hi9f29jBvN@lists.openembedded.org
X-Gm-Message-State: AOJu0YzXnrSb6QSX1FC6I3a7vlaZiMzhnw6r8eZrG6RzpY2XHAcLV3PH
	BV07TIfCda4BAWHwl0eyNMuc9owqmJ7ELccZ/nrZesrDfEnQlwGWgizsrWRHofE82n4fVnJ5h4D
	TPc+pfwSpEMEfC7g7uuZRIP/V4i/ttRA=
X-Gm-Gg: ATEYQzzPEIwGr8TESxlp1dOrlHElJ6biw3aTckxINuJmZk0iMAg8/vohEumU8WhpDrf
	wHuuciPz8sPvXPlwl7zIjEIcAv+eMBftmJuIfv2I53cwyJeG4RnmVag6+KaiVQZpks7usAo0j/j
	OMsjff51Qfya13tiQ+B+91AkzBK6wCHR4/nyteiUhb6WY1F4/jDhy9MzsGXX8+ZjQ81xUaqUVVm
	D36NJTv7C+CaZC0xCoDa4DaduQLFo1F7fln9tg6dZ/cJ/9bTzPH4BKqvVsjW657OXvWfYdD07AL
	odcTH2JqlaxwIRVQ6T/Iu++DDwLsTG/JDDI1srt6yQ==
X-Received: by 2002:ad4:5bef:0:b0:89a:b94:3cb6 with SMTP id
 6a1803df08f44-89cc492ec67mr120120626d6.1.1774528093662; Thu, 26 Mar 2026
 05:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
 <20260325071342.47272-10-adrian.freihofer@siemens.com> <18A063C3AB1866E1.55659@lists.openembedded.org>
In-Reply-To: <18A063C3AB1866E1.55659@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Mar 2026 13:28:02 +0100
X-Gm-Features: AQROBzDjP5o3nzWyLxpiwsbDmzo2aRC4zal7424ThnLRnLG0lQ28e9V_OyUgWAI
Message-ID: <CANNYZj-WzXmLenRP9CQRYQ2=FSMTGNqsECHz-fZiQKc=UtTOgA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 09/10] bitbake-setup: add
 --rebase-conflicts-strategy to the update command
To: alex.kanavin@gmail.com
Cc: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 12:28:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19237

On Thu, 26 Mar 2026 at 13:25, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> - e.msg += "..." could be replaced with more pythonic e.add_note()

Ah, this is a 3.11 thing. We can't use it yet.

Alex

