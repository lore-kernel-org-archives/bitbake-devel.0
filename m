Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
	[209.85.216.51])
	by mail.openembedded.org (Postfix) with ESMTP id 07EB07FA0C
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:55 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id m13so7970598pjb.2
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=nRRdQRKmh9ijSCjVPXxTOLx9VYr3CQs/WC+XIihr5XM=;
	b=EomyZUkQ1xDdzYR4ZoddZcTHKW/1yx4Iqt/fbhTE9JEEWYWGlWP2X+0uv/QINuyA6R
	jPNdjBFgwPL/nlTm6wB845tqbvSVyqIDsiBxST64Ih2kumXx2RVqolO7eZnmxHi19M5y
	YU59GAy6Y1QFk3HVVJEEdwAdVAS4g6ryXZwldA3zxKyGVX/oAmywHb/iVaWdiB9a6mVv
	pziOrIIU8UZtsm2hQsShTCihsYynlT0DE9iWne9ouXKTVseGuYe9vRHbHuWdCIVcF1LB
	5thz/tu6KM4awBRJxf+mfM7bmOFXFkAfpkjAjPiNEw3PhF1UC/X1xQw4ipWANSWFAs2G
	a9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=nRRdQRKmh9ijSCjVPXxTOLx9VYr3CQs/WC+XIihr5XM=;
	b=M4v2jD9wf4EKtrnz9Za8NJL29yZQf7xor6l1YMZzYP0KIhVs3Rvd0FW5myFOFvyM7M
	BGwRDZesvSyAOMC4J1H7DW8ueX+EzvmWhyGnSiELsw41hzyU3RYltF+HpMTGz0nWJ9pg
	5IxzW30xvERM0xkjy02IPKItUP8mc+D6jnNNt2roxmCop1MvRbEPRAWpnWEwhNyxlh3Y
	og7w0gqHPoSqcGDeFPEl47/PNRrdaiQTot3hdhE8+0KKE2jmj5EYi2+eAHGh1iLYcmG3
	S5PADDHDWU/GL8dl3N7Mvwsg4R9NLk1rCakPuwyItgWdXryELofkA1Dd5QN+LZA07bnb
	f4fQ==
X-Gm-Message-State: APjAAAU9o0Hidnk4DgFf+vqZfR2IdwMjkWTl3yyQ+/XmaASR4JmuAEaP
	dG5+a3J5jMQ4mpocW7CPxGrKmZv8
X-Google-Smtp-Source: APXvYqzO2CAee2S003SX4u3VWIFGRKpeQmSMKIzUvSOnz1YGTFF+PU85z5tkU034KXoToPszwzV+gQ==
X-Received: by 2002:a17:902:7c13:: with SMTP id
	x19mr108295065pll.236.1578328016929; 
	Mon, 06 Jan 2020 08:26:56 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.55
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:56 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:28 -0800
Message-Id: <a7426c73a8e9fae468414a2c32a533d9c3729405.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 07/25] runqueue: Batch scenequeue updates
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:56 -0000

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


