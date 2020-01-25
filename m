Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
	[209.85.216.44])
	by mail.openembedded.org (Postfix) with ESMTP id CB4EF7FD65
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 16:01:11 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id n96so1160958pjc.3
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=h39p7rGmeriaNZP9yMx4jVuKCJ7Rcn97tmduTEr7phg=;
	b=dtcYSj0yjrsMNc/IC2e5dUZieFMBn8aBRwxFFqurW/qB4mh4vT2qyx5qXoS9hGoVG7
	wrv3U40GqCv8HivYXNG/1oaMYkoDZstLI+Y1oCyRJV6sgIgEZNp3i4McxkxjhimDW9q5
	7/zo0V/VGtdeDaXDMD3vUIgHfRWWGzRapBOAkagTkbDQrLuCaZ/i+RTiJ8ESVCgyZexY
	xTmXaw3xr7yP+1OWSDoUb0wJcyBmiajlBwrgUfEoEZNkIytqIjxCG2fgjORAArGStCVU
	vyb8R91AOT2ZBRuwjHL99/+Ohrlfvxvs5kpuT0bO4YoXLocJb3YxU1wDnZ/OMXi7ZS0C
	V1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=h39p7rGmeriaNZP9yMx4jVuKCJ7Rcn97tmduTEr7phg=;
	b=d+uluWgTJY4uAI4Ais4WdZ3U5rg6eeWcfAfBD/rSdThMJb13kfHE4H3ZtlDPiidLa0
	ZJTkOV6MTacxDePrWDOJ7i62C1UV6A1/riu0Aoq/Qs74ji94g7Gja7Ps6M63Q0TFFs4g
	4wAcaIVsOn6CVkbwfrqWL5xx3QEty9zAbx0+FexrR7Is78VGhLFzY4JuoWWn/UsHpLlT
	SzYYRXia1oa/aMgO/SqQTKK4ygbmgQPdmFjwrmBttWulFEZcJoeyQE6MI6WiROlElWZ2
	uSPmFg4lAhMKb6FsQiHyrX0k8BLSR/Gc8z9OJCXrW8nlVAeeYHseC6k5sP81bJVzHqup
	XJDg==
X-Gm-Message-State: APjAAAUBNuSDHSXG5YRViHv4sr//sMu67Gzef000VHQvEikUvHvI2s/s
	aoXbYNSSx4SsGYZX3dj0ii2AB717
X-Google-Smtp-Source: APXvYqzYTO68E6pE7350YOO5fZDkHj0RK4y/4Tuz8m+JIR/EpmxmdRzXmN5KWFDy5+nFq2hCQRm/xA==
X-Received: by 2002:a17:90a:8a12:: with SMTP id
	w18mr5318820pjn.68.1579968072681; 
	Sat, 25 Jan 2020 08:01:12 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:953f:6ade:6955:1d1c])
	by smtp.gmail.com with ESMTPSA id j9sm10291064pff.6.2020.01.25.08.01.12
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 25 Jan 2020 08:01:12 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sat, 25 Jan 2020 08:01:05 -0800
Message-Id: <16799ada1cda8e021cb04c43e469225790525723.1579968003.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579968003.git.akuster808@gmail.com>
References: <cover.1579968003.git.akuster808@gmail.com>
Subject: [1.44 1/4] cooker: Keep track of watched files using a set instead of a list
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
X-List-Received-Date: Sat, 25 Jan 2020 16:01:12 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

When there are many watched files, keeping track of them using lists
is suboptimal. Using sets improves the performance considerably.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1e96df260e47d160dbd36bfc92c31ef06266f662)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/cooker.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e6442bff..b74affa7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -169,8 +169,8 @@ class BBCooker:
         bb.debug(1, "BBCooker pyinotify1 %s" % time.time())
         sys.stdout.flush()
 
-        self.configwatcher.bbseen = []
-        self.configwatcher.bbwatchedfiles = []
+        self.configwatcher.bbseen = set()
+        self.configwatcher.bbwatchedfiles = set()
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         bb.debug(1, "BBCooker pyinotify2 %s" % time.time())
         sys.stdout.flush()
@@ -180,8 +180,8 @@ class BBCooker:
         self.watcher = pyinotify.WatchManager()
         bb.debug(1, "BBCooker pyinotify3 %s" % time.time())
         sys.stdout.flush()
-        self.watcher.bbseen = []
-        self.watcher.bbwatchedfiles = []
+        self.watcher.bbseen = set()
+        self.watcher.bbwatchedfiles = set()
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
         bb.debug(1, "BBCooker pyinotify complete %s" % time.time())
@@ -278,14 +278,14 @@ class BBCooker:
         if not watcher:
             watcher = self.watcher
         for i in deps:
-            watcher.bbwatchedfiles.append(i[0])
+            watcher.bbwatchedfiles.add(i[0])
             if dirs:
                 f = i[0]
             else:
                 f = os.path.dirname(i[0])
             if f in watcher.bbseen:
                 continue
-            watcher.bbseen.append(f)
+            watcher.bbseen.add(f)
             watchtarget = None
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
@@ -294,7 +294,7 @@ class BBCooker:
                 try:
                     watcher.add_watch(f, self.watchmask, quiet=False)
                     if watchtarget:
-                        watcher.bbwatchedfiles.append(watchtarget)
+                        watcher.bbwatchedfiles.add(watchtarget)
                     break
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
@@ -302,7 +302,7 @@ class BBCooker:
                         f = os.path.dirname(f)
                         if f in watcher.bbseen:
                             break
-                        watcher.bbseen.append(f)
+                        watcher.bbseen.add(f)
                         continue
                     if 'ENOSPC' in str(e):
                         providerlog.error("No space left on device or exceeds fs.inotify.max_user_watches?")
-- 
2.17.1


