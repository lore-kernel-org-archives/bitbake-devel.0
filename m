Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
	[209.85.210.180])
	by mail.openembedded.org (Postfix) with ESMTP id 2EC5A91665
	for <bitbake-devel@openembedded.org>;
	Sun, 26 Jan 2020 16:16:28 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id p14so3746612pfn.4
	for <bitbake-devel@openembedded.org>;
	Sun, 26 Jan 2020 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=nvZMBgl7N170zgYVja3AHuusnU/uDzhLHg2hSX1lfEc=;
	b=d2XzVqIDLSqF3fYwKjvdBqv5yhh6nf5AbGhtmLJMKSLvZ1l1N4Q5GMRtloWv7AV4/W
	UHcWOgU23KZbhSbiGT1RMs2af+hWoIUjKqBF7e0DM/u8XB5TVsN0qRfl5WF4vIH3/GYB
	ZFAV51/YsXEP+SAQllKUVbsj+QJgEblUkC3AFAgtv1lQv8pch04uT9W2pa+ORAzbCUot
	Dv3zDGSWHPO6YGC/yRXoCHRT++AITJXCDQQlHOb+XP038haO1+ROcHp7IhtDQwOoeB3r
	Qt+4HnVsGtgY5FQNgCdbPlcNg7W3Kr9NmMxoyKNPmwdPep04DZZoMkAmxjhb08XipwuX
	7trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=nvZMBgl7N170zgYVja3AHuusnU/uDzhLHg2hSX1lfEc=;
	b=QnmINmIoTO2/buka0+U7zDBvSxqljaU4eDMlxFEDRMlvoeHj790PV62vlxm/IUKYuQ
	jNS84VkUNCPCuGXgTBn/sbLsQJSosL21NlQhLNetm0zQ0YuE2FsHDt2pr9+RlYi0dvXd
	yDAPRXnmEHaVQwE7qNyUwyhrLXAh6GDVbsHr3elM4MtTUy2Q/SdqYhUKMdFLnd3xQCSE
	J0a1CCqtB3pI9pQ9mZe55xb9m3/BNDJteUr45OMooBU1/KcMEbvUiUxQkDngBGorRSHR
	oL1rrGTgjzVrCgpbwGjMVYlG8xlwkIe7GGqrY5zZiM901bLBMT9u+OWYDOC1soXxEZw0
	BsRg==
X-Gm-Message-State: APjAAAX3iqQS/B8JUNnYAhqyoJfuJ3uwgrXKG1iaL2u3Tm/cY181gcBD
	zrSC9WIygdcT2FtNE/85+15uWJ5P
X-Google-Smtp-Source: APXvYqwuoaNvvUNSAQKgct8ZTa7a2O57fgyKt6U84Gpm4puZPq+CsnZMUVgA+dp1mpC1lOM7ocE4TA==
X-Received: by 2002:a62:3086:: with SMTP id w128mr12013927pfw.58.1580055389946;
	Sun, 26 Jan 2020 08:16:29 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:bddb:633c:e712:cec2])
	by smtp.gmail.com with ESMTPSA id
	b4sm12895937pfd.18.2020.01.26.08.16.29
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 26 Jan 2020 08:16:29 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun, 26 Jan 2020 08:16:23 -0800
Message-Id: <aa770081d7d3ff678b18117a4b4e9b3da09b72be.1580055259.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580055259.git.akuster808@gmail.com>
References: <cover.1580055259.git.akuster808@gmail.com>
Subject: [1.42 1/1] cooker: Keep track of watched files using a set instead of a list
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
X-List-Received-Date: Sun, 26 Jan 2020 16:16:29 -0000

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
index a97bafdc..77d18a5d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -171,8 +171,8 @@ class BBCooker:
         bb.debug(1, "BBCooker pyinotify1 %s" % time.time())
         sys.stdout.flush()
 
-        self.configwatcher.bbseen = []
-        self.configwatcher.bbwatchedfiles = []
+        self.configwatcher.bbseen = set()
+        self.configwatcher.bbwatchedfiles = set()
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         bb.debug(1, "BBCooker pyinotify2 %s" % time.time())
         sys.stdout.flush()
@@ -182,8 +182,8 @@ class BBCooker:
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


