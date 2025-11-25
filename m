Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C527BD0EE24
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 20:26:29 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3672.1764102381216425322
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Nov 2025 12:26:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jlovIcdo;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so3389770f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764102379; x=1764707179; darn=lists.openembedded.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGjtrlUjs3tet43inieWPcWI1WolvyJZuYcLAUeCaho=;
        b=jlovIcdoTPYKjyz1ikTdfa19FSwr69RWuL/O3yk/7K5yCEg7/h+lCP+pYOcVfezIr1
         peQcHtJP0rGRzVUlT0BoMPCU4jLm1DhC+CHQloDMopDqWc0RX5HEcNcXW77TnmHDE2Ul
         33iqwV0m+KE0lVz+btsCQAqDO9Bf2oxI849WlVcgOUzgJXKcnNk6D72XSSSYp5UdquBP
         Vqls3OWQAuNjMjLrhCfTemYKGCdpFIP7+J24dYGhtUKVPA8Rt5vlUqy+9RqHFEFHOzTC
         KHANT+HzKQVh2xOSC3Vl/rJ4gE7bDjFtv1mtdDey4F32UnRn2U/RvOfK3hFG/KMHclfh
         namA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102379; x=1764707179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGjtrlUjs3tet43inieWPcWI1WolvyJZuYcLAUeCaho=;
        b=qQBhzytvcCVvjz+jsqQxYjTr8/YJy7kawuXcxCY3p19xCK/IZ6yz3hB4ezoukIumGv
         WTaSUAIkMU2HERsjCc+ZcHEz1hspLs5Tb2iRr0mlnPc+nesuIC6Qy4lSgcCAab8xRwTE
         qAreCovsQwSo2a8oaedni5s3jlKjR3H8KuaPHltTgfQY5InMrH4Iapt0ADr0fdfIfTGE
         yBN46Qek1B0PDUrz5rik8kiZ1371D2er35CRbSGnmH2DOKgtUnfmbfNHcl6peylunCFY
         PDF5PX5ZUiay4TwxYotSPgMld7hm5KvEblTdJRhcaXVcodEXE+QFPlpogZC8jfrwBP7j
         kLeg==
X-Forwarded-Encrypted: i=1; AJvYcCUSDdVBiLBhep8zPp+dJShGfYTrfclY9uGClxVurkPdWIWe946MM+JwIV1INO/ckqPwepjBkw++G7ga64JU@lists.openembedded.org
X-Gm-Message-State: AOJu0YzUVR+4v5qf07g5GzaK520hUXXCY6h9DszHD9Jlu8J0OqLZy/eV
	FHGxV45vuQWhTIcUpO71lJldquIohv94UVeLinzn9l38CPU8e+EtWY1r9mZwwA==
X-Gm-Gg: ASbGncspTL9KMCg6RKp3XuVHI6WHs3ZP7iG+XctstqK/08ALfbiEPrOPucEWYwxXsrD
	6D5N3F7e8LCLvPch8QFQlTt3HSA6vlku7hv/7irT+Nozt9f9vcqpwRiChjbMeczkJjoowoD+LD3
	wNccO31tKGaOd3CFY3QQqmK/6NHZKGKH7S0fmV+qdN60mE86xjlXtzRejoqVFrvUh+WETaTSq08
	X8eyKtp0IjD5AEeSEqyZvUrS7VgQ+d5WTEerTFBZ3HrvcjKYw2/cLolQC9wx72C7hlrptPKRH2G
	aNiejgU62Z2H5N9gBny2+euyDwuJGsj+tM65n/Oly7aqGSKpGVmKC0IZ0GCqvWVRe0lDU/qhbg5
	IzKvy/eFvGkTcC7GsMNdXfXJJGoUES0ovhkutnOoEjy5mrmx47E2RRu9Ic3tC9spXPtX3tzVyWv
	+RwpWIW0CgLlM=
X-Google-Smtp-Source: AGHT+IEeh1Q6t3gaxnoYVDjokJOyDFsCxfny52VNSBp9JA1glyVs+gjSomKS2V9w13W3Dr3XarYgGw==
X-Received: by 2002:a05:6000:430e:b0:42b:2e94:5a94 with SMTP id ffacd0b85a97d-42cc1cf4540mr17263274f8f.29.1764102379421;
        Tue, 25 Nov 2025 12:26:19 -0800 (PST)
Received: from osama ([197.46.139.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm36254857f8f.36.2025.11.25.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:26:18 -0800 (PST)
Date: Tue, 25 Nov 2025 22:26:16 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Ross Burton <Ross.Burton@arm.com>
Cc: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [yocto] [RFC] Proposal: New tool to display recipe dependency
 trees
Message-ID: <aSYQ6IxFgosukd2B@osama>
References: <aSSUtHYFQlychNQk@osama>
 <74C05E37-CEB7-49C9-AA53-CCA988FC7E7B@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74C05E37-CEB7-49C9-AA53-CCA988FC7E7B@arm.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 20:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18493

On Mon, Nov 24, 2025 at 08:49:31PM +0000, Ross Burton wrote:
> On 24 Nov 2025, at 17:24, Osama Abdelkader via lists.yoctoproject.org <osama.abdelkader=gmail.com@lists.yoctoproject.org> wrote:
> > 
> > Hi All,
> > 
> > I would like to propose adding a new command-line tool (or BitBake subcommand) that generates
> > dependency trees, including:
> > 
> > DEPENDS (build-time)
> > RDEPENDS (runtime)
> > Optional graph output (text, JSON)
> > 
> > Motivation
> > 
> > Currently, BitBake provides:
> > 
> > bitbake -g produces task-depends.dot (task-level, not recipe-level, must use graphviz)
> > oe-pkgdata-util runtime dependency only
> > bitbake -e <recipe> view variables, but manually
> > Errors from the dependency resolver (if a recipe is missing)
> > 
> > But there is no built-in CLI tool to display a recipe dependency tree, e.g.:
> > 
> > bitbake-deptree dnf
> > 
> > dnf
> > ├── libdnf
> > │    ├── libsolv
> > │    └── json-c
> > └── sqlite3
> > 
> Note that the build-time and run-time dependency trees will be a _lot_ deeper than that.
> 
> The ability to mark some dependencies as “soft roots” (eg gcc-cross, glibc) and optionally stop at them would be useful.
> 
> > Is this functionality valuable upstream? Would BitBake benefit from such a tool?
> 
> Yes
> 
> > Where should it live?
> > Options I see:
> > 
> > new BitBake subcommand (e.g. bitbake-deptree)
> > extension to oe-pkgdata-util
> > standalone Python tool under scripts/
> > part of devtool?
> 
> I’d say this is a question for later, the question for now is “make it work”.
> 
> > Preferred output format(s)?
> > Plain ASCII tree (default)
> > JSON
> 
> And HTML/SVG graphs.
> 
> > Should the tool:
> > 
> > cover only DEPENDS (build-time)?
> > include RDEPENDS with pkgdata?
> > resolve virtual/ providers?
> 
> Yes to all.
> 
> > Any prior work I may have missed?
> 
> bitbake’s own taskexp (bitbake -g taskexp) is basically this with more granularity (because it’s task dependencies, not recipe) and without the drawing of an actual tree (partly because I just implemented it as a three pane window for convenience.
> 
> oe-pkgdata-browser (oe-core/scripts) and pkgexp (https://gitlab.com/rossburton/pkgexp) let you dig around the pkgdata interactively.
> 
> bitbake-whatdepends does basic processing on the dot file output from bitbake to let you see _why_ recipe A depends on recipe B.
> 
> Many people ask for this tool, so I hope you manage to implement something that works well.  I’ve started a few times, but never finished…
> 
> Ross

Thanks Ross, this is very helpful, I'm going to look at that and start the implementation soon.
Will need your feedback for sure, but as you said, let's make it work first then we discuss further details in the patchset thread.

BR,
Osama 

