Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0662D7FDC2
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:02 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id kx11so7759925pjb.4
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Rlc1OF0Phsi+GUzKQVF5KBH54uMrUokL0zzu3ychQow=;
	b=QO3yvppNADD396eqj9zG71H3/HSJ1Zu00ZvUxO8YqBhH6vKDLzxRCCuLRDWYqtTcy8
	vMbkqhAcV8snsPGR/rmBIOX4EVeMm1Z8AeRe1XTkatgYp2xbIGy/6aJnhHE6bweuSsWr
	VcMMMqhRLkVlNx0PTPgcTWHQJMco4Us+iQ2hr9H9Sd5FqyiSkhCFTuQVMn9rdJoshNhz
	mqxHFaUPQH8g8h79pKisS1kNgStd5ggX4k1zNZ5qe2D1s3FgTPYoUiB7i3kNbQmCMemV
	c3hvaUOzkqNW+o0vrVxzshtq/9p6yNwyfsx4ykYWERi7hlshpRmsiuDCgU9MVJlcVMc3
	DIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Rlc1OF0Phsi+GUzKQVF5KBH54uMrUokL0zzu3ychQow=;
	b=CFwSjncr4p3Rg5C2F83XVzijteujrtaUDtSaf6BiI/00BeBvLEsI6rQQqrJdk3EQJP
	loH02thpPrerQE2pK8rlcimKQfA7M81ffDDDwBP+ZGFkPQyl9qA+Qp/gCuPJPjvgiUes
	PTvSkjWHW2Hmj4+0EnRA4UHRWhOjkYkLTosDujtoDHvzjuGMtY3Q7Nk9gwuCFyJLv7ef
	mjoONa5OhMwfHNWwa1vZXfB7AGDHRUONOjCpH5OyV+UEc9/2Mh36I8zJavAqPSRXuk+t
	VDgs8bATu0FV0zrLCUIk8tke2bimkB6TCkgbUg5wRcwBvXniFyL4J/f/7XQDlZ1snP7Z
	3RGQ==
X-Gm-Message-State: APjAAAVOW7BTD8lgjmuAh8LujMr/OJQYh5Od9Y2f6X2xEjGDMY5L5N4l
	rUpvz/ECXXSKTGC/tMuxL/ybq8po
X-Google-Smtp-Source: APXvYqyZh6kKlnn8CindzBSe8Ji05vwN0LTTSQPNhTT+Ktwn71Ch+KaaGItAQnHiddAWcgM/567U7Q==
X-Received: by 2002:a17:90a:cc02:: with SMTP id
	b2mr42346503pju.137.1578328023211; 
	Mon, 06 Jan 2020 08:27:03 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.02
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:02 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:34 -0800
Message-Id: <a80024a4397485f96693c4df108b40f6b1bdf32b.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 13/25] runqueue: Fix sstate task iteration performance
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:03 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Creating a new sorted list of sstate tasks each iteration through runqueue is
extremely ineffecient and was compounded by the recent change from a list to set.

Create one sorted list instead of recreating it each time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit de18824996841c3f35f54ff5ad12f94f6dc20d88)
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 515e9d43..2ba4557f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1965,10 +1965,14 @@ class RunQueueExecute:
         self.rq.read_workers()
         self.process_possible_migrations()
 
+        if not hasattr(self, "sorted_setscene_tids"):
+            # Don't want to sort this set every execution
+            self.sorted_setscene_tids = sorted(self.rqdata.runq_setscene_tids)
+
         task = None
         if not self.sqdone and self.can_start_task():
             # Find the next setscene to run
-            for nexttask in sorted(self.rqdata.runq_setscene_tids):
+            for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
-- 
2.17.1


