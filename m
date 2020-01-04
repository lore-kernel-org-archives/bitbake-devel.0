Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id B6E997F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:19 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id z124so24163670pgb.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=nRRdQRKmh9ijSCjVPXxTOLx9VYr3CQs/WC+XIihr5XM=;
	b=ZSFpTLPtbdkSoXN7sU7fG14KyYJElA9L2Ys+4gMrOWfri1QVtJYabZoQy18r8qWU48
	vDxWdlRdj9P5Bjc+Kx+spGPEuy9Yu25mTcRrVJib+NSKrym5MIIKJEdkoW0o77BMw3Sx
	/VIovczvxFZzdQUqQaQoomVp48mfU+mkQEXYeHig8d7YLgLaZ+Gci7STdjLYBQIQI3oI
	50Y0EmfMjxYqapUSrnqtgvfUzuu4F3MeIXQCKAurCr/UrKByD4ayAQ6nzbEjUtXo9uK/
	T4kJksibm9yTlKmzXuw3HLIE23Ao/Fn7nHXS3JQ0NBJyHmNFI8cdUVIUAzR64/o+jB6v
	lNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=nRRdQRKmh9ijSCjVPXxTOLx9VYr3CQs/WC+XIihr5XM=;
	b=Yi7ouaZjLJ7lRj2bpAYc1115KGcXThLeYqvmyNEoX8ZB8RmhgmiqXBRfDIXshMpekx
	JB2DUxHq1B57vA5ckBG8vEp+TGRPdhq2CWg19reEiy8+UiiCtA/O7bQOLmuXXD6ryc2r
	xYrPFWYiPkJKTb9Cb6fRFP8jYiK3jr5oNCfaLqkHvwnCwVXJaYi1fzSYGVkoinFXXoup
	JKeLV6sAlXMW/3TiPokFGP1+HNOw7gZ+Nc9hl0E/jALHyTjEnO/q9id7esSv3TaNP2id
	zbXT6Xdw+KJG2vkIcSdG8aexUTZyaLnxM5sMHJ13aCi3+mQRaryocBFUgMLg1cukEa23
	rrdA==
X-Gm-Message-State: APjAAAUIVKD7eTZpclxXPNJU4vaSBkzomUZFxYAHExuFW3ImzkVP33w9
	m2KgU1IJvdKkux+UQCnWUeT/9ufqdT0=
X-Google-Smtp-Source: APXvYqxC0rn53Grr+TrUEcyV3+GkcqcwxffOYTHcTrMgI7RuvOHHmYSOkngxgxLCrCaIt94KPPpUkA==
X-Received: by 2002:a65:6088:: with SMTP id t8mr100547223pgu.329.1578104600851;
	Fri, 03 Jan 2020 18:23:20 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.20
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:20 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:52 -0800
Message-Id: <a7426c73a8e9fae468414a2c32a533d9c3729405.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 07/25] runqueue: Batch scenequeue updates
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:19 -0000

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
index 246a9cdb..cb499a1c 100644
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
2.17.1


