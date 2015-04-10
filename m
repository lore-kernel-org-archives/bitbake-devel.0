Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 0F96C73D1E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 14:57:15 +0000 (UTC)
Received: by pacyx8 with SMTP id yx8so24029442pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 07:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qvWSCmlpHppaXlQjSlkehuajbbG3fw8fFjwBk1NGJx8=;
	b=d2n+88+cbaBPqBZJLELXC6hlvjHWdnfcJYyQUaz26Dgbseclh0aLZmV7V1zjpjfTAz
	Cqg+xs8kYCNaXCPBKtaW+3qVrtqRBObT1lqwh4XU+sppaefGfMaKqXsV4Ztqoep0TXBv
	tSnco8TdGI8LxRzGw33kM7YDnViX7YCVmWV2c3STQJLDoAjjIX/uNn1RHvBSSw8xrxUt
	D1JzXDHJmWV3J68oCTHrq1YAk4PmWNKbyffYa0F/9CqCGtvKIsLcRj1XQTJMUYd5WGfW
	w9uj2NoDimr7TlgSP0VxCjisJRX3d16jyn2WX0xXcYH8z0SghqXiJas9GMIQMEIvvkpp
	8nYQ==
X-Gm-Message-State: ALoCoQno9HFWaM3/wuLl4fT+1yKBJVPUsm4zlyqUmbtSnAAMJegxD1BA0YW5pdsfQQIICBitLqn9
X-Received: by 10.68.139.225 with SMTP id rb1mr3306095pbb.93.1428677836773;
	Fri, 10 Apr 2015 07:57:16 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id i6sm2541794pdp.53.2015.04.10.07.57.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 07:57:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 8E6DB56121E; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:07 +0100
Message-Id: <1428677827-12371-8-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: [dizzy 7/7] cooker/server: Fix up 100% CPU usage at idle
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

The recent inotify changes are causing a 100% cpu usage issue in the
idle handlers. To avoid this, we update the idle functions to optionally
report a float value which is the delay before the function needs to be
called again. 1 second is fine for the inotify handler, in reality its
more like 0.1s due to the default idle function sleep.

This reverts performance regressions of 1.5 minutes on a kernel build
and ~5-6 minutes on a image from scratch.

(Bitbake rev: 0e0ba408c2dce14a0fabd3fdf61d8465a031495b)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 2 +-
 lib/bb/server/process.py | 3 +++
 lib/bb/server/xmlrpc.py  | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2f2a852..aeb3f71 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -142,7 +142,7 @@ class BBCooker:
                     # read notified events and enqeue them
                     n.read_events()
                     n.process_events()
-            return True
+            return 1.0
 
         self.configuration.server_register_idlecallback(_process_inotify_updates, [self.confignotifier, self.notifier])
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index d362f8d..302ee5f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -135,6 +135,9 @@ class ProcessServer(Process, BaseImplServer):
                     nextsleep = None
                 elif retval is True:
                     nextsleep = None
+                elif isinstance(retval, float):
+                    if (retval < nextsleep):
+                        nextsleep = retval
                 elif nextsleep is None:
                     continue
                 else:
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 4205a4c..10d4b5c 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -241,6 +241,9 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
                         del self._idlefuns[function]
                     elif retval is True:
                         nextsleep = 0
+                    elif isinstance(retval, float):
+                        if (retval < nextsleep):
+                            nextsleep = retval
                     else:
                         fds = fds + retval
                 except SystemExit:
-- 
1.9.1


