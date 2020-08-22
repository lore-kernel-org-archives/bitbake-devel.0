Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.156527.1598107524401422879
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Aug 2020 07:45:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PKDtlD+s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id r2so4498500wrs.8
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2020 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=at1uCURhY7NMKg0WNXkfkgeP3k3Rc/msnEPz6lnBvbs=;
        b=PKDtlD+su8Srck3+yWIflFntHNufu1VtkzN5H5mDimY14kn9agGxpQs3HIWEODNswX
         xT7UMh/7KF4IH1CpXzm2C5mlvCJA/PtndaWN3heX9z0CKcTKViHxVlb4ZuFCrXxSdzd9
         NtDfr9tYcM9jAIbv1fFpUW5bUyZNBl4Mg/3OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=at1uCURhY7NMKg0WNXkfkgeP3k3Rc/msnEPz6lnBvbs=;
        b=TELXo8b1bAtlSP64+BZrVYliHz17AV4ho+0scOJWdo3LJ01QIy2eJnTPu7RinAxCQp
         yOsof6Jta5/7kS7P2zkP0aVYF5emFysblsEThSHQKyI1W/S/TJXkQSrboaeEFq5DjTS5
         vZCMApQCztFvYS6bFnVBspEwiDyLBjz5t5mS7mDbM9qft3VwEAvfDduQgPb6YAOOSPeH
         TRpr0VsubKgYVnuPWewOa3iBj27fZSMefrE+FiSBd1iaHtx2f7wqAgcG2QraJzYcVmXW
         goz6J+wja65fCOEl/vnJlA/dKWZX3rMFo3Xl/EgTu853SRr/UPNscVeRGawNzYdg5+qT
         wewA==
X-Gm-Message-State: AOAM532u5KWhcCoWpiRNt2gA3gjB7xYUuDJDBfPhwn1xsZHSIJDRqDvM
	Iu75u3JbEJPNNQxCppIWptxSxmmDX504vco5
X-Google-Smtp-Source: ABdhPJxJFka1bw1fB/VikMV6ZRdEr+q/odhIWInwvXpUcMvKSQGYV3bAtX6SyDvleyU2vkEe680Nog==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr5445744wrv.280.1598107522418;
        Sat, 22 Aug 2020 07:45:22 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id k15sm10147817wrp.43.2020.08.22.07.45.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 07:45:21 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Drop cups.org from wget status checks
Date: Sat, 22 Aug 2020 15:45:21 +0100
Message-Id: <20200822144521.1313575-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its becomming clear the upstream server doesn't like this, drop these
two urls from the test, not sure we need them here anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 29c96b2b45..61b80bedee 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1262,9 +1262,7 @@ class FetchLatestVersionTest(FetcherTest):
 
 
 class FetchCheckStatusTest(FetcherTest):
-    test_wget_uris = ["http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2",
-                      "http://www.cups.org/",
-                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
+    test_wget_uris = ["http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
                       "https://yoctoproject.org/",
-- 
2.25.1

