Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.6494.1622720759808208373
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 04:46:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=OVtFAbzS;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id r13so3216256wmq.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQzDh3kOzwP3MC0Naq4NR7XVZo1Wg3C1hVfa6jmlgG8=;
        b=OVtFAbzSz8csbs/+dzgYiO2W8ta3Dq4wwr+H7SFr975edF9Bww9uUKEhyyPsqQFHmz
         efxG9ScvfRNWFmJbGu76akKbZwJcyner+tu/sIm31liab7oIF6imyflDso3ym6JUuC6Z
         1BnB17Yn6DI+0HbfYpdLX8ZhpA2kq6dCH5ylFmn3FJ5BnnBgb0ZNh/SK+ArJ9f9TQj7b
         MESV6DsKzz/UDo4X0GSk0rmKXR6pWoM4jBI6ZM20lOuLPyLa4ZwX0r1rrXXKcywfrgQE
         kRMGTS1Mmvi8zPCBUBSWhPak3myZNmZfZdrDpcu4S94DFBSPCPzkVtDuvXMM5Zm7n2C8
         2/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQzDh3kOzwP3MC0Naq4NR7XVZo1Wg3C1hVfa6jmlgG8=;
        b=oGpbD2CZFzwRJMJKl+DXME7blvIThHvzbGBdY3izM16Ft9pV3mKAn24HgBMYhqGxXt
         5eJ555LWgpFVmiOsFy8H7uarbVJ/DTpQgsM6mbgUUbVLk/VcLR6OwO+4Zjiv4yMP+Ead
         g10Qz9F+l92xRDmALWeY453dJwhpPr5PBV4pJc/YHN0dkEbwbHXOyzkJ9OP4/9syEBP4
         SAvu2XKIJjpVgK285FzRYJylcwZbMZSXeHoNwhm0J812ieonTZskPhRC0usK6p/fYzgI
         BbY6cOkqB+wafs6Y2eY9cNP7PBGH8LUwyLx4pnH/KyDMuLmXPvWUqZYKMJJrGqaYJWa6
         94iw==
X-Gm-Message-State: AOAM533zgRFOjYYlkfAtZGJaW3HqEu+bwe8dpi+i9ifjXQTzIJubKVhr
	HchxAhhWLU4oUK8Iail/0lswCm6oZpY=
X-Google-Smtp-Source: ABdhPJxF+wUoZCxjWhSjBg4k24jKz/YjuVd2tcWLMXLmGtjd91qJye5FGb6aiX5nuryDdNCW60E37Q==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr9714783wmh.139.1622720758212;
        Thu, 03 Jun 2021 04:45:58 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id o22sm5425667wmc.17.2021.06.03.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:45:57 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH 2/4] cooker: Explictly shut down the sync thread
Date: Thu,  3 Jun 2021 13:45:41 +0200
Message-Id: <20210603114543.98044-2-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603114543.98044-1-Martin.Jansa@gmail.com>
References: <20210603114543.98044-1-Martin.Jansa@gmail.com>
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
2.30.2

