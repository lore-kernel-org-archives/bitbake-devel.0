Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2335BC3DA6F
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:43:39 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.620.1692827009704372202
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ed4jw1W5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40057e09bbaso7549635e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692827008; x=1693431808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=svko4/2QmH20hShl99GU/f84jczVOqXxGCP/E/yZz3o=;
        b=Ed4jw1W5FuGvypy9+kCNOFnuXk1RkcRlFEiFU7q7+up/M2YnmkGkXmdWv1QGuRj1rl
         sd/KEnEe4HXg+WbXtjVPy8ffBwwc8LB1B53l9wmTV61mgAJBOIxwWsjvUSWCJMUQBlgW
         h4t6gQ+taR60aQIX0GYZX/S8i1XJFsgxCIqME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827008; x=1693431808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svko4/2QmH20hShl99GU/f84jczVOqXxGCP/E/yZz3o=;
        b=VCEhs33T1P0sOWeTcNiRc80djBjMOICSttLCwI1JTD210zFq7aLYTH9r9ssxnqbx83
         jX0nz+zKNDEMwrosZ2hrznwk9EmwfMYiTXUnOrxSCsTAps+T8EDY7UtMW3A7nzsjuemX
         AtBhg4KbBHmRAjWR9ABn7eCa8rAQqvePdtsBYPMpJ5Ke6bhQB5X9tP/S9ezHtlx17Gmi
         upN4gqmo4EOhc5qmhN110Q49Vo4KIubaMKS6ronJxqZKiFpQUIBNDL+WPaFllmRqZWam
         lGUYmWik8iiIsdoGK7jemDM6LdUWU6Pa0cRoz1gyrlcgZDU5fItAmAokDpWHXAbn3QQ5
         Gs0Q==
X-Gm-Message-State: AOJu0Ywfsk+GbkP5zKmr862qJXz1dsqJJVlvub43vEBKZoAXUUFHFnBC
	sRM0K30YC1TC85yvrl6/JC8WNF8mVnmc+5Z/wbQ=
X-Google-Smtp-Source: AGHT+IEksFrMagp6uvzF4Tmc4vFsCshPySZdXA9mWknb+2BXbZrcySaz5N2Z9z9QCR3RM75uz7vw1Q==
X-Received: by 2002:a1c:f204:0:b0:3fe:d71a:d84e with SMTP id s4-20020a1cf204000000b003fed71ad84emr10908400wmc.1.1692827008077;
        Wed, 23 Aug 2023 14:43:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5461:c902:2158:9a5d? ([2001:8b0:aba:5f3c:5461:c902:2158:9a5d])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c22d600b003fbd9e390e1sm670352wmg.47.2023.08.23.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:43:27 -0700 (PDT)
Message-ID: <d919a55403c39fc3b11499aedfa9daacf607c1fc.camel@linuxfoundation.org>
Subject: Re: [EXTERNAL] Re: [bitbake-devel] [PATCH] bitbake-worker:
 export_proxies if network flag = 1
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Randolph Sapp <rs@ti.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Aug 2023 22:43:26 +0100
In-Reply-To: <bb78cd5e-8df9-49a4-be07-20a84f0b8ecd@ti.com>
References: <20230823210438.2172797-1-rs@ti.com>
	 <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
	 <b79ef56133cb5c2275560936527d822a32bd80a2.camel@linuxfoundation.org>
	 <177E20AFE73C2B6B.11498@lists.openembedded.org>
	 <bb78cd5e-8df9-49a4-be07-20a84f0b8ecd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:43:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14966

On Wed, 2023-08-23 at 16:38 -0500, Randolph Sapp wrote:
> On 8/23/23 16:34, Randolph Sapp via lists.openembedded.org wrote:
> > On 8/23/23 16:25, Richard Purdie wrote:
> > > On Wed, 2023-08-23 at 23:20 +0200, Alexander Kanavin wrote:
> > > > Something doesn=E2=80=99t compute here. How did it work all this ti=
me in
> > > > tasks like fetch?
> > >=20
> > > Before we had network isolation, we did ensure we only set the networ=
k
> > > proxy information before network access code. This meant the things
> > > would break for "unknown" network access outside of the points in the
> > > code where we expected it on systems that used a proxy.
> > >=20
> > > I've mixed feelings on "simplifying" things like this as we'd lose th=
at
> > > markup of the code and a second level of checking, even if that check
> > > does need a proxy setup.
> > >=20
> > > Was there a specific place where the proxy information was needed but
> > > not present?
> >=20
> > Rust, Go, Flutter, Matter, and all of the other new frameworks and=20
> > languages that decided to be special and make their own build systems=
=20
> > that reach out during the do_compile phase.
> >=20
> > Though, it could be argued that this is just a cover-up for the real=
=20
> > issue, which is lack of proper integration of these build systems into=
=20
> > bitbake. I still believe this is useful for compilations behind a=20
> > corporate proxy for those few recipes still *cheating*.
>=20
> Also, any custom tasks people add that have network dependencies. I just=
=20
> think it's a little rough having to play whack-a-mole with task and=20
> proxy oddities.

The idea is that you realise something is not right and then fix the
issue properly, which would be proper SRC_URI support which then means
we can cover SPDX manifests, license auditing, source mirroring and
reproducibility amongst other things.

Sadly most people just want to ignore those things and go for a
quick/easy fix.

I'm therefore torn on the patch. How easily do we want people to ignore
these issues?

Cheers,

Richard


