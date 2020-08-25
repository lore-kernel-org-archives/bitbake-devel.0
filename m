Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.1347.1598396905067741892
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 16:08:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bnYdHo2o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id x7so470824wro.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZlTwcnbmJa30l+rbzBRBKZTyyFOOYz83mupFAQ5N5U=;
        b=bnYdHo2o7PlCdRUzwHpiJG6Qad/iJ1zmPyMPOnwKReWEhYqfPu9eGQijiJpKa61cdS
         Yqji1IY6YDwJpR8CccbM6RRT3WoZ2moMVuu60KdSIv1GqaiHLGH+nU1WspkgN3h4vk7w
         g9e8pIsWyRzZtrJ7WjY9Q9kL3M4zddQr0NIq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZlTwcnbmJa30l+rbzBRBKZTyyFOOYz83mupFAQ5N5U=;
        b=qJxHIIUjiB6YW0n+ZKBbMexN1tkS9p0UME/jfmi3EL1K4zWrk9oa9xUAYkrjKpj5qV
         MV5TeWGeCQLjjS4o74d8qCLEF2FIkJBTMdYyqMO8lxhKA2ea2d4RYAtnHVLBh9V3ffc3
         HusSNVODm7vwL0dCb/pHW/4WO/uiaVFqMObqkWAY8SfDIGm/2lra1BFU9X8CB9QuhA0o
         4zgH5SR7x29A8bJJic7wo+Fyp4YTH1JNivMJnjwoKvqd9uqBMI/rSAhjlerDobw2mBPk
         Uf3CR2dtXkrra8BHRPaqvEwRtx8esWjWJdv8aqj/WJFMOlYdz3mRdHNtt9mIFenxZ+0E
         uc1w==
X-Gm-Message-State: AOAM530eSwZUHKK1ZyiwmWm+2z5DBKtMW0IH8gpVfF/lrnN5LBBq1K08
	qXkDTpkO8+QEL7SWZ/Vo3bmgBqDYnDK0h4ez
X-Google-Smtp-Source: ABdhPJzdZjC40mhL48rszXFT871Rzh2CiOb81PUkI7m2o2tJhPUsM55QSGS8ulxDkmBLxgTw9kJ3qw==
X-Received: by 2002:adf:f847:: with SMTP id d7mr11983142wrq.328.1598396902507;
        Tue, 25 Aug 2020 16:08:22 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c407:538:d07:8b9d])
        by smtp.gmail.com with ESMTPSA id q6sm451710wmq.19.2020.08.25.16.08.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 16:08:21 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] process: Avoid bb.utils.timeout
Date: Wed, 26 Aug 2020 00:08:18 +0100
Message-Id: <20200825230819.1448746-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a suspicion based on process traces that the flock() call is no
longer interrupted by SIGALRM and hence the timeout doesn't work. We
were relying on EINTR triggering around syscalls but python is likely
protecting us from that in modern versions.

Re-implement this code with a different mechanism which doesn't have
that potential issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 51 +++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 6d936ed457..973bc45251 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -266,34 +266,37 @@ class ProcessServer():
         lock = None
 
         while not lock:
-            with bb.utils.timeout(3):
-                lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
-                if lock:
-                    # We hold the lock so we can remove the file (hide stale pid data)
-                    # via unlockfile.
-                    bb.utils.unlockfile(lock)
-                    return
-
-                if not lock:
-                    # Some systems may not have lsof available
-                    procs = None
+            i = 0
+            lock = None
+            while not lock and i < 30:
+                time.sleep(0.1)
+                _, lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=False)
+                i += 1
+            if lock:
+                # We hold the lock so we can remove the file (hide stale pid data)
+                # via unlockfile.
+                bb.utils.unlockfile(lock)
+                return
+            if not lock:
+                # Some systems may not have lsof available
+                procs = None
+                try:
+                    procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
+                except OSError as e:
+                    if e.errno != errno.ENOENT:
+                        raise
+                if procs is None:
+                    # Fall back to fuser if lsof is unavailable
                     try:
-                        procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
+                        procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
                     except OSError as e:
                         if e.errno != errno.ENOENT:
                             raise
-                    if procs is None:
-                        # Fall back to fuser if lsof is unavailable
-                        try:
-                            procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
-                        except OSError as e:
-                            if e.errno != errno.ENOENT:
-                                raise
-
-                    msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
-                    if procs:
-                        msg += ":\n%s" % str(procs)
-                    print(msg)
+
+                msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
+                if procs:
+                    msg += ":\n%s" % str(procs)
+                print(msg)
 
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
-- 
2.25.1

