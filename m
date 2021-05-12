Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.6432.1620823895797536592
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 May 2021 05:51:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=pn4mnYQf;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: chuckwolber@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id m124so18086127pgm.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 May 2021 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RnKv4HHtqFnoPZI94oWBRb5fumZmg3qPXM/jM9+LR2M=;
        b=pn4mnYQfNyMlHbg1RPW0Knvca/CQeT5TJ7MH3LfyXShEj/sfcaGRPDDh6qgVaq5Lpl
         Qn6KDPRWv5EuapdCXKF/pzUq9GwmwehZIC942MahHgIWLf0biOWhEpANHqcLe9TjzoVs
         AoYKBiaAxuOcQxyJL1SdPfRtx0yqXfKWoSOtjMvI6KoxTLFPR9Oj87DIETolRcIrMQRN
         ulWf/K8RaOFMdex8pSL8JXgIUBmQDmnWesGaL1o4nieYOZl1/VrV5seId0Nt9S0HznKB
         Ed13Eoje5UZjLWe0D7wLe6RmPzyh0XTcJC9DBnixeA77r4hwImQUcmv2lYK+dDA6zbrf
         ljGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RnKv4HHtqFnoPZI94oWBRb5fumZmg3qPXM/jM9+LR2M=;
        b=r0785ndsEbkP80ACEg/TVdPbd4xafYUpEJBco5un6630zi5Or6gaTtq+QnhchB2GFK
         NZCXRvr30zhAwxjgQ2Mp2Fc+3FIlaYy4BmEBfvkar+RydMQWJGiaTI97n3s4rIIUlA75
         mdPc/b3vQT3bHnY6Lv8PmnaIAs/4GTsniGARLHfGF1dVGk+IqIBmFclnIWRiGcW9Vpx4
         hShKoXHP7LSsHeCE8wYFfbXjjT1XCh62SI7afKSdY3y1c9WXFWpdhpLwTGQSCHwy3C7o
         nIMheA3Cm+hEnFTPu43VY8karKLsTR6FoCaAtfM89ROwRFlIz3yxwzDw2s8aIJh0D6Xl
         gZcw==
X-Gm-Message-State: AOAM531EY56hEGB3enVh5H2NhrBDw48HRBJfzIwkNn0PJBUyB4XNl8dc
	1EhqoJQV/6g2PgLZbrjz/B74LZ90G+loDfrrXeOl2L+kh914kQ==
X-Google-Smtp-Source: ABdhPJxrLxld7cbv3NW4LYyqBoysCxQVmJKtpGCy5LRrObqwxiKltNceEe9mtghYSJqmPJWnUNHBHUiSoH2e4BQpFJc=
X-Received: by 2002:a65:50c5:: with SMTP id s5mr36167064pgp.138.1620823895012;
 Wed, 12 May 2021 05:51:35 -0700 (PDT)
MIME-Version: 1.0
From: "Chuck Wolber" <chuckwolber@gmail.com>
Date: Wed, 12 May 2021 05:51:24 -0700
Message-ID: <CAB=6tBSrVooUvS4G_NDPUHrHTLjxoHqJ269AVHA2K+4guYzerw@mail.gmail.com>
Subject: Git Fetcher Branch Default
To: bitbake-devel@lists.openembedded.org, 
	Yocto-mailing-list <yocto@yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"

I got a fetcher failure on go-systemd today, which puzzled me. That
recipe has not changed in ages, and the SRCPV hash is clearly visible
in the repository.

After looking at it closer, it seems that github.com/coreos/go-systemd
has changed its default branch from master to main about six days ago.
This appears to break a fundamental assumption on the part of the
fetcher when looking for SRCREV and SRCPV hashes.

Looking at lib/bb/fetch2/git.py makes it evident that this is the
case. I can trivially fix this with a .bbappend, but it seems to me
that the fundamental default branch assumption needs to be updated.

Has anyone discussed adding main to the list of default branches to
try? If not, I may be able to come up with a patch, but the code does
process default branches as a list, so I will need to think a bit on
the best way to approach this. Any guidance would be appreciated.

..Ch:W..


-- 
"Perfection must be reached by degrees; she requires the slow hand of
time." - Voltaire
