Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB3C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 16:13:33 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.19911.1670775203633125216
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 08:13:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NOGshKsT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so3191653wms.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFawhiAhxrhKINfkzoggWK9OkLYGcUpFD4KHJ3NucBo=;
        b=NOGshKsTdvSamNlMZPcbLzusl8iPhjkrNPyrqYhbPhx0TVkBbV7/YSIZoazlgE6Ax3
         +XZwUInzSvKbxuJ/3WdiadUbLS5kIyPGyWoU2w+LcMLJLDauTwTFq+PWqxRy6xKwpgXh
         tsGhNgWZMMl8AQY2Zbao9rRFpqkX/+zoIQQDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFawhiAhxrhKINfkzoggWK9OkLYGcUpFD4KHJ3NucBo=;
        b=tFLWX6L+01uekATFd2SqDLryX+wFg4vKf9U8XZfet+fnAbDswJjr9NzRUh197zwpBG
         5+aIasxKOdwVyuPi4I+dKo0vUwpnycFPYdvZaNq/3sEodequThD0EmUpz+n5WmYWta87
         fxIHWzmrFD9xe/N19e5CfrDqX0RH1+Om3YYNRAoQdulA+A7sCt4bI6+kaIJRYB8nQqnr
         K3PFQAmrixM0FMnE0BVTIsM42qeXsxHJiHbwqmvDdNzIDS4UqmbjyZoa03Dko6L8DByy
         aOAZzRkeGZGz27hdBbXizJvS7CIwPxcO0k+fRDqL+ycNQkCcp1gshDRIkX9Y3XW2RLhN
         1kFA==
X-Gm-Message-State: ANoB5pncOaC8o82tDT2I2gM1WFZZvAtQhV/ak4FgwK0TSlSXctYmBnp7
	KJGO6lLGB4CY31PzR6H73lfbBFvYja1ZXNUF
X-Google-Smtp-Source: AA0mqf77f9Bf2fnHhcZpdigOFjpyHGhKBrP2YUZebhykggYWSysi5L3QdpQI2la7U9wS0Ha7WKafXw==
X-Received: by 2002:a05:600c:2101:b0:3cf:e850:4451 with SMTP id u1-20020a05600c210100b003cfe8504451mr10254652wml.9.1670775201811;
        Sun, 11 Dec 2022 08:13:21 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id bp3-20020a5d5a83000000b002415dd45320sm6561018wrb.112.2022.12.11.08.13.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 08:13:21 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] build/siggen/runqueue: Drop do_setscene references
Date: Sun, 11 Dec 2022 16:13:20 +0000
Message-Id: <20221211161320.17794-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 16:13:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14170

do_setscene was from a different era before our modern setscene
per task code. It hasn't been used for years so remove some old
obsolete references to it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py    | 6 +++---
 lib/bb/runqueue.py | 2 +-
 lib/bb/siggen.py   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index db706d0a3a..5ac191647c 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -782,7 +782,7 @@ def stamp_internal(taskname, d, file_name, baseonly=False, noextra=False):
     When called in task context, d will be a data store, file_name will not be set
     """
     taskflagname = taskname
-    if taskname.endswith("_setscene") and taskname != "do_setscene":
+    if taskname.endswith("_setscene"):
         taskflagname = taskname.replace("_setscene", "")
 
     if file_name:
@@ -818,7 +818,7 @@ def stamp_cleanmask_internal(taskname, d, file_name):
     When called in task context, d will be a data store, file_name will not be set
     """
     taskflagname = taskname
-    if taskname.endswith("_setscene") and taskname != "do_setscene":
+    if taskname.endswith("_setscene"):
         taskflagname = taskname.replace("_setscene", "")
 
     if file_name:
@@ -865,7 +865,7 @@ def make_stamp(task, d, file_name = None):
 
     # If we're in task context, write out a signature file for each task
     # as it completes
-    if not task.endswith("_setscene") and task != "do_setscene" and not file_name:
+    if not task.endswith("_setscene") and not file_name:
         stampbase = stamp_internal(task, d, None, True)
         file_name = d.getVar('BB_FILENAME')
         bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7451e5c56b..63cce8184f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1408,7 +1408,7 @@ class RunQueue:
             logger.debug2("%s.%s is nostamp\n", fn, taskname)
             return False
 
-        if taskname != "do_setscene" and taskname.endswith("_setscene"):
+        if taskname.endswith("_setscene"):
             return True
 
         if cache is None:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index be56b3a31c..cdf7d03a34 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -429,7 +429,7 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
         return self.basehash[tid]
 
     def stampfile(self, stampbase, fn, taskname, extrainfo, clean=False):
-        if taskname != "do_setscene" and taskname.endswith("_setscene"):
+        if taskname.endswith("_setscene"):
             tid = fn + ":" + taskname[:-9]
         else:
             tid = fn + ":" + taskname
-- 
2.37.2


