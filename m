Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C91C433EF
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 23:15:08 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.554.1636067707078321185
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 16:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PNoqUG3d;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id d13so10974819wrf.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=I8uT+gKC6FRs006GYUrvM+0M7aMO+3+2woxeZ/d7BpQ=;
        b=PNoqUG3dlAIKiyapjqZk87QVMTtjPcH4/m48zvulL95TUfleiOgudno/rPONEzdxET
         hzHfoRnFGKHjiChxr34g6/reYjhmeDpWgDhDo2lrsaHdZrtGWgky9Um66wEiJBWw55MQ
         iCQJj5RfmUYC+4JCQvpjOycBM4zFC5XsY2lt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=I8uT+gKC6FRs006GYUrvM+0M7aMO+3+2woxeZ/d7BpQ=;
        b=AuVatGKu29WDDX7XNoe0rFn288BcDNrTFWW7iW8u7O0ip2shC44TKuTCh3GkJOVsKO
         p7esY+aQLCqnjlyGLD7C+GTUPBqeKYNsgcVrdq+5Fm2mMzI0JpmJWRCt2IwLbaebXbXO
         rnoHcdpXVw39tsvKIR93NJzrDB78ESMYJ4jAdNqertku7Yt9oag6jB5aoISSue6GVuq8
         pUFeo6DnZRBbWGI+mK/XdMQ+s2v0jop8REijQv0s36VL5ul7DQx4KhFxH+vJ8pz1BcBe
         fOmPGnLTupaVIubqUww3JvUxnVuNtyg4dt1wBJAh4pWlQ4TNagIpHK2SfAkJfAKc4mJM
         ER1w==
X-Gm-Message-State: AOAM530QkQfq2xM9xE4e47Dn8vORuVrip2ScFdo/GzOncO2PtPvWm1MQ
	zDHzwU6uwUH9uxfvuW/DeWSE3A==
X-Google-Smtp-Source: 
 ABdhPJxcBH0i+vTC8SVHSNf948gN9P6ISvG+d2ypUnSOmulNo0wYu9LmM0pNZw6Y5HmXa/mfzfMKsg==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr5873098wrv.73.1636067705508;
        Thu, 04 Nov 2021 16:15:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:38e6:15ea:3134:28e5?
 ([2001:8b0:aba:5f3c:38e6:15ea:3134:28e5])
        by smtp.gmail.com with ESMTPSA id
 10sm7973975wrb.75.2021.11.04.16.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 16:15:05 -0700 (PDT)
Message-ID: 
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "martin@mko.dev" <martin@mko.dev>, Daniel Baumgart
	 <Daniel.Baumgart@iris-sensing.com>
Date: Thu, 04 Nov 2021 23:15:04 +0000
In-Reply-To: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
References: 
	<1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 23:15:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12884

On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:
> Dear Bitbake developers,
> 
> recently we have been looking at the npmsw fetcher and discovered some
> challenges regarding the integration into the developer workflow as
> well as the build times within Bitbake. We believe that we found a
> mechanism which would integrate well into Bitbake's existing project
> structure and drastically improve the situation.
> 
> 
> But first, what are the issues with the current npmsw fetcher?
> 
> 1. Let's have a look at a typical npm-based project. You'd typically
> have your package-lock.json (aka shrinkwrap file) stored within the git
> repository containing your source code. Developers will rely on this
> package-lock file on a daily basis during the development cycle.
> Unfortunately, the current npmsw fetcher only supports shrinkwrap files
> stored within the meta layer or within an npm registry. This is not
> ideal, as changes to the file might be made within the project repo,
> which then need to be manually applied to the lock file within the meta
> repo. An ideal npmsw fetcher therefore would support using the lock
> file directly from the source code repo. 
> 
> 2. The current implementation of the npm class uses multiple shellouts
> per npm module in order to add these to the npm cache. This is done, as
> the `npm install` command is not called within the do_fetch, but at the
> end of the do_configure step. This drastically increases the time
> Bitbake spends in the do_configure step for a npm based recipe. In our
> case (we have a relatively small project with approx. 600 npm packages
> in total, including recursive packages) this takes ~100 minutes to
> complete. What makes things worse, every change to the recipe and/or
> lock file will cause a complete rerun of the do_configure job.
> 
> As a result, the npm fetcher currently is not really usable for
> production workloads.
> 
> 
> So how can we address these issues?
> 
> We plan to implement a "sub-fetcher" for npmsw (a concept which might
> also be recyclable for similar use-cases). This would take the
> form of e.g.:
> 
> SRC_URI = "npmsw+git://git-uri.git;npm-topdir=path_to_npm_project;..."
> 
> The idea is, that the npsw fetcher would then call an arbitrary sub-
> fetcher (in this case git, however any fetcher will be supported) and
> after the sub-fetcher has extracted the source code into the DL_DIR,
> the npm fetcher will create a secondary download folder as a copy of
> the sub-fetchers download folder. Within this copy, the npm fetcher
> will call `npm ci`, effectively downloading the npm packages by doing a
> clean-install on the basis of the package.json and the package-
> lock.json files within the npmsw download dir. This results in a much
> faster build, as it removes the need for seperate handling of the
> individual node packages, as well as streamlining the developers
> workflow with the build process within Bitbake.
> 
> As this fetcher would be implemented separately from the current npmsw
> fetcher, this will not cause any breaking changes for existing setups.
> 
> Additionally, we plan on writing a separate npmsw.bbclass, which will
> parse the package.json for each node module for an automated Bitbake
> license manifest generation, which will resolve the current challenge
> of having to maintain these manually, as currently described at
> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#npm-using-the-registry-modules-method
> .
> 
> If this is something you see as a worthwhile goal, we will provide a
> set of patch files within the coming weeks.

At a first read it sounds reasonable but I don't know the answers to a few
questions which make or break things from an OE/bitbake perspective. Those
questions are:

a) Once DL_DIR has been populated by this fetch mechanism, can a subsequent
build run with just the data from there without accessing the network?

b) Is the information encoded into SRC_URI enough to give a deterministic build
result, i.e. if we run this build at some later date, will we get the same
result?

c) Is fetching only happening during the do_fetch task and not in any subsequent
step?


I'd love for some of the other people who're worked on this code to jump in as I
don't use it or understand it in detail. I am worried about how we maintain this
longer term as different people seem to have different use cases which sees the
code changing in different directions and we're starting to look like we may end
up with multiple ways of doing things which I really dislike.

If we do go this way, does this mean we can simplify other pieces and stop
supporting other codepaths?

Cheers

Richard







