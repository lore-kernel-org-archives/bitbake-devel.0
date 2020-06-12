Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web10.20.1591983425716658748
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2020 10:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=nUyVLcSX;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id r77so11103418ior.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2020 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1g+RxTZRzr+e3QxG9iKTzp08WxDHFHp3FNh/sSpN+s=;
        b=nUyVLcSX7Gm4Jezt9DHaUa9PMexklqsrAnJNDCK26kSlzLk2NhV8XWjQ5tHY6Iq1/8
         MEmIfg7j8rM0FWoH32Ojbge9hMe/A7LAA6dlNGcaZbmkaTQdOgR45QOxv2AbOgvfA0Jd
         rVCGW/rfMXIDkCMySwu4CBiqWSkIw8e53mTpIpt8YoH8R3oXizavaESNlCJZvMevgDpG
         Clr+bg/FUCh7ton1pmBIU4d4D8WJUEuRMs/W5kFe0m8xBrVipvBhT8ZgvHOa86r78LhD
         +1+zTRBK59EfHnlTj9JfMpM/Fhp5yPB+gsNlPY4G8Uv8dCv/q9JsHdt8aDNnR71wPy0U
         BIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1g+RxTZRzr+e3QxG9iKTzp08WxDHFHp3FNh/sSpN+s=;
        b=jkdmsf16AZAPjjYush40cgCS16x5vRQOD3M3eTgCcbdU3XprdYHdGIAzSLm/WTPCNp
         XQ2+BMxRfjyTqlRQrC7WhzlG8FJfWxozetjE+MxYEwQjyoXkW/3/OdSkKSGVsuQ4AYTX
         hYfBVJi8lGQMvzvWSzFNTY8FtrPO6ybiJzKXaDejd+2l6uPihCCFnfC2YLcyeh7apBlf
         NK2IwzuHShiGmB1SRjJ7BuP3UfWwIDpGhng3esfnP9MrokZevz1g5awT900ax8hiRFTb
         utsjwdRxJD7b2a2HhPsiw51LgPl8rk5nnmQPa/yGk4inIfCryGV6Nl6UV34qka8Ql9Ad
         /n+w==
X-Gm-Message-State: AOAM531DW/SBHcwgBZS61cMrdu0l+Dv/PIN5R/b9chmfTSt++eqU4T39
	lHlU/BEttrHGQr7iIQmVZeqOpxBF
X-Google-Smtp-Source: ABdhPJyx2vcUF/ANvJZTGdYKeqEeGc3YSYEDDSfIPrMXeOLaA1IXnK9bUikXmliBI46ChfKZpMXFtg==
X-Received: by 2002:a05:6602:5ce:: with SMTP id w14mr14727094iox.178.1591983424817;
        Fri, 12 Jun 2020 10:37:04 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:35f5:8651:479a:b9eb])
        by smtp.gmail.com with ESMTPSA id p15sm3418976ilj.15.2020.06.12.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:37:04 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: cache: Fix error message with bad multiconfig
Date: Fri, 12 Jun 2020 12:37:01 -0500
Message-Id: <20200612173701.7595-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtualfn variable is not defined, the filename is what should be
shown instead.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index be5ea6a8bd..c1e08511ba 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -727,7 +727,7 @@ class Cache(NoCache):
         if self.mc is not None:
             (fn, cls, mc) = virtualfn2realfn(filename)
             if mc:
-                self.logger.error("Unexpected multiconfig %s", virtualfn)
+                self.logger.error("Unexpected multiconfig %s", filename)
                 return
 
             vfn = realfn2virtual(fn, cls, self.mc)
-- 
2.26.2

