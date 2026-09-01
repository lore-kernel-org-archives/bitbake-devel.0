Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9368EC61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 18:28:39 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1836.1788287314724191062
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 11:28:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lRBU9spq;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-936dfd009d1so173210985a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 11:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788287313; cv=none;
        d=google.com; s=arc-20260327;
        b=sA2mApKKIPN+gDHf791dyU7Am1x6YETr0bIp5TMhW5ciK9Ny7GEF2dmDYOatTS2RET
         bJbl39PcbQSKobTFAg0LrRNafm6szbR7D5AHAwHfuQqB+WW4qUVBYkyoLsJV0SKdoYYE
         21T2hUl2mlo0q00xPy1RH+34DGBV33PwUwj50rLKv//Q/djGRqdlnTuKa/j9EowDLhf9
         MUIJSKp0+3/ptCkE93yHjmJm5DLeEV3p/mK1+zrfaPQh4Z17BI3ZrUG4ggg5YYJi+gM5
         xXrZYcIxHvmb1WS+FeOjehM61x8I1p2+ZKh3Z8v72t1wXZbLLHhxyqiL+n5opvg32nba
         qdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5kc+/yYe8bMn8H/2WtukI0pRx4vMiNcRc0T1MI4h2cU=;
        fh=NruX9YT3//5SbihJhU5ZsoXNUbwQbnK8iHEcKr7skuI=;
        b=afdNF/Jx28Ob0DyrpaKLXJJgVUIYFZIo4ltj+83acaOs4I/JMv6FJtWxi4VJjujEpA
         3gMCSpEEZn8rjsb199NcVSJrpVRSyPrtgPecsx1khGNbiqlSBoffhq/uIwhoUDYpb5le
         b3GSU48ChboNafNajtrNq6Foc1JzCozveIqkwKTtVfDX3VwQaG9vW+u5Kvl6cEcIPufd
         oa+EIVbWh+FXGC/KyypjatixiHkU+S5LBfW0Qkc3wkUCrky0DWz7wCprkYDUyzDkyiar
         Dj0ZDThSqVZXU6cBfe10l7wjLHKlAbpWv727Oz+xzDw3a6wwkYEhpV13VA7CdZPIwoNi
         gMFA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788287313; x=1788892113; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kc+/yYe8bMn8H/2WtukI0pRx4vMiNcRc0T1MI4h2cU=;
        b=lRBU9spqDscmsm4CpQsxwpWg0tu+iNDUTSvrM/g2u2tCpMtm1yfdmFi4LhH84QxOf3
         Qm4Su47eNFCW29DUAZRS9X8n7AsU/4mY03QhPQEBbKZfj9F+3WkOcgwELxo8JA5YSyNh
         GiFlQ9QznNhrz8M5m6zvCsFSj3uP/II3tasvdSEpSuFuIgB8PhJiKBxiZ/J80BYw7LTE
         ZSHesbIcwZjr5w0F/QLiHwLAIBhW2YimiUNlP4VLI/67Peey7ghKp8RgDCho9SvwmAHx
         nAay5stoL0zAcOaeZbC5XQR0sVURjus/uA+QGmgu7StjW4t3rQcv1eGMWcALXF5s3vJ1
         ii5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287313; x=1788892113;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5kc+/yYe8bMn8H/2WtukI0pRx4vMiNcRc0T1MI4h2cU=;
        b=Y7VV7UMiGQY0Gze2y+pozyj0dtvF31HjsvlKWYONfszzI9WeRmmBrOz42Cpyp1lBKr
         ekQMi5/gEfcklM6Xfn7US4nZT4wumVdAr0bnep0VYvnSxZnP6lFF82g9Y0mQLYYo7Z52
         LSMc+cYJr8CW1U6iF4S2zO4xKvMBTal6tYGz0NC3vToiH/Uj92pNCxczGiv7Z4crq6sx
         NhXzNBIPue0bTesjxEwIgnW9pSExj0wk+n1VKfZD82/TIatam63cGz8JsAIKyHBp/q32
         l/27V3tPw+0CGfDcfX87oPSnVSndUuHfOxbnAAHGUWhJj9U3E7T0++EYQMSnKgfnntDo
         Ivdg==
X-Forwarded-Encrypted: i=1; AKwUvByQbqtb9bsJcEX5Q0OmLwoRKWb2D4rWt3kj2bHXHKc+1HxK+cxHYz6fVidOEApSWDFi0ThL6UlpOQx2X5Oq@lists.openembedded.org
X-Gm-Message-State: AFuF++k1fyWBOC+BYra32xueVD8Sr3LPWev3n9aVRMziLCiujhZUoMaG
	8OXla2Y96z6CRjlDZs8KEKN8+WiCzMrB8ZyZeDucPr/DCobnpXWYYb/NI6DCrgwYj0TvFEqjZbO
	gtNiyEOxViNUhc1/6/3QJprzXivdYPFo=
X-Gm-Gg: AYBFou2uHWcVw9ixwKcz3oIQA4T02ijQDm4Ai+8MBqmc7jWoSOec7Y9vQ/HZbHGbEOi
	SGKgg9cR2H4TmV1zyjTk85NsNC8Dt/C2sAvFNnjHGsa3V35OqzYmchFpYvp6ss8b41Wff3UCWo5
	ivIGc+gmFyhNSyfuawRphEZYWxWuvCcnRjM/OQfkX00qVySIRGzDlEEOA0SltWHAsra6/ZmweDL
	3nkX+gt8E5vkT/dVf0W+kTym3BnDCxhMAwaD+ZbVm7k+XHc+68d7ICCTg/QUweVV+lCxxuY1ADL
	3Al2lySUph4Bbf55MRWgiIn2Ekd8xegSGqh62gqVo8wtyEE8JQcFmDmBYrJdhAYs7kfuRP0Uynm
	T1HQ=
X-Received: by 2002:a05:6214:54c9:b0:908:4249:337f with SMTP id
 6a1803df08f44-90e9573cf09mr118212366d6.5.1788287313453; Tue, 01 Sep 2026
 11:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-appending-fragments-v1-1-2e359cf751ce@bootlin.com> <afffba8970ad228db773766f7f6c894cbb021279.camel@linuxfoundation.org>
In-Reply-To: <afffba8970ad228db773766f7f6c894cbb021279.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 1 Sep 2026 20:28:16 +0200
X-Gm-Features: AcwNN1WjrWaHEz4QLKJCnNRZLKNsmEWA97yEIp-SMWfgCpBRlOajddvWFaztRM0
Message-ID: <CANNYZj8cso=2X3Wi3u=59Xzt92g5V6CvuDtLD-Y8r3HycKBOVQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH RFC] parse/ast: add support for additive
 built-in fragments
To: richard.purdie@linuxfoundation.org
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 18:28:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20138

On Tue, 1 Sept 2026 at 14:15, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:

> It is definitely an interesting one and the syntax isn't too bad.. Are
> there uses beyond class inherit though?
>
> machine/distro were added as they are clear variables in common use
> which avoided tons of boilerplate in layer definitions. Do we have
> similar needs here or are these inherits better captured in config
> fragments?

Antonin first wanted to just add 'real' fragments (that are defined in
files) for common class inherits, and it was my idea to implement
additive built-ins that make it generic. It's something we can
consider and discuss, I don't necessarily insist on a generic
implementation.

I guess we can all look at our various local.conf lying around, and
check what's piled up in them over the years. In mine, two variables
immediately jump out as candidates for additions: IMAGE_INSTALL,
IMAGE_FEATURES. Those certainly will not work with regular fragments.

Alex

