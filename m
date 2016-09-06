Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id E61266E630
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 11:53:20 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id w12so87131522wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Sep 2016 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=+U2rVD2fcVtus9v3Orw06rcBVkdhhPdHSGdvpGvPGqg=;
	b=V1iV09RrRT+a+qaOBXWRLfExlamrzc5iI0ozNaV0bqPxgVywv5GH/DB5TjiB/HEVQk
	ECfxZ/yYdTTx+ICkJBuH/HSxXU3OJZp5Aw/46LEnhoxQ4uNdXnS8EjX5g2yvNAlO4hms
	u2riahh4tuNpSoCXPK7id0UQhbIVzGr7X36tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=+U2rVD2fcVtus9v3Orw06rcBVkdhhPdHSGdvpGvPGqg=;
	b=jEypRSrIBtk3orRHyl67V3NOKixBX/UFJ2K4E+Z76wWxALvAVf71IRnHH80jdOfiDL
	066ALDjMZLUkrGHPaDJOBrFJuwq9fhLKbljv8gznIJeOhN6/+MQW3dLc7BsHfuHQUR9b
	N6uk7ka+GjNvji5k/x23naG7Q2vD0gwYdJIUrKUZHTCzSaBGDv6DAukAc9xKZwe46Esx
	RzZnFfCauKqjjsXefELDMJcCW2wKHRDJBKpEmyJiCUoK4K4cLfO58TLsVuMTT6CMcfEs
	DRYiRdQybQA59DBgeUOR9ou4Pea2lIv9T9m+YNqQGNzyNK7wR48AYJv0b8OP209b+zpH
	FW9w==
X-Gm-Message-State: AE9vXwNk4glz/NjNSndyFTTSn7sE6T8ymT0kx2dNMPilo8qGCahnvhktuJNyQ2RryL9yoqgF
X-Received: by 10.28.67.1 with SMTP id q1mr19565699wma.50.1473162799853;
	Tue, 06 Sep 2016 04:53:19 -0700 (PDT)
Received: from hackbox.linaro.org ([81.128.185.36])
	by smtp.gmail.com with ESMTPSA id 12sm9540978wjx.42.2016.09.06.04.53.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Sep 2016 04:53:18 -0700 (PDT)
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 12:53:00 +0100
Message-Id: <1473162780-11643-1-git-send-email-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.7.0
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH] lib/bb/build: create .old symlink for run.do_xx and log.do_xx
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
X-List-Received-Date: Tue, 06 Sep 2016 11:53:21 -0000

When they exist, keep a reference to the 'previous' (or old) build for run.do_xx
and log.do_xx files, which can be useful when debugging. The symlink are created
as run.do_xx.old and log.do_xx.old.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 lib/bb/build.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 310b5c0..7cff578 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -246,6 +246,16 @@ def exec_func(func, d, dirs = None, pythonexception=False):
     # link won't be created as an exception would be fired.
     if task == func:
         runlink = os.path.join(tempdir, 'run.{0}'.format(task))
+        oldrunlink = os.path.join(tempdir, 'run.{0}.old'.format(task))
+
+        if oldrunlink and os.path.islink(runlink):
+            bb.utils.remove(oldrunlink)
+
+            try:
+                os.symlink(os.readlink(runlink), oldrunlink)
+            except OSError:
+                pass
+
         if runlink:
             bb.utils.remove(runlink)
 
@@ -503,7 +513,17 @@ def _exec_task(fn, task, d, quieterr):
 
     # Setup the courtesy link to the logfn
     loglink = os.path.join(tempdir, 'log.{0}'.format(task))
+    oldloglink = os.path.join(tempdir, 'log.{0}.old'.format(task))
     logfn = os.path.join(tempdir, logbase)
+
+    if oldloglink and os.path.islink(loglink):
+        bb.utils.remove(oldloglink)
+
+        try:
+            os.symlink(os.readlink(loglink), oldloglink)
+        except OSError:
+            pass
+
     if loglink:
         bb.utils.remove(loglink)
 
-- 
2.7.0


