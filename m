Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.8871.1632493354819972013
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=wgf2Q6Uw;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id w14so9043486pfu.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b/ZgWR7ksy87rmIGoQUW7ko0BAEIQmX/6YxilLuyQcY=;
        b=wgf2Q6UwTjxUJoKTWUXW6bbxpOWsczUJShbH52uPgNHQ3zH/+jCMyx7eFJM6zoc7Fp
         bdDu05ADQ88SAdLQt2GacMwndK5+AvLKvWWsIH2iYJkoPvLLmL+YN+I/9xUE9+FrjOGl
         YKT0Q7YK7gtF+q+5UAA4hoNT5Q/Rzyn1v9et/tD20ThEVpXgLeKGUAtscd8SJ6brfGdS
         f9Spy4Mdg346Q9bPnTcd7Jcs1L4/curBmsi2QoEfQGLBbxlPznWMl1aHAu89nXe8g4wc
         nwyhnObBSM1oj5wiiv5YKvBphUxB2pG+fOQOVdYQgp8+1UFbFRHS/YN52OWGdZ2p+yNN
         TgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/ZgWR7ksy87rmIGoQUW7ko0BAEIQmX/6YxilLuyQcY=;
        b=fvpgqyQ/QxuJ5D4ruLixNa2hkf1G2LKOLjmgnr47Z+Q130NTGSb1V9Iskvo4FFxG6j
         hVUKKM6psRPPU6pfhMLhBg80vMfhNu8zb/mFy/SLfke4a7krKS7hsNY8DmlcvIq5YPrU
         5wcno0ThMFZQIY1am+08PcnmGajjOIos7o4bPXCKsIarOoxWIImOP3N7jG8ITpwRwRvs
         yg8g17KVg0T5Q/0SM8PkQHjoGBMbb3BLRpMRsMKVDGJ9pdrNkmcZGZsSWWOao9FXVVXd
         ZaOSno+B4WzS+neX262GKSqc4KwnRSQlL3PFMlaBvvZn21lELx2SuLB+WCqt2HYBoCh8
         uZ0Q==
X-Gm-Message-State: AOAM531YKMTigl6rv6gGv02Lqg1vjk6jFTF67cMJy7s6HUonJKbSXD5x
	Ijz16uXBCNbp6FZlejaMv+hmxBn8OwLdnRYV24A=
X-Google-Smtp-Source: ABdhPJxgr/jJ6lpqCLuK1NQ2ImBQ7zPY+6mBJ1FA4L1GynIiDrCgEDDTE3rD2wNCYfU2eUNpjam1Qw==
X-Received: by 2002:a63:f513:: with SMTP id w19mr3914444pgh.231.1632493353841;
        Fri, 24 Sep 2021 07:22:33 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:33 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 09/14] build: Catch and error upon circular task references
Date: Fri, 24 Sep 2021 04:21:02 -1000
Message-Id: <e33b04b3a2bc95ac4e3e3321805072791e84a43c.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If there are circular task references, error on them rather than show
a recursion error. A simple reproducer is:

"""
do_packageswu () {
       :
}

addtask do_packageswu after do_image_complete before do_image_qa
"""

into image_types.bbclass. There is code in runqueue to detect these but
we never get that far with the current codebase.

[YOCTO #13140]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 339d4d6be515a71311b81fb9e99742af0d8a5130)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/build.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 6e9c064e..17c70d0a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -905,6 +905,8 @@ def tasksbetween(task_start, task_end, d):
     def follow_chain(task, endtask, chain=None):
         if not chain:
             chain = []
+        if task in chain:
+            bb.fatal("Circular task dependencies as %s depends on itself via the chain %s" % (task, " -> ".join(chain)))
         chain.append(task)
         for othertask in tasks:
             if othertask == task:
-- 
2.25.1

