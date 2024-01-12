Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0280C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 12:13:43 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.5634.1705061618007088353
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 04:13:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NV6KjvoM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so5666014f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 04:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705061616; x=1705666416; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlwSxZFZlb1ukhYeOk6vWmv3npBW5FlaUPVfT/btBE0=;
        b=NV6KjvoM68/RoTzahP6BLjQs1DciNxwy7Po9ZcdGJMyF0j9laSBiFbAIgcNqfluxkO
         bUv2HYQ2tcyQ284/HdacabFgCtO15tRBWnZhlfiPWl970y7qCcX4m1PLy7pXlcZVzOlz
         eixOKzXv8woc0q5df837MldqYaYpC9hjHs5Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705061616; x=1705666416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlwSxZFZlb1ukhYeOk6vWmv3npBW5FlaUPVfT/btBE0=;
        b=LISVS2ErkT1e5kDyfEVdNhXjnB1n5msnXYkpxR6GrzzI8t+fhHKrx7u+WzkLGuatZi
         OszuXgFk3Rd9JKsVC461ofRxEJZ5g4g181FAZ1KWuNqJAnIHlp8akD/jcYhrGss8Ywnc
         lUstDF9eQ9eZHa8b9k3DKtOhOx3rfFgBeqcnPFC0STZiCh0jC/NiE52J/q7lSyeuHDJA
         EBaKNjVUuAJ+MpaEfc/VoZrXirJe/HzRzXI1nsKxU8NSpef5VGBSGpuZ1YGS8wJZPkq4
         RGVXWOj7koxY0RjToCYD097RWRek2hPAtpnuNCQ0DJPImm/VsD6N87BT0Y/15Gxk1bhZ
         hCng==
X-Gm-Message-State: AOJu0Yyc50tDJqg2kFOwSKNlccevcwsQ9ZN+4aAFn6YVWkiwt4HErVni
	u+Go3QnxO5a1S3DvzrXf1a9N06aXkttqBw==
X-Google-Smtp-Source: AGHT+IGOBU47xR/6jG/Yu6F7pDVGbmwW2mi/5oydZQ4TiQaekG9qRW3044qqEKtNe+gn/O+cXO0ErQ==
X-Received: by 2002:a05:600c:4487:b0:40e:5a7f:dde with SMTP id e7-20020a05600c448700b0040e5a7f0ddemr349823wmo.259.1705061616062;
        Fri, 12 Jan 2024 04:13:36 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:54d1:179:7c44:2de? ([2001:8b0:aba:5f3c:54d1:179:7c44:2de])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm5664295wmo.40.2024.01.12.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:13:35 -0800 (PST)
Message-ID: <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] regression of 'world' performance?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 12 Jan 2024 12:13:34 +0000
In-Reply-To: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
References: 
	<CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 12:13:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15786

On Fri, 2024-01-12 at 11:57 +0100, Alexander Kanavin wrote:
> there seems to be a noticeable slowdown in bitbake doing world builds,
> particularly when layers in meta-oe are added to it. I've locally
> observed Cooker process spinning at 100% while no or few tasks get
> executed, apparently deciding what to do next, and it is noticeable in
> autobuilder too, e.g. right now:
> https://autobuilder.yoctoproject.org/typhoon/#/builders/88/builds/3515
>=20
> I'd like to profile what is happening, but not sure where to start. Sugge=
stions?

I've noticed a few slow builds too but I'm not convinced it is bitbake.

We observed a qemuarm-oecore build take 19 hours and of that,
nativesdk-gcc (for i686) took 6 hours.

It is likely that something else on the machine (maybe in another
build) is probably taking up much of the CPU capacity, e.g. rust
building or something.

The reason I mention the nativesdk-gcc above is that at the point that
is executed, bitbake is pretty much out the equation, it is just
processing logs. Whilst it is possible bitbake is slowing it down, I
find that unlikely and there is probably some other factor at play.

It is worth noting that there is only one build currently running on
alma9-ty-1 where the above build is and there are quite often multiple
tasks completing each second when it updates.

So nothing specific I can suggest but just my observations/thoughts.

You could pull the event log json file from the build and "replay" it
with some new viewer tool to see if there is any specific delay
involved between task executions. The events should be in there to
allow that.

Cheers,

Richard

