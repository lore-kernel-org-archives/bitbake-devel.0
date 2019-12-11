Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id 3D5C27F9B3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Dec 2019 22:16:34 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id b15so257818iln.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Dec 2019 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=lFNOd5/I0CRcWJCWRuGoby6aOw8BtFE3fpCiolptKy4=;
	b=T831nsZCKow6pnag5mEDbYPRhmaamTJAWQYRAL45fxfNf/qCPsMx5kQvMVhaBSeLsH
	au0LobfpinViPyOVnGqHUVowbetlE4UEHkW0OK6i6PoZN03hIvAhnoBM4kfzpaVtw1w6
	e6nkG9JlH/813/0egmQ2y4zHsJM2jjd3Ei0f6funrikdn5LXZbpvuYmqBHNC5jH7M3aF
	ygo2XInxqwwduWStz7hNNKtVDXo47xYWssO92rgSHVpixUgYSGiPz/KZshkJkHl2a1xD
	93AQIVmQllNTMKunxmE0S5sJ8bgdWafrhwwEGZAyrMIySzlnTFvlvONy0qPXEofClwdn
	KsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=lFNOd5/I0CRcWJCWRuGoby6aOw8BtFE3fpCiolptKy4=;
	b=eWHnk3MFsLBfQwSETukoSQX5U1Ngbhz06o+msF2At9S4aMXeSUrnMpDabsdqSaKIat
	Zpx5IlLUe8qunxyfs0wK+ZX/2ur1c1w/YiUtaCeCRQpP+HVaY6wQcRR0cFsJyeWRrmEb
	iy+uSZni71WDiF7vhF9JMW/M2PSg+Lvm5e2fYI9vekcJihy4DaRSzB7wD98hieMw3GO7
	O7E0bwdI7gaOMng4Pypt3SshljGYclAGWCcplFW9/AJl8K21KYLUCqunENmO3iij6/RD
	6cul2zRapflyeTa2rMnRMq6ctEmeC007d063jWLkAEJEN6BvU2qulpMjPxqiffgoAQmA
	raAQ==
X-Gm-Message-State: APjAAAVk/qkA2AQBu4/ciThl7ueGd+rrYO49fP30j/rLLagb04QJF6of
	KlKN7A+ovhiLPOqGO3YW4Q6GAScrB2I=
X-Google-Smtp-Source: APXvYqxEDi2hM+FvuswnjlJ7lCofAbKS3RLx8E0pOvBF0nWuQd/NCl0b/hg/IpWYVROuzbt4QJWVEQ==
X-Received: by 2002:a92:5c8f:: with SMTP id d15mr5757638ilg.102.1576102594819; 
	Wed, 11 Dec 2019 14:16:34 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id n9sm801265ioo.38.2019.12.11.14.16.33
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 11 Dec 2019 14:16:34 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Dec 2019 16:16:29 -0600
Message-Id: <20191211221629.971140-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Subject: [PATCH] runqueue: Batch scenequeue updates
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
X-List-Received-Date: Wed, 11 Dec 2019 22:16:34 -0000
Content-Transfer-Encoding: 8bit

Batch all updates to scenequeue data together in a single invocation
instead of checking each task serially. This allows the checks for
sstate object to happen in parallel, and also makes sure the log
statement only happens once (per set of rehashes).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 246a9cdb642..cb499a1cba6 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
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
2.23.0


