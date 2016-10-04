Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id B002F71A0B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2016 16:11:27 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id 190so4648669pfv.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Oct 2016 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=qJxsFsRz06pIcTCBXdBQze+IVl+UCnSrR/q/TMkIKr4=;
	b=voAFlTlymEyJu+03u97c0k78njcIf+GGsZDZ4tnkHZPvtPs7ISiAoAN0DUB3HkvBzv
	6h5eES2ZDc3bimQQ7es28bRbaH4sROWO8fKhkKylYubUyc8/nd9y6uhKGfbgl7SK5h0A
	i1/mnbAOEFfWGGf5XFaP//YQDb+PIZ/lyQVO4aPEyjRTrTQZeWTxLWrnm7NofAqY8dEg
	4tOVp2N3vfYJZ5cf0OdzOKVXK8y9rz+zOmMF6U1xN12vBew9/K9lvNifTesObWncsw7y
	/tRaZTTM4avR/Clkc4hY063z2AheHNSqru0KfPzBZRlIYqb5P51D9ydo0ERaLzmRzDcA
	QwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qJxsFsRz06pIcTCBXdBQze+IVl+UCnSrR/q/TMkIKr4=;
	b=RpzoDKRgWIOhrOjrv42qHY5I7KjT0eakZMvMqywA41hqmkTpOz7u75ozmoGO3oTdbT
	bSztwDxxQBL0Rru/N68476SUJkOLLkPmCb3bOSO5HDt/lGKpQDhWtljOBpi7PfkbMvO4
	asTpLBPq8lYsgU/WjLLrFK7p3YbNrOmLwLOqaRhTdBwQmGJP0c4JEHkMu+o/L3mICLFI
	TolTdecAuOXBblhABS9n07mEat30B/ilWpgSTxWEWdFE1HuLL3N4L+sJltcTkxaI3fuv
	En/kPPsyPDetOLAwW5ts6FVwViLXSDivW4wyqihws5BhLuT91xf0qAsG50YMTA7wLgpQ
	pagQ==
X-Gm-Message-State: AA6/9RkEpzCTqk7zOHC0JgkJHQKyq5epNp9ZVO7ifGCqi3BcwnnD0sAHJags0uL1+OGOcg==
X-Received: by 10.98.93.204 with SMTP id n73mr7314841pfj.54.1475597488942;
	Tue, 04 Oct 2016 09:11:28 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i62sm56347331pfg.89.2016.10.04.09.11.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Oct 2016 09:11:27 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Oct 2016 09:11:23 -0700
Message-Id: <1475597483-31241-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.build: in _exec_task, catch errors from TaskStarted
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
X-List-Received-Date: Tue, 04 Oct 2016 16:11:29 -0000

From: Christopher Larson <chris_larson@mentor.com>

We don't always want a traceback when an exception is raised by the
TaskStarted event handler. Silently return if we get a SystemExit or
HandledException, and print the error and return for FuncFailed.

This is done via a separate try/catch block, to avoid firing TaskFailed if all
the TaskStarted event handlers didn't complete, otherwise the bitbake UIs get
unhappy.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 bitbake/lib/bb/build.py | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 2ed0441..666fe08 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -560,24 +560,32 @@ def _exec_task(fn, task, d, quieterr):
 
     flags = localdata.getVarFlags(task)
 
-    event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
     try:
-        for func in (prefuncs or '').split():
-            exec_func(func, localdata)
-        exec_func(task, localdata)
-        for func in (postfuncs or '').split():
-            exec_func(func, localdata)
-    except FuncFailed as exc:
-        if quieterr:
-            event.fire(TaskFailedSilent(task, logfn, localdata), localdata)
-        else:
-            errprinted = errchk.triggered
+        try:
+            event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
+        except (bb.BBHandledException, SystemExit):
+            return 1
+        except FuncFailed as exc:
             logger.error(str(exc))
-            event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
-        return 1
-    except bb.BBHandledException:
-        event.fire(TaskFailed(task, logfn, localdata, True), localdata)
-        return 1
+            return 1
+
+        try:
+            for func in (prefuncs or '').split():
+                exec_func(func, localdata)
+            exec_func(task, localdata)
+            for func in (postfuncs or '').split():
+                exec_func(func, localdata)
+        except FuncFailed as exc:
+            if quieterr:
+                event.fire(TaskFailedSilent(task, logfn, localdata), localdata)
+            else:
+                errprinted = errchk.triggered
+                logger.error(str(exc))
+                event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
+            return 1
+        except bb.BBHandledException:
+            event.fire(TaskFailed(task, logfn, localdata, True), localdata)
+            return 1
     finally:
         sys.stdout.flush()
         sys.stderr.flush()
-- 
2.8.0


