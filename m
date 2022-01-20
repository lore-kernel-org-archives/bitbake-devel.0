Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2875FC433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 21:38:37 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web09.2961.1642714716711180419
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 13:38:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=m4U/vBi1;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id x11so671611plg.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 13:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDh7fRc3JlT9BN4SozEXVsEkErTJSsqCjmvrvcRBZrs=;
        b=m4U/vBi14qbF39XPZyV8arxmRgh9zk/BYgTO9R26yuv4Yz1FrjWxYErDog6jz121B2
         9PX9bCx2CPqk43Jf5N/1j7G7MyKZ6P5+o4Jyi//MX9RJmo4yNrnZrqOJHP309ioN3FuX
         brqIj5A/2+Ki+NGpZZC1gtK9OV++sTR1pzOOEOkmWXKcyDF6CbVqLoKB7f4V0fjhgmo5
         DdQ4h0TiNp2rh3VMmhUxgCDRnJ7sCdgL8Tz5Su4bT0/xlLjxoPqbD08BWTNkyBMkufuy
         PrHeQgcvLGGzJuzX9L0efNl0ayDBy4UK2SzLxK+uXBvt3EMHyhh8nItawda0qSY6Rbsy
         RBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDh7fRc3JlT9BN4SozEXVsEkErTJSsqCjmvrvcRBZrs=;
        b=EdWe9lyFfGUZRJ03+bHFH0ScmWsOZYeG3kiR4iAhfBHHQshlOufntwMtEdFHN65lUp
         SBYRf7o3f5dskFyodP+GTTloT0lH73DKaTC1mk7qRJ/vAk6171i9Gq2wgPURBezxZSz9
         9mw6e2VLRprXBEyjNd0p8SnRR6HTmP7fDG+wleHCkTrlWA61tf4jQOfiPOpB2PcFcGUJ
         g0pI1wtR9mS66i/qV1R7uznek9mFIPh71z837nqC4+ToaAwUg1phVV9s4xfy0JxkpN1k
         d50AWPdCZaQ+ZG3RF15aEupm+esgoiolKXoZSPYW/ve5RiS5BF6nIBPhkR3w3EpsRuPk
         Qe5Q==
X-Gm-Message-State: AOAM533mUSeRA6/bG/IDwyejp0GCGLJtRe1ezmOYykz0APh4kMXiPfJ6
	hkDUxDPHt3GZ94UiX6kNfZY8paHdra46YH/wxO4=
X-Google-Smtp-Source: 
 ABdhPJx/zmFpiR+ntlHu5MXTqxU1xktUmrATSQ9V9qmdxmuHTGK0LoqIm3iBUTOnKKnVQEWa3P6XJg==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id
 kb10mr13031568pjb.200.1642714715644;
        Thu, 20 Jan 2022 13:38:35 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 mt14sm3085215pjb.21.2022.01.20.13.38.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:38:34 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Patch review
Date: Thu, 20 Jan 2022 11:38:23 -1000
Message-Id: <cover.1642714447.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 21:38:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13263

This patch fixes the bitbake timeout errors seen in distros still using python 3.5

Verified with oe-selftest-ubuntu on autobuilder worker ubuntu1604-ty-1:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/3088

As well as a-full on other distros:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3141

The following changes since commit e6d75e0beb95aa0cdf82bbc0a6b767c7f6cfcfc0:

  tests/fetch: Drop gnu urls from wget connectivity test (2022-01-17 21:53:02 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Jate Sujjavanich (1):
  hashserv: specify loop for asyncio in python < 3.7

 lib/hashserv/server.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.25.1


