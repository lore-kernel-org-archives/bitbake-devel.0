Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C47D13588
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 09:17:49 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.47534.1730107066312828986
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Oct 2024 02:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BeTmoUX5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.177, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb49510250so38627911fa.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730107064; x=1730711864; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqAu1TNggFBcvK71DKKqV0jKs6l7lg/n2HM/yQV2qEU=;
        b=BeTmoUX53ctRbsMtgQ9dA5xhR/4A6KrdqJpPtMZTTKyXFtb9YpyBVy+Fwd6E0UhC39
         Ejz2dilFQdtGK4sCPLTfnl6/xP+7LPt6HfiewBmRmHqBEBQ3q+dn9dudbaAzi3kaCheL
         mRjRJoll3CFmFdTsBzjckjf+VEbNK4wFw3wQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107064; x=1730711864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqAu1TNggFBcvK71DKKqV0jKs6l7lg/n2HM/yQV2qEU=;
        b=QvDNnup56Ihsf5otOFtj1d3+3V0MNHJlTag2HL8axj26Ra9It4teWSobF/4RsQZXGN
         6j+Ck0eOp48gcWHraEcxEgHDR6eczlxZgYBKljMgVsqQONJf4QzgUSfmSgwN54nBDaDq
         UU25o7HvDbJsbz5dfaMW9l9mdRX3SqVXoendhmy/R5YeSg0gAwyWz1ZvnZS7pZHOUYzA
         hq4x5Z3u0ITxPO+0r4WVPuanHFTwUjqJBUfB9ypkycCEAMxOY6Hm2FyYIYsITpgpH3Y6
         o+u6UjDCuFGTipoZ5V/0CQeMUKtyE89I2Qwmrl0cW8FmUBVGQRPiu0YYUvsmR3a6pWop
         x85g==
X-Forwarded-Encrypted: i=1; AJvYcCU11R2e42q3VMyvel6/uwd/dPIqJDLww9Ez2mAejrNq152xCLPajpX607T3iXbiyfD1PyJLBGpgfPiWUMcL@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz0f/e8dssOkmSucFBZ+K+bpbPmFvN6YoJNncLhUo5IeXrYDMCM
	Wx2v/1fKpHKWiEh7kTWZLna3BLIqePEpEEt7HBrPAmYdrtRouHjsSGvV9ehR7xw=
X-Google-Smtp-Source: AGHT+IHcwGtnCwfu2pK4y3vdzj3UBnQ4mVpaxHOvnDr2qZOaDZnGpn1qwz2uFB7TWK8gtJY+KcUqsw==
X-Received: by 2002:a2e:a78a:0:b0:2fb:c6e:9a36 with SMTP id 38308e7fff4ca-2fcbdfc6495mr26421911fa.24.1730107064031;
        Mon, 28 Oct 2024 02:17:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:73ef:5707:ed3d:2605? ([2001:8b0:aba:5f3c:73ef:5707:ed3d:2605])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b57a1a4sm133167935e9.41.2024.10.28.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:17:43 -0700 (PDT)
Message-ID: <d2fbb000fdcaa8728c6de2337a88df6eec631a2e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Why bb.warning output goes to stdout?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: amikan@ilbers.de, bitbake-devel@lists.openembedded.org
Cc: Baurzhan Ismagulov <ibr@ilbers.de>
Date: Mon, 28 Oct 2024 09:17:42 +0000
In-Reply-To: <e189adfe-65b7-4d04-a2a2-0aed0ddeedae@ilbers.de>
References: <e189adfe-65b7-4d04-a2a2-0aed0ddeedae@ilbers.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 09:17:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16734

On Mon, 2024-10-28 at 09:57 +0200, Anton Mikanovich via
lists.openembedded.org wrote:
> Hello all,
>=20
> I've just noticed that bb.warning() API (and also bbwarn FIFO API) output
> messages to stdout, while warnings are usually goes to stderr.
> Having warnings in stderr can be useful if using pipes to inform the user
> about any issues without hiding them. Python logger is also output warnin=
gs
> to stderr.
> Is there any reason of bitbake to output warnings to stdout?

It is a good question. Partly history, I think bitbake always did this.
Partly that warnings are not fatal and don't cause failure, unlike
errors.

It would probably cause disruption to change it now as there are likely
things depending on that behaviour.

Cheers,

Richard

