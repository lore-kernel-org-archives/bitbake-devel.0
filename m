Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A94FC4167B
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 10:58:55 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.18362.1671447526322746661
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Dec 2022 02:58:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QVcBd3xW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id bx10so8275561wrb.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKNdydkMFMdICAKia3m3NJACh8FgaJGmbZJSTUxKpfI=;
        b=QVcBd3xWwHnEHiglK1znMgKTbvA+qdsIkB/ujVidMPzglLzaRwshnq89NaE74hh5VM
         5nULbWveFGW43ZDWxWs4phuaUznE7O2Bzpv4IZnvezue9hBlBixtMmSkK0f8z86Ah3f0
         pg1qrTlh/zWJrODrCcl1f9R4r0Kx9ClqM6PNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKNdydkMFMdICAKia3m3NJACh8FgaJGmbZJSTUxKpfI=;
        b=1JJBd7Y1sAVxhLKATokZtsMrT1CGuRQCetpQi9GLdTHpcGpdkg/1++yhWiVi03loBj
         IUWyN1dEtTyhW5ykLHA7H2+9p4DeUeeqpsFotsdWIAWkgO6OJ+QtNwdhDQnmg51ljyao
         VmRvzufwx+YW+5d4D9xpgTsLO61OQzR1zh/0MeriFM+N6swp1ouNlyWkZkaiLm+ap25G
         dZJAUC/D3CQxWst/xrTo07hp3Jkc3Ik4x5quMvMEbYAK6zE0ADmgse+HzEgdfZSiIMTl
         l2/WMJyIWaFPADIjYxzXjIVCDQeVU3hi7UPiAagdJwlUm4J5KggCyfW7rhtoDyOKWsIm
         LPow==
X-Gm-Message-State: ANoB5pngfp4HD7+fekpYZef7C0/ZDug76togRWe4lu7IqqRY7TUh7AtK
	Wpks3mDa1NMPrHdUmDSqrkcgqw==
X-Google-Smtp-Source: AA0mqf5IfK4fF4gez6oGjGkTi+icparcu/tLIBZWcqsnLnL2gDDP2x1VZjpZkCiBrzfWCnK7pS4sEA==
X-Received: by 2002:a05:6000:1d9c:b0:242:7eb8:37bf with SMTP id bk28-20020a0560001d9c00b002427eb837bfmr28348515wrb.32.1671447524415;
        Mon, 19 Dec 2022 02:58:44 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac4f:7328:1210:6c79? ([2001:8b0:aba:5f3c:ac4f:7328:1210:6c79])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b002423dc3b1a9sm9618365wrn.52.2022.12.19.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:58:44 -0800 (PST)
Message-ID: <982d94511de46a7c9e7eed63c1c1cdc89d4ca816.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] wget: Add CHECKMD_wget option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alp.oezmert@mercedes-benz.com, bitbake-devel@lists.openembedded.org
Cc: changhyeok.bae@mercedes-benz.com
Date: Mon, 19 Dec 2022 10:58:43 +0000
In-Reply-To: <a7e199839adbd9e003c04d1bd021f5f0d8f2cc3c.camel@mercedes-benz.com>
References: 
	<a7e199839adbd9e003c04d1bd021f5f0d8f2cc3c.camel@mercedes-benz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 10:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14198

On Mon, 2022-12-19 at 08:55 +0000, alp.oezmert via lists.openembedded.org w=
rote:
> `CHECKCMD_wget` defines a command that the wget fetcher module will execu=
te
> instead of the built-in HTTP client when checking if URLs exist.

This says what the patch does, but not why. I can read the patch and
see what the code change is but I can't know why we need to so this
information is much more important for the commit message.

>  This
> allows to completely match the behavior of the wget fetcher including pro=
xy
> and authentication.

We're changing the behaviour of the wget fetcher to match the wget
fetcher? This doesn't make any sense.

> By default, this option is empty, and wget fetcher behavior is not change=
d.

Why do we need this? Why can't the HTTP client be used?

What this appears to do is add two different code paths meaning we need
to double our testing. I really don't want to do that.

Can't the inbuilt http client code be fixed to work with whatever
auth/proxy issue I'm guessing you're running into?

Cheers,

Richard

