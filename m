Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail.openembedded.org (Postfix) with ESMTP id 489C27F041
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:36 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id g17so4225658wrr.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=vK06hrOkqxHXMkkDClQV+iPNBeFBrXwYF3tb01tVtPE=;
	b=XTFPuXKq16MeMxqiZ1c8Ls/Jqlf5ba/REM9kiKxC0z+ApG7TemtULpAzcHdQjKUFh6
	B6pTYgW6Lexbb9LD+z4dblU9H5Z3yy2a1ufYpbrQOtZ2wTsQVmmqG4B+6HdE3AhOaW++
	hkDe67bclZSJlPUFODPKrYwA8QqWzJ06r31Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vK06hrOkqxHXMkkDClQV+iPNBeFBrXwYF3tb01tVtPE=;
	b=MePdJzqr6A72UHwahxTPdMpdyGuOQAjW+JwvMZIqFqPM7b4772+HVHQiVpGn9qFFk+
	zFMsd05y5/+x8xiAwvEORigl2iBJJmGUwJ+EPlwNf7Csz0yCCKrcOXfS8erFxNHCXtfL
	2SzkrHXLYn6/wNUXIDiIZZNgYBVnl5bEhDNDCIEYJN0X7fgGSiksHJXItoeotlYmVHTA
	RT5430CLyxlqY3TyMOzT4l2rUqSl5TOnbOZuDPkBUKDjYYmLwfXzWk6kvDLUnudMvYB1
	9yd34b1Ab5zIIIRcW7boMn0GyChH69v0ErOziDUvy+c7Kj9nEFUnP3c3ImZJ7VNoNyYR
	rrIQ==
X-Gm-Message-State: APjAAAXv8nxhKTxASD1j4G2C/hQoiy/Qzi97FeWOhgPdLFXMjQ35TdLv
	A+Xgs5712FTClFk53XUiDeoL2wb0cyI=
X-Google-Smtp-Source: APXvYqx/EnH3V+ckW9TNeIRZp9vo28+BacW5IjUctZfDLm0l5l9x1AMnck72GZ0fieBkZmt7P65aJQ==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr236439wrl.344.1562802876754; 
	Wed, 10 Jul 2019 16:54:36 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:10 +0100
Message-Id: <20190710235420.23825-16-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 16/26] runqueue: Simplify scenequeue unskippable calculation
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:36 -0000
Content-Transfer-Encoding: 8bit

The existing code to compute the 'unskippable' setscene task list is overcomlicated,
so replace it with something functionally equivalent but simpler and more efficient.

We don't need to process all chains, just the 'top' ones to the first setscene tasks.

This also makes the code more readable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1d7706a219..1f41340170 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2271,7 +2271,7 @@ class SQData(object):
     def __init__(self):
         self.sq_harddeps = {}
         self.stamps = {}
-        self.unskippable = []
+        self.unskippable = set()
 
 def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
@@ -2344,38 +2344,19 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     # Build a list of setscene tasks which are "unskippable"
     # These are direct endpoints referenced by the build
-    endpoints2 = {}
-    sq_revdeps2 = {}
-    sq_revdeps_new2 = {}
-    def process_endpoints2(endpoints):
-        newendpoints = {}
-        for point, task in endpoints.items():
-            tasks = set([point])
-            if task:
-                tasks |= task
-            if sq_revdeps_new2[point]:
-                tasks |= sq_revdeps_new2[point]
-            sq_revdeps_new2[point] = set()
-            if point in rqdata.runq_setscene_tids:
-                sq_revdeps_new2[point] = tasks
-            for dep in rqdata.runtaskentries[point].depends:
-                if point in sq_revdeps2[dep]:
-                    sq_revdeps2[dep].remove(point)
-                if tasks:
-                    sq_revdeps_new2[dep] |= tasks
-                if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in rqdata.runq_setscene_tids:
-                    newendpoints[dep] = tasks
-        if len(newendpoints) != 0:
-            process_endpoints2(newendpoints)
+    # Take the build endpoints (no revdeps) and find the sstate tasks they depend upon
+    new = True
     for tid in rqdata.runtaskentries:
-        sq_revdeps2[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
-        sq_revdeps_new2[tid] = set()
-        if (len(sq_revdeps2[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
-            endpoints2[tid] = set()
-    process_endpoints2(endpoints2)
-    for tid in rqdata.runq_setscene_tids:
-        if sq_revdeps_new2[tid]:
-            sqdata.unskippable.append(tid)
+        if len(rqdata.runtaskentries[tid].revdeps) == 0:
+            sqdata.unskippable.add(tid)
+    while new:
+        new = False
+        for tid in sqdata.unskippable.copy():
+            if tid in rqdata.runq_setscene_tids:
+                continue
+            sqdata.unskippable.remove(tid)
+            sqdata.unskippable |= rqdata.runtaskentries[tid].depends
+            new = True
 
     rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
 
-- 
2.20.1


