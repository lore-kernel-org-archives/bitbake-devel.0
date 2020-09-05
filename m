Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web12.15864.1599301769832252288
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Sep 2020 03:29:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bzz550rV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id e11so9072202wme.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Sep 2020 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ybc29ARmBBC5NFveR46y6fwZZjNbUPf49vcAsSf3xgU=;
        b=Bzz550rVW4CZYrrqT//IAfUujOIZaoiCFqErrpfR5sSJhzi2kUqU7kgIeGkOoBaN5/
         NF1VW8H1HZP/rLvm/EJfmEc/prKYrJaccY+rCvAQRhF088QxG8hlsbccYvfSuADNDhaP
         7h/IwmArl88hhq8MLWyOSC3P8VEsWg70Xsgoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ybc29ARmBBC5NFveR46y6fwZZjNbUPf49vcAsSf3xgU=;
        b=ObOPHVMrMwcVSh1WOS7KQbyUgtNrmNJxcvyPNoNgoL5syhI2UkyZKH8umNdat7OJ35
         lHdE8/Hfy0TKnwwCR5GKGjnEx5dzct2NpcY52nWc0wdO/kIh27qmF/MCjofLVIBeCzVh
         7fVOFgK/q18p/mgkLccNQSitXljiI+HaqQg8Q/isSdJDAZ8D1bkGqsANTHVRNd2+xj9b
         r2hhNEZEMsTUvqbIiwMSgZeQSWT2HoKtzy4uBt0jIq4ym7HR5VsfY6Po5T6xmo04iZWV
         m9oQf7v8tNb/07IsZ6/z0Snm6uNnUnAQunIQFntYzfb6A4BclGgCrNT/47CeBAyx3dgO
         TBAQ==
X-Gm-Message-State: AOAM533kdNEJuof0XqYbpvetx9uJrN/U1ms2imNLbBlLE6BXgUEL/asy
	dwh+8dshuxb21IAVCapgLRNq0hb57G6uFA==
X-Google-Smtp-Source: ABdhPJw0HAOjE+/pySLifx+vnUDEn5ACADTl0Grkjd9vCb+aIqMSUN+Qj97uwBW6mBstZo39HKdhkg==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr11223778wmf.37.1599301767567;
        Sat, 05 Sep 2020 03:29:27 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id o2sm17079713wmo.37.2020.09.05.03.29.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 03:29:26 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] server/process: Ensure we don't keep looping if some other server is started
Date: Sat,  5 Sep 2020 11:29:21 +0100
Message-Id: <20200905102922.1847453-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Showing "leftover process" messages when a new server has started and is being
used by some UI is horrible. Compare the PID data from the lockfile to
avoid this (and the ton of confusing log data it generates).

Also, move the time.sleep() call to be after the first lock attempt, which
reduces noise in the logs significantly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index f794505fd4..83c3e6b444 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -266,6 +266,17 @@ class ProcessServer():
         # Finally release the lockfile but warn about other processes holding it open
         lock = self.bitbake_lock
         lockfile = self.bitbake_lock_name
+
+        def get_lock_contents(lockfile):
+            try:
+                with open(lockfile, "r") as f:
+                    return f.readlines()
+            except FileNotFoundError:
+                return None
+
+        lockcontents = get_lock_contents(lockfile)
+        serverlog("Original lockfile contents: " + str(lockcontents))
+
         lock.close()
         lock = None
 
@@ -273,14 +284,22 @@ class ProcessServer():
             i = 0
             lock = None
             while not lock and i < 30:
-                time.sleep(0.1)
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=False)
+                if not lock:
+                    newlockcontents = get_lock_contents(lockfile)
+                    if newlockcontents != lockcontents:
+                        # A new server was started, the lockfile contents changed, we can exit
+                        serverlog("Lockfile now contains different contents, exiting: " + str(newlockcontents))
+                        return
+                    time.sleep(0.1)
                 i += 1
             if lock:
                 # We hold the lock so we can remove the file (hide stale pid data)
                 # via unlockfile.
                 bb.utils.unlockfile(lock)
+                serverlog("Exiting as we could obtain the lock")
                 return
+
             if not lock:
                 # Some systems may not have lsof available
                 procs = None
-- 
2.25.1

