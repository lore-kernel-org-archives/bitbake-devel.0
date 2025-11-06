Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3125CCFA13
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 17:09:40 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2868.1762448976196012014
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 09:09:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SFZ7ukBg;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b145496cc1so159895285a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448975; x=1763053775; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=djOi6/pAH9A+9a4wRE09D2LqTG0pnS8nyTUnY/j3WrA=;
        b=SFZ7ukBgo3iVuwZgi8veKavpVLCDXJqfRrxLiZrZV39Ernc1zWmnDRpoo0lz0NeNIZ
         DR+f7wc2nnIuo8Wcj1gTHbu7nVq/GaqOPjdJRr4nq4L+OADNIrpXmOPwlz94q0UuQpHK
         RKZ36AxlA7XikdVrChKJZ+rlzMmwM3RAITB2grRc1d0wv6VQkE+P5g7WuMXG4jhWidKY
         XQzltMPu9plstMTZLEobTFR1/TfTu4VappWuEgdBAqzdK/422vVchViioNSdKZuFFkdM
         9Fa0+apjRp5uTZr6NXt7WQwScltMeDjCDnlVQKxbs3qYZkItftiz6YrC06VIxlrcfMPx
         ftHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448975; x=1763053775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djOi6/pAH9A+9a4wRE09D2LqTG0pnS8nyTUnY/j3WrA=;
        b=EHT7dXmv6RlXalIw9TUvT0ZNlSDQ12X/B6+r4iEi8acN1LaNO4O/5fBDP7u+bRtpw6
         NlpSHfiuOoMcwJdsFU1J5RqqXBNqcPgN2P/CVTaorFV5oWMKUxrvsSLHxAP7lXppmFrK
         sFdGvPvcs5QHA/HdHHYnfSM6aF1GmH9vUzr4RWho6ygBZD2uAP/MKFa6rj2/cTZfUlP9
         G8VkZh0xgKRAItJOkS1Oe1cMoQrQ6mtXhzt6tLMm/qZji98BL+p2T1+4DStRXfKgFf+x
         cWi4vB5yEZNZrMbjW2Pb5g+/9lpYZ5fGck1LpC+gzcm1G1kldgXSqTTz7cSN9//7EsVr
         AdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpVrF8D/uBUmmtkC+8QWSn24WKn5la7pm84uzlIwGxv8vePWs1xOMZ7WGymMYRp3SGAvb/36CxNEs0x9M3@lists.openembedded.org
X-Gm-Message-State: AOJu0YwPfMl/dbDq83WP6FQ06lXWFrXkaPKHxgKnHCOvmHZUhIJobp7H
	pk5oljpAzOI8PNH9XvNhpLwDY3ICp4ZYHnFMMUITtVsRfwq7/chpNqA+d60lEGFlQMmfWTWurz2
	g5HQskf1e+HA+31CW57u7u+VmKlwqIU8=
X-Gm-Gg: ASbGncs/lofK0ZesqDSF1dHTdc9V5sx6FDfrIJMqC9itDjlvdPlsAi68+Wlq5mMthgm
	eDUpgw7kfRF4yYMYc1hrCCwdxp4Rj3mV/VAIXkKVo4Ht44VLgHlvIKsg3BHU7pijTiVldfqv0Iz
	Q1Hx6W+y7q4UxvlJyWWTmIvI/VWGwQz3qsT9n/+bwTnoSOba01nLE1FP1IL1/gC/TtNi4ZmMsqx
	Ai2nki27oIATMUIX+DxMrahh9A3NAXC5J7VSkJ7fwHDB1fh7I0r3kVB+LZ1cghWCW5qe5FbcH+l
	KhWXsan4PDFPiCSv0ofJA6V1qQQf4Q==
X-Google-Smtp-Source: AGHT+IEuvJYcDBtYOrHr6eTge7VSsC2aGB1FUS5KgBvJtcIiBMiiW38Fkdv7/nqi3WcHbezLD/qNXb2+4WYpAIH7lUA=
X-Received: by 2002:a05:6214:2621:b0:880:46d9:e33b with SMTP id
 6a1803df08f44-8817676490fmr2717926d6.50.1762448974730; Thu, 06 Nov 2025
 09:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com> <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org> <88d8a127-0232-01d4-130f-c59162b4f818@crashcourse.ca>
In-Reply-To: <88d8a127-0232-01d4-130f-c59162b4f818@crashcourse.ca>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 6 Nov 2025 18:09:23 +0100
X-Gm-Features: AWmQ_blwrZ2b2bfDKqvLnsIBffK8KOGtqMSIMo6gFKNi2-jIJiRuYSbp06euNuM
Message-ID: <CANNYZj_xMdhWEzemjNtjEazJQhNhRF1hDsj_iYY5sqknoibU0g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
To: rpjday@crashcourse.ca
Cc: richard.purdie@linuxfoundation.org, 
	Antonin Godard <antonin.godard@bootlin.com>, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 17:09:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18294

On Thu, 6 Nov 2025 at 16:23, Robert P. J. Day via
lists.openembedded.org <rpjday=crashcourse.ca@lists.openembedded.org>
wrote:

> > bb-layers-relative maybe?
> >
> > bb-layers-relative-to-this-file is precise but does feel a bit too
> > unwieldy. Any other options?
>
>   the qualifier "-to-this-file" seems implied and thus superfluous.

Alright. I sent a respin that uses 'bb-layers-relative'.

Alex

