Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by mail.openembedded.org (Postfix) with ESMTP id DDE237E687
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Jul 2019 18:22:51 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id s7so30915386iob.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 01 Jul 2019 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=R54/CSN27ZikvZqMvMdvLb+53s0cT9fYiXor7DNU6+I=;
	b=PkjR1EsRfBX18C46zlkyhLw7msXn7p7cO5ugc5jAPap4J0RT1vji+mbt1aPb+xJjuk
	udGRg/+V5TmZl8+8TMqZMUb0wqwWeN9UJMI2xaa67ScSaqUe6Xs2dwN7HjxA6w0r2RDH
	FvQ9oVI07gxEVNmFlc/DV6zXgBQXGNHNLcj3+4oDTUgmbCM8DhHoVq5sVF6u/VON3gOU
	j0ZDuw2dAjDQwN3Ekgqd7Ms6ZOt77I8v/ysT1xUKLHzAabdG+tHfEHoovTEq9Ea5i0za
	sZCS8/PMcWb+JWkygp9hAeWF0MZqaFxWiCU/mL0KOCTrdrzIEbyrx7ujYEg7xvtQv+8o
	ce6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=R54/CSN27ZikvZqMvMdvLb+53s0cT9fYiXor7DNU6+I=;
	b=rSlOq3pszDS5ClJWhBkb02WQbE9nkdUEkp/uWJ/Z13JdKEE/F5DFv8JZ0YO9bxhCYI
	rnTcM3smfx9Yg8vigRmGfq6rE58WDn5Bu/bzqynVLAPr9qL0EbdBXW4A+cz3qCnUtKF7
	JTwDnouvHkeNjUGNvjBPPQE7/izaTiSGWGTLfJsiRxZ5aBSajkHLhATMZIgGrgOYTv6x
	h08i6GEShHXAGcMqBBuvPYCMofNHSExuLaCK1yCnkFxwRJG0COWja6NhFiGBG0H06FfM
	gXclN8Qa75RMLSg8pHVDb1GAM8jDnX4uLNptH7BsBMn+sfvSIsd/7hP2hiKshzOjb22G
	bY3g==
X-Gm-Message-State: APjAAAVFlf+Zr4DMsmdHduNFAHha5UVXqGPJnaMONth+X3z+tID9N+gt
	xdYecRBOfdY88zpaG9djbWdjd4ZW
X-Google-Smtp-Source: APXvYqy0QIuTUmyoyGHONbcZlc+fBWCWhQxdppMEPVMHp7vn9aVO8DrPpywg0aJJ3Q8OgL9JJT9rsw==
X-Received: by 2002:a5d:9749:: with SMTP id c9mr29108819ioo.258.1562005372438; 
	Mon, 01 Jul 2019 11:22:52 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	b20sm9485445ios.44.2019.07.01.11.22.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 01 Jul 2019 11:22:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Jul 2019 13:22:23 -0500
Message-Id: <20190701182223.32611-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] bitbake: Add --skip-setscene option
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
X-List-Received-Date: Mon, 01 Jul 2019 18:22:52 -0000
Content-Transfer-Encoding: 8bit

Adds an option to skip _setscene only if they would normally be
executed, without ignoring sstate completely.

Previously, '--no-setscene' would allow a build that completely ignored
sstate and _setscene tasks, and '--setscene-only' would allow a build
that only ran _setscene tasks, but there was no option do a build that
would respect tasks previously restored from sstate and build everything
else. Now one can run:

 bitbake --setscene-only IMAGE; bitbake --skip-setscene IMAGE

which is functionally equivalent to:

 bitbake IMAGE

The indented use is to allow a build to complete successfully in the
presence of _setscene task failures by splitting apart the two phases
e.g.:

 (bitbake -k --setscene-only IMAGE || true) && bitbake --skip-setscene IMAGE

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cookerdata.py | 1 +
 bitbake/lib/bb/main.py       | 5 +++++
 bitbake/lib/bb/runqueue.py   | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 842275d5301..5f51d38f52c 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -122,6 +122,7 @@ class CookerConfiguration(object):
         self.profile = False
         self.nosetscene = False
         self.setsceneonly = False
+        self.skipsetscene = False
         self.invalidate_stamp = False
         self.dump_signatures = []
         self.dry_run = False
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index ca59eb9af80..d62726d77de 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -255,6 +255,11 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Do not run any setscene tasks. sstate will be ignored and "
                                "everything needed, built.")
 
+        parser.add_option("", "--skip-setscene", action="store_true",
+                          dest="skipsetscene", default=False,
+                          help="Skip setscene tasks if they would be executed. Tasks previously "
+                               "restored from sstate will be kept, unlike --no-setscene")
+
         parser.add_option("", "--setscene-only", action="store_true",
                           dest="setsceneonly", default=False,
                           help="Only run setscene tasks, don't run any real tasks.")
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 010b0850102..d0342c481aa 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2489,6 +2489,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.task_skip(task)
                 return True
 
+            if self.cooker.configuration.skipsetscene:
+                logger.debug(2, 'No setscene tasks should be executed. Skipping %s', task)
+                self.task_failoutright(task)
+                return True
+
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-- 
2.21.0


