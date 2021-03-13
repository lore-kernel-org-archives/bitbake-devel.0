Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web08.2744.1615662325555120487
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Mar 2021 11:05:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=ayl45mFw;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.50, mailfrom: steve@sakoman.com)
Received: by mail-ot1-f50.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so3151212otr.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 13 Mar 2021 11:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uFIy2SrsHmXovvrZo6ZHBFtZGVFdDsmDNfcxUmeNR+Q=;
        b=ayl45mFwKzD/mneGzKFoXWjsIHLsbRoKPYWvaKFG4xCwG77ZakwMdcyRCgTBTHhQd4
         Y0NL1i7czyKMNcTQDv8RjNo6i40HPHnM2uSqXd5VMDHU00L+cy6ZdGKAANvXphgM59Fn
         tgx1NyEfdycHBuaVUw3KBQYDtFLCUXGG37hTQOe1r4VOu6F4sEJlecpj2buc1hNr22if
         LJ1Cs/U7pIUpUD+NsMShvDWjKb0aJConMZqlXPXaAXropQ2oXqvd4lNT5Vymgq/NHcrU
         fv/HG2Bcu9YQvWq1uRgwZ+oUOj9doL8I9m4pMUPL1HnnBP42Nx4ywD+0SXSEFzN74ja0
         qRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFIy2SrsHmXovvrZo6ZHBFtZGVFdDsmDNfcxUmeNR+Q=;
        b=YErBU/SLDS/reYFiTwiSZngbYsQKleEoGebDoWcKenSbf2KxQ+cGdVZ4CpzsHOtBNb
         +97wLEnekAkNad79s5ahqjTVNgmdgg8h5yWHyn3SCtWxu6L1MzB8MjmENo9SPay+8Mui
         zC90iIdH6s608nVcJTbEJuC867QHigzKs+ohlLh/zL98YN4i6khJ8cMYUynBecgw9wK2
         GCF1QpN0jI6Wu1TulqwzM/+npQjsffnOVVrmVv1GRVn5WiZZEnM5iezg825DWfZG74Q4
         jmueAjIbdL9OO1MJN0Cn+FXa/hTcGu8f29lPrQwq5FFhgaNLdQj+rmZkkGtUAJvDC149
         bRZw==
X-Gm-Message-State: AOAM532lPvMuqQxnzVbV/dpXUGV7vcOqt4PacEx6yo0EHA8z5kjeIdPs
	3fd2j9Sp0GCcuL+ntGt7hmabs4+Wv7gewHvn
X-Google-Smtp-Source: ABdhPJzkOg+O7GPXK7I7hzvb2B5lv4thu1/xNTacniRWm6Qu99rCrmuXwvtKBZhbxCEg2U1uxxLa7A==
X-Received: by 2002:a05:6830:1ad1:: with SMTP id r17mr7992546otc.171.1615662324440;
        Sat, 13 Mar 2021 11:05:24 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id o63sm4056160ota.6.2021.03.13.11.05.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 11:05:24 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] runqueue: Add setscene task overlap sanity check
Date: Sat, 13 Mar 2021 09:04:52 -1000
Message-Id: <7c88ab063fc7a06da482c2cddb91507ced244d3b.1615662134.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615662134.git.steve@sakoman.com>
References: <cover.1615662134.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen hard to debug issues where a task ends up in both the
covered and notcovered list. Add a sanity check to ensure if this
happens in future, we see it in the logs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6e001410854792f9bb66a0409a2ac176171b0507)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6186a83f..2bb97b6e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1934,6 +1934,10 @@ class RunQueueExecute:
             logger.error("Scenequeue had holdoff tasks: %s" % pprint.pformat(self.holdoff_tasks))
             err = True
 
+        for tid in self.scenequeue_covered.intersection(self.scenequeue_notcovered):
+            # No task should end up in both covered and uncovered, that is a bug.
+            logger.error("Setscene task %s in both covered and notcovered." % tid)
+
         for tid in self.rqdata.runq_setscene_tids:
             if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
                 err = True
-- 
2.25.1

