Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C45DC77B7A
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 12:00:29 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.9880.1685016027729502389
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 05:00:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=TlebG60S;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f37b860173so2416467e87.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685016026; x=1687608026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYwmYvJMyu8HFv9Lt6U83n7KZBj3cTLOV1Xbaz790hQ=;
        b=TlebG60SewNh66JTK7GnqCQnv2ZMvtoW1NKKA0y4BneX3aESFKsDlaoeh7L1uLFK9Z
         llE0EhTqmcPBwKXUIiH1n7n/yVcU1nMjSMk/8v7at8hupecsgdNTsn0LFpZnu7/My8du
         /DZYAvr2mmjJH0GAwUxWLBUg3y6Q70/zOh+Wlhf426qiI6i3JYs2AT198cVwefIlKn8T
         wwXdD1/nDBgwumfj0G/jRWaFkbI3lBev/3bzT7BZS5zNYa0H72LOttHyupC96eGSPPia
         HloWfYVk2y/i3AVpmLcELwrIgFHXZvZDWf9yZpWcDNH7kOOWSHEWF1zM9oixdWRGfRHC
         wxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016026; x=1687608026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYwmYvJMyu8HFv9Lt6U83n7KZBj3cTLOV1Xbaz790hQ=;
        b=T/MGyjLgNeNAsinyEgCAeRrWHGm9BvJsjDThPeII6/CsiJe2T1YG5ySShKBimjmzZf
         6fKcf7Nv4kYHCTdssuTO24V4oqcbJpHbOepwGUdfgiMfhLnfidi+BXrlKP3KQRmIGWlJ
         1M0vVq9ekw0yGyIYANEjxBk1Ozd7VN4ESQW2qIeHVWlKA65F4DifDn2HegK6JhQJcm8Q
         Ub32hW7FmPP1SM20YXMya/97byd9xF1BQRVkAYJRY5vQf8YdvE4hJc29LrwxSd5M00nM
         l7GOnl72gMlhZK5MYQ9Er4gk1nzp9f+8GkvMBZ1+EXP1rM8dMWCx3FoU0bPx/3rCLm5t
         r4pA==
X-Gm-Message-State: AC+VfDz1LF/0Lmg3BcbnnaMeXmEjJU6+CqN+kDPWyLQwhPMraYNJ4GD3
	MbTdTIKcHJEqVg6icd+mwOSCNuWAkaYRuiNFce0=
X-Google-Smtp-Source: ACHHUZ6fcSNqaWA8Q73RYRmq0tG2ClCzVWhiqYUjEIKMKY1D4er++feSDpDqW7K9ULu/Q5nuFEkOIEinw/akV+adLc0=
X-Received: by 2002:a2e:350b:0:b0:2af:3f7:53fe with SMTP id
 z11-20020a2e350b000000b002af03f753femr756189ljz.50.1685016025643; Thu, 25 May
 2023 05:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
 <ZG88JxkZkP4z3kR5@nuoska> <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
 <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
In-Reply-To: <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 25 May 2023 14:00:14 +0200
Message-ID: <CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Michal Sieron <michalwsieron@gmail.com>, 
	bitbake-devel@lists.openembedded.org, 
	Mateusz Marciniec <mateuszmar2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 12:00:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14810

Yocto has a download cache mechanism, so you should not have to fetch
more than once. Are you throwing away that cache between builds?

Again, the actual problem is slow gerrit/artifactory instances, not
stuck fetch tasks. The idea of 'retrying' the fetch so that it maybe
works better on second try is especially off-putting.

Alex

On Thu, 25 May 2023 at 13:41, Tomasz Dziendzielski
<tomasz.dziendzielski@gmail.com> wrote:
>
> Hello,
> let me give some more context on the patch. We use self hosted gerrit and=
 artifactory (with git-lfs content and tarballs with source code) instances=
 which tend to be slow sometimes due to some overloads and other reasons. W=
e have a 3h timeout for the whole build. Now let's assume do_fetch tasks ta=
ke already 60 hours instead of 10 minutes. With the timeout solution propos=
ed by Micha=C5=82 we can detect it quite fast and stop the build job and un=
block the jenkins nodes for other builds or just retry the build in case th=
e fetch on the second run would take less time. Now without that and with t=
imeout on the whole bitbake process we're still holding the jenkins node fo=
r another 2-3 hours even though we know this build has no future.
>
> Best regards,
> Tomasz Dziendzielski

