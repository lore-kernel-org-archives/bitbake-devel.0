Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5423.1792845244953617374
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 24 Oct 2026 05:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=E8xT6Zke;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5579B1A1316
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 236F960769
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6346910328FE8;
	Sat, 24 Oct 2026 14:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792845242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZKu7CIfHGAHP0hs1KMEesIl1hWsQUuTfFK04XanqYqQ=;
	b=E8xT6Zke394oZC/gG6iKFBAqSm/QVXrNSM838JXwQwVmlOzr2MfVva5UL5oMdvjOURkyWZ
	FAPqSOSBBZiwNM0tQCIMWSmSlZgjmAIZBKWrs52YXExzDGe6FKdu5AJDasJ38iqv3IFUPJ
	f38tvptFf0kb54bSuF1D77IknrukSaBFoVW9mRluJxJMmpXtM2+bH+Xb2r27MJ+yzwVwU9
	iAKZUv5IS0+JxYEiO1l5j07ZJ3H5KE9EUoRvut9LlP+zEkKO01NO9SSgW5Wvk7FQ6uc1ZB
	dooU4dtlTaFOTtMAtB9Dqht66wfP3psYsl7fwjAPcj3Y+qHNCZLYHMBWoPVC9w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sat, 24 Oct 2026 14:33:33 +0200
Subject: [PATCH RFC 2/3] build: Attach a log catcher to tasks and save
 their records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-mathieu-debug-replay-v4-v1-2-3f7f52a3b8e6@bootlin.com>
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
In-Reply-To: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792845239; l=2632;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=bwu9ErDIi26KsDaJGWrD240rDAdMinoHL0OlD+mO1jk=;
 b=D3WM5hto+s+2xsIPdae4PSaEYS3BBoZUW9hpuZ12xK1pNwMi+Jj+Lgm72+72Q/0/7i1NQVSfH
 DnLVXXfLP1FAK9pXtF0dmKHmkwOec1LH1EmE69HEFY6EYyUgnXSQzRG
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20375

Every task gets a LogCatcher which records its warnings and errors during
execution. Right after the task body, and before the postfuncs, the
records are written to ${T}/logrecords.<task>.json. The sstate packaging
postfunc reads the current task's file to bundle the messages for replay
when the task is later restored from the sstate cache.

Writing the file before the postfuncs makes both the current task's own
record and the files of already finished dependency tasks readable from
the same place.

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/build.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 8b49721d60f8..033e5b1c3f30 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -21,6 +21,7 @@ import time
 import re
 import stat
 import datetime
+import json
 import bb
 import bb.msg
 import bb.process
@@ -656,6 +657,11 @@ def _exec_task(fn, task, d, quieterr):
         except OSError:
            pass
 
+    # Task log records, for sstate log replay. Written right after the task
+    # body, before the postfuncs, so the sstate packaging postfunc can read them.
+    logrecords = os.path.join(tempdir, 'logrecords.{0}.json'.format(task))
+    bb.utils.remove(logrecords)
+
     prefuncs = localdata.getVarFlag(task, 'prefuncs', expand=True)
     postfuncs = localdata.getVarFlag(task, 'postfuncs', expand=True)
 
@@ -698,6 +704,9 @@ def _exec_task(fn, task, d, quieterr):
     errchk = ErrorCheckHandler()
     bblogger.addHandler(errchk)
 
+    tasklogcatcher = bb.utils.LogCatcher()
+    bblogger.addHandler(tasklogcatcher)
+
     localdata.setVar('BB_LOGFILE', logfn)
     localdata.setVar('BB_RUNTASK', task)
     localdata.setVar('BB_TASK_LOGGER', bblogger)
@@ -711,6 +720,9 @@ def _exec_task(fn, task, d, quieterr):
             for func in (prefuncs or '').split():
                 exec_func(func, localdata)
             exec_func(task, localdata)
+            if tasklogcatcher.records:
+                with open(logrecords, 'w') as f:
+                    json.dump(tasklogcatcher.records, f)
             for func in (postfuncs or '').split():
                 exec_func(func, localdata)
         finally:
@@ -720,6 +732,7 @@ def _exec_task(fn, task, d, quieterr):
             sys.stderr.flush()
 
             bblogger.removeHandler(handler)
+            bblogger.removeHandler(tasklogcatcher)
 
             # Restore the backup fds
             os.dup2(osi[0], osi[1])

-- 
2.47.3

