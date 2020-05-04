Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web11.16096.1588627442287331232
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 May 2020 14:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xh8sE2Yl;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: schnitzeltony@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id w4so13968964ioc.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 May 2020 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GcS3ruXWbcgRK95b/m2AR4seNb044KggJVCrqy6svWQ=;
        b=Xh8sE2YlCqXCHe3CiUwokAHAexLDZjGE/8N9Zoxr9oj2RpGDAXq/lFR954wP14plgH
         5crvvo/OIcC3BWv/O4Ite0RrTL7aHM7NZtVXPOM3k0oCiMcHuajxrmCFAzXnDjYIgvN/
         xcnUHQg3rTDOwe9YNA/KXgKcmSqn7DFQbzwgQJeDLaOXDFoz0KNkCA9Ex/IhGVD5HTqk
         Zap7bSCJdgNGewHqa/H8J7Tux3QxKVW2X93CtxJfJKEIreFYRsrW+6uY8Q+DQf8p8VLd
         pqCG8EaH1lnfc68HkFtO3vOWIiL+arJ6xvE0KGQbKnhU6+AJhOqoVKkxnAQ5Yvm4Ftwj
         yckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GcS3ruXWbcgRK95b/m2AR4seNb044KggJVCrqy6svWQ=;
        b=VrUU/2lkQ77/pth1F0j7NtB0SXoN5ywQKCs64uu05DTbpppUVV40mngPR1R6Aqwlz/
         99dgsnQQknzJrjTBmLyfpwpQHhCRRguzoKryF+aOB7pHoLom1Y1FL/c7hcd4yClj0Fzm
         uWMuKLg3vN8TGnlAt3lkUw+0WKBxy1UHZqE+rDpfMYOMckk53DAcQ8vvXJYoYW8jGZhn
         +uusL8HILTZkgVC3nGbGQLfeaRgrsAc/QK3f6y9lyI6bTWSQhaDVdQi9Tuk1biqeal51
         TlbUFMnYQSOTPlw8iTQUulA1B+feToGadFSL4yclnt2arPZYt23qG9O1r3eTwrhNBxDL
         tNwQ==
X-Gm-Message-State: AGi0PuYi8dvJtz96euUYeSoszeW8jwc7XTVfnr2d3UMtv/DhIM0lIt3U
	EjhGhS/ivGWunTMeTfsvduMVGTcFfEwhtKgXEnEsUmvi
X-Google-Smtp-Source: APiQypJdvDOnh2fdos9YjnUMnMexqxsx0BQVKWP+xQZFUozHUEw1zzOMfmMS4XHZHitHT4B+2JZjOB3ILSStd/BBNtU=
X-Received: by 2002:a6b:3ad4:: with SMTP id h203mr303673ioa.43.1588627441207;
 Mon, 04 May 2020 14:24:01 -0700 (PDT)
MIME-Version: 1.0
From: "Andreas M?ller" <schnitzeltony@gmail.com>
Date: Mon, 4 May 2020 23:23:50 +0200
Message-ID: <CALbNGRQGgPng5u33Dq_DzpfcqQkhVeWgD4sW9sWymXMHqni8Mg@mail.gmail.com>
Subject: Questions on fetcher
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

Hope this is the right place..

Have two questions on fetcher:

1. Feels this has changed recently: When I add/upgrade a recipe
fetcher retries two times before giving up. Problem I have seen often:
servers running two fast downloads but the third is VERY slow
10-20K/s. I checked docs/mailing list but did not find helpful. Is
there a chance to abort after 1st fail and show checksums?
2. In case of incorrect checksum the error text to copy easily into
recipe does no more contain md5 entry any more. Does that mean md5
checksums are not necessary any more and can be removed?

Thanks in advance

Andreas
