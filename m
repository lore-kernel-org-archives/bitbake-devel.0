Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EEFD597B0
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 13:35:41 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.11449.1731504932923256487
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Nov 2024 05:35:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RWtGnUdH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316cce103dso85835615e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Nov 2024 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731504931; x=1732109731; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coG1kaUpwpB9CZJu40caMIAuOjYzOFxm6Gv5jk2FDtc=;
        b=RWtGnUdHQjiOfTvvFksYXugdmOdECAkAh33fxZ/PvTb67SS7oj5BJKL8eO3ZEJqm+B
         UJnv4FSkYtpDWYn+Pm0/+cFC0gvapEwaVkZMOYo0gaMXmMbuV7/aNz49kURZDX7WLRNk
         eago7atQk8FUYV/+eSxIl0C/7UGnyLr4ExqB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504931; x=1732109731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coG1kaUpwpB9CZJu40caMIAuOjYzOFxm6Gv5jk2FDtc=;
        b=e6reeS0+KwBOVMrFBbZ8ylZ0LKSo0qb4cAOzK2lTjgv58EVujueL1iGT8uaDvb4n2+
         PFlgIlkeyFMbwhsjyoK4NMibsNKGkcjtT4AVO1qpxalcC09pa/kvw8yLIgIqV4SPKECQ
         ng+Y2tvS742gexPkWT+moY1TMRXp1zBzQRj+MioeSNuC/7y8ptGf9zHaUWEqLG813PtW
         7u/dKmRWj1TdBNhq6Use+QEvp28SYFkqde/6dGLW0YGpCIIRipVlZJIMqE4ju39iF2xh
         T7taEEqemBFQcDDJco5nRQ+SoCLIhlQX6unORTrpctODeXRcQH2H7EigWx0bs64WmHdI
         29/A==
X-Forwarded-Encrypted: i=1; AJvYcCUed5wnLtGn2sfD6CDlMBKSr2q+OZEpYDArF+BYK79G5FIz64S6MhSGrVc6Oy4QWwzEoOz/tO6mnpc+sryc@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw+IfbFFO+1olEVZGQtSPqdu11H0t6pw8fBiItcwRiSz6gW82eX
	p/Fx1+jK/GB/beGUt047eqMJeW9ZjuuXpyI3k2JW/AyB90GUWezRZ2vZ42QJV8c=
X-Google-Smtp-Source: AGHT+IFWqwUax/Z0GycrSot0dQAuZJuJnju4tt5f2hVgnsnZMMNdnm7VXhkfCrXEA16WJFTi+BPmSQ==
X-Received: by 2002:a05:6000:402c:b0:37c:cd1d:b870 with SMTP id ffacd0b85a97d-381f1872118mr21799407f8f.29.1731504931225;
        Wed, 13 Nov 2024 05:35:31 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ab73:49b3:d413:b355? ([2001:8b0:aba:5f3c:ab73:49b3:d413:b355])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e46bsm18146677f8f.30.2024.11.13.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:35:30 -0800 (PST)
Message-ID: <5dd0a1168306f6915189ce95816d7fbd4d588cab.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] AWS S3 fetcher help
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: neha.dubey@omron.com, bitbake-devel@lists.openembedded.org
Date: Wed, 13 Nov 2024 13:35:30 +0000
In-Reply-To: <bi5D.1731435557154707775.iQWz@lists.openembedded.org>
References: <bi5D.1731435557154707775.iQWz@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Nov 2024 13:35:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16795

On Tue, 2024-11-12 at 10:19 -0800, neha.dubey via
lists.openembedded.org wrote:
> I am working on adding the capability of fetching from S3 buckets.
> When I add the SRC_URI I can see that bitbake is using aws s3
> fetcher, as it posts the command it is using to fetch. But it is
> unable to find credentials file. This is what I get from failure
> logs: 'fatal error: unable to locate credentials'. Yocto
> documentation does not have much help on s3 fetcher but how can I
> find some helpful example code to see how to pass credentials to the
> recipe? I have tried adding aws credentials file and then exporting
> it as environment variable when building like:
> 'AWS_CONFIG_FILE=3D<path-to-file>'. Would appreciate any help.


Bitbake filters the environment so you may need to tell it to preserve
that variable.

You can see AWS_* variables in lib/bb/fetch2/__init__.py but
AWS_CONFIG_FILE isn't one of them. Perhaps try other variables, or if
you really need that specific one, you'd need to add it...

Cheers,

Richard


