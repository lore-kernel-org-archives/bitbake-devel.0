Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.1709.1623794458791790059
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Jun 2021 15:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=XBXNcJ9K;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.169, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f169.google.com with SMTP id p13so584121pfw.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Jun 2021 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWIEzakTQXb/PWk3cXRFVs6Ix739/QQZ9Q4IVdmWgOY=;
        b=XBXNcJ9KyFn1M9yJPi4q2hN/NDb115PRwqzVE9ci1MfnyswLgWz3S6qiQRj3tj+Yv4
         +0L4jVZk0VTXr2lOWVEA8Po5PtcNcD+dx1BQeC9Gcb+yzDMSAUwG+FAONoKKqGa2xqJH
         06Xcr5uvQt7au0M/WORz8+Nv15ggHi2NFV9TvX2Z0TYRfmYko59VoPj8Si6C0mIDrwIv
         qXFm10FeO6zBBhMlgdY6xOshzIBcr1I9LNlwVmcg+f35T67Y1LweNdHM1nVJnFrg0t0e
         y3g9GyZwsiI6ZuqtZlvRdbotF//CC/DtrWSYyf0g8K9vR/ymZQOONZ11bMFYAzRx32ey
         sHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWIEzakTQXb/PWk3cXRFVs6Ix739/QQZ9Q4IVdmWgOY=;
        b=Y8iLqEusQW+dBtH3+UGhi/etvyHmr+4JeOMn1Vb4WGOr3AJxGC7N7hVf66fgvuERFM
         U6VUJl01yxcXTE+e4HsWWQvM9v8j+79qSypztJ4HwObr/JO7Yvw1yI6AFKm4C6vmk0xO
         wR4IuBGNCIb8VfO1uQZzCBBeiRtrQHUWNPdQJNtMwY/4Fsyxrec0QuYflbV5J70M6ng7
         wKpyldK9SJ0sb9JOa80RbbR2AcTLvbNuPvbbbNfHMNbEwVEEq7KoxNJmZaSzb4NlZsnZ
         1RPGRFrHJfzv/32dniTqhfSpetI0VUO3rNtYnVjrq7G8rFIraKKDvq1ta4H6xwaI2Y9r
         cZeA==
X-Gm-Message-State: AOAM532Z1/iCyeE6VUB3KQGrWmr2joL7KEvOd966ZuWTDqsDGffoR9tr
	XJCMVKVwY2Wll+0Y2F6zXkWePeGzDOiSMopefig=
X-Google-Smtp-Source: ABdhPJwTM7hpwwsOCjaSl5KSCxiv3CNmBZKvr0KXaYjhjCZeVqpN6zYJGViFGJT2+Wmb1qzmiZrkJA==
X-Received: by 2002:a63:616:: with SMTP id 22mr1584000pgg.291.1623794457677;
        Tue, 15 Jun 2021 15:00:57 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id ls13sm115049pjb.23.2021.06.15.15.00.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:00:57 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/4] Patch review
Date: Tue, 15 Jun 2021 12:00:29 -1000
Message-Id: <cover.1623793815.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Martin Jansa proposed this patch set on the list a couple of weeks ago
and there was a bit of discussion on list and on IRC:

https://lists.openembedded.org/g/bitbake-devel/message/12366

I've had this patch set in my testing queue since then and I haven't
encountered any issues on the autobuilder or with local testing.

Most recent a-full test results here:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2247

If you have any comments please respond by end of day Thursday.

The following changes since commit 078f3164dcb1de7a141bec3a8fd52631d0362631:

  providers: selected version not available should be a warning (2021-05-13 04:26:15 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (4):
  cooker: Ensure parse_quit thread is closed down
  cooker: Explictly shut down the sync thread
  cooker: Ensure parser is cleaned up
  cooker: Avoid parser deadlocks

 lib/bb/cooker.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.25.1

