Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49052E77180
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 16:10:23 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.105375.1733760615763280720
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 08:10:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Lv7e+lik;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8edbd1a3bso21669356d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760615; x=1734365415; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DLxXlP4Ic2dJQe7+BQkOPXcGfa6kRfiM7rcMyWGM8Q=;
        b=Lv7e+lik3mf3pThMYD6d8sziNXcQX8PKcI/tIMynIkLt8ivheiOpiuqq7V2bxk0usK
         zsQEqeRiRDFlows9h9Imscxcu9kLoxwiHW3fqMcfBWrksoNEVocyT2NxhOMMqmkBz9/+
         Yr/F4CU5G/5BobFbkDPurePjU/rDFuHRX92CwcC33HeKsPW/NVZyGSEXUSTZykqFa90P
         Gg0yTjUKguJ0HUZKoT3dysPu+ZFuKHAkpvd+U6hasRlfPKCEohkjKpWfUQCmZU30foSu
         8jBHk7xoyesCtP28nIp3EGEhwgHItOa4u/hEoLN7T5qzgdZd0TxxekmV5Lpsko34iMeI
         NISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760615; x=1734365415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DLxXlP4Ic2dJQe7+BQkOPXcGfa6kRfiM7rcMyWGM8Q=;
        b=BtMzDk949reI2R0jHucCO/ahfsWAcpDR1ObuciCqCWOW1HT2IvN6E37QjBxznsSBVD
         E7d96zZEhT/C3DTkwfaBWlzHLqTWnwHz6RnBHUKAinA/KHI+jL40Yj9dM4J4QE4ckFpV
         V6En091xsQr9mzjneyca8vGidO1TCUh2Rz7a7VCWq0/V58PHk2s5N+p72ii303SaW0wC
         NS91yfMXm8wlqEfDPMrrF69lWCEzlIhpTAL2JgWzWfPeHdVRlMJgPteHZ1sreQ+fNYPK
         cushOQHo/2xb/lwjshbQ4CMFD36SqCBQnvZ81W9AHRnXBPg+FlX2y9k6mBm94XgCUvoq
         7Pug==
X-Gm-Message-State: AOJu0YxZFBSKIbbK7uYjHwpZc+JzKEuEStDOyjWzBwy2hEWbST1Ypi0Q
	luJvS2VTlsk2wSAKjUSQV7kSI//KeQRtXpfj9fx3+GJ8r/mP3HG7mdEB+7s+GKvmGia7b05D32J
	vGUOdhlWbstsR/9IcIyHUdRwrWbY=
X-Gm-Gg: ASbGncviIgEUBK0qcoS6pfk4CokfqAJ0JEQQHt6LddFhsVXwuIX71zfDjMQ1nxy95AP
	4AlKqagBLgPNO87eq6ZwGTsWF9KWs/yGeW/0rJ6fA5ruFtrqpp6tr6g4UILNTon/L0Q==
X-Google-Smtp-Source: AGHT+IEqad66cydCDPdfMwLkoHjATLnUUunmXvfi/9luy1ei9XTy8G17sdOD7xO6XtuHcuHvaN8ZXy021PEaVoJzylQ=
X-Received: by 2002:a05:6214:20e8:b0:6d8:9832:75d0 with SMTP id
 6a1803df08f44-6d91e3747a5mr15952726d6.17.1733760614793; Mon, 09 Dec 2024
 08:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20241209133053.2494088-1-alex.kanavin@gmail.com>
 <e0d3f4c1-f252-44f4-9e45-dbfa13b41996@cherry.de> <CANNYZj-LziSwSdKMCTkRQgwzHBM_TFoZhkKbx9Tvcf943zBS8Q@mail.gmail.com>
 <36c6cab2-e348-4ad6-9ceb-4692f177aeef@cherry.de>
In-Reply-To: <36c6cab2-e348-4ad6-9ceb-4692f177aeef@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 9 Dec 2024 17:10:03 +0100
Message-ID: <CANNYZj_78AvkfB+ENKbXThD+rR6B_Ek+JkaOU+ayJtixDu9E7w@mail.gmail.com>
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual-metadata: add
 a section about 'addfragments`
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 16:10:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16902

On Mon, 9 Dec 2024 at 16:50, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> I'm suggesting to make the explanation a bit more thorough about what
> the "path prefix" actually is. My understanding is that it is the path
> relative to the root of any layer, i.e. relative to any LAYER_DIR.

I sent a v2. If you think further explanation for addfragment
parameters is needed, please be specific, and send followup patches.

> This answers the question of "where should I put my fragment in my own
> layer so it can be used with addfragments directive". I could have a
> repo with multiple layers for example, where do I put it? Is it impacted
> by BBPATH?

You place it in a layer which would be the most appropriate for the
fragment, considering its functionality. You can have any amount of
nested categories, as long as its subdirectories under conf/fragments
(or whatever location addfragments prescribes).

It isn't affected by BBPATH because the constructed paths to 'require'
are absolute from / on the build machine.

> Can't we have nice things in the BitBake docs as well? It is technically
> usable on its own without OE-Core even.

Technically, yes, it's usable without oe-core, and it can also be
placed elsewhere than bitbake.conf.

But I do not see a use case for either, and won't try to invent one in
a hand-wavy way. And so I'm describing the syntax, and only the
syntax, and leaving it at that. Actual instructions about using the
fragments are very much oe-core specific, and will be placed in
respective manuals. Including about where to place the fragment, and
how BBPATH is not involved and so on.

Alex

