Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.4647.1620467472435794851
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 May 2021 02:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZrCpxan5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id h4so11601919wrt.12
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 May 2021 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=nZOnnm0e+RB1RwrTNbXqtcBzq3QaS/y1uzarCp+TOuk=;
        b=ZrCpxan5kaOFuj8N7824RKbNOeEU+TaEkBy2J1XePcGH0IkI/h+lRuufOtXcAo8C8u
         xakZZOGC2YbCOn2A75AU3npj+IyPBc7ksW8LjhthOpClw0sLxgmXPJVCoOlbdXLcf7uU
         Y3VDJtBSjWIdOyhBPJb1bvLWINR4k2eJz8Y2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nZOnnm0e+RB1RwrTNbXqtcBzq3QaS/y1uzarCp+TOuk=;
        b=bzFYwKOsi4qORwT5f8je3RCBQNi2IgzOaw2y00XSnJ4g5x+EQBUZP8MKyWuIrM+HgR
         KZswIN+hVb4F1FYcb4nPNNgBOQJYpwaebbhrdNdlNrFKojWV43ROJPa30rtwLzaeTTYL
         wAfdZZ8l09zgKexmeLFGW1Hlk1YbJQOPPNxyWQiOvLyFr4qMXXWNbXNjWXTvxAO8JWEU
         pD7MNX4pHXL67lmybDQtEAvTGaZwNlRUnTuTVtAYn15qQcL9dcPS/bvmNZ0d69gb37Qz
         TclTtcol8lIfVUd3JR4qwDPqwEAFcLjGlPJ7nTMg899LrW4ytBas9SQ8Vpm7/zEPHzWr
         xZ1Q==
X-Gm-Message-State: AOAM5336pW1Yq7VvmeZH1sQWejG1R/p66gRda/Gn/2ThLKtiuDDK/zn2
	qZisB3e/SRFmbBDEg50bK3HnqA==
X-Google-Smtp-Source: ABdhPJz2lzBaQfHEoww9H1wJSCybyw1AeYhNRv5sQtlj0s+BLBPyWPi80ec2sfqG92KKnUTncko4zA==
X-Received: by 2002:adf:f212:: with SMTP id p18mr18050995wro.120.1620467470877;
        Sat, 08 May 2021 02:51:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8b6c:ea91:f112:97a5? ([2001:8b0:aba:5f3c:8b6c:ea91:f112:97a5])
        by smtp.gmail.com with ESMTPSA id q10sm11595031wre.92.2021.05.08.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 02:51:10 -0700 (PDT)
Message-ID: <5a873755d26ac7e8e483ecd43dd09ef92e7c90ca.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Options for allowing Git mirror tarballs to avoid stomping each other
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: matt.hoosier@garmin.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sat, 08 May 2021 10:51:09 +0100
In-Reply-To: <36D6A83D-004A-4E91-9092-F50686966F0E@garmin.com>
References: <36D6A83D-004A-4E91-9092-F50686966F0E@garmin.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-05-06 at 14:38 +0000, Matt Hoosier via lists.openembedded.org wrote:
> Hi,
>  
> The Git fetcher generally assumes that repositories it fetches are well-behaved,
> in the sense that content fetchable from a head today will continue to be reachable
> on that head tomorrow. There's the 'rebaseable' SRC_URI parameter that can be used
> to override that assumption on a repository-by-repository basis (it's set to 0 by default).
>  
> I'm concerned that when more than one project of different vintages are publishing 
> mirror tarballs into, say, a common HTTP-served directory, this assumption is going
> to cause trouble.
>  
> The mirror tarballs of a Git repository are named based only on the URL (not the
> revision). So, for example, git://sourceware.org/git/glibc.git;branch=release/2.24/master;name=glibc 
> maps to a mirror tarball named git2_sourceware.org.git.glibc.git.tar.gz.
>  
> Suppose for the sake of argument that I have product A on a version of OE whose 
> glibc is fetching release 2.25 and product B built using a version of OE whose 
> glibc recipe is fetching release 2.24.
>  
> Product A goes through its release cycle, which includes an exhaustive pass of 
> fetching and generating mirror tarballs. These are copied over to an internal 
> premirror site for safe-keeping in case upstream Git of glibc disappears or has
> an outage. So the pre-mirrored tarball includes revision history for stuff up 
> through 2.25.
>  
> Now Product B does all the same steps. This will mean that its mirror tarball 
> of glibc gets sent to the premirror server, and now the premirror tarball 
> includes revision history only up through 2.24.
>  
> If Product A needs to reconstruct its sources using the premirror site, we're in 
> trouble. The history for 2.25 isn't there anymore in the tarball filename that it
> expects.
>  
> All this has happened even though glibc itself is a well-behaved repository. No
> maintainer there has removed history from a branch or anything like that. The loss 
> is just a side-effect of local operations done with two different releases of 
> Yocto-based products.
>  
> Short of doctoring all the recipes to set 'rebaseable=1' or resigning myself to
> have a completely separate premirror directory for each release of each product, 
> I can't see an obvious way to avoid these history-losing collisions.
>  
> Would it make sense to unconditionally build the revision number into the Git 
> mirror tarballs so there's no tension between competing copies of products' Git
> mirror tarballs?

These are some really good questions. We did once have versioned tarballs as you
mention. The challenge is that they end up generating huge amounts of data in day
to day usage and users hate them for the inefficiency. If you put the whole git repo
metadata in, it's wasteful and if you don't there is no way to incrementally update.

We changed to a model where we're supposed to be putting all the git metadata into
the mirror tarballs. I suspect we made something more efficient somewhere (or git 
changed) and now we're only doing partial fetches. The fix is probably to ensure we
do fetch everything from the upstream when generation of the tarballs is enabled.

We do have to be careful as we also need to preserve things that were upstream but
where it was deleted there, e.g. where there was a "master" branch and it is now 
"main".

Cheers,

Richard





