Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F015EE8017
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 15:29:19 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.42273.1694186957202188476
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Sep 2023 08:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LiJR+Vmx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-317c3ac7339so2021886f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 08 Sep 2023 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694186955; x=1694791755; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rdG4QAoIFIFJI+H7UCa+x3G13JgcjYKpYK3kAZ51FQ=;
        b=LiJR+VmxW7gjZIkk13grWpymyn/ORThiWJ3jQkSuNUkOr5VAWh+da4eZvJnrJ3k1t8
         fmUgTG+eHT41aAaE1fCSeqWSdiRjdTOXmnYup7VhDPiJqQELrTAv5Ta5tUQL249Dpyqw
         w2pIGw1F1JqVAmzIWCsH6wys3GbDJGPHruPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186955; x=1694791755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rdG4QAoIFIFJI+H7UCa+x3G13JgcjYKpYK3kAZ51FQ=;
        b=ZNMPAETH4ROr+H+T9GEQT4dGGeWbmkCXXESG3/K7ty3QvnUNSTnMbM1ivvbTevEqyw
         qR0pKuNymRICU4obhXew7MyfUGidMS3JAw1IhHPxvfi2dPLmYNDIfqrIt3MIdOHa7gpG
         Lkkl1CXFEkwNwZf5jai1TG87XO0y/IfQNEbMndoy8I8jPrLkBx+RcuH5Rk+syo8GgJU+
         8gPX7fnuYvOa6Ym2BxctJT1o/7aRu1dvgmN4Q4tgxTuO/CajNM0qxsjBVci12e8mPmVT
         VK4Lfi6wlmn5J15A3G5UcKsv2H7/ffi2bAoJVk9Vpw2VuMmwM0uOrkmmHRSpXdntNrqS
         cLkw==
X-Gm-Message-State: AOJu0YwW2urTaO0wLzV1I7UArLjmY40K5a0CcXJ/8K0cR+z+V6tF4peX
	bKFYpm8MMQ26tjoWLF2s2T41Lw==
X-Google-Smtp-Source: AGHT+IGzN+Lr9cLerFM/mdTIly0aEcAF1E2HnzGwslny5l89VsvT9mZW2PvCWwZpzE/lrrlaqwwsyg==
X-Received: by 2002:a5d:43d0:0:b0:31a:d871:7ae7 with SMTP id v16-20020a5d43d0000000b0031ad8717ae7mr2231020wrr.29.1694186955571;
        Fri, 08 Sep 2023 08:29:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f8cb:1f37:5b30:431c? ([2001:8b0:aba:5f3c:f8cb:1f37:5b30:431c])
        by smtp.gmail.com with ESMTPSA id c25-20020a05600c0ad900b003fee567235bsm5508078wmr.1.2023.09.08.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:29:15 -0700 (PDT)
Message-ID: <fe14201ece95b570c0932341f885032f343db99d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Error in bitbake-selftest
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: asifaligorikhan97@gmail.com, bitbake-devel@lists.openembedded.org
Date: Fri, 08 Sep 2023 16:29:14 +0100
In-Reply-To: <a8Vo.1694166021887221847.XYCR@lists.openembedded.org>
References: <a8Vo.1694166021887221847.XYCR@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Sep 2023 15:29:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15016

On Fri, 2023-09-08 at 02:40 -0700, asifaligorikhan97@gmail.com wrote:
> Hi
>=20
> I am getting this error when I run bitbake-selftest command=C2=A0 in my
> bitbake directory. My Image is built ready. I need to run selftest in
> my built image, help me to solve this issue=20
>=20
> Error is as follows:
>=20
> Stdout:=20
> Fetcher accessed the network with the command git -c
> core.fsyncobjectfiles=3D0 ls-remote "git://github.com/clutter-
> project/mx.git" refs/tags/*=20
> Running export PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 ls-
> remote "git://github.com/clutter-project/mx.git" refs/tags/*=20
> Could not list remote: Fetcher failure: Fetch command export
> PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 ls-remote
> "git://github.com/clutter-project/mx.git" refs/tags/* failed with
> exit code 128, output:=20
> fatal: unable to connect to github.com:=20
> github.com[0: 20.207.73.82]: errno=3DConnection timed out=C2=A0

Which version of bitbake is this? I believe it was updated to use https
in all actively maintained branches?

Cheers,

Richard

