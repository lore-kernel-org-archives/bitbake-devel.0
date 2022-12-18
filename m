Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B54C4167B
	for <webhook@archiver.kernel.org>; Sun, 18 Dec 2022 21:41:31 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.6933.1671399684736036048
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Dec 2022 13:41:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iK9jWy+G;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id h10so7044738wrx.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Dec 2022 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fKcV+pawju/T5OvzAUwush+Z1OMXqxNgRQs0ACNwjk=;
        b=iK9jWy+Gj+FeOYRV7WWE7eHqrrCB/8uuicYuQ8P5o+ibOQZyQw4hiqjGsmFbvSuA92
         G2+d49CbpFNOdEbYRc9ViAaMyhhyihRa/iyu4ziwRiSMgONyJRxHQv790gW8nqhptgBl
         4+n0qKRaDr+vmzszHQ5z2cRoj132WmkW1EQGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fKcV+pawju/T5OvzAUwush+Z1OMXqxNgRQs0ACNwjk=;
        b=SfixvcnjGPl7eufy9rxcIfiaU07bj1a6cDl9xREhhRfjI548YSomlnBc2WdqeSaxXy
         OOhY8VXJQ7gB+QOLsZgAj3GEPiniGWPw432FqLFzWddvFI69eXVmBeCboPCf/jrqymbI
         5N4p9GPjGh1almalIc01mVyLU3P8sxFQ/EHIlV8p9LDrVMbchnI1BHI+giRLs9MzPg3d
         +M7QMI42uM2GPPYrqQop50cIjv3nCois9Qx6QUm87/zTBgYRoUIiyqSKCngmPTYJX541
         xHWPQCNPUXcTfNJbZ0Tb6sjhtBb5oVwRSLgWb/dBemf7NcVqRNcXOz5/AtA27TuLRlQz
         asxg==
X-Gm-Message-State: ANoB5pn4kkg7lNntwkCwStrN4j8J3NoH99vo2Sl8BKZm5TcSdAfYKVV+
	ExFX6uTe+dZnaA4WXpoZejt3xA==
X-Google-Smtp-Source: AA0mqf4TkARVHFFg+QeNGgKTyzpopiv8vZdoYt+aTIWzoqBV9P3J0IpjGiNXSFlq0LB/cIDOMDn/rA==
X-Received: by 2002:adf:ea8f:0:b0:242:70f1:2134 with SMTP id s15-20020adfea8f000000b0024270f12134mr34178080wrm.60.1671399682689;
        Sun, 18 Dec 2022 13:41:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c6da:1aac:207:2ac7? ([2001:8b0:aba:5f3c:c6da:1aac:207:2ac7])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d4344000000b00242710c9910sm8182657wrr.8.2022.12.18.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 13:41:22 -0800 (PST)
Message-ID: <64b26408f1b87a4b8e58268cb9529e0952c30582.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Enable to use some bitbake server
 commands
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yosuke.nky@gmail.com, bitbake-devel@lists.openembedded.org
Date: Sun, 18 Dec 2022 21:41:21 +0000
In-Reply-To: <12037.1671292360153891865@lists.openembedded.org>
References: 
	<666017467d067ed9473268336311c98dcad4dcad.camel@linuxfoundation.org>
	 <12037.1671292360153891865@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Dec 2022 21:41:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14196

On Sat, 2022-12-17 at 07:52 -0800, yosuke.nky@gmail.com wrote:
> > I'd like to understand which objects are being passed which can't
> > be marshalled=20
> AFAIK, the type for the objects which can't be marshelled is
> `collections.defaultdict`.=C2=A0
>=20
> > =C2=A0I'm worried that two different behaviours between the transports
> > where one silently drops data isn't a good idea.
> I agree. need to see if there is a way to convert to marshallizable
> object.=C2=A0

It looks like we may just be able to add a dict() wrapper around the
return values if these are all defaultdict objects?

We also need to go through the code and make sure the code using these
commands is not using functionality of the defaultdict.

> > I'd also be interested to learn more about how you're using bitbake
> > if you can share anything?
> I'm developing bbclient that=C2=A0provides command interface for bitbake
> server. I'm working this as an part of visual studio language server
> for bitbake.
> I'm sorry. Not very common use, I know=F0=9F=98=85

It actually sounds quite interesting, it is something we've wondered
about for a while. I'm curious to see how you get on! It is a use case
I think bitbake should support.

Cheers,

Richard


