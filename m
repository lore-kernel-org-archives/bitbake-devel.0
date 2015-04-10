Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 6A81F73D17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 14:57:14 +0000 (UTC)
Received: by pddn5 with SMTP id n5so25096024pdd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 07:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=5WTrTDY3v4az1n3WapiP3AmLeRYD2uwfueZx40eBxFc=;
	b=WwLZrTI8nU7YGqvVRH7g2rsrR5Hxkm65BDjZJbd1my9NFCTjgFneYg7eypgFcuhh6R
	Hwwd30/fQjgh3bdf3SswwA/eAzVrGXDJ2TLK0QZsm8GwYlqrfyOYucByrwR2iq6meHvl
	iZY00/LQlZ0wDNOY6sxgMvHWJaqUalTBqFJ422N4HF6/EuPY1bgLQx0oxcbMFB3c7ncj
	+LPOwY+45WXqLMXMijHd5PMT7sc4Qj5fxSYDXJO8G6uLNOlv1UsmWKs3Ni3OVNE5XxR+
	TQa7ElF8ekLqWCdDKyW0V7DduogFAhC0iF2zGWQbRKsZcuRZj6rMCj4IAn0cs4d7sgCO
	0Qaw==
X-Gm-Message-State: ALoCoQkq10Yei0/VlLFC6SfAvI3C8vLHeaKD3RqsqWxlJrinWPF2pM2Fp2sWusEoJ9xX8ZaRCS3b
X-Received: by 10.68.97.131 with SMTP id ea3mr3215339pbb.165.1428677836493;
	Fri, 10 Apr 2015 07:57:16 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id tj4sm843928pbc.63.2015.04.10.07.57.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 07:57:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 8900D561127; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:05 +0100
Message-Id: <1428677827-12371-6-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: [dizzy 5/7] cooker: Improve pyinotify performance
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
X-List-Received-Date: Fri, 10 Apr 2015 14:57:16 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Benchmarks show that the introduction of pyinotify regressed
performance. This patch ensures we only call the add_watch() function
for new entries, not ones we've already processed which does improve
performance as measured by "time bitbake -p".

This doesn't completely remove the overhead but it does substantially
reduce it.

(Bitbake rev: 493361f35f6cc332d4ea359a2695622c2c91a9c2)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e965bcc..3909dc0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -122,11 +122,13 @@ class BBCooker:
         self.configuration = configuration
 
         self.configwatcher = pyinotify.WatchManager()
+        self.configwatcher.bbseen = []
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO 
         self.watcher = pyinotify.WatchManager()
+        self.watcher.bbseen = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
 
@@ -180,7 +182,7 @@ class BBCooker:
         if not watcher:
             watcher = self.watcher
         for i in deps:
-            f = os.path.dirname(i[0])
+            f = i[0]
             if f in watcher.bbseen:
                 continue
             watcher.bbseen.append(f)
@@ -194,6 +196,7 @@ class BBCooker:
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
                         f = os.path.dirname(f)
+                        watcher.bbseen.append(f)
                         continue
                     raise
 
-- 
1.9.1


