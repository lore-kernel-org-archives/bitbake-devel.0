Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C94BC43217
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 10:30:29 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.114574.1669631420289511112
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 02:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QobGeuxy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id o5so7021080wrm.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmuIrDTFWdRlgqVZEKy8abUqcaSTJ+ZgaHAjX9Lr8OI=;
        b=QobGeuxySUp+zum6FsJNV1aNqaRCIoeOGh17Rjm4DdTDC1DbtOvtWKFi2t9DU0kPfz
         2hv5tmueBvGtu4wbxRHQU+bQTKZ99k+NnHq90IFmpp0hgMjdOxDPkYjvGQRO+c/arEX5
         auxlrYMbtE1AEodkdsTPZ8MMbo1BO1xCF5dN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmuIrDTFWdRlgqVZEKy8abUqcaSTJ+ZgaHAjX9Lr8OI=;
        b=8JbneIM+F7ZFOnh0A2L5m7eGU3W4XvBewHB/HhnJQkkfKwxCAYDiWQzzRGYmPiVbRf
         V3OIMVwgDkFpZT5mDnIBPcPabO1x6V9OUaI95wSF5xrjFYHsCDtUqHXJ7L3kF8D4INIL
         C/rLDoeTXM4Ksjl5S6y2hb1+zRZhqvxa3VtiPb7Wemw9JEFkcrZ7jG0+Q2Uvu5GLMsfk
         Lqmj5VN2sN8ZyKSeYVTd6nDgYsIikMTCyIW3SgT3ct/elp87l+81UBI7ZJYFOO0s6Ptx
         h6DGDpie9K2xhLwSmZNiQZ0byNvnRhCy6XJAmNK/sCNKEp1HCYE2WnktodVpoX3sV1Xg
         h7ig==
X-Gm-Message-State: ANoB5pkK0esPeaMT3kY7+07MfA+i4MAvWD2yUvlEen2nwk7JGHe1hJ2k
	7WJPg7M6UqhPik4Fx5Zq39shCL0ULaHDiw==
X-Google-Smtp-Source: AA0mqf5XH/IrdJje/MalnjqVNwBwYnQDqZuEv7U6G9r2VO2W0RFsuHcJwhlxEhG8e9cJ3lldY2zXww==
X-Received: by 2002:a5d:43c9:0:b0:236:78d0:5223 with SMTP id v9-20020a5d43c9000000b0023678d05223mr31678483wrr.250.1669631418296;
        Mon, 28 Nov 2022 02:30:18 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1da4:7286:b644:a924? ([2001:8b0:aba:5f3c:1da4:7286:b644:a924])
        by smtp.gmail.com with ESMTPSA id bt7-20020a056000080700b00236705daefesm10536759wrb.39.2022.11.28.02.30.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:30:18 -0800 (PST)
Message-ID: <15fb6239fd34315b945694b594fe4826eb145250.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC] data: Evaluate the value of
 export/unexport/network flags
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2022 10:30:16 +0000
In-Reply-To: <172B8F6B3E0D6C64.11309@lists.openembedded.org>
References: <172B8F6B3E0D6C64.11309@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 10:30:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14118

On Sun, 2022-11-27 at 21:49 +0000, Richard Purdie via
lists.openembedded.org wrote:
> Currently the export/unexport/network flags are acted on only by presence
> or lack of in the data store. This is deliberate due to performance reaso=
ns
> since a given recipe shell task might export ~80-90 variables and this me=
ans
> expanding flags for every one of them.
>=20
> This does catch users unaware since values which expand to nothing don't =
work
> e.g. ${@""} and setting values to "0" wouldn't work either.
>=20
> The downside to this patch is slow down in parsing speed of around 4%.
>=20
> The network flag is easier to change and doesn't affect performance, it w=
as
> made to operate the same as export/unexport for consitency reasons.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker |  2 +-
>  lib/bb/data.py     | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> I'm torn on this patch due to the parsing speed slow down. I'm putting th=
e=20
> patch out there for discussion.

Also related is https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13808
and the noexec flag which has the same issue.

Cheers,

Richard

