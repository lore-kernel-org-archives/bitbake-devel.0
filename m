Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web12.5520.1596805268318465198
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 06:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QDvB8IBo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id f18so8662374wmc.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Aug 2020 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=6N3vG11+hILNVzC7avPPh2Q2RXmbviKVGl8dEXqBU3s=;
        b=QDvB8IBolO9wkMz2WnIGLv1k4Bt4Nb83Q2UTXI32FrWwU/AKWvI587ZnaWobDHRmcB
         AE+VMztwujTB4lC2ZPJeS9ZtLi6ef/msuaKcYTTtfeWrGA6eVV9rdzfSsZBRtJG1ZZMo
         iQhh10r8z0MzISNxRjECy1i+sfCCej0vsXyjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6N3vG11+hILNVzC7avPPh2Q2RXmbviKVGl8dEXqBU3s=;
        b=B9emPtUB8bAxG/3w18PGAAI7aYaisSowTIQiwlwla8ErW9qMPF5dsHE9d9mAPfDXx6
         5SJb+HubU6/8gSd+b96FW2TZxT/yKxRt0kMGuzpxZ7RQN+G62F17SpMH6udYx7g+gd1h
         I67oGINelQnuL35Sj7Ha6WnoTnx58apLjBYzar8h99ilWXL5PcLAvjcHVbt8sqVYCh3b
         /8H1CS4vqVG3xJHPgahwOiv16iEXzoPfx9grY/1PSnISYwSh+GuqUwTFoC/LTQqrv+xo
         69jMjfSHyrt7s6k83nQa52T1AE5cLlGY74BSY06Gmk9i3qS6/BUIC9okohOp3za1iu/a
         VZdQ==
X-Gm-Message-State: AOAM532Cu5dHTnAOQ1BkY3HId+4XavweYRz92WOUH/fhX/ljMVW7wRH4
	HIGNBVSByO732M+DDzQMImtRlw==
X-Google-Smtp-Source: ABdhPJzfLm0B+22uK8Qhi8t4/tmHhzitM4/mmLo14vHQFmo3rXjojPIBLNOBrSnompfT6FufdjbIJA==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr13603349wmi.180.1596805266543;
        Fri, 07 Aug 2020 06:01:06 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 7.d.f.c.4.4.6.0.3.1.c.1.f.b.1.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (7.d.f.c.4.4.6.0.3.1.c.1.f.b.1.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:91bf:1c13:644:cfd7])
        by smtp.gmail.com with ESMTPSA id h6sm10438426wrv.40.2020.08.07.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:01:05 -0700 (PDT)
Message-ID: <ebc1c0da5227e49deb6778b571a58adf56a4d79d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] ipk ar/tar unpack
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Chris Minnoy <chris.minnoy_ext@softathome.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 07 Aug 2020 14:01:02 +0100
In-Reply-To: <5687.1596801277895813527@lists.openembedded.org>
References: 
	<436e18f3d9dd0fd0ae23547f4172f907fed50dc9.camel@linuxfoundation.org>
	 <5687.1596801277895813527@lists.openembedded.org>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-07 at 04:54 -0700, Chris Minnoy wrote:
> From d21155c4b55ac96d3c13a3cef1f020df67b62641 Mon Sep 17 00:00:00
> 2001
> From: Chris Minnoy <chris.minnoy_ext@softathome.com>
> Date: Fri, 7 Aug 2020 11:35:27 +0000
> Subject: [PATCH 1/1] bitbake fetch2: fetcher can now unpack .ipk
> files from ar and tar format
> 
> Ipk packages can be formed with ar or tar. ar/tar can't read each
> others archives.
> This fixes the unpack to call the correct archiver based on the
> format.

What is creating ipk files using tar instead of ar?

I know they did once exist but I've not seen real world use of those
for many years?

Cheers,

Richard

