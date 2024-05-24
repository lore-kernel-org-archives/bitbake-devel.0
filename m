Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20279C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:00:02 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.17988.1716562793588614033
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 07:59:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hkXDUJ1P;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52961b77655so1058583e87.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716562792; x=1717167592; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Er/Mhsp2SB6T7OPeWDLSUacCE3zR1zohK4z/OgY1YcE=;
        b=hkXDUJ1P7QcICdALvESw9csFsv6SlHMdVbQxns+RMELtduXuCbgA+KjMmtnbm60L2S
         Q2xfgeHTc0yPVLqhXAakJwXw8XWXCLViZ/CTBoMp3nh1MaaX/L1NMTD0GX1tCsZGiVu9
         vqz63riw0HVfHnyfR6OoPZMomUA0wxdYPrcvfnGgNVy/4r0tyz/AzOvj0OFstvHWBRo9
         FVIipdgXAlGuaJqs2M13383nvke8fdO+X0MwAOMFcp1g2xJzgg/gA84xUoLBnZymccwm
         CFQ1TteW3VDeV8v+7ynpKyGMpsj8eqvR6lFU5GzugTJJvC2TXARDr/zQnVBG6r+5A9Xe
         eZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562792; x=1717167592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er/Mhsp2SB6T7OPeWDLSUacCE3zR1zohK4z/OgY1YcE=;
        b=rVpfJUfxA0+WuvlkqjH+SW5MqPoCiLbVNOpNVe+gaYqv4cF0qBLgLRuvs5p51JxTwa
         Mvpp+yMwyXGr10RU4YHngjpWGNGEvKD5Jme1XqDcJv0+ubXiddawt2miKoajwaeu0FLO
         k6ZN7wRonRpIBlLKVe9n/VOUvDZJa6KiY55GqKEWRq+Cvz+TeNlBAqjzTX6pHtlZuzj7
         oLT3pdV5wDt2EC2Z21EZAGM19tyiztCOcynugn1q44Bdg+R5tyH0Qena/4DDrLlLwfmg
         QzVvwbmSJMsaCXwzI1ZRXTbWETVB+kIGTzLAvG+GXrqqlOkE5klSxyy+6Ki5KExlPRO4
         pmaA==
X-Forwarded-Encrypted: i=1; AJvYcCUkVK7VRsRekmfbi1Si0+2dOkfH9FcMWCqdilvURgBX02jiLX/VOmlVfgSPlBH2WcKEspx7ylS8c8PfAzAzqsw+9L01dL3U2qkCAwzucGaVlcIDOmg=
X-Gm-Message-State: AOJu0YxgVW2LmZd/JqzSPLRiSPWkwz0lXTfNe7UdPYi+uTpxyVpzbAHE
	woyMvr2jerJX6EXq4xCw9EDQj6V5gxMc5RrNAqhQlCA65/+8yN6JyBrYzW3j4hGKHLTHyIbA82J
	K+sWq8c9wrYyLbt9Vk65tJbO8m30=
X-Google-Smtp-Source: AGHT+IHfJ5NOvY/M8jKZD7I1buzTWAe+qZku4H9VmGr2bS/R6gWNel6tY7DSPTLazisZhLa64c/7syqBykXJ+UeWNU0=
X-Received: by 2002:a19:ca44:0:b0:51f:5872:dd8c with SMTP id
 2adb3069b0e04-529651991afmr1455569e87.39.1716562791501; Fri, 24 May 2024
 07:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <lfcT.1716559062178660500.wc5p@lists.openembedded.org> <afdd4a7a-8e55-4519-9ce6-7d09e50c0d44@cherry.de>
In-Reply-To: <afdd4a7a-8e55-4519-9ce6-7d09e50c0d44@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 24 May 2024 16:59:40 +0200
Message-ID: <CANNYZj_XF0cXbK-nVeK=xpd8_XC07j-FC8rovvips085M1OMHQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Dependencies ?
To: quentin.schulz@cherry.de
Cc: mlynch@hi-techniques.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:00:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16254

On Fri, 24 May 2024 at 16:14, Quentin Schulz via
lists.openembedded.org
<quentin.schulz=cherry.de@lists.openembedded.org> wrote:

> I'm sure meta-intel would be happy to see patches to fix those issues as
> well, so feel free to send them some bug fixes :)

Not even meta-intel. This needs to be fixed upstream first. The
correct course of action is:

-  check upstream repositories of failing components if they contain
needed fixes
- if they do, then update the recipes in meta-intel to take the
versions that contain the fixes, or if no such versions are yet
released, backport them as recipe patches
- if they don't then make the fixes, and submit them upstream first,
and obtain upstream acceptance, then backport the fixes as in point 2

What isn't a correct course of action:
- roll back some of the layers to versions/branches that mismatch
everything else
- mark the recipes as somehow 'incompatible', if the fixes can be
trivially developed (and in case of clang fails, they almost always
are).

Oh, and: bitbake-devel is for bitbake discussions and development.
This is a general yocto matter, so yocto list is better. meta-intel
also has its own list: https://lists.yoctoproject.org/g/meta-intel

Alex

