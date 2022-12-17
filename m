Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F7C4332F
	for <webhook@archiver.kernel.org>; Sat, 17 Dec 2022 11:34:11 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.5715.1671276849700164995
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Dec 2022 03:34:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Sub8PcNk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2503336wmb.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT8rxwJwFrjsh4TkE65Z7xSsn2mj3kIOs0DoTvrt81Q=;
        b=Sub8PcNkEueRYaaasyYOSEe7lVEVgXHHdnOpYv9vxyfJ6W/dyqjDeAC3IwtXMMQ6Wx
         jC7JzCBPQRr8M31KygLWZXi0IjGrDGT2FEG2/rnlG3vucdgUXlcbPCtbdo/o+d9uQOB0
         GVZg9HUmZH/fE1esghomTgwjjB6b0MKF2ryPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pT8rxwJwFrjsh4TkE65Z7xSsn2mj3kIOs0DoTvrt81Q=;
        b=cjPP+rUw3Ytg1Ri1o7aMSAMXcgPPDtLRK4RZLHWq4NUdJDhfXkaY5/rMXgLWFH9D69
         WLyaHEoV5gHKGQxNmbh/4iI0p36tptVPqgrGii3i/yILDeQ3v2lCJ6RHwx8j+qYtA5Mc
         ge05DqtIFPqCHL5puAcBnAj6D1z7m+xZfzrqbridA5SiMo5Xz8w/Su42zlnLfvtLblJT
         cQ+hMbTEs0fMfw3BQLHoSPyFBdD/eWkVAaimK/wUCSH4FqfUoNqacr5FkoTsYQONHsNR
         1Os63H6kM95E275CHUZ0yhZz1hxgFdNArWoQn1NWkqsYBJ0jR6XvYqIV6N4NXwkfywCO
         NDpQ==
X-Gm-Message-State: ANoB5pkFAZNHIzaOaXwg9Uil72OUInJnMPUBCjOH2yHS2N5cVgygeaj5
	ecfgUZOIjvWtHLgPE8O7kxk0cQ==
X-Google-Smtp-Source: AA0mqf7HLGbvv6YP8EkrY2BWttWkcA+95RVTJ0PjPNZYaWg9ztov3wZP/Aaxl0aq7GClkfdv7+oskw==
X-Received: by 2002:a05:600c:4e52:b0:3d1:fcac:3c95 with SMTP id e18-20020a05600c4e5200b003d1fcac3c95mr27089707wmq.34.1671276848114;
        Sat, 17 Dec 2022 03:34:08 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:17b:a3fe:f7a:35a6? ([2001:8b0:aba:5f3c:17b:a3fe:f7a:35a6])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b002366e3f1497sm4808774wrb.6.2022.12.17.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 03:34:07 -0800 (PST)
Message-ID: <666017467d067ed9473268336311c98dcad4dcad.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Enable to use some bitbake server
 commands
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yosuke.nky@gmail.com, bitbake-devel@lists.openembedded.org
Date: Sat, 17 Dec 2022 11:34:07 +0000
In-Reply-To: <20221217084454.24346-1-yosuke.nky@gmail.com>
References: <20221217084454.24346-1-yosuke.nky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 11:34:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14191

On Sat, 2022-12-17 at 17:44 +0900, yosuke.nky@gmail.com wrote:
> From: "yosuke.nakayama" <yosuke.nky@gmail.com>
>=20
> Bitake server provides getRecipePackages, getRecipePackagesDynamic, getRP=
roviders and dataStoreConnectorCmd.
> getRecipePackages, getRecipePackagesDynamic and getRProviders always retu=
rn data that can't be marshalled.
> And dataStoreConnectorCmd also may return data that can't be marshalled, =
but this depends on sub command.
> On the other hands, bitbake server uses xmlrpc module, but this supports =
only marshallizable data.
> Therefore, when bitbake server returns data that can't be marshalled, xml=
rpc raises an exception.
> To fix this issue, this commit converts return-data to marshallizable dat=
a or None(if return-data can't be converted into marshallizable data)
>=20
> Signed-off-by: yosuke.nakayama <yosuke.nky@gmail.com>
> ---
>  bitbake/lib/bb/command.py | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)

Thanks for the patch. I'd like to understand which objects are being
passed which can't be marshalled and think about fixing those issues
more specifically. I'm worried that two different behaviours between
the transports where one silently drops data isn't a good idea.

I'd also be interested to learn more about how you're using bitbake if
you can share anything?

Cheers,

Richard

