Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17767C021AD
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 23:19:09 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.10293.1739920745055295756
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 15:19:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cGyi6C5n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so37446035e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739920743; x=1740525543; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsgfp+eyNNqndBnQJRK0SO5Yfdvt76PlvUmRQriEx/o=;
        b=cGyi6C5nQEiZW4642P9npyaGZ1WJjMkagnsGfdgZIeIB3NTrtsl5cFYBQAMv26xCwI
         aUxg3WsnO9OHsRDCGokWCWuidAhUoFnVWDqlDxCWyQXre2mGTCvoMInYoUYNlyRkTI3w
         1JoyLhzzxP56YucpU2eKGYLftzaXRau7zr+NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920743; x=1740525543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsgfp+eyNNqndBnQJRK0SO5Yfdvt76PlvUmRQriEx/o=;
        b=DvBO4ho+kcs0r9CjlPpawovvTT+TlPrKcukDaOXYbvWPODa3l4MSu5L+D35n5D0kDK
         Ak9/kmECF6xop+kN8c3KwW54em3s6Yjn0KKPgL2WemvGwdkgxLd9+70S2qKpFrJ7Y9RK
         Cxwwgo4SifX6f2P7VxdOaO7N4sBoZHO/H5sP3rH3h9nwaCBubT6jgLZ2QFFbP8tFV0Ve
         InXtFVXy4iEGrC3HHi3Ja81Y2j6HA9Sx+v9kgl5+Q/iIK9d9IGWANf5PGuBBTYq5q6AS
         1XhYWoTM7/WRwKF4SQk2NSQIUgbHVRJIEolIkNSFTcAsNtl1c4+t2k4y8T2w75lRqNsv
         R5lQ==
X-Gm-Message-State: AOJu0YwzdwSQqH+/pw3ns9A5PrOQrm6SIKbl6nY/oLsuN+apRTWH7DLK
	zAY6BaPHzLV5pu8+44P8R8apTQb1jscU6L30IN8qwQRgPxJD4zs7ddbSwWkNaDGqiy38eu4RSFO
	/
X-Gm-Gg: ASbGncv0/hmKTIMJTEGFIQcJiLZqt1q2TznnZ+BCYiTZ13SZvzb3GWG1/9Zc1B1Wxh/
	wYsL0OrBm2k0VkcPK8RnLklbnYL3pankf+taTX/B2UvoTNknJk0X3liCZxq4d8pDc7Orj52cBnr
	RtsuNIu/tJ1twTQCiqm20M5t5Yea7o5rY7MoJECcVWuKz10qtiZ7LA3pZUFbym4u0a8CQzRsNRH
	bqckaFWFfLH5Nw+uBZFsD3WmDY0yk5Z6vhIHkxS20rVFu99fjgP4BswBm47+5EUDu4aErguTPZi
	RMbo3uxJwxj6VZ1sc7APzN4+4vOStgnM/ra0PuyIANmc
X-Google-Smtp-Source: AGHT+IGPr69V5BMLBEk9jvDVutyufBO5jwM4s7eVHyQsELAyc2MdWj2pgjPT2G1EyJY9aK6eGyCBRQ==
X-Received: by 2002:a05:600c:1c86:b0:439:9863:e876 with SMTP id 5b1f17b1804b1-4399863e985mr21145485e9.24.1739920743039;
        Tue, 18 Feb 2025 15:19:03 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1cdc:d60b:3749:b3e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm65304265e9.3.2025.02.18.15.19.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:19:02 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] TODO: Cleanup obsolete info
Date: Tue, 18 Feb 2025 23:19:00 +0000
Message-ID: <20250218231900.1468007-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 23:19:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17246

The file has some useful items but also something things which are obsolete.
Clean it up.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 TODO | 65 ++++++++++++++++++------------------------------------------
 1 file changed, 19 insertions(+), 46 deletions(-)

diff --git a/TODO b/TODO
index 54d091fb84..4e0bd9a791 100644
--- a/TODO
+++ b/TODO
@@ -1,36 +1,31 @@
-- Reimplement the interactive mode as a proper ui
-- Continue dropping fatal/SystemExit/sys.exit usage in favor of raising
-  appropriate exceptions
-- Continue pylint / pyflakes / pychecker / pep8 fixups
+
+- Interfaces
+  - Add an interactive mode to knotty (similar to the interactive mode we dropped)
+  - Fix up or drop the ncurses interface? Currently too limited to be useful.
+  - Concerns about whether teamcity interface works. No testing.
+
+- Improve exception handling:
+  - dropping fatal/SystemExit/sys.exit usage in favor of raising
+    appropriate exceptions
+  - Audit bb.fatal usage - these should all be able to be replaced with
+    exceptions
+
+- Continue pylint / pyflakes / pychecker / pep8 fixups - focus on real issues
+  or performance issues, not cosmetic ones.
+
 - Drop os.system usage in favor of direct subprocess usage or a subprocess
   wrapper
-- Kill the execution of 'tee' for the task log file in build.py
-- Fix up the exception handling
-
-  - Kill exec_task's catch of FuncFailed, instead catch it in the other
-    callers of exec_task/exec_func
-  - What exactly is the purpose of the "EventException"?  I can see using an
-    exception like that, *perhaps*, to abstract away exceptions raised by
-    event handlers, but it has no place in bb.build.exec_task
 
 - BUG: if you chmod 000 local.conf, it silently doesn't parse it, when it
   should really fail, so the user can fix the problem.
 
-- Audit bb.fatal usage - these should all be able to be replaced with
-  exceptions
-- Figure out how to handle the ncurses UI.  Should some of our logging
-  formatting stuff be made common to all of bitbake, or perhaps all UIs via
-  the UIHelper?
 
 Long term, high impact:
 
-  - Change override application to actually *move* it over -- so the original
-    override specific version of the variable goes away, rather than sticking
-    around as a duplicate.
-  - Change the behavior when a variable is referenced and is unset.  Today, it
-    evaluates to ${FOO} and then shell has a chance to expand it, but this is
-    far from ideal.  We had considered evaluating it to the empty string, but
-    that has other potential problems.  Frans Meulenbroeks has proposed just
+  - Consider changing the behavior when a variable is referenced and is unset
+    Today, it evaluates to ${FOO} and then shell has a chance to expand it, but
+    this is far from ideal.  We had considered evaluating it to the empty string,
+    but that has other potential problems.  Frans Meulenbroeks has proposed just
     erroring when this occurs, as we can always define default values for the
     variables in bitbake.conf.  This seems reasonable.  My only concern with
     that is the case where you want to reference a shell variable with odd
@@ -38,25 +33,3 @@ Long term, high impact:
     expansion rather than normal $.  To handle that case, we'd really need a
     way to escape / disable bitbake variable expansion, \${} perhaps.
 
-Uncertain:
-
-  - Leverage the python 2.6 multiprocessing module
-
-    - Worker processes for bb.cooker
-    - Server / UI processes
-
-  - Create a bitbake configuration class which is utilized by the library, not
-    just bin/bitbake.  This class should be responsible for extracting
-    configuration parameters from the metadata for bitbake internal use, as well
-    as pulling specific items like BBDEBUG, and importing settings from an
-    optparse options object.
-
-  - Python version bits
-
-    - Utilize the new string formatting where appropriate
-    - Do we need to take into account the bytes literals changes?
-    - Do we have any file-like objects that would benefit from using the "io"
-      module?
-    - Do we want to leverage the abstract base classes in collections?
-    - Aside: Set methods now accept multiple iterables
-

