Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A2C4707A
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 17:24:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.7023.1649168962332350502
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 07:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XcYqRI5E;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id n35so8083861wms.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=X9gmPxzfAjU0JNoFFIhgZ59HxyUpefFcLDdvAVIdA8Q=;
        b=XcYqRI5Ei4H4ANGxHwANIzn6Ckt98DK7sCuRjB2EyzeG4Z0lJTFA8cacPcT2QBoInn
         X+FjU73q/NMNg5xG20GrUsEuRtR+GPkb5O9cggkQ2MV1MmoA1Mi+uAAUYEhQhynRAWBx
         pG0X19vT/5pUC/pOrrnUAb1gjdIN1dZ+sJVfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=X9gmPxzfAjU0JNoFFIhgZ59HxyUpefFcLDdvAVIdA8Q=;
        b=kVAFsEYeeB0HAqBVeUifpDfjbeVqp0R30PdMK3VeCFmlpSlz8roc+n4SBIsam204Kb
         Vi+nd3hJLWLdJzOW6ixQRbtx0v3a0Q+fyyJPGhRiFGH8Z6ZGdCaRRJpWUgNRkt3uS+iu
         aV0HB7TB9VBrQYcm0pOi3cWCkPGb18SB67ZR9sUZPofGigeMEr/zD+IFsF7MOcCLufLG
         cUdYBzFLfRFPOSZiKXQC7ulRxAYrMsLRNjbLinMWZkiimj5TWYYJdwGvRCMaDYJokXm+
         LMgLSzuCszYcasH6BcSp1ZtYOKPSbbsxIRtuza1SRO/kQPgQDrp0hFtX1kbDvzf5r8m9
         sSQw==
X-Gm-Message-State: AOAM533q1e7B7VaG67o3Y6ZsXxJIsHb16J+/nARZkenjTW1TTS9U3GZ7
	V6tz9i9BBqzKRJienD1rgkSahQ==
X-Google-Smtp-Source: 
 ABdhPJwgJHb6LhXkZad4rpg6erEPbUXuzgGicIDelfBAAd5iNdrcXGbaQ/1uAzp5EFdy3bZx4TGNUg==
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id
 bh14-20020a05600c3d0e00b0038c9b5e52c0mr3292623wmb.3.1649168960719;
        Tue, 05 Apr 2022 07:29:20 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:87d4:527c:2858:e93c?
 ([2001:8b0:aba:5f3c:87d4:527c:2858:e93c])
        by smtp.gmail.com with ESMTPSA id
 y6-20020a05600015c600b00203fa70b4ebsm15061956wry.53.2022.04.05.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 07:29:20 -0700 (PDT)
Message-ID: 
 <cbe0db4fa9db0352b148eeaa7d10db6540ef5e81.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/git: stop generated tarballs
 from leaking info
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olaf Mandel <o.mandel@menlosystems.com>,
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: Marek Vasut <marex@denx.de>
Date: Tue, 05 Apr 2022 15:29:16 +0100
In-Reply-To: <e5d525bf-e18a-6129-8d62-c3e33ec4b218@menlosystems.com>
References: <20220324164759.4097867-1-o.mandel@menlosystems.com>
	 <20220328173618.960965-1-o.mandel@menlosystems.com>
	 <e5d525bf-e18a-6129-8d62-c3e33ec4b218@menlosystems.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 17:24:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13581

On Tue, 2022-04-05 at 13:38 +0200, Olaf Mandel wrote:
> Hello,
> 
> Am 28.03.2022 um 19:36 schrieb Olaf Mandel:
> > When using BB_GENERATE_MIRROR_TARBALLS="1" to generate mirror tarballs
> > of git repositories, they leaked local information: username, group and
> > time of the last fetch. Remove all these by setting fixed information:
> > 
> >   * uname = pokybuild (6000)
> >   * gname = users (100)
> 
> it was pointed out to me by Marek that instead of using pokybuild:users, 
> which seems to be an artifact of the YP autobuilder, I should use the 
> "canonical" combination oe:oe. But that raises the question: which 
> numerical IDs should I use then?

I was happy to get a consistent value, I'm less worried about what that value is
but if we want something different I'm ok with that...

Cheers,

Richard


