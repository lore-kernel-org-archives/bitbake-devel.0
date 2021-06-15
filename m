Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web12.1692.1623794469701711041
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Jun 2021 15:01:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=rbdutF8x;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so2725473pjn.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Jun 2021 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cteHnuWaxREY4ewBSL0Tt208BAfj8xi43KTwgUBFnHU=;
        b=rbdutF8xhrccN4UpAv3aMNafqZjI/5bmoQtt+MdY/had1oNHZ3hqzQYG1n4nj4ds56
         0/hzGyhL+iKnplyY9vouEtz+Ak1fNAdwjPUSqvOjgwQBBxOPLfRiOtyxsrVsk4wcGS8x
         KctpHgrogVl7+sMFvJhsHR6Q37fGK4MMv1acmzOSKyHd13A/wZ9H97OUxZOHS4GRISyz
         idGcEdL+mRfHlzZaY4CTCx4dIb4BEDLQRtpMzTW6KUMgSTQA6OceaFAbLKAlrACBt01V
         4JzGzg3xj3lNbI1KXlOC4G3611pt0N4GH/yZpeO9R32Xoh79og2S6dbcCfttfk++VCER
         500w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cteHnuWaxREY4ewBSL0Tt208BAfj8xi43KTwgUBFnHU=;
        b=WWvHgMx04HzR3pH6Qa83EbFtETOn73TJlwp9vtg2FapCDAAQz7N9PSFUd1PlySb8g9
         KRjx7D1M8IP8RgOsxIYRLDXPWL8eXUeweDbjcco0obQ0S88JgO/FL0L87ZjqQ3765xp6
         Lm93LIUjQiGASunlA600M93FE+FoujUYjHa5yefkws46u+VKy3bIsgeHi+qJROfhSBwq
         l8KIrqrWDVywBMQZgZ1WX129kFMEH3CKxxCS8vbIb9wEE1xD+hPKygKu0Gx0x+HunDkn
         oJO5tFQB8P3Gi7ysdDmsRJogdv/yiGU1SY56sxjtpoZQSR+sRpV73X5SWUCbmJsQ325w
         yFlw==
X-Gm-Message-State: AOAM532upOSfWk1xdue3ZyALV4cNnnSzkx7mG6FFC74j2zIuL3gEmWed
	+D7+S3DhOru3RBSxiUjOa3bRVY7KNLVw6o1wCxs=
X-Google-Smtp-Source: ABdhPJyLB2g7dRzjU9irXTjr4K98vr/M/hwI6jLJcf7ff5hdFfiovmVnUyfgYFsrszMGFkqZXwD2zg==
X-Received: by 2002:a17:90a:24a:: with SMTP id t10mr1461355pje.178.1623794468759;
        Tue, 15 Jun 2021 15:01:08 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id ls13sm115049pjb.23.2021.06.15.15.01.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:01:08 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/4] cooker: Explictly shut down the sync thread
Date: Tue, 15 Jun 2021 12:00:31 -1000
Message-Id: <f0f0fca51cab890bba8ca9e7bc7e3249b6903449.1623793815.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623793815.git.steve@sakoman.com>
References: <cover.1623793815.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Hongxu Jia reported a problem where the bb_cache files were not always being
written out correctly. This was due to the sync thread being terminated
prematurely.

Whilst the preceeding changes mean the exit handler for this thread is now
correctly called since we switch to using sys.exit() instead of os._exit(),
this write can happen after we drop the bitbake lock, leading to potential
races. Avoid that headache by adding in explicit thread join() calls before
we drop the lock (which atexit or Finalize can't do).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4820d268..87884574 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1650,6 +1650,7 @@ class BBCooker:
 
         if self.parser:
             self.parser.shutdown(clean=not force, force=force)
+            self.parser.final_cleanup()
 
     def finishcommand(self):
         self.state = state.initial
@@ -2015,6 +2016,7 @@ class CookerParser(object):
 
         self.start()
         self.haveshutdown = False
+        self.syncthread = None
 
     def start(self):
         self.results = self.load_cached()
@@ -2081,8 +2083,8 @@ class CookerParser(object):
         self.parser_quit.join_thread()
 
         sync = threading.Thread(target=self.bb_cache.sync)
+        self.syncthread = sync
         sync.start()
-        multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
         bb.codeparser.parser_cache_savemerge()
         bb.fetch.fetcher_parse_done()
         if self.cooker.configuration.profile:
@@ -2096,6 +2098,10 @@ class CookerParser(object):
             bb.utils.process_profilelog(profiles, pout = pout)
             print("Processed parsing statistics saved to %s" % (pout))
 
+    def final_cleanup(self):
+        if self.syncthread:
+            self.syncthread.join()
+
     def load_cached(self):
         for filename, appends in self.fromcache:
             cached, infos = self.bb_cache.load(filename, appends)
-- 
2.25.1

