Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 01C3573D1E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 14:57:14 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so25179739pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 07:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=M0gdFYlhtdrOS0ANdArrtLklpo8adtn837t+l1Sa+58=;
	b=LaQ3+6XH6zOtdRk3gtazLv7NbMxGtyVlSbomnMbsjduvNql8VNPjb62oiI0DazNozE
	2gamS+1/iRy+06cYToZpKwB2WE79uP5r6Cv87vq6HylRA8I1MeXwLkTtTl7rXaRdnaky
	8NNe8ra5K9ZGJg0uRqvXcyjf/pY7n1odc93ADEeKznwmP2gUV/uRHC5Gja3r9+m5bX3d
	c7VYeE4z/LcIUS7KVsCkgnENJXB3hYv2WJ5GigipdB9WSnoq9ihw6LHFk5361DLy69CY
	QlvfFCVEDbKsq7GHDfpu9IrcjASvJbPCX3RAFevYYQZ8fW7gdZAU/ViTMThUEw0tOnZs
	xe1g==
X-Gm-Message-State: ALoCoQktt+AC/gh+bfMEj0Ol0urzDE7Hnww1lUpjPnrQMLtp7qP7/IxpzwQOhTFwN0DOH/8n5d8z
X-Received: by 10.68.132.194 with SMTP id ow2mr3301736pbb.51.1428677836223;
	Fri, 10 Apr 2015 07:57:16 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id t8sm2529740pbs.59.2015.04.10.07.57.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 07:57:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 8C40D5611B8; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:06 +0100
Message-Id: <1428677827-12371-7-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: [dizzy 6/7] cooker: read file watches on server idle
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
X-List-Received-Date: Fri, 10 Apr 2015 14:57:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The inotify facility monitoring changes to the config files
could be overwhelmed by massive changes to the watched files
while server is running.

This patch adds verification the notification watches to the
server idle functions, in addition to the cooker updateCache
command which executes only infrequently, thus preventing
overflowing the notification buffer.

[YOCTO #7316]

(Bitbake rev: 996e663fd5c254292f44eca46f5fdc95af897f98)

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3909dc0..2f2a852 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -133,6 +133,19 @@ class BBCooker:
 
 
         self.initConfigurationData()
+
+        self.inotify_modified_files = []
+
+        def _process_inotify_updates(server, notifier_list, abort):
+            for n in notifier_list:
+                if n.check_events(timeout=0):
+                    # read notified events and enqeue them
+                    n.read_events()
+                    n.process_events()
+            return True
+
+        self.configuration.server_register_idlecallback(_process_inotify_updates, [self.confignotifier, self.notifier])
+
         self.baseconfig_valid = True
         self.parsecache_valid = False
 
@@ -171,11 +184,13 @@ class BBCooker:
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
     def config_notifications(self, event):
-        bb.parse.update_cache(event.path)
+        if not event.path in self.inotify_modified_files:
+            self.inotify_modified_files.append(event.path)
         self.baseconfig_valid = False
 
     def notifications(self, event):
-        bb.parse.update_cache(event.path)
+        if not event.path in self.inotify_modified_files:
+            self.inotify_modified_files.append(event.path)
         self.parsecache_valid = False
 
     def add_filewatch(self, deps, watcher=None):
@@ -1336,11 +1351,12 @@ class BBCooker:
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
-            for n in [self.confignotifier, self.notifier]:
-                if n.check_events(timeout=0):
-                    # read notified events and enqeue them
-                    n.read_events()
-                n.process_events()
+
+            # reload files for which we got notifications
+            for p in self.inotify_modified_files:
+                bb.parse.update_cache(p)
+            self.inotify_modified_files = []
+
             if not self.baseconfig_valid:
                 logger.debug(1, "Reloading base configuration data")
                 self.initConfigurationData()
-- 
1.9.1


