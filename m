Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id 6D8C171AAE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 16:40:49 +0000 (UTC)
Received: by mail-pf0-f177.google.com with SMTP id 189so25680065pfz.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WMq1on6liJEKG5HMIrz4auMxBlt6exhkd9hwuWnzi9U=;
	b=kO1MwQ9asaKvknEa+Lyq4IcdET7TIt6uWhmNleyXUyJTjvaS8JWc1PUB40p6JsKpwx
	wddX0JaCy3XXGQfRxJHe/9hT4j3wE6pkjzsrgzEPFpU2vPhoEwzHxvwjea7v7INyLYnj
	4vUXVU8FidL3Ghl4iOMgNRsfpG4knMIuh46PXMyxbB27+f3G4SMdsBds8STdolio7pgE
	1QCn5HOMfVyPkDvH06hZXVXxs9QX7JK+RnPZPR83zftlly+V4dMVuFDGey8dNFiJ4+f3
	nlmLjFg7VQknYBdhHv23N/4yPEA92xm//Ry5c2tg/Czs1KxxS4ZHXxoj8EaRaMatJI6Y
	SntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WMq1on6liJEKG5HMIrz4auMxBlt6exhkd9hwuWnzi9U=;
	b=Bun8AjfBnX1/aGvebmeGPpIhkmzgzpoVN64A15CTtCu5a5Xq0qwNJJp64lf8pcRpUp
	3/8LtK3yR73UrjZYbnyvaHk/V0HKYS60d8DNzgL/yMDy6fqTHvs/127V6UCzVp89iSgJ
	/hYxcAIetNozYDhg/nWtuYD7Y3yVOTV/U3TZjMb2g6OjGhczLxuActxjXB0U477483Qn
	2IeGxs+N16RZpt/8OxyLuRpKiEBC4IzqoOZg3CjZavMbA5WniQYmPiQM8ucjVJKiXQNv
	io7diNGHhc9avWiKcDsihJL9MRCbmiNIQ28UjxA9rbDmJAbs3bj7GCQw1A6BHeCPjGW5
	nYdQ==
X-Gm-Message-State: ABUngvelGBISIR7M8D16DEtVsrMO+K2JaJAD2UJdsl/iCgB//GA8wgmmll/6uKY1lyRtMerA
X-Received: by 10.98.20.131 with SMTP id 125mr11994467pfu.51.1477932051096;
	Mon, 31 Oct 2016 09:40:51 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	j192sm36718494pfc.60.2016.10.31.09.40.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 31 Oct 2016 09:40:50 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Oct 2016 16:40:39 +0000
Message-Id: <1477932040-10112-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
References: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/4] toaster: add eventreplay test case for zlib
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
X-List-Received-Date: Mon, 31 Oct 2016 16:40:49 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Run toaster-eventreplay with zlib.events.
Check if zlib build and package present in Toaster database.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/eventreplay/__init__.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/eventreplay/__init__.py b/lib/toaster/tests/eventreplay/__init__.py
index 792f07d..6956619 100644
--- a/lib/toaster/tests/eventreplay/__init__.py
+++ b/lib/toaster/tests/eventreplay/__init__.py
@@ -34,7 +34,7 @@ from pathlib import Path
 
 from django.test import TestCase
 
-from orm.models import Target_Installed_Package
+from orm.models import Target_Installed_Package, Package, Build
 
 class EventReplay(TestCase):
     """Base class for eventreplay test cases"""
@@ -85,3 +85,13 @@ class CoreImageMinimalEventReplay(EventReplay):
                                     'update-alternatives-opkg',
                                     'update-rc.d', 'util-linux-libblkid',
                                     'util-linux-libuuid', 'v86d', 'zlib'])
+
+class ZlibEventReplay(EventReplay):
+    """Replay zlib events"""
+
+    def test_replay_zlib(self):
+        """Test if zlib build and package are in the database"""
+        self._replay("zlib.events")
+
+        self.assertEqual(Build.objects.last().target_set.last().target, "zlib")
+        self.assertTrue('zlib' in Package.objects.values_list('name', flat=True))
-- 
2.7.4


