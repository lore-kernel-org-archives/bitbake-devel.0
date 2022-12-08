Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB6C4167B
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 17:36:28 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.21033.1670520984792955020
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 09:36:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KAQ9QxEA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so3897455wmb.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5JhumMollyNSxYFV2QbnPIUs0JsQZvBClsWDCz1Q5A=;
        b=KAQ9QxEAci1xmsEpMouJTDchJVQ5jvflwwcnh6lY8kx8D5v1BHSXxD6eOLPPW1vfZy
         EnJhe+7BCYQTErYW9wJPSrWtQJUuOSYItP7E4InRpZVbdzUmt4K5gjOhHYAET7LtVVb3
         72sA73GpxyLZlvhLdtHtHUupXYaDigq6HZVj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5JhumMollyNSxYFV2QbnPIUs0JsQZvBClsWDCz1Q5A=;
        b=SFK4zc6qkQKzJlEUG5yEX6sqR/PiibQaVcwQdc63P5nTDv+KM/eVnaFU6YKHqG7kFA
         qSnnkx1SVbg1aQMIZztHjmy8/EAz1qQ9Jj2H/lK5OnfZQ90bI9stLgwSEbEsDi1LAszl
         13iM1oyRJ5/9ian9+gMgzpZCmslHyVUzPJfTmoWLY/rZfv5kUWh745jWLBTgUhnemkHT
         4c457cOV1JBOVSMOQPBdrLCwYQNkGb6VJo3sk4FrPtGLHN0lwv5ujk34VARmI3Fe0o1L
         w69ASSmoVLyNxwS+ooD7rJNUGH0BW/V923gDe5KHTrPtbiC4NDFsVKVBV0Jem8Ap97NT
         7JRQ==
X-Gm-Message-State: ANoB5plN+LFscWGzg1gJibMCv5I981L7VWywVVH6YeNSDqqvJr5saOd4
	cwb3ilzZ7LZo9nd7eIHTAZPzqPGWlZwT37Va
X-Google-Smtp-Source: AA0mqf5Rfjs0s97uoQzREwfH89HKZSbUL+k5dloA5VJUnHtv3mL1su9I/IH18WG11ATNm4dGDGHPnQ==
X-Received: by 2002:a05:600c:1c1c:b0:3cf:d37c:dda5 with SMTP id j28-20020a05600c1c1c00b003cfd37cdda5mr2468475wms.38.1670520983053;
        Thu, 08 Dec 2022 09:36:23 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:50bb:c4ee:bb3b:bc91])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b003d070e45574sm5956409wmb.11.2022.12.08.09.36.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 09:36:21 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] main/server: Add lockfile debugging upon server retry
Date: Thu,  8 Dec 2022 17:36:19 +0000
Message-Id: <20221208173619.2382692-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208173619.2382692-1-richard.purdie@linuxfoundation.org>
References: <20221208173619.2382692-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 17:36:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14155

We keep seeing server issues where the lockfile is present but we can't
connect to it. Reuse the lockfile debugging code from the server to
dump better information to the console from the client side when we
run into this issue. Whilst not pretty, this might give us a chance
of being able to debug the problems further.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py           |  9 ++++---
 lib/bb/server/process.py | 53 +++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 6294b85cfd..1e38d04bcf 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -422,7 +422,7 @@ def setup_bitbake(configParams, extrafeatures=None):
         retries = 8
         while retries:
             try:
-                topdir, lock = lockBitbake()
+                topdir, lock, lockfile = lockBitbake()
                 sockname = topdir + "/bitbake.sock"
                 if lock:
                     if configParams.status_only or configParams.kill_server:
@@ -439,12 +439,15 @@ def setup_bitbake(configParams, extrafeatures=None):
                     logger.info("Reconnecting to bitbake server...")
                     if not os.path.exists(sockname):
                         logger.info("Previous bitbake instance shutting down?, waiting to retry... (%s)" % timestamp())
+                        procs = bb.server.process.get_lockfile_process_msg(lockfile)
+                        if procs:
+                            logger.info("Processes holding bitbake.lock:\n%s" % procs)
                         i = 0
                         lock = None
                         # Wait for 5s or until we can get the lock
                         while not lock and i < 50:
                             time.sleep(0.1)
-                            _, lock = lockBitbake()
+                            _, lock, _ = lockBitbake()
                             i += 1
                         if lock:
                             bb.utils.unlockfile(lock)
@@ -494,5 +497,5 @@ def lockBitbake():
         bb.error("Unable to find conf/bblayers.conf or conf/bitbake.conf. BBPATH is unset and/or not in a build directory?")
         raise BBMainFatal
     lockfile = topdir + "/bitbake.lock"
-    return topdir, bb.utils.lockfile(lockfile, False, False)
+    return topdir, bb.utils.lockfile(lockfile, False, False), lockfile
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index afd77ac0a5..f4ab80ba67 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -41,6 +41,35 @@ def serverlog(msg):
     print(str(os.getpid()) + " " +  datetime.datetime.now().strftime('%H:%M:%S.%f') + " " + msg)
     sys.stdout.flush()
 
+#
+# When we have lockfile issues, try and find infomation about which process is
+# using the lockfile
+#
+def get_lockfile_process_msg(lockfile):
+    # Some systems may not have lsof available
+    procs = None
+    try:
+        procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
+    except subprocess.CalledProcessError:
+        # File was deleted?
+        pass
+    except OSError as e:
+        if e.errno != errno.ENOENT:
+            raise
+    if procs is None:
+        # Fall back to fuser if lsof is unavailable
+        try:
+            procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
+        except subprocess.CalledProcessError:
+            # File was deleted?
+            pass
+        except OSError as e:
+            if e.errno != errno.ENOENT:
+                raise
+    if procs:
+        return procs.decode("utf-8")
+    return None
+
 class ProcessServer():
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
@@ -306,30 +335,10 @@ class ProcessServer():
                 return
 
             if not lock:
-                # Some systems may not have lsof available
-                procs = None
-                try:
-                    procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
-                except subprocess.CalledProcessError:
-                    # File was deleted?
-                    continue
-                except OSError as e:
-                    if e.errno != errno.ENOENT:
-                        raise
-                if procs is None:
-                    # Fall back to fuser if lsof is unavailable
-                    try:
-                        procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
-                    except subprocess.CalledProcessError:
-                        # File was deleted?
-                        continue
-                    except OSError as e:
-                        if e.errno != errno.ENOENT:
-                            raise
-
+                procs = get_lockfile_process_msg(lockfile)
                 msg = ["Delaying shutdown due to active processes which appear to be holding bitbake.lock"]
                 if procs:
-                    msg.append(":\n%s" % str(procs.decode("utf-8")))
+                    msg.append(":\n%s" % procs)
                 serverlog("".join(msg))
 
     def idle_commands(self, delay, fds=None):
-- 
2.34.1


