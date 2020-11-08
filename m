Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.1739.1604866204354014553
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 12:10:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ceeJWdga;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id t67so1746339wmt.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 08 Nov 2020 12:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=3JPyNvTk8dlzyRNUMtGS8VqX4kPWEjDk2iMaD037lgg=;
        b=ceeJWdga3EgBgelv5EOy+iLWluSTtTtSux6w3KtQudbyTja9X2SJwjwGW8NjTGeAHL
         bRJpEH2gTNFuu+Ia/TqAu6xeXdpgPNSlUAvHzhU9h70nhPRI22/njWG/L6CfKGoWyrLZ
         /pBUKtMNpS09TKkpKeW+bt4cjAOIPW++78az8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3JPyNvTk8dlzyRNUMtGS8VqX4kPWEjDk2iMaD037lgg=;
        b=B6LU9lgN8WJ0HlYNkH0IsqCcgEuUUBivvzx13z7YK78f0OeXLnTSXTtLTBYcLnFU2z
         wl/cOX7OA0myFQy2qVIHLCDbb3kFA1yXvfqx0bR+yVDZzxeKaVvvFXV1OzmoqGRtPQqG
         2/YCumJA5HbaSLBCfuXSkCyDJ6z6cUIxPxz9E96RIQOOC5mZYAoxQE4jkA5JKyLsw+SU
         TkTA9/ko6qoUuXq5/Ryr7RbhxHJHJn3tLhi7MER7VWxGLqrQgqbnMEOYkB4MiDgfcIvP
         h+kdycIKBHbdKQb9vyMRYyCO3QFAp7ZCNGCwFURDN0dWIudoo7BK+SF3pUFBcnjx7gmx
         m6bw==
X-Gm-Message-State: AOAM5303JFpOgnGuEs6CGzysaH31tBGqI6ZRoOLjatlPJVkmME+dWFUK
	57ef8IzmrdMrG4rONEQwn8BrmA==
X-Google-Smtp-Source: ABdhPJz6HrsN7gOfym9jt7vQDOdeU1jZ3P9LVHP19K6HKaDJ3fgxzHzildgX4L/oFx8UfmNJKzoB0w==
X-Received: by 2002:a1c:3d4:: with SMTP id 203mr10694536wmd.52.1604866202675;
        Sun, 08 Nov 2020 12:10:02 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:5827:926c:3479:c4e7])
        by smtp.gmail.com with ESMTPSA id n8sm9804641wmc.11.2020.11.08.12.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 12:10:02 -0800 (PST)
Message-ID: <a91001f466bded3e426a579bacdfb11d6ae61ded.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/5] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 08 Nov 2020 20:09:59 +0000
In-Reply-To: <SN1PR12MB2480AFF5381B01CD820B27FD8BEB0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
	 <c332c4a65509274710a782edf25d9f47af4aa7d9.camel@linuxfoundation.org>
	 <SN1PR12MB2480AFF5381B01CD820B27FD8BEB0@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-11-08 at 20:07 +0000, chris.laplante@agilent.com wrote:
> > > v1: initial
> > > v2: fix intermixed argument parsing
> > 
> > Thanks for the new version. I did run this through testing but it
> > looks like
> > there are still some issues to resole:
> > 
> > https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fauto
> > builder.yoctoproject.org%2Ftyphoon%2F%23%2Fbuilders%2F83%2Fbuilds%2
> > F1567&amp;data=04%7C01%7Cchris.laplante%40agilent.com%7Ce03cf697b
> > f2c4fb4def608d88402a23a%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0
> > %7C0%7C637404494128992636%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> > C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> > 0&amp;sdata=j0vRU5pkrLvJaCPKza3QqktvaVCe%2B1KZCmx4Eem%2Bi%2Bc
> > %3D&amp;reserved=0
> 
> Is there a way I can work on a branch and do autobuilder runs? I
> haven't caught any of these problems yet with bitbake-selftest. I'd
> like to be able to iterate and use the failures to add new selftests.
> 
> For example, I will add a selftest to catch the improper parsing of
> 'bitbake -S none world'.

I'm afraid not, the autobuilder runs take hours and we have to test
patches in batches, we can't use it for individual runs. I wish we had
that kind of resources but we don't.

I am happy to see new tests though!

Cheers,

Richard





