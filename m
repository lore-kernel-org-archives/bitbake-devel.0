Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D39ECDE012
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 15:03:27 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web10.45849.1727362998874877547
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Sep 2024 08:03:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JhMQF4UI;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f762de00fbso13432371fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727362997; x=1727967797; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=paI0G57LW3MZGi4dYCC0XtKCZ2vSatxK7aT90AjyHd4=;
        b=JhMQF4UIxLDPxs70URj465p4JFNBMrd0lrlk5wwZ6ocDbT8tJmE0h0TDSS4jiKWdp4
         OJ3KywsyvIqSTvaGOXTaPdFd40YzMXbOCZSYXwqhjuhP6VwiQz96KqexdUaBRX9njf0P
         fgGNmJgXUTrK5HhI5JWobJP3q2+UYxF8XKFKQWKCMR+5nvzg7cQEeXqWeIP/bv2YjqxA
         GjaCL5COPyEN1dbEYjVcIIAi/Wp5xm9W5pck85ZnsobqYd/+AoHRz4p/T46A6TItY4Uz
         HCCwZWaK8x2gBCGbrLTm1/ggz3+XqvSs0uvpEzfC56sBLqJsoNbf6FbpNL0Mo9iYqIsz
         QV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362997; x=1727967797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paI0G57LW3MZGi4dYCC0XtKCZ2vSatxK7aT90AjyHd4=;
        b=t/kSegc/jOaG3m8gb3E76H2KlVixoeUC5h8RIc0+phhtu8QbieBGJDusNrNPca/k1Q
         tqgjIOGx6HWQArt+uZXmBPM9q/y1exUYBuGf1qs41iwmoxofaguBSYdGrsIDSHPH//i0
         TJrP4SVsccrEVlM947WUJNZhiQFEze3iaO6O0OzBMyIjSvjYi0xHaGwZvtiI7fWj2j9u
         6D1SgHVLM2iJXJGMhLYPjTgJGHB+m7PUskwClVjTn2Cd6ZHubtE4tH02WOM/SObQv5dp
         0hm0RDySHyrcURPtj4GvI2pGvmH6pjtqqxtRPhsOs5boPXHKQu3soXZ6tnJyFsNpv4Pr
         vQiQ==
X-Gm-Message-State: AOJu0YxVxpdHGDg2oeYkRfp1GXaaFAtsjVlVB2ioVSwUe148ctNJnPVh
	olkT0chQc5XffQZHqF2/wZq4UuT3BjYwTl+mx7sk2GRcHCJACNxhVthsao4LhdnK7MTkoxp0kJe
	M1GmqLjL84O1hpSp4xSx0UFdimPQ=
X-Google-Smtp-Source: AGHT+IEm2X9c7Gm1R6RlHO7vSLTWWsbd4FXYB+gEcofcIlFN/+fylrOIZUxfuq1/Mwdu+9Lw/pSnB7s2gPl2SyUchVY=
X-Received: by 2002:a05:651c:2129:b0:2ef:29d4:3d97 with SMTP id
 38308e7fff4ca-2f914bb82d1mr44496421fa.5.1727362996588; Thu, 26 Sep 2024
 08:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj_3XLABQZLYvRuQu+PnQ52gDRS8pXgQDS-SBfp8g9o=sA@mail.gmail.com>
 <29158.1727362658714839430@lists.openembedded.org>
In-Reply-To: <29158.1727362658714839430@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Sep 2024 17:03:05 +0200
Message-ID: <CANNYZj9y7cMMEd__1s5POt64HMhY_xxKrBt38T=uLT2aPRKD4w@mail.gmail.com>
Subject: Re: [bitbake-devel] URL encoding/decoding bug with files like
 "serialgetty@.service" or "sshd@.service" with archiver.bbclass #poky
 #bitbake #kirkstone
To: brennan.coslett@bluerivertech.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 15:03:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16606

On Thu, 26 Sept 2024 at 16:57, Brennan Coslett via
lists.openembedded.org
<brennan.coslett=bluerivertech.com@lists.openembedded.org> wrote:
>
> I think the bug is in `bb.fetch.decodeurl`, I just noticed it because of the archiver.
> @Alex if that means it should still move over to the oe-core list, let me know and I can do that.

Right, let's stay here.

> Steps to replicate:
> 1. Checkout poky master (just replicated with 8634e46b4040b6008410b6d77fecb5cbaec7e90e)
> 2. source oe-init-build-env
> 3. append the following to the auto-generated local.conf:
>     + require conf/distro/include/init-manager-systemd.inc
>     + INHERIT += "archiver"
>     + ARCHIVER_MODE[src] = "original"
> 4. Run "bitbake systemd-serialgetty", the source dir will be created but it wont contain anything:
>     brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$ ls tmp/deploy/sources/x86_64-poky-linux/systemd-serialgetty-1.0-r0/
>     brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$
>
> I think something in the regex inside the `decodeurl` function in `bitbake/lib/bb/fetch2/__init__.py` needs to change to stop it from
> parsing out `<name>@`  in `<name>@.service` into the `user` field or maybe it needs additional logic inside that function when its a
> local file to put the parsed out `user` group back into the `location` group? This appears to fix it but i'm not sure if this is actually valid,
> if it is I can submit it as an actual patch. I think there should probably be a corresponding addition of a fetch test around these types of
> files?

Let's do test driven development here :) There are tests for fetchers
in bitbake/lib/bb/tests/fetch.py - if you can check and add a test
that exposes this issue (e.g. fails without the fix and passes with
it), then we can discuss what the best fix would be. Run them with
bitbake-selftest.

Alex

