Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCF3C433EF
	for <webhook@archiver.kernel.org>; Fri, 27 May 2022 16:32:20 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.5768.1653669138011501855
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 May 2022 09:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OO1SINIK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id t6so6539931wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 May 2022 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=u4Dqy5j2A4x9t0c45Y4iy52IE3Knbm9eCXJuENNtQl8=;
        b=OO1SINIKWdTGXc9fLeB+7DY9W+6AM+CxJc/br7Gq8x7jdunB0D2Sgb861hXFhgPfpM
         1Tk/w/Uup+MCvk0GTwIsWXpdpWOXMnFZy6pLGh0u/01hqEg1Xe9hX7F6H6qPLZCOpB1K
         +tu1zK4H/0VKHV0vJgpV0DczDKfjdgcStoCBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=u4Dqy5j2A4x9t0c45Y4iy52IE3Knbm9eCXJuENNtQl8=;
        b=Ej0eIVc4YUzQqh19Mhdprod7U10V9E4QTI7VRKq3Oh9h38tNFRsVIajxcewfWiYyea
         M4ZZRWt72HvTtgBQiqenOhZTzhq3p384vCQHonPVFprwn2HPqBZkDm4bRL/pYnrlXT/v
         rqaBLboX+psPcO+BetKzY7tHE1kmGoUnSnlJmNmd9wikFI/+AyNiujGl7QuvK80gdYmv
         UiuPbeSsUxWP6pCMhpxQ7eT41TpEVSR60fqyFd1DCN5W7GKScEJYwTvX6vZQWRg9FE2H
         /zBwKzySTMv/4zo3ExGjsCJ66ob8uOUgXBPqX4O7UUHGh9aXL0bcgqCKlIleLm4TBBqy
         CgAQ==
X-Gm-Message-State: AOAM530il+q5yv42Q5HBu2MplhIELC0P4ozA+jsppC5zBzyjXs/VVC3L
	B/2q6nX3f3Cl8g+V6sBCmTVZWw==
X-Google-Smtp-Source: 
 ABdhPJyz7JaIbYslkEZihYfco9eMkXMfzjoI4wvc304BXpxux7BIwXl7tJe97UI+cCmAAnF5CVInFg==
X-Received: by 2002:adf:ea02:0:b0:210:1e78:743f with SMTP id
 q2-20020adfea02000000b002101e78743fmr2395713wrm.182.1653669136434;
        Fri, 27 May 2022 09:32:16 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a82:36c1:b105:e682?
 ([2001:8b0:aba:5f3c:6a82:36c1:b105:e682])
        by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b003942a244f50sm3034489wmq.41.2022.05.27.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 09:32:15 -0700 (PDT)
Message-ID: 
 <bab9cb806dbb1d11b8e29db5e66f5d58ace98b53.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
From: richard.purdie@linuxfoundation.org
To: "Reyna, David" <david.reyna@windriver.com>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 May 2022 17:32:15 +0100
In-Reply-To: 
 <BY5PR11MB4167CBD5CFCAC739E65B50BFEAD69@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <cover.1653448549.git.David.Reyna@windriver.com>
	 <b17960eece2c4985b066539792242c23@axis.com>
	 <BY5PR11MB4167CBD5CFCAC739E65B50BFEAD69@BY5PR11MB4167.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 May 2022 16:32:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13716

On Wed, 2022-05-25 at 19:37 +0000, Reyna, David wrote:
> Hi,
>=20
> > "May I suggest using a name that does not include "cli", because as I s=
ee it, ... may be something like 'tty' or 'ncurses'."
>=20
> I am open to a name change.
> =20
> My take:
>    taskexp_tty : my preference

FWIW that seems fine to me.

I've been hoping to find some time to do a more detailed review of the
code but haven't got there yet. It is great to see this development
though.

My biggest worry is about maintenance and testing as we don't have any
tests covering this.

Cheers,

Richard


