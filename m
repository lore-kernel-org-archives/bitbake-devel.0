Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F1D185ED
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 12:28:11 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5308.1767875290776733757
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 04:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LsD6p3MS;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a288811a4so30645076d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 04:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767875290; x=1768480090; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ftIPL7wlXoI6D42fIIzmyuOGq4RshxohAqepoSjtaA=;
        b=LsD6p3MSGQTcstiwWTLEea7DT4kdBYxUGC91rt3rMqypqnlG4K3sOQwPy5ZaqM3346
         OPKCj2CGe1ce/0BhGDMVy2SMoQqZYnXjDM2OhuGPZr+7HtcyUbPHYypXBcLe3svvl0Xz
         x3AYhrbRbODbRq1rz3DiX/ptJnVwJRQKneJXej30ANKv0tEXSkmgUtjhCP+BIV+t7eib
         p/5KFFQ/pAfxmazsseFAsDNZidfk7b73xHmlvCAuHg58z+ltLFQ4J/QJBDPYC3bwN8hM
         xoe3m99wAyi2LADpQF36HZcuvOKvAeZ+Bb9vvCtoOsMmjF4hvF2wMjIyzFPykEGzE4EG
         iNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875290; x=1768480090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ftIPL7wlXoI6D42fIIzmyuOGq4RshxohAqepoSjtaA=;
        b=JUJ/ABkixKqKf72x2dliJC/9SdEcqPNpj95GFFKBcMpMLRgmP9jI9OZmQDb124fAiI
         4H/UxD3sX8BHjy/VaKQ5FUVKpFLW4tCrzGpWBx8BVYdoJEPSkkPoF9nC8l6/JwUK368o
         vivtIFCSUP8WV3UPDVkBtEUniVh3QYsOmlVVBz1G/JAvb7q1uFkrc6hA29biM90gSk6y
         p42OrhGH/9YeHec+kDDJm8e4hjZTIaJ0EjJV9Vh45pX0sT9q3/lcAgVKvNskHi4aZAQN
         kdkAXXyucGUARKexTfaR6Ku9zVKlyF5+K0lvQ5fJDyUmSccuYP8aWgGc1qMeNDrmmOAh
         P8Ng==
X-Gm-Message-State: AOJu0Yxlwb4z5KTWGZp/r4o1e7fefOXFOt4O0qU4IfqRtd7PvIQ+01j9
	bcUCBHELssSW3csWDzeZvjamTfGqxIoRB73IF/9jfeiuEIlPUB5M+vD48GHxb78ht+yKx7LqoFb
	Gaw41f7YOfdsmoYT9vBZvdr6PiyffJP0=
X-Gm-Gg: AY/fxX5EWQyHAm3Nz6Vho8tuhE8qOJpoK7CneI7zFOo/vM7PdCzQmN5UcQj4Pc1QL4G
	P+Y1c/47TqoOgGppkX4Lo1C/t6qNGu8valNHKnyELgBLqc9WyAzr8BOnwHVJwPsp1Kjn4jmqWpP
	OCImQbevnyBLEkUp2HcfTY0/71k2w3uZuOyi16vwdcaqcORRLeFj7F0B2Hng7xajZ/WZWOMGtbI
	xTRLPseqqaPtrz0SAf6eItCDCwJcr8Hzn+28obrtIgFywax0hrEWQFmErsgxeEL2Qyz77yw/Get
	/Nc+8vj8/XXw8Q1fYY0MchJ1+RdO2IPUl/593iMH
X-Google-Smtp-Source: AGHT+IFNAZtsgI+kIs39GUpzSSbmmZ8D6dA5oDRws2ZvNYXnFD2mRDpVExprJW1ZIzIyMpz7u8Mv5F61zVYAwlwc4rg=
X-Received: by 2002:a05:6214:21c7:b0:88f:a4ff:454e with SMTP id
 6a1803df08f44-89084175481mr80582846d6.10.1767875289659; Thu, 08 Jan 2026
 04:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20260108-ignore-bitbake-builds-v1-1-f7a993e9059f@pbarker.dev>
In-Reply-To: <20260108-ignore-bitbake-builds-v1-1-f7a993e9059f@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 8 Jan 2026 13:27:58 +0100
X-Gm-Features: AQt7F2pqpIYLAzJwgVUwi-exy62vmRP4NqQC-L2yoViSwBGgaJhuGD1h0f0gIDA
Message-ID: <CANNYZj9Z4NXfhcRRyjqkX=egw+0EQoUptgrFYXk6a6ZxU+0bQw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] gitignore: Ignore bitbake-builds directory
To: paul@pbarker.dev
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 12:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18709

On Thu, 8 Jan 2026 at 13:23, Paul Barker via lists.openembedded.org
<paul=pbarker.dev@lists.openembedded.org> wrote:
>
> Running `./bin/bitbake-setup init ...` in the bitbake directory with the
> default bitbake-setup configuration creates a bitbake-builds directory.
> Add this to .gitignore so it's not tracked.
>
> Signed-off-by: Paul Barker <paul@pbarker.dev>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index fbf9eb2031c8..8152f617e72b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -3,6 +3,7 @@
>  *~
>  pyshtables.py
>  /doc/manual/html/
> +/bitbake-builds/

Perhaps it should be ignored across the whole bitbake tree?

**/bitbake-builds/

Alex

