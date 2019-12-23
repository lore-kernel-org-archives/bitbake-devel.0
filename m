Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
	[209.85.216.45])
	by mail.openembedded.org (Postfix) with ESMTP id 514C47F849
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:51 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id n59so6935339pjb.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=qUiB+rLHoCKvLV1Fy0dFIiMOydKHxq3CZQq+SWtcReo=;
	b=o55+gMEBUaWhVU6hOUjjfMyeQn1TuOhoPJZWRVRVPiaI+onXapbkeJsKOaLJF/w2Ph
	Vykw68bZZPJ6YCv6uq9lppDNPTYqWsDdWHo51lyxcrHRGZm7e2B2bsIvvstNXeDnH+7h
	BK5o9vLaYbJLnF4zzbsVt9c6s9Z8GoXkUEIPJglyV8XS7FXr3ASsnMnd7Rz9XJqmId35
	9t0GLzKvY6NZ4SFmfM/bgcezek0cODvqoQ1fDrjILpENDiGVpK7znAmqseWQeYBCjbbV
	ailm87CKRqQjX3gAJRZmKyl3njnjTVVC9gOIu7+stBW4VY6nY7oxUHjMg8Fh2RzVcHsW
	jXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=qUiB+rLHoCKvLV1Fy0dFIiMOydKHxq3CZQq+SWtcReo=;
	b=ULhSMWDGCObv5PoPH74ziY6pEyrbtbHVI0t/drvADEgrl0R4wkHCEDHX9Ary/vHCtc
	lgRR+Uk0s8wO2VIj/SRkZTiX1Q90vHHLFzg0BvABTiPWQ3KJKviRW8aA8D2zZ9XCadMj
	fthhTub11qI1gO4XlzHo4PV5yyPAM44xA+MtY6QaSQiHmxMc9bsBG8sSoV0YzXnwkba6
	lRSBtK2LGWe6z58Fg/qNCIXJwLQxmglzHttrK6Ze8VeJ8uWmsUKvULNC6rGhtQ8GzZJC
	XBcXpRjoNDPttCEAJ1KKRy2U+5IN9SpOxikreUuUZhojjPCS0fesu+RCD7ur/FiFfZnE
	aatw==
X-Gm-Message-State: APjAAAW36YQrw/DwO1YofJSW17PU8XRFAXoAg4B2/TVMQr0YV16+Jr59
	oS2s5Uuj3JkTB8jncxhVb0ob//Gx0Y4=
X-Google-Smtp-Source: APXvYqx8fV+TiCRpD1AxWAzcCAlrO4xSjvrKw4xDpcTFxojUVLzFbqju5iVS+RrI79rizXKI/O8LWw==
X-Received: by 2002:a17:902:aa8f:: with SMTP id
	d15mr26567316plr.276.1577076652267; 
	Sun, 22 Dec 2019 20:50:52 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:51 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:31 -0800
Message-Id: <a7426c73a8e9fae468414a2c32a533d9c3729405.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 07/18] runqueue: Batch scenequeue updates
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 23 Dec 2019 04:50:51 -0000

From: Joshua Watt <jpewhacker@gmail.com>

Batch all updates to scenequeue data together in a single invocation
instead of checking each task serially. This allows the checks for
sstate object to happen in parallel, and also makes sure the log
statement only happens once (per set of rehashes).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit db033a8f8a276d864bdb2e1eef159ab5794a0658)
---
 lib/bb/runqueue.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 246a9cd..cb499a1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2320,6 +2320,7 @@ class RunQueueExecute:
             if tid not in self.pending_migrations:
                 self.pending_migrations.add(tid)
 
+        update_tasks = []
         for tid in self.pending_migrations.copy():
             if tid in self.runq_running or tid in self.sq_live:
                 # Too late, task already running, not much we can do now
@@ -2379,11 +2380,13 @@ class RunQueueExecute:
             if tid in self.build_stamps:
                 del self.build_stamps[tid]
 
-            origvalid = False
-            if tid in self.sqdata.valid:
-                origvalid = True
+            update_tasks.append((tid, harddepfail, tid in self.sqdata.valid))
+
+        if update_tasks:
             self.sqdone = False
-            update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+            update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+
+        for (tid, harddepfail, origvalid) in update_tasks:
             if tid in self.sqdata.valid and not origvalid:
                 logger.info("Setscene task %s became valid" % tid)
             if harddepfail:
-- 
2.7.4


