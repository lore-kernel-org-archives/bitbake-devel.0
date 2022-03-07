Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDCFC433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 09:49:30 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.24484.1646646569460649118
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 01:49:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=X7KHBaP+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id q20so6468925wmq.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fm0mf8/2hxi7Y51nGE2wP5mrk8U+5dXW6uDiPf4+isc=;
        b=X7KHBaP+Ozn8ZfEHZ9H07yz1tUvKt1HF2DalTsn6KuMeOF2D/NLKbB95r7PtJ9S/so
         LSnvxy8++mbMyXgqi0mAEaQT3v8P+ju8aMRSuFEKZ/AwajkN7IfpjtAUnTJAN/3/bAhm
         K+vjEOn6o/bwLsJJKccPkz7dB2YpOplSLSuM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fm0mf8/2hxi7Y51nGE2wP5mrk8U+5dXW6uDiPf4+isc=;
        b=Hqzu2IB46hdg31H9c/HvDrvRolS2c1IHtj9aRyaXZamq03knp9SCz/nGJm+lkmUyDu
         4BXA13CWCO5/p/4VdS6R0LsFIsSXADZf0Ejq/40vg/tNBQCrwC6OribUVu6UfQeZ2YCu
         gwsNjp+RX+pej4aefgmIYRUYd52sjCOvUDQ/iAeC35ukHdr2ebb5edP83VlMeDordWGK
         tV+zfyT+7ljQ3s2wBtXZcim/JjRhyriHBICOyiQ3Uy926iIT0dH4mNMEZ0Mb7XTwTaiw
         RK8yvQ8FdQ1ncl4HfB7Kwj1d/4zOB83E8xPOxjWlTzF7GT29PppYD4Kp3GTDTxYctC8q
         yRhg==
X-Gm-Message-State: AOAM530P+PGI/cTdNVBiUbw36BSQTYCVAtWj9HnhiUEh4Al0WCQZwykB
	j7Cu95T4JKYqzcLIEFZ4PJ/xiw==
X-Google-Smtp-Source: 
 ABdhPJysD4AcjjZ+pYcti9DHFq/0d1aESp3ueRvGvD+ZLJ8rHAvZ5IBEYfiQVikoTJl/qpf0ECz38w==
X-Received: by 2002:a05:600c:3c98:b0:37f:2f14:7be7 with SMTP id
 bg24-20020a05600c3c9800b0037f2f147be7mr17638338wmb.180.1646646567930;
        Mon, 07 Mar 2022 01:49:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bb31:2700:8490:fdf8?
 ([2001:8b0:aba:5f3c:bb31:2700:8490:fdf8])
        by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c351400b0038688a67568sm14398778wmq.21.2022.03.07.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:49:27 -0800 (PST)
Message-ID: 
 <b39e90ba68d15f6e13a6ec7ad9557b83f1dca176.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual: further
 override syntax updates
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Mon, 07 Mar 2022 09:49:26 +0000
In-Reply-To: <aece6598-6fef-0d61-abe1-fdc80d01e39e@theobroma-systems.com>
References: <20220304201150.418001-1-michael.opdenacker@bootlin.com>
	 <aece6598-6fef-0d61-abe1-fdc80d01e39e@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 09:49:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13419

On Mon, 2022-03-07 at 10:37 +0100, Quentin Schulz wrote:
> Hi Michael,
> 
> On 3/4/22 21:11, Michael Opdenacker via lists.openembedded.org wrote:
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > 
> > ---
> > I think I found some missing updates for the overrides syntax,
> > but I'm not sure, so please review carefully!
> > ---
> >   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > index 174cac78..b90e5cf0 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > @@ -511,7 +511,7 @@ variable.
> >   .. note::
> >   
> >      Overrides can only use lower-case characters. Additionally,
> > -   underscores are not permitted in override names as they are used to
> > +   colons are not permitted in override names as they are used to
> >      separate overrides from each other and from the variable name.
> >   
> 
> I think we can now safely say that overrides can have underscores, 
> dashes and digits in addition to lowercase characters? I don't know if a 
> variable can start with an underscore, dash or digit but we do have 
> x86_64 and qemux86-64 which are overrides AFAICT? This should show we 
> properly support those "special" characters. Probably would be better in 
> its own commit.
> 
> Otherwise, for this commit:
> 
> Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks. It does look correct to me too. We do support digits in overrides and
dashes. Underscores have a history of being painful and are the reason we have
TRANSLATED_TARCH_ARCH:

bitbake.conf:OVERRIDES = "${TARGET_OS}:${TRANSLATED_TARGET_ARCH}:pn-${PN}:${MACHINEOVERRIDES}:${DISTROOVERRIDES}:${CLASSOVERRIDE}${LIBCOVERRIDE}:forcevariable"
bitbake.conf:FILESOVERRIDES = "${TRANSLATED_TARGET_ARCH}:${MACHINEOVERRIDES}:${DISTROOVERRIDES}"
bitbake.conf:TRANSLATED_TARGET_ARCH ??= "${@d.getVar('TARGET_ARCH').replace("_", "-")}"

although now we use ":" as the override character, we might be able to rethink that.

Cheers,

Richard



