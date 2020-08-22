Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.155506.1598105823396246986
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Aug 2020 07:17:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FPsDIYZ3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id r15so4426541wrp.13
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2020 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Az3oy4AdQJKfT9BbamNua6MhXDoMnOW327VrpoDPMN4=;
        b=FPsDIYZ3y/y11xav6L5x7FmA+5ZHj/7HSLw+V9pokIX9plm1BtOSHuC8RdJvykf2ax
         HYRxtPevE/Sot5Q/7Oho1zC2QxLz3vpYwF9VIubOFfE6dE9adpcL+VCzQmTZUXxYp1RE
         rQtMFjJdwxSyNQ3Rp+FScUo9oMBigOo4PJAIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Az3oy4AdQJKfT9BbamNua6MhXDoMnOW327VrpoDPMN4=;
        b=rT9qyGp+bjltMghm67qdgtd0NF+2cDYfnhiEnQ3XT6jLJ3Goj7u83gtIDCZ8J+mTfV
         OWTPI1eReEN+uOA57YCfSpx5sku+lE3Wh6mqqUdHV0XXWjPu1TMcW2zWuxZcKbOwQuKW
         9Mlp7EdcyFqiCZ2Frjel+MBs/pJQx5RMqBU+bceKJybodFsxQNM9391nUPWQkr9wkZuf
         etJ5hAuQYNDN5dob2CZyyO4ZZoLS5F7NlmsuF6Jc+lZZYyvllGKuwHcZiB5W/twRTFL7
         6/2/r+ctqlLpoRtpf3RouVgnYF8HR/K9rW5HoUUiaukM97fSFoEK0JKnsV7l0pWV3QX+
         OlqQ==
X-Gm-Message-State: AOAM531hTMC2fQZNRSMZl335eyZMWWRfTLZf4+wYWvhcjZTc4QQjzG+F
	Drn46UTyL169S+KjRuVn8qozPnp0xlWd/q8z
X-Google-Smtp-Source: ABdhPJwPfKFb7hWkoyMR5VyM0IbiefbTG6GjUQ6UoIobE233ViUHiQddRX+VYTzg4zhe6iouG8bsqw==
X-Received: by 2002:adf:de09:: with SMTP id b9mr7356389wrm.409.1598105821698;
        Sat, 22 Aug 2020 07:17:01 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id l81sm12640281wmf.4.2020.08.22.07.17.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 07:17:01 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] cooker: Explictly shut down the sync thread
Date: Sat, 22 Aug 2020 15:16:58 +0100
Message-Id: <20200822141658.1312549-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200822141658.1312549-1-richard.purdie@linuxfoundation.org>
References: <20200822141658.1312549-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hongxu Jia reported a problem where the bb_cache files were not always being
written out correctly. This was due to the sync thread being terminated
prematurely.

Whilst the preceeding changes mean the exit handler for this thread is now
correctly called since we switch to using sys.exit() instead of os._exit(),
this write can happen after we drop the bitbake lock, leading to potential
races. Avoid that headache by adding in explicit thread join() calls before
we drop the lock (which atexit or Finalize can't do).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 05be9bef67..33452e7b93 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1674,6 +1674,7 @@ class BBCooker:
 
         if self.parser:
             self.parser.shutdown(clean=not force, force=force)
+            self.parser.final_cleanup()
 
     def finishcommand(self):
         self.state = state.initial
@@ -2063,6 +2064,7 @@ class CookerParser(object):
 
         self.start()
         self.haveshutdown = False
+        self.syncthread = None
 
     def start(self):
         self.results = self.load_cached()
@@ -2132,8 +2134,8 @@ class CookerParser(object):
                 c.sync()
 
         sync = threading.Thread(target=sync_caches)
+        self.syncthread = sync
         sync.start()
-        multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
         bb.codeparser.parser_cache_savemerge()
         bb.fetch.fetcher_parse_done()
         if self.cooker.configuration.profile:
@@ -2147,6 +2149,10 @@ class CookerParser(object):
             bb.utils.process_profilelog(profiles, pout = pout)
             print("Processed parsing statistics saved to %s" % (pout))
 
+    def final_cleanup(self):
+        if self.syncthread:
+            self.syncthread.join()
+
     def load_cached(self):
         for mc, cache, filename, appends in self.fromcache:
             cached, infos = cache.load(filename, appends)
-- 
2.25.1

