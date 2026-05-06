Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E943CCD3440
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 14:23:06 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19862.1778077386331243160
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 07:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PMUlAB2i;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca4e14411so64849846d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 07:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778077385; cv=none;
        d=google.com; s=arc-20240605;
        b=SXRtYk615jOG/VhSOSo65qziQcuaSrQWaHZVQ+N+nJDAYtMAB6M2NHcHAfPC7TwSR3
         1H6QQxqT7smM9Wj/mexXYyqEc1KJeqsfYFFaDeulHACstFzRcRYYrQ4w2oah8W1LPMRU
         NcaNfhn8XK/SkamSfETEKkavMyJr1yXx6+aiDcEDhTb3cLuj2Izf0HrhKaDxJuzMIVfS
         MXTSaBhpTZs6M7qFUXtj62GIH95vKElvjnR3MDpHXbOOKKrHWDyjQ7i4ya4+g9IQBrN6
         6gTQIW1jc3cJirV53Bwyq7Ilo4l9/FrEw3pjJCEZRlQDDGXpKrLMTuFp4Z1s6tszcqcP
         nQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KFn0dtk6K7F69xXfUk638BZIecsjwd3DrdfmTcIh+Qs=;
        fh=3fDeZQ9yjC2Zny8pCZOJT3BQw22idAASnyciguEnUVQ=;
        b=Bnbde3f9CbQtps1dqidY6eC/ItyCe0pgg+b0bI7/FN63hXWyhBcQgMuPWx7DRCWQIQ
         k+tc3OiQiuaOyZIZ2fPFZItGJIeSQnp1+wTDDe2guYc/zn6g/rliIHWNsjLEG9BOHcPF
         KYq9Uk1sPXd58nxbpF0xXouxo243DyMUcB0c+whcfQTzhaDSJsnrs0aGgpy1sicdDcNy
         aSqTZkUmNPeaWl6VmZayVrZNFnOYoOBQWpZc9PbzZuWgY+TT02CKBB/SROWwu1ls4vGL
         kn5EqRJdZCbzejgIMYFPbevUBM/q061bZUu1FdWwyhcca4sXIxNwd7e9F7baEltjDnyq
         ccnQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077385; x=1778682185; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KFn0dtk6K7F69xXfUk638BZIecsjwd3DrdfmTcIh+Qs=;
        b=PMUlAB2iczEquA8jouy3j3DmfeecSZ/Iu+TW0M955L27CmaUtXW3KXBf+e9k7rNM3m
         Ov2kQ9111U8caWFlYeD8dVw5f5tVpB1A4PyJG13gkCefhNt4GyOpoKVaa+bzHt9nTtwh
         RAz8L6NUxKK9YDzl3ElYX1hI94x4nmrUAooWY+BV6EHp3zABoxyvYRBCmYfQ2/37NhWe
         hxFNRYr9TclbrOLgEIOmIlHw8Hz7saP8nhekGHLoMEleKZd055bOgrw6v4tU07/G6NI0
         nws7vMzsr3Kg47lFHdHnV02md9Ms60w+17Io8w8PgfZrGiA1kGJxwy2H83oxOUqQS7iJ
         6/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077385; x=1778682185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFn0dtk6K7F69xXfUk638BZIecsjwd3DrdfmTcIh+Qs=;
        b=Ya6y5o8Ti//bPHGig7ZnLYspgen+yGdnz/qujEP/ZcZyxNfWS15EWul+48Sr9hU4fM
         tMP8SubeUvanCIJcADXs4w56IG5RQhXD+/B8fpmuNRS5LZAobnRGoTr4JtYgmt+6BJux
         UXNLGWRS5eJEbhqolsgELNoLQlJwK8Oc7RCIs4DNMjv7XCLln1IiPQKQdpqyH4anXFUU
         qCMiTlaqF60w2Zz9RcirvBLOhg5PT9ixQHE1dfEVaqsMK6QOd4bWFNbhN3ij6yVqnrUA
         PTDUCVbdaYdOBQZm0PqYgJj2SR6afe4M3efP8txE5OFd/tzVBEuhTImorxl8nbKAlXe1
         3cYg==
X-Forwarded-Encrypted: i=1; AFNElJ+/QlNPj6tutzLLalFFjGnUBxo6RxjH/MqRfEPW9igyrDyW5FVWUtABym2r03p8YKwCtA1fTGoF/O3mHPz9@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw9aJGA3wHyjb9zwZT0NWSKcoBMUZvX6/ZF/qWaG+VxOXE75p16
	iVk6/PoPcOGyj+DZ6d7av6gw9203DGBfcodfj4tlmEg4eyc0iKOoevPGnkywnViaFL7lStxYTue
	tEHWtXxcMpQcWLPm5ke5uyDi7Vxi/F7s=
X-Gm-Gg: AeBDieu3MOFmt9KIaTvniAREAHbj6XbzsD9ArJ5J9G7Qg4KisejmBGwM+FU8ugnMqlE
	dyZJ4oxPLJDw+kcuPlEyP9e/di5h+yJ4ThbQlGs14RtEvGSokCIE7BHGrQmUmuAlOpa7tKeE4CB
	Ji7jXflBBEzEyGOQhlE4NcfOZ94NKUcnzH+554Ngkb70s+1UnYv8zKSs5APyTmEFlVv/qgmRqQg
	xR9GMKWBgOSuNYU0U/GN/63tfkx6uaaBp47ZZG3EYXc5x/DzuFt15MIn5UB6DGX/k8YVsRdjC19
	eLCIGbJKSktmEANZeEvGM9fNRQilJIJwvtsPiQrXU4kmzKTchvLIqqAnzUGh0Vg=
X-Received: by 2002:ad4:5c64:0:b0:8bb:2e70:7a2a with SMTP id
 6a1803df08f44-8bc441e5420mr48051426d6.31.1778077384610; Wed, 06 May 2026
 07:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com> <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
 <CA+HEL7_H1MJe3WGhdP3TMQho8u0M8g5OfUv2oFXxQjefAo6Hnw@mail.gmail.com>
 <CANNYZj9=Qap1AsWfgFgEforE17Gz8ft8fNz4hJcU4Y=zmTKDZA@mail.gmail.com>
 <58d89d74-bca7-49eb-8591-5c5e1a0a40fe@baylibre.com> <CA+HEL7_pJqDsKUn2OL3Kqhiy4y_H7LRoQTWuVJ-EbOH7k8NymA@mail.gmail.com>
In-Reply-To: <CA+HEL7_pJqDsKUn2OL3Kqhiy4y_H7LRoQTWuVJ-EbOH7k8NymA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 6 May 2026 16:22:53 +0200
X-Gm-Features: AVHnY4KYQ36G0gfkWOWAo-Gx8pPCYTx1RCnB5d2fvEZpOszh652UBTaR8Wwao7Y
Message-ID: <CANNYZj_CperqNKE-a=gGJQw24wyhZ_5MyYk9vTa8Ytp7urMUQA@mail.gmail.com>
Subject: Re: [Openembedded-architecture] proposal: build pipelines in bitbake-setup
To: Daiane Angolini <daiane.angolini@foundries.io>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 14:23:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19449

On Wed, 6 May 2026 at 16:03, Daiane Angolini
<daiane.angolini@foundries.io> wrote:
> > I do like this version of the proposal better. Having read the responses
> > from the two of you, I think 'bitbake-setup run' might be a reasonable
> > compromise for running steps and pipelines. What do you think?
>
> I like that the bitbake configuration template may provide a set of
> usable steps, but I don't understand what this other tool does (other
> than wrapping the build script)

I was confused by your response which quotes Trevor's suggestion and
then starts talking about a separate tool. But if you are actually
responding to me, then the arguments make sense.

I think we can drop the 'separate tool' idea, and use 'bitbake-setup
run'. If someone wants straightforward shell scripts that just run all
pipeline steps one after another that can be done too, but rich
functionality should be inside the 'run' command.

Alex

