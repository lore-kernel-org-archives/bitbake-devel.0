Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246FC433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 11:03:35 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.9111.1636628612317677986
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JlP+F3aR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id t30so9092758wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=FLqcXdQnQR4KXe9DkXsts/d/7yVCq1ixK4nU+1XvQTQ=;
        b=JlP+F3aRhhAVfZwCTqnTCWurC9IX11N4NLoZEmFs5joCeyVKJLsnPj8LcrLp2N20Yg
         alWZ2FcW84qFjvEu87k6oz0pqA1o1ZmoRgCIa0onKfw3CKeWrYXDNJQa3tXzEN5xdCmh
         fPtFpDVNrWg+1AS8tT5BDjoPunOz5HWF5mowE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FLqcXdQnQR4KXe9DkXsts/d/7yVCq1ixK4nU+1XvQTQ=;
        b=2i40sZ/1DcCmUspaZzR2YaTrWY+VAgC9U3lfQF9UeSlddjX6EsQ0ak5Zjc/mlD2H1y
         zZuvgtoRI0+8g67bri2mT7sq1Yl5FESjhqkY/eDMomoD/Q45P8qfTfwh/AAk1JE9LagV
         +3e8rU7YvQVAPYaujtj+MKG/7pZNbxhJZCFqUHhbKVh7olOH7sKPIz0TAyvJA/Scf7sp
         JSp7Gdn5/wPsyhEb7NaSi7GGuBBhdl3AuAY1XPUoycoUM3UOqcSN/18ovmmYLhm2P+7s
         SQpv2dL/PiU7ZPxoAOffvmgmGgWg+9Y7GODYJhZdV25oZ9nTNt9YF7tAlkV+whKl9Qyu
         wYOQ==
X-Gm-Message-State: AOAM533Xs8S93nMdBHPyxi9es/lHHbT6XXUmv3Ep6R5y9TwmXcIyuHcD
	Vpxp9A6zOSGLrqb+rzoOqoFTGg==
X-Google-Smtp-Source: 
 ABdhPJytsmxZ9hizslowB9SttjkvxE0TM9V427RnnhnVllwNd3ARTZSS8srKOOJjlsTIN4QCwQlfsA==
X-Received: by 2002:a05:6000:1010:: with SMTP id
 a16mr7661268wrx.155.1636628610660;
        Thu, 11 Nov 2021 03:03:30 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:b19:11f4:a3d9:cabc?
 ([2001:8b0:aba:5f3c:b19:11f4:a3d9:cabc])
        by smtp.gmail.com with ESMTPSA id
 c5sm2687490wrd.13.2021.11.11.03.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 03:03:30 -0800 (PST)
Message-ID: 
 <5b3eb5a7a03a999e37b2ac0aacf2997819c00fd2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: gabriel.valcazar@digi.com, bitbake-devel@lists.openembedded.org
Date: Thu, 11 Nov 2021 11:03:29 +0000
In-Reply-To: <22842.1636557332722004495@lists.openembedded.org>
References: 
	<CA+chaQc1n4sZDrNvBN5HGebqWLKLSXFr2w9xDEKhQMEfg_dOrQ@mail.gmail.com>
	 <22842.1636557332722004495@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 11:03:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13008

On Wed, 2021-11-10 at 07:15 -0800, gabriel.valcazar via lists.openembedded.org
wrote:
> Thanks all for the suggestions. Indeed, creating a fork of poky and applying
> the
> fix ourselves seems like a reasonable solution if there is no official fix for
> old versions.
> 
> I've just tested applying the patch to bitbake 1.18, and I'm able to build my
> Yocto 1.4 distribution with no problem. Is it not possible to officially
> backport the patch all the way back to bitbake 1.18? I could provide the
> patches, but they're literally just clean cherry-picks of the bitbake 1.40
> patch.

The trouble is there are a *lot* of fixes missing from 1.18. If we start
backporting this one, which other ones should we backport? If I don't say "no"
to this one, which other ones would I then need to take?

I appreciate this one is relatively safe and easy but it is also very easy to
backport something which applies cleanly but causes all kinds of issues.

We can't really start giving the impression we support things as old as 1.18,
much as I'd like to help. I can't imagine this is the only fix you need with
1.18?

Cheers,

Richard


