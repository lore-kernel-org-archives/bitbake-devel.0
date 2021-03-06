Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.6625.1615033145870339594
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Mar 2021 04:19:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=azrqkomL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id f12so5384980wrx.8
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Mar 2021 04:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=PGhUbiGAhpiBzP88sfw/bZIK0fdpS++bcD7DCn86Dyc=;
        b=azrqkomLIQlWraLyfpBryrhTEpTZBjkSY4BhjztDA7aZiRG4xyHlelkikJSvK9A/nq
         ig9HbHo6tts4F9bF4kOJg8Eek5KkXfzY4Ya1q6h2cqIRwK9po6sA5V0oJS808IioCR5d
         VqsqusFq5PxxBs4QcQAOPkGJ6aj4OfnpDA7bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=PGhUbiGAhpiBzP88sfw/bZIK0fdpS++bcD7DCn86Dyc=;
        b=L1eaOqhMmC42/BYOuGCP4B4MBXqhDy++eUd7jVAxoMuQ9JaeoKMMZpzH0pYskkr3oS
         noqfD3FtoE1TrrjJtzKdRvBr/9mQEWHV0AwBKRrueS0wkLcoNuUwqDh9tKwKZM25SiK/
         9ItG+EklKEoCIdZoXjnRiE/FHl1efXcBjmuVQSU+1oGOyL5+N16XOv0myQkNuj+Klxjm
         VMySU1CKC2oi81aT4Mk2C/70eQAK+V1VOSBhXJvzjD/b1olVRESWmHtMEPXUDBzQ9AcK
         1qovbIkEYXM/AufhAdxzYhOK/O1KDNGWIXoQmfhcX6V+JRIu2cWoA+MGS3ZfB+QFxf/K
         Fbdw==
X-Gm-Message-State: AOAM532z4G8li5xlWYM+ErYgn+iejsjhD5azejyZ1WZsKm8IpqwBV94h
	NenrkMXnpqOsrMNGtIjTbs5yfw==
X-Google-Smtp-Source: ABdhPJxj33wQKzedWDJ9f4CDnLJdG/ssusZ5kcqyrzMV+mXH8G4lqnmNJYby4lVGIEfMB6NW6tYPwg==
X-Received: by 2002:a5d:5082:: with SMTP id a2mr13477694wrt.289.1615033144239;
        Sat, 06 Mar 2021 04:19:04 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8791:d573:be1c:dfe9? ([2001:8b0:aba:5f3c:8791:d573:be1c:dfe9])
        by smtp.gmail.com with ESMTPSA id u23sm8734436wmn.26.2021.03.06.04.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 04:19:04 -0800 (PST)
Message-ID: <157fb732bdede18804680bee71296e802faad63e.camel@linuxfoundation.org>
Subject: runqueue task race debugging notes
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Steve Sakoman <steve@sakoman.com>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Sat, 06 Mar 2021 12:19:03 +0000
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi All,

I wanted to write down a few notes about debugging the weird kernel 
do_shared_workdir issue Steve and I have been chasing after seeing it 
occasionally in master and dunfell. Sending it publicly so there is a
record and someone may find it interesting.

The symptom of the bug is that linux-yocto:do_compile_kernelmodules 
gets run, as does make-mod-scripts:do_configure yet linux-yocto:do_shared_workdir
does not. There are very clear dependencies between the tasks so the 
question is why the dependencies are "ignored".

In runqueue there are effectively two dependency trees, "setscene"
dependencies and normal task dependencies. The setscene dependencies
are run first and can "cover" normal tasks meaning they don't need to
run. For added fun, hash-equivalence means that dependencies can become
available during a build do the whole thing has to dynamically adapt
to a changing situation, where for example "real" tasks might be running
which a newly available setscene could "cover".

do_shared_workdir is an odd task in that it is a setscene task but it
never has any sstate object so it is never available. Why?
http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=f5f2467e4bdd1a3fda9b443712d32502645ebe3e

Anyhow, the basic problem is how to debug why this is breaking. We
do have an autobuilder test target which fails about 50% of the time.
It looks very much like some kind of timing window where there is
an opportunity for things to break if they happen at the right time.

I've spent several days trying to reproduce and staring at the code
trying to guess what was wrong. In the end the way I found of 
"reproducing" signs of the problem was:

a) Change the self.holdoff_need_update = True call sites to call 
   update_holdofftasks() directly. 

The code knows that call is (was?) expensive so only runs it when needed. 
Running it directly helps ensure all the data structures are up to
date and aids debugging. It made no difference to the bug.

b) Add debugging to update_holdofftasks() to spot a "race":

if "XXX/linux-yocto_5.10.bb:do_shared_workdir" in covered and \
        "XXX/linux-yocto_5.10.bb:do_compile_kernelmodules" not in covered:
    logger.warn("Bingo, race")
    for a in ['XXX/kernel-devsrc.bb:do_package', 'XXX/linux-yocto_5.10.bb:do_package', 
              'XXX/make-mod-scripts_1.0.bb:do_populate_sysroot', 
              'XXX/linux-yocto_5.10.bb:do_populate_sysroot', 
              'XXX/linux-yocto_5.10.bb:do_deploy',
              'XXX/make-mod-scripts_1.0.bb:do_package', 
              'XXX/build-appliance-image_15.0.0.bb:do_package']:
        if a not in covered:
             logger.warn(a

If you run that with "bitbake build-appliance-image", even on a build directory
where the build had already completed, there is a small period where it prints
the "Bingo, race" message.

There never should be any point where do_compile_kernelmodules can run
without do_shared_workdir having run first so the fact it prints the
message at all is a clear bug and would explain our race and build failure.
In the real world, the task timing would have to execute at the right moment
to trigger the failure.

Above, you can see more debugging I added to prove why it was breaking. I'd
hacked:

    sqdata.multiconfigs = set()
    for tid in sqdata.sq_revdeps:
        if tid == "XXX/linux-yocto_5.10.bb:do_shared_workdir":
            bb.warn(str(sqdata.sq_revdeps[tid]))
        sqdata.multiconfigs.add(mc_from_tid(tid))
        if len(sqdata.sq_revdeps[tid]) == 0:
            sqrq.sq_buildable.add(tid)

into the code which shows the setcene tasks which would have to "cover"
before linux-yocto:do_shared_workdir can be covered itself. The
fact it prints messages:

WARNING: Bingo, race
WARNING: XXX/make-mod-scripts_1.0.bb:do_populate_sysroot
WARNING: XXX/make-mod-scripts_1.0.bb:do_package

shows that it is not working correctly and it is the task we're
seeing failures which which is promising.

The fix should be to check sqdata.sq_revdeps before marking
tasks as covered. I'm working on fixes in this area although its
not entirely straightforward.

Ironically, the module-base inherit and usage of KERNEL_VERSION in
the build-appliance image recipe should be removed anyway, it doesn't
even work properly, isn't needed and has a race of its own, the 
dependency on the right task is missing.

Cheers,

Richard







