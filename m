Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.6492.1622720759156599932
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 04:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=daWtgnJ4;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id j14so5528062wrq.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afOKDk7TUFhQwUrj2lODx81TccoKaY6P0kCCUyQGJE4=;
        b=daWtgnJ4/jP5IOrRHbpytwRJP4ZOAyPIDgfaVGVl+9QFFSut1F45WOEHjujcaDKeya
         Yhl3chBmBCJEJk4sboxq3MdsGJ4aorlt/E8Ar7ZW2FCTXUTvGI9jNM69Vi6dMMiJd9ts
         xS3ATXUzmN99f+Bib7tJMK9VgQhUn8u/eK3rDczqgna+D5R+nn9FC3hqkdUByNBxR4Co
         R+TOvtW9Grad8m6rhTMVtba1kjXWdSGGMwucdgNr5r41fymAQHdDC1utV2wUplaOA9+k
         YBwb5twqdP/lF4OspzkhZFOlABLg+ZvtRmLHi/84FcG1pm+6skh4MD+iFkEqkeUDaLD/
         rRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afOKDk7TUFhQwUrj2lODx81TccoKaY6P0kCCUyQGJE4=;
        b=BTEvs7JpwxKRzu/DOf52dKdavdINX+hi/iELIeqMhdQBRYYVpFqOcB/qj/oNz7WVa5
         z+djU8A/Bfg1ClNEgbSEMxgdg08C0JRsRK7tFZwHe1NW2Szd9Ntt6SbVGoUpoZ6TEYW1
         MoHYbt0Y1aTOa6LqeUDBm+NtIswhBJS097pf52joyHnizvtfuX8yatuQoqzwIxTOgPVc
         7FdI4+lD3U7JoNxCKndUJ01i3D2cF/HTV82elRFxWdfhqnxLnHGyS1I9MYd2JYxsDCYg
         hXX8guBHaMtNIJY0zzeLUUV0ENjz7sDwjv5wNDvaJQv9J5Rgx/Fbh+HZxRJdtrWDPZtA
         QU9w==
X-Gm-Message-State: AOAM531vpLLZh3B4EALK8LMnoG7dLZ6KhxFXks+MLESOAMbYSeOQIVLi
	3yJ1ZFtUHhkXt0qnhoNvNy1cBs22ouw=
X-Google-Smtp-Source: ABdhPJyGSLM9zteOUEpW9I6kSCDdToJd0VMcaQXtpuFFOljYODZoK2EafAEHYNBMUYPR0Plr39ZEww==
X-Received: by 2002:adf:df86:: with SMTP id z6mr18495085wrl.255.1622720757401;
        Thu, 03 Jun 2021 04:45:57 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id m23sm2653815wmc.29.2021.06.03.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:45:56 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH 1/4] cooker: Ensure parse_quit thread is closed down
Date: Thu,  3 Jun 2021 13:45:40 +0200
Message-Id: <20210603114543.98044-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Each run through the parser would leak a thread from the queue created to
shut the parser down. Close this down correctly and clean up the code flow
slightly whilst in the area, making sure this thread does shut down correctly
(we don't care if it loses data).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 11cc2b95..4820d268 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2056,12 +2056,11 @@ class CookerParser(object):
                                             self.total)
 
             bb.event.fire(event, self.cfgdata)
-            for process in self.processes:
-                self.parser_quit.put(None)
-        else:
-            self.parser_quit.cancel_join_thread()
-            for process in self.processes:
-                self.parser_quit.put(None)
+
+        # Allow data left in the cancel queue to be discarded
+        self.parser_quit.cancel_join_thread()
+        for process in self.processes:
+            self.parser_quit.put(None)
 
         # Cleanup the queue before call process.join(), otherwise there might be
         # deadlocks.
@@ -2078,6 +2077,9 @@ class CookerParser(object):
             else:
                 process.join()
 
+        self.parser_quit.close()
+        self.parser_quit.join_thread()
+
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
-- 
2.30.2

