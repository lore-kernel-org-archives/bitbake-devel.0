Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.643.1615504354631761475
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 15:12:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WHmU+bJO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id d15so3769006wrv.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Mar 2021 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=QYO+q9DYzvJ9g18gcoWDNHoc70tyJIl26cYpqq5kKWk=;
        b=WHmU+bJOpDgyC5iVkHBVNCJsxd90uS+PNXoeRSesnmY28ush5GhJFHwtS2OACVYLMv
         eq1xmow0Y1HzxAywgzsGhJHvGx7P2iD/5IbaXcQQVTMFhw2XCDYNJK8I4RgeJIyzNewq
         0GQRHEz0EaEBg0bZ7Uor139B06ObVkgs3TjFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QYO+q9DYzvJ9g18gcoWDNHoc70tyJIl26cYpqq5kKWk=;
        b=GT/VwsDw+tBUBGScZgFA8oh6QUbeAp4oa4rZDQRDNM90Xru7A0KYygDAzZDGOkxBi1
         iLoOweE29eSM9akSkYyldSC2ZZUI2FcgSIIPF+KckIqh2W+hFKv8KvugmGKKrCNjedC1
         GOtrFoSVHcLPpyZuCHwPJzGTeT1BJfSZF3EU67eIIO9UuRiVta9CpcTsLEqnD+cui5vk
         m1/wUemQIhabS0nLONOfIgWng2EMxiD2wgJU4w08baWTtRbcKGiwrSvE8PVf/7dftzSx
         RRhawc/oig5s00XHBdVSaFHhRpV3DFDA9fNZIElUX4gSQ7v/9SUSuFAq/0Lqut6eOBiu
         /IdA==
X-Gm-Message-State: AOAM530RHnkDrKmjTIueNKLOAtwYaXGiYA1aeGVN8h5vDaAM9PQQ3udY
	ptxsrXQsf1SY4YMk1e8vN3aOBg==
X-Google-Smtp-Source: ABdhPJz6dGDxh97luGKVfWflWhKC2FqUda5atpXVnmUBmmnQo5VpCSTPWJias1qLZvgXzcm5afxOCQ==
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr11286211wrm.389.1615504353026;
        Thu, 11 Mar 2021 15:12:33 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:7cc6:73c3:839f:86be? ([2001:8b0:aba:5f3c:7cc6:73c3:839f:86be])
        by smtp.gmail.com with ESMTPSA id r10sm294112wmh.45.2021.03.11.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:12:32 -0800 (PST)
Message-ID: <c7d3048f54c45b782f2a867f37bf34b311be8347.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] event: Fix multiconfig event handler change performance regressions
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 11 Mar 2021 23:12:32 +0000
In-Reply-To: <dd8d9659f53a49c2b90e3ed6e689c4eb@XBOX03.axis.com>
References: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
	 <ea3cf67c8b174f3eab75d68d14e72440@XBOX03.axis.com>
	 <06120a8293bdb7a251fb7fb71f253f42e50aa3ff.camel@linuxfoundation.org>
	 <dd8d9659f53a49c2b90e3ed6e689c4eb@XBOX03.axis.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-03-11 at 23:04 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Sent: den 11 mars 2021 23:49
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-
> > devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [PATCH] event: Fix multiconfig event handler
> > change performance regressions
> > 
> > On Thu, 2021-03-11 at 22:14 +0000, Peter Kjellerstedt wrote:
> > > 
> > > While this greatly improves the situation, it is still not good. Here
> > are some
> > > numbers for me when parsing poky + openembedded + our layers:
> > > 
> > > poky + openembedded + axis dunfell
> > > Parsing recipes: 100% |###############################| Time: 0:00:39
> > > Parsing of 3935 .bb files complete (0 cached, 3935 parsed).
> > > 5767 targets, 711 skipped, 0 masked, 0 errors.
> > > 
> > > poky + openembedded + axis gatesgarth
> > > Parsing recipes: 100% |###############################| Time: 0:00:39
> > > Parsing of 4051 .bb files complete (0 cached, 4051 parsed).
> > > 5490 targets, 726 skipped, 0 masked, 0 errors.
> > > 
> > > poky + openembedded + axis master
> > > Parsing recipes: 100% |###############################| Time: 0:01:07
> > > Parsing of 4111 .bb files complete (0 cached, 4111 parsed).
> > > 5607 targets, 732 skipped, 12 masked, 0 errors.
> > > 
> > > And here are similar measurements with only the poky and openembedded
> > layers
> > > (meta, meta-poky, meta-gplv2, meta-oe, meta-filesystems, meta-
> > networking,
> > > meta-python and meta-webserver):
> > > 
> > > poky + openembedded gatesgarth
> > > Parsing recipes: 100% |###############################| Time: 0:00:17
> > > Parsing of 2289 .bb files complete (0 cached, 2289 parsed).
> > > 3537 targets, 91 skipped, 0 masked, 0 errors.
> > > 
> > > poky + openembedded master
> > > Parsing recipes: 100% |###############################| Time: 0:00:27
> > > Parsing of 2354 .bb files complete (0 cached, 2354 parsed).
> > > 3659 targets, 64 skipped, 0 masked, 0 errors.
> > > 
> > > I have attached profiling logs (first 40 lines) for a gatesgarth run and a
> > > master run. If I read the data correctly, it seems that during the master
> > > parsing, there are a lot of calls to fnmatch.translate, posix.read and
> > > _posixsubprocess.fork_exec that are not there during the gatesgarth parsing.
> > 
> > Was this with or without c3f6fee42bfa23f23f167cb29f0cfa05ac2fa197 from bitbake
> > master?
> 
> The time measurements were without it, but the profile log was with it. Adding 
> it seems to shave off another 5 seconds when I parse all our layers.
> 
> > If with, please send those full profiles to me offlist. You're right about the
> > increased re.Pattern objects, there should be information further down about
> > where those calls came from too.
> 
> Will do. 
> 
> I also did some tracing of active processes while the parsing was running, and it 
> seems the process that is forked during the master parsing is `git rev-parse HEAD`.

Hmm, that makes me think of:

commit bd6b25f9a3416ce63e26d763cce7ed1ad4fd816d
Author: Alexander Kanavin <alex.kanavin@gmail.com>
Date:   Thu Dec 3 16:07:29 2020 +0100
poky.conf: do not write current date into distro version, use git hash instead

An immediate expansion of METADATA_REVISION may help.

Cheers,

Richard




