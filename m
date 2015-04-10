Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 07C7D65C98
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 15:14:29 +0000 (UTC)
Received: by pdbqa5 with SMTP id qa5so25559653pdb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 08:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pYxbsEmtNc9JzcMEkFuPZhQzMgm7XwAbgRvOkHj94rU=;
	b=VFXCmsjtzlMDn/vd3IZeCfdFuX50UMmLta2ohMDvFvJlQWFSsIwZMF3G7L7S/i/ZKu
	sgyHFY4JXkT0NgeKucIvmzkBubPPHiehx/zj9nuqCYSTzPj+2h9cMKJHt51AbSzRQKlX
	fUQ7tbya+Br08VfCHMD5JNuSmXKRk7R6T/WDUHrP9S0C6yt18MqhFxmGM2fePCZzavO5
	9XsKdOPdQC/+nPlh7e0eaLYL059dn3qipruJUirt3h7hoKEBmpo8S9ponNS1QV08wYv2
	VFfJ1yQAt7kaGZcxrr1adMze4X2p/lh5+xrymxBYPOiujcELHIk51Lw8ctjlgI5m4x/8
	3B4Q==
X-Gm-Message-State: ALoCoQkaemdRF1Nm8wSQtRVIhH6CHl0oe89BT3Sp+bxTEwcNt0x5f6mbiOtkOaWnZDBVHkdef/l0
X-Received: by 10.70.62.97 with SMTP id x1mr3427273pdr.41.1428678871261;
	Fri, 10 Apr 2015 08:14:31 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id rb6sm2555313pbb.96.2015.04.10.08.14.29
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 08:14:29 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 85481560E79; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:03 +0100
Message-Id: <1428677827-12371-4-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: [dizzy 3/7] cooker: Fix pyinotify handling of ENOENT issues
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
X-List-Received-Date: Fri, 10 Apr 2015 15:14:31 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We try and add watches for files that don't exist but if they did, would influence
the parser. The parent directory of these files may not exist, in which case we need
to watch any parent that does exist for changes. This change implements that fallback
handling.

(Bitbake rev: 979ddbe4b7340d7cf2f432f6b1eba1c58d55ff42)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b5a5281..614d47d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -176,9 +176,23 @@ class BBCooker:
         bb.parse.update_cache(event.path)
         self.parsecache_valid = False
 
-    def add_filewatch(self, deps):
+    def add_filewatch(self, deps, watcher=None):
+        if not watcher:
+            watcher = self.watcher
         for i in deps:
-            self.watcher.add_watch(i[0], self.watchmask, rec=True)
+            f = i[0]
+            while True:
+                # We try and add watches for files that don't exist but if they did, would influence
+                # the parser. The parent directory of these files may not exist, in which case we need 
+                # to watch any parent that does exist for changes.
+                try:
+                    watcher.add_watch(f, self.watchmask, quiet=False)
+                    break
+                except pyinotify.WatchManagerError as e:
+                    if 'ENOENT' in str(e):
+                        f = os.path.dirname(f)
+                        continue
+                    raise
 
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
@@ -1342,8 +1356,7 @@ class BBCooker:
             (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
 
             self.data.renameVar("__depends", "__base_depends")
-            for i in self.data.getVar("__base_depends"):
-                self.wdd = self.configwatcher.add_watch(i[0], self.watchmask, rec=True)
+            self.add_filewatch(self.data.getVar("__base_depends"), self.configwatcher)
 
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
-- 
1.9.1


