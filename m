Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id DCC3660116
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:00:45 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id oz2so3812320pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=GHa+2lZ4p79sFUsQMFm5ud4GN7bZdkMBi8GxwgaaAlc=;
	b=evg7rdOBx+mtxuip1UBSUSBGh7pHsEw+J7aoYiEDIKC+RDKoIb48+qfK3ITwnTiT22
	jMKqJQ6wrvzM9724xzQ2SWwoMnwedVIXSSq6rY4c8pgohSBfQkFqOpGWXyyowew83VuO
	75CrLHMhNj0YwQ3Y1iW3lFy5Q+htCnIyCEfQLm3N8kifRfYT8V1Vv5vqF5nLwZ+pgOJF
	f6fuafOqP0aNAqAakmAaHwPs6j+3Y2nhG/ugylTwTPeLqlsXmbmP8K8vcGuvDBRslfx+
	8lC1GOte4JXF/sjH1TGWAraUAtYUbJUV4gFfvFUlMatcs6kkwwgsSyJjN1JnOHlLHAP8
	A7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GHa+2lZ4p79sFUsQMFm5ud4GN7bZdkMBi8GxwgaaAlc=;
	b=hCDM3wPYEUhfZav8n1Pgc5MBfmcasLVbBmMQzZycGeO0ZbvDj198X2wQystj3K2c61
	X8zS6VxMi8fqr3jxfTGLJEJMWurBkkA4UkG9rezfNGPhX+8eIPJ7LkiahbeEOxiAkaMY
	owB+AQ19VI9LbE/LUY3ycnr9w9tbTT3hMRG8QjkAFcZ23D5nEKB6lrZMuU4nFkQboAuz
	UZ3p/DzpBHYhZ5BPwvQCkD7on7CX8668E/WjRMjA9Jjs+scDQ6JYT1ODvSPvn+hX4hLM
	rE1fdjNxxTGA8sLmyCr4XnIRrSdX2wdJGxocM6ZUvvV+5v77OYnoIaPWzM+tZo3I+6fY
	idzg==
X-Gm-Message-State: AE9vXwPQWzD73GTmFwKWqZRT1ATCPm5yawZeXfCo5X6v8pVgHIC9M5O+mhKsLRA7Hlb2qg==
X-Received: by 10.66.43.164 with SMTP id x4mr25463046pal.11.1474056046359;
	Fri, 16 Sep 2016 13:00:46 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	b64sm54098609pfa.82.2016.09.16.13.00.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 13:00:44 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 13:00:41 -0700
Message-Id: <1474056041-11200-1-git-send-email-kergoth@gmail.com>
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
X-List-Received-Date: Fri, 16 Sep 2016 20:00:47 -0000

From: Christopher Larson <chris_larson@mentor.com>

We want any exceptions raised by the TaskStarted event handlers to be caught
rather than unconditionally hitting the exception formatting + traceback in
exec_task, otherwise we can't cleanly exit the task with a nice message from
such a handler.

This is done via a separate try/catch block, to avoid firing TaskFailed if all
the TaskStarted event handlers didn't complete, otherwise the bitbake UIs get
unhappy.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 2ed0441..b74557a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -560,24 +560,29 @@ def _exec_task(fn, task, d, quieterr):
 
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
-            logger.error(str(exc))
-            event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
-        return 1
-    except bb.BBHandledException:
-        event.fire(TaskFailed(task, logfn, localdata, True), localdata)
-        return 1
+        try:
+            event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
+        except BaseException:
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


