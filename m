Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F6C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 14:58:55 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.46736.1710773932724138700
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 07:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nIm/LJpB;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28051376eso72126511fa.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710773931; x=1711378731; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0KW7LZFqX4MBgRqEUC/4tf3S+ZJbgHHrdbMCnR0DJQk=;
        b=nIm/LJpB9Lv1YmyDMkFCVIrnd3BBIGwS97QVbekJV3yhSIe5APbxa1xmUQIGzlNFtt
         HJqPawp0VJo5Gw/GMb9EdHQAXRw5b4A9REWpqzelrfRcn9meI/b+8RLI7mtt4mdBsA8U
         y8BLS/gRLqVuhUUKC1SB74YMMJJuZfv66rA2AzpmRJ8IFALEojBkchKuYjxiG1ivy2oj
         wFwA4H+i+rQaU97faQn2vYtrMZsST/Kw1M2k0ApU9JkRMr6Lk3JuovGx3jue6XxiF3k0
         Q43BdWEMBUf44pw29FJ9tqx+x7u03uZrfCqKUv6IpwbMfGKYSNl+S+D6wwVx71YebU0z
         KrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710773931; x=1711378731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KW7LZFqX4MBgRqEUC/4tf3S+ZJbgHHrdbMCnR0DJQk=;
        b=PnQgb1dmu14Z7PCcM1W+THvvVTJN7yYPG5SBBcdziz5mq8GK+H/bBWcjyidDC9ezcm
         hmjX+bna0IMdfRYiZK1ATehtmJv0FkZbnVtPbz2gyF4Olk21MyXj8U95enmCdlKBoN6Y
         7rG4XVlhzvhZ0x69VVQ59dhfg95XMtRPhqAaUoZl7/V7P9kyoPPHmD2CyzEmgeNCxGUU
         IU0WC0bTfdmlkene0bdGNDXoLhyBOL/ZhGOOsOQR+p6LSVCXt205hhVrO+oCNbCrMNf5
         5A4yExa8+p3w/IousMyGvV7USD6iplfKbiBFrFR+5DuJ/SvG37QDW+bLKBx1a+QRezkq
         jmKw==
X-Gm-Message-State: AOJu0YwVE0eUQ/o00sssjWLglToUtrE1vPhQUxi5SGGR48jxW2kRsvTO
	gjeLe80bbCiPk6r8C9te3JUG4uYKvV15Xny/oGGKgvqaI9Jrna68w0WqcglciOdC0qx1huvl0ER
	nMNJ4t9zEXg2Ki8rHdeST9UmHzMc=
X-Google-Smtp-Source: AGHT+IGzkr1PP96egWjldfv/IxStZMvURtBlPX6L1XODWbBBpp4TWo/Xv7lxUUvEEkrZpv3RZGco+mInSpwx0yGYkCg=
X-Received: by 2002:a05:651c:388:b0:2d4:707d:8b3c with SMTP id
 e8-20020a05651c038800b002d4707d8b3cmr5137470ljp.18.1710773930669; Mon, 18 Mar
 2024 07:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
In-Reply-To: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 18 Mar 2024 15:58:39 +0100
Message-ID: <CANNYZj-O5xKQ9+bfdg-aziioenM_MrDYHDtuuVTN80QjdttvCg@mail.gmail.com>
Subject: Re: [bitbake-devel] How to turn a poky patch into a bitbake one?
To: michael.opdenacker@bootlin.com
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 14:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16003

If the patches modify existing files and don't introduce new files,
then 'git am -3' will apply them without issues even if they were sent
from the poky tree, which I have relied on to sent the patches
numerous times over the years, and just did the same a couple minutes
ago. Admittedly this is not exactly robust, and maintainers can come
back complaining.

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

