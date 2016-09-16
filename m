Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id 83A46731D7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:05:17 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id my20so836476pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=GHa+2lZ4p79sFUsQMFm5ud4GN7bZdkMBi8GxwgaaAlc=;
	b=xS/avdpclU//NVAH0yl2CqlxsMRkrYEfN7VrLU74YxDF7Igy5UXqeh7FJDhjixlUuA
	5/4aHAeZTpye8QPbBxSyOeRqodyF6fBwFY/Pa0K/NLi8oiK5ncOwCFaZwDbMtzXhBhhr
	x6JiwXYceXTlweMrUjpGFAsg2BeT7P9hYlrOpZkAT69SfNvtf6E50iNxosZK3fDxrGeo
	ID769nLI779WOJ5bwSoo9KnrV9tdxoF7LOE8F2bA+nDwK2uY9ZMhiEfZNH50jg+WxeiV
	NJABmAAUDU2uhiV4De68vzKYDhVeDdMoPQhAAFjo/QjoB1R/3TjRDTO5uhUQ2xM6udqT
	HABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=GHa+2lZ4p79sFUsQMFm5ud4GN7bZdkMBi8GxwgaaAlc=;
	b=btM7QOg/Wy+e4IWvBluJRiZUVYvW0ESAVsjnzPLgJwNfIwi/X9+2y77qjkbrnwvsSG
	IBIbFkqecrtiRJVCCvm0eE0gRMVZHUk16OWvSvp0+bR/ja1P1MmQNKvxMLzfQddnoO6Q
	qCEh7/R8SZl0SvIvUbp143O+btpD9uw/s9iL/eSIF8EkEJitd/Gzr+00A/45rzoIK1I9
	K+eCT/0uThfL1CnINXPskeaFmRQhpwMJSEfM5C21y8r+fk6BkjYt4z2DxZCs51dNwUsx
	S/ASqwEAxn4XwlEzm1tDTdemlvDkFK6i34ersKwdg4r2h1JqqzUz8pcHVyR/SJWAoUh6
	GVCg==
X-Gm-Message-State: AE9vXwOFq6hAdgI/zhrUM5tRBvOj81kuMJQ5kcC1fU9Zfws07crT653Vw8oTqwxls1RS4Q==
X-Received: by 10.66.120.69 with SMTP id la5mr15417752pab.65.1474056318015;
	Fri, 16 Sep 2016 13:05:18 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	h123sm54113642pfe.69.2016.09.16.13.05.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 13:05:16 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 13:05:12 -0700
Message-Id: <1474056312-13817-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1474056312-13817-1-git-send-email-kergoth@gmail.com>
References: <1474056312-13817-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCHv2 2/2] bb.build: in _exec_task, catch errors from TaskStarted
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
X-List-Received-Date: Fri, 16 Sep 2016 20:05:17 -0000

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


