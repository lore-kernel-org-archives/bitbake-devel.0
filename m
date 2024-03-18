Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2736C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 15:47:55 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.48095.1710776870393887237
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 08:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fS/2RyAh;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso64775321fa.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710776868; x=1711381668; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UnlnNB0vgwWDyUdy2dpLVuJqvdAgC8XJ+EJF0qJ+3u0=;
        b=fS/2RyAhkTgj3jU074KWEZdAHZ73b9huYbudxCk5AJPL8tIRcn6Yu45D9gBlIN9vkm
         /sAXYPOo32jAkkGFM/qoYSNDIGKs7rJPKM/tA7tALtapsVBGZ5jHJwPgyoapksYOkeTR
         KTmlq5U/DZQ5opBlkOLaIstP7z5fOss6VvQ6yjlBpyQCy+dCDZCud4EJUuqUef/Xyhei
         dqD/naZsaW6mbHSuFqTMBTH4GoYQHuVCgrFCcVawGaZ3ZvbDqPaOSmbS37t5KkSWnt7Z
         XWfVuYrU6Lh4gjORmeVnw41s9t3Yg7a3i5OqCXbpv3rPxqB78wTmpH/OlKXBDDgHWF2r
         3jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776868; x=1711381668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnlnNB0vgwWDyUdy2dpLVuJqvdAgC8XJ+EJF0qJ+3u0=;
        b=rLkeM8ulflkBFXkbL6ZiWnHRh4870GcXoT0xZRKGGaoYCQX9zQNKPijg7yl3ekm6mp
         B3bNw7h1E+MtSk5gpnv3rHcxjL4DdRRuk/+jB/AjK/yak6e4d2uZY9bdc/kYyWtOJTnb
         PHMV/gnLmdysTdfP/Iq+PEiaK3QyshLaJX6tw8UAY9d3a80lcKRbTfL1dGwylDPkOJgR
         /HQ5GvQUnaQqS9XO7zTUqBq+IGZloGZgGFFoG1y3T9bEyRSQRyiet0DNzfYIbaNXeEiQ
         +jTOrvY5oUMkXPpqDWWKwVlfOCWFIpUT8WRQgGbSyZfUW4pyD5JgaYxKA4hlTMQcJp6X
         Gp1A==
X-Gm-Message-State: AOJu0YzZtb32DATth/xhVzGxWveNaxCsRkkbCSc16fihJp0nn9cbR/nf
	cy67ZanuQN2RQ3JZlwj4Qact8AuDFY1oMVnFQLyFD/oMbDD7KoomIG0j74rkuVaJ1vBsFK6xJOF
	eM86pjlUGmwjtr75KCA3MUf54bHg=
X-Google-Smtp-Source: AGHT+IErZQJtdrlYKHcEO8/Psrh4n/i1CLFCsK5gMSZLtolqYxGmOTjPj0X6SZWH0BSQB0dgxKoM+oReuQ47hRGPqew=
X-Received: by 2002:a05:651c:151:b0:2d4:9950:20ab with SMTP id
 c17-20020a05651c015100b002d4995020abmr3537246ljd.11.1710776868319; Mon, 18
 Mar 2024 08:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
In-Reply-To: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 18 Mar 2024 16:47:36 +0100
Message-ID: <CANNYZj9tBJL2T_G9t9ruZkOw0P3kt7mMq4XB-h=nTyGtaZAgHA@mail.gmail.com>
Subject: Re: [bitbake-devel] How to turn a poky patch into a bitbake one?
To: michael.opdenacker@bootlin.com
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 15:47:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16006

Okay, I found the correct thing to do:

git format-patch --relative=bitbake
git send-email --relative=bitbake

This will strip the bitbake prefix from the chunks that have it, and
omit the chunks that don't have the prefix altogether.

Would be nice to set up the poky repo to do this by default but I'm
not sure how.

Alex

On Mon, 18 Mar 2024 at 15:41, Michael Opdenacker via
lists.openembedded.org
<michael.opdenacker=bootlin.com@lists.openembedded.org> wrote:
>
> Greetings,
>
> For testing convenience, I made BitBake changes directly in the Poky tree.
>
> Before I re-apply my changes to a BitBake tree before submitting them,
> in a very manual way (like removing "bitbake/"  in the paths in my
> generated patches), would you have a nicer way to turn my changes under
> Poky's "bitbake/" subdirectory into a proper pathset for BitBake?
>
> Git tips appreciated. I guess I'm not the first one to do this :-}
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16001): https://lists.openembedded.org/g/bitbake-devel/message/16001
> Mute This Topic: https://lists.openembedded.org/mt/105004317/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

