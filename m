Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 350A77CA47
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2019 10:41:06 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x10so4050664wmg.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2019 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=03LgW/EcTBXezJAtRgoJDEhe0eNOqLflDLbOJfLPr/Q=;
	b=SYA8f5OFSjTiP4oA5/o3xkbNV0rYjvSE+hewdFVW2GxHAN/WwcCorAGdMEYKPVEwzK
	JSoLQwDgsJ4WeQDGaSeyltN5K9yj9VvExKC2dZEY8M+slIPrNUIq5nVDV3dzlXpsNnON
	Zo0ea2XOA0/EVfUdNEl6NQTrSdTszwd94z8Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=03LgW/EcTBXezJAtRgoJDEhe0eNOqLflDLbOJfLPr/Q=;
	b=oTOvSZ5TRlqjZ0xXiJjg8vRGQPVE3KWqw54zMLBeyoPh42Oeh1uIOe2JcL0el1Twoi
	Tl2+3UspYcCaus+WGrn5R73pbYDq7MRTNEM0a/mFDpn5r6u4e3xBLUVX8K8FGGPovdyv
	L9T8Q3d32W3YNdoTRfek9oaEZMSvgMhvEH18MTIC9v8IjJqP/W6q1Wof/nCqxbOF2BZP
	KXlNqnfTfZrd3AyNsZEeqHikcFNyDVJSblMp20goAUBkvJvZcaEXVjI5/zBDYyUhSgfu
	4QhWOkynmTqARWN8fA2H6Rld8As9nrj2yADi6J30qP4B56bcad4mZTUfOFS6FEF4AMRS
	+PVg==
X-Gm-Message-State: AHQUAua1dyusOoVVrcPi+w9XieyNKq+sFgeVPS2hDsNT0OOk3Tj+iFJF
	T8jXADrEFNy0//+VkWPY2F2Inbsiw34=
X-Google-Smtp-Source: AHgI3IZqd881KOvCWVe5+Up/h6SGi5ttiI3rXlDX9+bQ/DAvYd8ZhsRgbAumL00f2ToMCwfkcffR4Q==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr4264203wmj.49.1550918467350; 
	Sat, 23 Feb 2019 02:41:07 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p1sm4989664wmi.9.2019.02.23.02.41.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 23 Feb 2019 02:41:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Feb 2019 10:41:02 +0000
Message-Id: <20190223104104.11201-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/3] runqueue: Filter out multiconfig dependencies from BB_TASKDEPDATA
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
X-List-Received-Date: Sat, 23 Feb 2019 10:41:07 -0000
Content-Transfer-Encoding: 8bit

The consumers of BB_TASKDEPDATA in OE metadata can't cope with multiconfig
dependencies. The choice is either to start adding code to each of them to
filter out multiconfig dependencies, or do this at source.

After consideration we've decided to do this at source as doing otherwise
is code duplication and error prone and in any case we've looked at, they
don't make sense.

[YOCTO #13090]
[YOCTO #13130]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 71f178de4f..329cda33a4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -50,6 +50,11 @@ def fn_from_tid(tid):
 def taskname_from_tid(tid):
     return tid.rsplit(":", 1)[1]
 
+def mc_from_tid(tid):
+    if tid.startswith('multiconfig:'):
+        return tid.split(':')[1]
+    return ""
+
 def split_tid(tid):
     (mc, fn, taskname, _) = split_tid_mcfn(tid)
     return (mc, fn, taskname)
@@ -2102,10 +2107,23 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         return True
 
+    def filtermcdeps(self, task, deps):
+        ret = set()
+        mainmc = mc_from_tid(task)
+        for dep in deps:
+            mc = mc_from_tid(dep)
+            if mc != mainmc:
+                continue
+            ret.add(dep)
+        return ret
+
+    # We filter out multiconfig dependencies from taskdepdata we pass to the tasks 
+    # as most code can't handle them
     def build_taskdepdata(self, task):
         taskdepdata = {}
         next = self.rqdata.runtaskentries[task].depends
         next.add(task)
+        next = self.filtermcdeps(task, next)
         while next:
             additional = []
             for revdep in next:
@@ -2115,6 +2133,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
                 unihash = self.rqdata.runtaskentries[revdep].unihash
+                deps = self.filtermcdeps(task, deps)
                 taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
-- 
2.20.1


