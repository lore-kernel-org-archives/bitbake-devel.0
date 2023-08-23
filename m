Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B5C27C40
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:40:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.561.1692826848511442113
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:40:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Pk+zNYQw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so29864005e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692826847; x=1693431647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vWH3uMar1Evbt07nAZwl0GTAmZTKo1IFmwdSAagWVuY=;
        b=Pk+zNYQwYMZT8cvEZPsGfNlzcWo/SHwC3KVEMczvpGcat4LZMTp2h/6XHCFWCnTKYp
         sGrS8WIT6KQOtmGieaVyI3U246GfmIsphl9KdwBfHHU72Zd6ILhQm/c0JIOzRVlvhIRp
         4Gc49EoVaevHBIF8h9Tj4TY2aiUzMCUl2VCyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692826847; x=1693431647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWH3uMar1Evbt07nAZwl0GTAmZTKo1IFmwdSAagWVuY=;
        b=frviL7/jy6TY16IDUAnEzQHWyIPWqDGltxJqqt5MEUSiH/zro2o9KaRJeujTiJslWY
         8Mhcz9v2yY4nA4sc7B3ed/Gs2meNVB/ADtlUznejz7y1XZc17omLJUSGgL38E6dKHwBy
         jqIyx4QSgez+LjHvEkJUz6LOyVUKdSHi7DjPKkQlC51EwNRa7+gjay0FtJIaU/8+rcPJ
         oHOoD4YYQ0cu+LrLCFsfvgVNzKp9qTpuDwymbUQaGRHawSdPF1C1hQlFlT+7B88P4sKb
         S6hpoCipgVuL2rOm81wAAol7GS7US2Gau+iprhi8JBoDQS2FeFlb9H1KPmxpBT1jmf9X
         86ag==
X-Gm-Message-State: AOJu0YwrfhczX29U74YM8Fir0PBop72SbcrllBCZsj5z4P9U8EkZ6OoO
	F2gsvRK1tyv+A3d53xxfKQ/ubQ==
X-Google-Smtp-Source: AGHT+IH2GzJYlDdHBH5H1cn3EsFg0Vv8UkFKCxFLUd6codHrpGuN0BGD3o0yjiHIEtKRuPjC1RmzNg==
X-Received: by 2002:a05:6000:1361:b0:317:7062:32d2 with SMTP id q1-20020a056000136100b00317706232d2mr9399099wrz.54.1692826846893;
        Wed, 23 Aug 2023 14:40:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5461:c902:2158:9a5d? ([2001:8b0:aba:5f3c:5461:c902:2158:9a5d])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6101000000b0031c612146f1sm6883877wrt.100.2023.08.23.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:40:46 -0700 (PDT)
Message-ID: <151825c6950a24bd1614cdbbdb24c021ff664768.camel@linuxfoundation.org>
Subject: Re: [EXTERNAL] Re: [bitbake-devel] [PATCH] bitbake-worker:
 export_proxies if network flag = 1
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Randolph Sapp <rs@ti.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Aug 2023 22:40:45 +0100
In-Reply-To: <76f9f90f-5a76-426b-b425-5484655b21a9@ti.com>
References: <20230823210438.2172797-1-rs@ti.com>
	 <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
	 <b79ef56133cb5c2275560936527d822a32bd80a2.camel@linuxfoundation.org>
	 <76f9f90f-5a76-426b-b425-5484655b21a9@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:40:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14965

On Wed, 2023-08-23 at 16:34 -0500, Randolph Sapp wrote:
> On 8/23/23 16:25, Richard Purdie wrote:
> > On Wed, 2023-08-23 at 23:20 +0200, Alexander Kanavin wrote:
> > > Something doesn=E2=80=99t compute here. How did it work all this time=
 in
> > > tasks like fetch?
> >=20
> > Before we had network isolation, we did ensure we only set the network
> > proxy information before network access code. This meant the things
> > would break for "unknown" network access outside of the points in the
> > code where we expected it on systems that used a proxy.
> >=20
> > I've mixed feelings on "simplifying" things like this as we'd lose that
> > markup of the code and a second level of checking, even if that check
> > does need a proxy setup.
> >=20
> > Was there a specific place where the proxy information was needed but
> > not present?
>=20
> Rust, Go, Flutter, Matter, and all of the other new frameworks and=20
> languages that decided to be special and make their own build systems=20
> that reach out during the do_compile phase.
>=20
> Though, it could be argued that this is just a cover-up for the real=20
> issue, which is lack of proper integration of these build systems into=
=20
> bitbake. I still believe this is useful for compilations behind a=20
> corporate proxy for those few recipes still *cheating*.

Do we really want to make it easier for people to ignore that set of
problems? :/

People seem very very reluctant to try and fix any of these issues
properly and with the kinds of regulations coming in, this is a serious
issue whether people like it or not...

Cheers,

Richard


