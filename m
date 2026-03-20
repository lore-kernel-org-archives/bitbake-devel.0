Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD71099B33
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 18:13:37 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19594.1774030407156143952
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 11:13:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FW/XAEXX;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509101189f4so19097211cf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 11:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030406; cv=none;
        d=google.com; s=arc-20240605;
        b=IxLeAeVIcB/TQLAJaoTNDGiyk4fnGwbXpp+kH0+yHl/0/5dyBPBA2t1nAnVz4TWqVL
         +LfFJIT0+eZH4q2PqigwNEhL3zgBQEfSVqNdxcvErg9pjG7RfxVCNN2mVYuq/1scd1f7
         yR/KGV3risQ5cjkZvDfQUJtVONghkwxOD21g3AVkQOoqdcVXerHRhbsD/u9QoOtEyvdI
         U+PGnF4VNPLQ7ux8WUI02xSkdnSEpxAMYR1KONKSPQVc71X5ySjz8+z4+W3vJwiTgdr3
         n5t20Aq2frnpNlrNLEhA92SD+WZRxh5939PqRKdp0hEWutsJHSeashvp1qzketJdGYfW
         SxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M8JnFfy6Day7i6UV2jazxSui/t+qV/pNPWWSM9scRWA=;
        fh=FTUywbExhvBSMQF7MJYRPM4cQMsl+817iw9grkn41BE=;
        b=W6NadPOZug8BFhDhZRQAaMLL5+8GLmi4fXWomvVvkEJGTCvrTmmIkYtujZ9Xc5bIRm
         3fqu9QYnbyfyPXF9zIDpRn58veJNhcqQqUPnBREHy/s7tXWVSXoRbqe+VbOr81uzSdJJ
         F1Ujcp4NXC8cHeCSdqz0OWrqe6YZ6x16M9pjgVfrUVI4i5aeGuxKEZTdinYyeC9G4Wt4
         AlS+JTNMq9pPskzd179v8RGf1WqvI8euUgbPG2vZtHl5CS/Uz/bPUfE/9EuGsFlwpa3E
         5IuwFF9Xj3ZrDb3jZ+fyHjqhm48WOpm37dsnQ8s2lPVIM10Dvy0vgUZzE+xT9xjHcXzm
         g9KQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030406; x=1774635206; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8JnFfy6Day7i6UV2jazxSui/t+qV/pNPWWSM9scRWA=;
        b=FW/XAEXXr9igvZQ8EIMMWC+ZGsX60+qEkoytzTcgmUsXUXTolqKFxo2hcSlnuaqLCb
         +cIV9Z8e+ht1tcFPqJP4zX5msC7nYAS0EvlpiA8nJtH3JEfnJs/coaz4r8WZSdZsl0xE
         0D75xTiMQ/7EUh/HDQZVKfXHEfLWasY/nlaJukXYeF58Z/f9by/q0jvsPzEXMtjx2lOU
         6oZNR9bWezFvgHf0F7ocH4TWbKRrgElccaqcfClSRBUegm1eGw+dy3rljH/Q2LSE/BcZ
         Yek3tCosjO3TY8VF9yZ4HqPjCF+5yHElNNQs73UBDBGto3x4NDKxzNeDCCVL4et1N8XK
         WH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030406; x=1774635206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8JnFfy6Day7i6UV2jazxSui/t+qV/pNPWWSM9scRWA=;
        b=NOylb2WXpPtFTZayABXOnYj2qTv2TnMq3sMSPr0r2R8HT9QZKeth/CNDLlySbPv462
         2wjZaHDdfhbu8zvE8z/380bg91qTJEc/mi7vn7nT1Ofo8Pc/1uCqrS64YSf4wTdCC0rc
         rnCjGn0FBaihx7uKQWE2te3wTtWU2owBvEQXQFWF7vChqcalhHr/3WxflwIV4JTq/cpv
         AQxr6l3U5dmeeDjojAxDakVFLBMhhTtIHxPUivRgihZD5OoEbbimWeOGJInG4v4AliNj
         b+45FDwri0IRcGkjAU0Ik1GP5T8t9j7mp0rRD6ve8QZIrBklv2a6QQQM6qGHyUZp+u7t
         NiPg==
X-Gm-Message-State: AOJu0YwjlLRrHzu7/HIkxQr4q58R5QyUN0dh5HVFyDcJdo2NP/Lm09H0
	Omd6ma0QeL8bjTUbYOFUAdvQuQALLquCukTPBzVdVYjhFSF1kBrWMheXJkBjXxl/VJx1lwVnc4K
	eXOoXaVbYoxTmnrl9EKTMXB4WImCq6lg=
X-Gm-Gg: ATEYQzzE9H0ndZXItMSKUSds5T8GNsaPEm7Kk0zeRKNyoOanDbFoR5g2UVqMUsiLqBA
	o/ZLWvfo/oz7UJ9/uqcgDMxYfKcMQfGFR6ZZEFIdHt7vsMafrLBXOA6CE49Y5Ir47c/1tjlvkuO
	Iasy2CVJ4M8mxRk3lGPLsdhIrxrTL7T57YX45TZ98/bTV3rvtsvlLRPdZBuXce/eyeRU95Iq88Y
	7WXInc8XIG+grvTcRhlxo1GjEz2G9Ry4XwF4tbLjKX/6n+tfS3pnkYfOBq5jbhTL/SjI+r0+h/V
	m6es/eJ24S/FBg1EGJHCet4Tu8HFq8vl7C5AurxmYw==
X-Received: by 2002:a05:622a:894e:b0:50b:2d05:368 with SMTP id
 d75a77b69052e-50b374b27d9mr46828961cf.42.1774030406168; Fri, 20 Mar 2026
 11:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
In-Reply-To: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 20 Mar 2026 19:13:15 +0100
X-Gm-Features: AaiRm52-oQ-VtgTTJ6bohoSPY7Z0ho7gErKrpeT_q4T78j_DnhOiRJcxkf6fBZA
Message-ID: <CANNYZj8F+B2guCqm9+1ikMMWTkckbJXEYJv8F8zDoKjShawRrA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 0/3] bitbake-setup: config-driven
 local.conf, default target and docs
To: zhangfei.gao@linaro.org
Cc: bitbake-devel@lists.openembedded.org, christopher.obbard@linaro.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 18:13:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19195

On Fri, 20 Mar 2026 at 16:03, Zhangfei Gao via lists.openembedded.org
<zhangfei.gao=linaro.org@lists.openembedded.org> wrote:
> With this RFC, config can define:
> - bb-target = "xxx-image-minimal-sdk"
> - bb-local-conf-header = [
>     "MACHINE ?= \"qemux86-64\"",
>     "DISTRO ?= \"xxx\"",
>     "EXTRA_IMAGECMD:ext4 = \"-O ^metadata_csum,^dir_index\""
>   ]

Hello Zhangfei,

thank you for the contributions, and trying bitbake-setup for
production builds. Let me review this in two parts:

1. bitbbake-setup is explicitly designed such that it never writes any
bitbake configurations statements to local.conf, and its own config
files do not contain them either.  We want to steer people away from
'custom hacks' in local.conf, and have them use it strictly for what
it was intended for: local tweaks to standard build configurations,
for experiments or local development.

To parametrize the standard build configurations we've developed a new
mechanism called fragments, described here:
https://docs.yoctoproject.org/dev/ref-manual/fragments.html

Particularly MACHINE and DISTRO can be set with 'oe-fragments' or
'oe-fragments-one-of' as can be see in standard poky configs:
https://git.openembedded.org/bitbake/tree/default-registry/configurations/poky-master.conf.json

The EXTRA_IMAGECMD settings similarly should go to a fragment file,
that file should go to a layer, and the fragment file must contain a
summary and description of what it does and why. Which is better for
maintainability.

2. I agree that a mechanism to define standard targets would be really
useful. I even had something almost exactly like the one you
implemented in earlier bitbake-setup prototypes. Then I took it out:
bitbake-setup configs are again the wrong place for it, and having a
single, generic target is not flexible enough.

What I'd like to see is ability to have multiple standard targets that
you can give directly to bitbake:
bitbake product-build
bitbake product-test
bitbake product-deploy
etc.

And what they do would be defined directly in bitbake metadata, e.g.
in a distro configuration or in fragments. Syntax could be something
like:
BB_STANDARD_TARGETS = "product-build product-test product-deploy"
BB_STANDARD_TARGET_product-test = "-c testimage some-test-image"

We ran out of time and developer bandwidth to prototype this (let
alone make this work for upcoming LTS), but I think it should be
considered further.

Hope this helps,
Alex

