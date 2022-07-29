Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558CC19F2A
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 06:25:02 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web12.5030.1659075891546760315
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Jul 2022 23:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BThOUToi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id
 b21-20020a05600c4e1500b003a32bc8612fso2027469wmq.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Jul 2022 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=d6eOftBxxv/69dwPF/pJ0QuZOC/leJleak2HXE7L7Jo=;
        b=BThOUToiYW1SUa4acDm0TAfoCglSm8ShTh94aHnTbhgAh6cNAgQ/Yam24v58VdV5yv
         riI4/+KbIC8Nluxyuey+VH0dT2AIxewoJ9229Wq8eeY6J6WVpL8cPE2fzaDTbFkDXDZf
         jWQjBBbDF6qwMu/5h3KH4fAEJWOnw9Zpr+zIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=d6eOftBxxv/69dwPF/pJ0QuZOC/leJleak2HXE7L7Jo=;
        b=tyIoRBbVWK05CF/B6FECa89TZSbagk5h8J6tVKlNg0X1jOCjt/8kNa+b38tz1IihEM
         KXP8t+hTgFKiKRgThvJhG30KEkeMpFF7jX7PSMsgu7faexz8f31VlZtL6/SBnSDP7VxB
         o2O1zIrcQzXoTf7eq6zlP+w6WtLFKff1xJrfLRChCW8763V7Z0WvVDwb+12k3LRKuo4F
         VCsCp8fbRNwL6Cw5RkE/ErTZt2mJKdufobYPFfdG9Gs+Sn0HP1RijU1vS89grytqrX0L
         JD+v2Dg4cBq/+DGSfgNIHVsuf3CIX05PDGK89ZAVz8aReBAXRYCHRNnuP5relPtmSx66
         yq3Q==
X-Gm-Message-State: AJIora+yKVwZz8+ZUUWtAe3s7ZAtrvsU2+jlW2lhIAq25bz9X4P0SkhO
	idrz65stOdCbrtIZ+ZpuWZpkYg==
X-Google-Smtp-Source: 
 AGRyM1scwAP1HxSAb0t/vhBGBjKbuyeFdbNtkQMx/21n7Jz1ME7qT9UONN+r5J5VPeen6J+jwCfV1w==
X-Received: by 2002:a05:600c:35c6:b0:3a3:4217:f06e with SMTP id
 r6-20020a05600c35c600b003a34217f06emr1559583wmq.95.1659075889595;
        Thu, 28 Jul 2022 23:24:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8ec8:b67:91aa:e08?
 ([2001:8b0:aba:5f3c:8ec8:b67:91aa:e08])
        by smtp.gmail.com with ESMTPSA id
 r16-20020a5d4950000000b0021e6277bc50sm3399199wrs.36.2022.07.28.23.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 23:24:48 -0700 (PDT)
Message-ID: 
 <2fd3cd9ffdb0400cbd75acd3c5cdd2dcbee6356f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [REPORT]Some strange behavior with XMLRPC server
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: regulationdango@gmail.com, bitbake-devel@lists.openembedded.org
Date: Fri, 29 Jul 2022 07:24:48 +0100
In-Reply-To: <bGRy.1658936975483534028.Wbtj@lists.openembedded.org>
References: <bGRy.1658936975483534028.Wbtj@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Jul 2022 06:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13861

On Wed, 2022-07-27 at 08:49 -0700, regulationdango@gmail.com wrote:
> Hi! I'm a newbie of bitbake community!=C2=A0
> Recently, I'm trying to implement XMLRPC client for bitbake
> command(this is similar to tinfoil).=C2=A0
> As I do this activity,=C2=A0 I found the following strange behavior.
>=20
> ---
>=20
> # getRecipePackages commands returns collections.defaultdict object,
> but it's not supported by XMLRPCServer
> This is as the title says.=C2=A0The following two places may help you
> understand.=C2=A0Isn't this a glitch?
>=20
> * getRecipePackages command
> returns=C2=A0command.cooker.recipecaches[mc].packages(See=C2=A0
> https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/command.py#n343
> )
> * command.cooker.recipecaches[mc].packages is set as
> defaultdict(list) (See
> https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/cache.py#n153)
>=20
> This causes an exception when calling getRecipePackages commands. See
> the attached log file.=C2=A0
> We can fix this by returning as a dict object.=C2=A0
>=20
> ```
> return dict(command.cooker.recipecaches[mc].packages)
> ```
>=20
> #=C2=A0getLayerPriorities command clears recipescache
> I noticed that `getLayerPriorities` command deletes cache data
> because `getLayerPriorities` calls `cooker.parseConfiguration()`, and
> this deletes cooker.recipecaches.
> Is this behavior as intended?
>=20
> 1. getLayerPriorities=C2=A0command calls
> command.cooker.parseConfiguration()(See
> https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/command.py#n298
> )
> 2. parseConfiguration deletes
> recipecaches(See=C2=A0https://git.yoctoproject.org/poky/tree/bitbake/lib/=
b
> b/cooker.py#n467)
>=20
> Therefore, If user calls commands by following order, the results of
> the third and fifth getRecipes are different because the fourth
> getLayerPriorities clears the cache.
>=20
> 1. parseConfiguration command
> 2. parseFiles command
> 3.=C2=A0getRecipes command=C2=A0 =C2=A0<- user can get info normaly
> 3.=C2=A0getLayerPriorities command
> 4. getRecipes command=C2=A0 =C2=A0=C2=A0=C2=A0<- user can get empty info!=
=C2=A0
>=20

Looking at the code, parseConfiguration is designed to only be called
once at the start of parsing. I think you have therefor found a bug in
the getLayerPriorities() command which shouldn't be calling it, or
should have some kind of guard on the call.

Cheers,

Richard


