Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.154765.1598105822737909922
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Aug 2020 07:17:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NIsIjHg/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id o21so4339338wmc.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2020 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tK1KNiv1j2rWlrgJidYw4GStk89JJX1a9bzeF0U4Cfg=;
        b=NIsIjHg/8kEnavxjj3oyQSPC+4pJ9CR4VtQMc45sYiMusFQtL9Gj2ftcs8lsmgia8G
         qlBOAhr3ckHmxHEE83brVKjdZi5UOfcHFDmftROR9h1bPhdZuhKb26mgCVBcIkHgyKct
         2LMmxetuQ0PX3OycPiIp7qodzADr2CD3OH6Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tK1KNiv1j2rWlrgJidYw4GStk89JJX1a9bzeF0U4Cfg=;
        b=NUIiR34/LnBXF3J/9jICnWqgErPQtGZy52j9hBTi+3uVYmuHe3xWOUIDt9arDRDTNp
         OswkrEWGICWYmZ+cgt0HIBybjP9DOf5oL+Dv2tfE8DNr+AplU9rZV97bfaWhYTAZ0iCO
         5sj7cdILEHdQdr1SUR7YnZxBi5iXq70eeRfJxU2BcHAhnCtg0zzEhcH+3AhAEBvtTjuE
         GSY9GcNbZSjr1DKQ7R7I8KIZicyeDwRuaPqBenQJ32LTqE38vZped/EgmXeZF1IAPIU+
         43EgyvT32Ij3HHYdatNwS2iDJXKDoE0cFSzCPolon3zArdRgg8rFS8R8uOF0vQioPct9
         Ko7w==
X-Gm-Message-State: AOAM5322s2IlI1eIe0L/6YrG065W+IpCMDMV0s05IXJbXkWdiNK2VRG1
	5A/Ya0+MiYL7RjWsA0GSxwIOCXf8k41pnYLb
X-Google-Smtp-Source: ABdhPJwvBwHReMAsMtvkANfgcebqRZ88OleqY5BpIAVo7VIE09xiJzijTpwxxuh+gF0T6irpPRbD9g==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr8760011wmj.86.1598105821005;
        Sat, 22 Aug 2020 07:17:01 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id l81sm12640281wmf.4.2020.08.22.07.17.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 07:17:00 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] cooker: Ensure parse_quit thread is closed down
Date: Sat, 22 Aug 2020 15:16:57 +0100
Message-Id: <20200822141658.1312549-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200822141658.1312549-1-richard.purdie@linuxfoundation.org>
References: <20200822141658.1312549-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each run through the parser would leak a thread from the queue created to
shut the parser down. Close this down correctly and clean up the code flow
slightly whilst in the area, making sure this thread does shut down correctly
(we don't care if it loses data).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9123605461..05be9bef67 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2103,12 +2103,11 @@ class CookerParser(object):
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
@@ -2125,6 +2124,9 @@ class CookerParser(object):
             else:
                 process.join()
 
+        self.parser_quit.close()
+        self.parser_quit.join_thread()
+
         def sync_caches():
             for c in self.bb_caches.values():
                 c.sync()
-- 
2.25.1

