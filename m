Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4714D72375
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 11:09:27 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65038.1769166557747639052
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 03:09:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DSal1OgO;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8887ac841e2so19913806d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 03:09:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769166557; cv=none;
        d=google.com; s=arc-20240605;
        b=AXU453lw2nTWN8vW8DPNSDkRxYJUGCi1BNdT21NcZ4+9TaWj7gzQxBNQM5FBXIuQFT
         xT0RnEUQFyiGLW0ZffehOHQPBdz1aIZlQNmyspVZnkheXMreAcYeRAJ6d19S5hVcwHMe
         BIw2oanWx9uvQn4NnoKAULxoFZtgS862w03qNhOvYx58IeyMjaFQRlZ+szQZvvg8N/+h
         mW3e1SrrqLaHGOxQnoq+5mRsXqgRrf3y7TaIUMzI50OJ5qxswLU+LiKzw/OHIjBMQ5UL
         RLQ5+TQGVfy2H7ua8l9Ydj9Ve3U0VdoAxqmzmULLo41IQ7anlRYgshNo1LnO4mFhmmyl
         XBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H9ypVLGqkEz5lVU/SbxCBdFL7hoTe8Jo+RnCSSr8R4E=;
        fh=qhSEGFZ5DCm8IWokOYU3VicGVJrPDbAcwTkr5XyhA7I=;
        b=RU3HKSb1CODQTmfihjs7hz46DhF0HAh7R3cLJsMfmHh8hLCIOgoyOIlo2EVYtmMnXF
         RyYAg3Xq3k3BkrTzE2RD3HmZS8RjW3XFHeP+skhLpBAunUsna7YiWqI7ZTEwxAmfADIf
         UGwUGiiVcEB2a8MrBxSy+oqyy2SWdCptwHHcii8aKIQ4/aU4UEezmGekSBCPgJt1LgEM
         yj5MbXkfzBiRD0WopNCsFFU7249PPoBmUGfWGCJesu5f0PWf5IFplfqx5ZFCf5SyygTZ
         ExZlOOOh9k9dhXc2NzFI9OQr0tkLk1F7UumbQbzIdp05pgbuizz+eLEalsrBZ/SRNxsy
         QW4g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769166557; x=1769771357; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9ypVLGqkEz5lVU/SbxCBdFL7hoTe8Jo+RnCSSr8R4E=;
        b=DSal1OgOwVEOuxjZtinEhUv4xP8It+TQ8Ql41BvXn+njQrexMyXUCbGTrE2/7/mQwv
         e21JaK/oa0Rydb7ju8f5rtD/OjUj7C1W9A35T0Va+Q+rGGwv8DVkeIp5P9gFmQlpYLN8
         r4q+wuyTlVkj/Kki/tcNLKV2DhTR3ZYg83836AdLaGgPFwL6lxyXmfBJWLDw1+KIeg2Y
         OVPHNQyZwk1F1B5dHl5CquhdZXpzgH8zu5FGLloC+d7MAVMCgbCQGkGOKv3Um1VhBvYu
         xkF2Bj77RVtcKXJm6QYsEZH7/gBSbAN6L4lImS3Hl+LLJrdwK8jJvcZLRoAQivOgR/GM
         pE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166557; x=1769771357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9ypVLGqkEz5lVU/SbxCBdFL7hoTe8Jo+RnCSSr8R4E=;
        b=ctUvyYgrJ4cjdN5oyAfmAmpYCgdYp3SDb9P89Rkw83qTU8t18Nqb7CwmQKjfWpdsQH
         jAzlWVUo8geOHxm402CY9Sr/VA/eq5WPPT5fz5G4eYGtoSapo2oRM31AprDuOsLoC7is
         NJxuooM/L9tGxQoV/2bgbBRemr+HkY9skoZJg9fdl3GOPCpsL4HXq4G1mP1TYYJSZ9Tx
         zChRta2WDE9kzEQkTn3x7eO33jnkF2mtu3vz6WnvAsgUm2iCE49bpBOl51J4rOvHawFA
         x/BRnHtHI82YD7ZzUeXBMJK5QvKfY9P7278kwLLr8MVMaN6iXTU0BmzcNbpBCc4NyqXX
         lSZg==
X-Gm-Message-State: AOJu0YzesnEjlJ5WulylDQ4AoplSy+oKdT6YN+fnLC91wn773rAHNxFr
	NS6+EBbGcAUYEyoZDXOWpxOE1nNMUrzD60BSEVtFJ8MWQP4Kzc4SiMseob813eiRzYwFlmTu1WN
	frCgdLtDmvsaZBUt7pZKQ+hUX/ZP8MIQ=
X-Gm-Gg: AZuq6aJq6PyaaHe4g11IyHeZQTOZ/3CRdWd4S1EX1XOMtveFORKNDhMQabWPQInKz+H
	4HGTHMzxdNPUCMbrkzhuXVMqJZVF4q1W2MWntAD+G7QYAQzeNwSaREnXePBqX+wMjVVMhb5XVmd
	UQr1+8cX/CBniHjuIAiHO0nHxwoi5nkaH80jMMX6gmBd+b+cPwaYICPa1C1CCwcJSKoNzww6d5v
	6TB7CVc9ZTK5thPawKuAVNah7Ig2P1sGBes1Gj+ablgpbqha9zngs+vo/ZwhOUUKOXc8UmNAP64
	rMi0hcY86rKvrCzZYUHQxI7TuwKX+Q==
X-Received: by 2002:a05:6214:c4b:b0:88a:2f46:8221 with SMTP id
 6a1803df08f44-894901ade43mr34494216d6.8.1769166556578; Fri, 23 Jan 2026
 03:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
 <20260122-bitbake-setup-choose-builtin-v3-3-c55291acc1a7@bootlin.com>
 <CANNYZj_SUcRFLWobRO9GHPzN+ZtG9koKVg4iZ-gzoKsSAUiMoQ@mail.gmail.com> <DFVTWVIZ6ZUP.1YHMAPRNIEF5M@bootlin.com>
In-Reply-To: <DFVTWVIZ6ZUP.1YHMAPRNIEF5M@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 23 Jan 2026 12:09:05 +0100
X-Gm-Features: AZwV_QgpbTRVHI8sFhzXe3ivtiCMKGIlCeNqC7lXn65xaVmb6i5xdiXtLkgN2Y0
Message-ID: <CANNYZj_4Y=PaLX3Du+YhZxTY5NTp1RqeQhNOtaVrdmxh7zTXiQ@mail.gmail.com>
Subject: Re: [docs] [PATCH v3 3/3] lib/bb/tests/setup.py: add tests for oe-fragments-one-of
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 11:09:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18857

On Fri, 23 Jan 2026 at 09:34, Antonin Godard <antonin.godard@bootlin.com> wrote:
> >> -                                                                 'gadget-notemplate','gizmo-notemplate')},
> >> +                                                                 'gadget-notemplate',
> >> +                                                                 'gizmo-notemplate',
> >> +                                                                 'gizmo-fragments-one-of fragment-desc-1 fragment-nodesc-1')},
> >
> > As there's only one choice in each, bitbake-setup should pick that
> > without asking, or having to specify them on command line. Let's test
> > that too, and drop the fragment names from here.

After reading your response, I retract this suggestion. The reason
bitbake-setup is not automatically picking up a single choice is
because such configuration doesn't make sense: if someone makes
oe-fragments-one-of with a single choice, they should just add that
choice to oe-fragments.

That said, we still need to test oe-fragments-one-of, so can you place
two choices to each (old syntax, new syntax), and supply the
selections on command line, as you've already done? The non-active
fragment can be entirely bogus and non-existing.

Alex

