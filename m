Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.18702.1621256486147345425
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 May 2021 06:01:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HPgNoj99;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id b7so2938944wmh.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 May 2021 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDHQQZEKa9+Ke9frnailHUhdzqlI6SRKYrZAtdm06q4=;
        b=HPgNoj992WSWW6Nt7PAK1975BJXhK2pk7oF4D7Jp3O8RkbG7pD2ikmm10rHvn3D2vH
         Rm7077rnbq+yU/wU8z1sptkNjpBNI7w/lmB/s2KjKVhYljT1I6/bi2V/Br6R7zRv4YmA
         kdc2mtg5pElMZUifhH8Ucwl+tMTNUYbtj0bPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDHQQZEKa9+Ke9frnailHUhdzqlI6SRKYrZAtdm06q4=;
        b=SKtg5uFOdLEe7y/77yapXH915DXKtwkvkSSsSWGYvU69nrpLLrXPFRZhwuxyvYuury
         eno8ZIAw0fkDYMaCfW60DQsimgH74hTj3zOSiw50K8X193tunX5cQRys8q6u8Q8KFgwL
         NTmZIs8aHJ/sSNssPq6USHvecMLE2j10dCL0RG2xkneqO/NWq5P1J3GRJTffaoB584lv
         Ldqemwj0CJZic5qD/Rq8DmOHPomakcYmqTk4rm5/bfPVejdeuyvvDre8qXuzAzutDque
         oCDnO6tDn9swLYcDt8OkYW7ORWqDQm9RPQl+ahylsbzJHCVcphju3Kv9fIiaZ2Y0T4Sb
         JZ5A==
X-Gm-Message-State: AOAM533QUXC44pTJ6N4Hl3WUG+fZzz9S0aakiTFwj0zcYoxSgy850KWL
	F30j4RI02Jad4cvJvAGaqiroQ6lCoOfUqQ==
X-Google-Smtp-Source: ABdhPJz/25dO3vyeSRSfZO/mf3b08ZUp87p6fFpeIQpDeAaOql0TCeKaw8X1ck9AbVNEhlBj2zAHMw==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr22731666wma.173.1621256484249;
        Mon, 17 May 2021 06:01:24 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:1b39:2a3f:a2c2:a4fc])
        by smtp.gmail.com with ESMTPSA id z3sm6521730wmi.31.2021.05.17.06.01.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:01:23 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Handle error in heartbeat funciton in OOM case
Date: Mon, 17 May 2021 14:01:23 +0100
Message-Id: <20210517130123.2429383-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've seen cases where an OOM error causes bitbake server to hang:

9171 02:21:09.127810 Command Completed
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/bin/bitbake-server", line 51, in <module>
    bb.server.process.execServer(lockfd, readypipeinfd, lockname, sockname, timeout, xmlrpcinterface)
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/server/process.py", line 550, in execServer
    server.run()
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/server/process.py", line 108, in run
    ret = self.main()
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/server/process.py", line 242, in main
    ready = self.idle_commands(.1, fds)
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/server/process.py", line 370, in idle_commands
    bb.event.fire(heartbeat, self.cooker.data)
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/event.py", line 216, in fire
    fire_class_handlers(event, d)
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/event.py", line 123, in fire_class_handlers
    execute_handler(name, handler, event, d)
  File "/home/pokybuild/yocto-worker/qemux86/build/bitbake/lib/bb/event.py", line 93, in execute_handler
    ret = handler(event)
  File "/home/pokybuild/yocto-worker/qemux86/build/meta/classes/buildstats.bbclass", line 182, in defaultrun_buildstats
    write_host_data(os.path.join(bsdir, "host_stats"), e, d, "interval")
  File "/home/pokybuild/yocto-worker/qemux86/build/meta/classes/buildstats.bbclass", line 160, in write_host_data
    output = subprocess.check_output(c.split(), stderr=subprocess.STDOUT, timeout=limit).decode('utf-8')
  File "/usr/lib/python3.6/subprocess.py", line 356, in check_output
    **kwargs).stdout
  File "/usr/lib/python3.6/subprocess.py", line 423, in run
    with Popen(*popenargs, **kwargs) as process:
  File "/usr/lib/python3.6/subprocess.py", line 729, in __init__
    restore_signals, start_new_session)
  File "/usr/lib/python3.6/subprocess.py", line 1295, in _execute_child
    restore_signals, start_new_session, preexec_fn)
OSError: [Errno 12] Cannot allocate memory

We need to wrap the calls in the same high level wrapper as idle function calls
and trigger an exit upon an unhandled exception.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 3e99bcef8f..155e8d131f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -367,7 +367,12 @@ class ProcessServer():
                 self.next_heartbeat = now + self.heartbeat_seconds
             if hasattr(self.cooker, "data"):
                 heartbeat = bb.event.HeartbeatEvent(now)
-                bb.event.fire(heartbeat, self.cooker.data)
+                try:
+                    bb.event.fire(heartbeat, self.cooker.data)
+                except Exception as exc:
+                    if not isinstance(exc, bb.BBHandledException):
+                        logger.exception('Running heartbeat function')
+                    self.quit = True
         if nextsleep and now + nextsleep > self.next_heartbeat:
             # Shorten timeout so that we we wake up in time for
             # the heartbeat.
-- 
2.30.2

