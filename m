Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.6850.1594551320156490765
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Jul 2020 03:55:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TVIQuiEj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id l17so10457880wmj.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Jul 2020 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgC/dGWj/P4Vfi3RCLxa/C6hnqzk6fxFBQ/t9Z3tzrY=;
        b=TVIQuiEjVi6c+tgJNQYtiQ31sEva/Lbh1PH0j0Z0ZchTUFJ5x79oTGqAe/SwaUYZ2K
         zdr2v7AB6Ylr20uf5lmS5FMpqkDr90PwaTKf/UPRbYiZLqhkuxKfgcHTf0bSfhNUkiNG
         FvTcxmlFyn+B0klf/nNAwuyPTAhQfXm9ChGpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgC/dGWj/P4Vfi3RCLxa/C6hnqzk6fxFBQ/t9Z3tzrY=;
        b=JVJGVqdlwxdTYDxSHDezMI1higv/glosZKIWV2asFjV+ChbLTDWwF4lqVdDTuFOvaP
         6Ho7CTZ4hPljbco6u9ZYEh6MkoiGxsVG/Ir2amiR52dwnzU7xf0cpGZH5XcQGA0H4/dZ
         SMsSI/Do4P8uzIHfIi2PVasZSnPEsE6tFfF/Zis1rp6EFx20/VwBm9/YQw+sOR1cZD9m
         RLZ/A8/g41FRCXXOQdjPJVn7qaW+b6FKobMT6dS7WT570ONpoLj6W0AUtfG26a/sSo4M
         ZwfKeZU5U+c0jt3CvfdFTYC4HcaKLn2qBvge+skIZZ3Ph1vWl70TXQTe/SXjqnYw2XEp
         MCjQ==
X-Gm-Message-State: AOAM533OK0ZuvyotdmNmfrBXHreNs+lb+pRQ0CGe2xRQMQYc8pIfPmrl
	PfP8APVKg/55ptfdd6CX3qgaTzUKpRBl7A==
X-Google-Smtp-Source: ABdhPJwJ/AqIqxMSIyrvzS6DG7vfqjXZacg8YX3QN+NXKyQc8nRjlROuJZEzHGMQuAt5hx3VwVsQaA==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr14549583wme.155.1594551318145;
        Sun, 12 Jul 2020 03:55:18 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id 26sm16954004wmj.25.2020.07.12.03.55.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 03:55:17 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Fix a rare lockfile race
Date: Sun, 12 Jul 2020 11:55:16 +0100
Message-Id: <20200712105516.507243-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're seeing rare occasional races on the autobuilder as if two server
processes have the lockfile at the same time. We need to be extremely
careful this does not happen.

I think there is a potential race in this shutdown code since we delete
the lockfile, then call unlockfile() which also tries to delete it.

This means we may remove a lock file now held by another process if we're
unlucky. Since unlockfile removes the lockfile when it can, just rely on
that and remove any possible race window.

An example cooker-deamonlog:

--- Starting bitbake server pid 2266 at 2020-07-11 06:17:18.210777 ---
Started bitbake server pid 2266
Entering server connection loop
Accepting [<socket.socket fd=20, family=AddressFamily.AF_UNIX, type=SocketKind.SOCK_STREAM, proto=0, laddr=bitbake.sock>] ([])
Processing Client
Connecting Client
Running command ['setFeatures', [2]]
Running command ['updateConfig', XXX]
Running command ['getVariable', 'BBINCLUDELOGS']
Running command ['getVariable', 'BBINCLUDELOGS_LINES']
Running command ['getSetVariable', 'BB_CONSOLELOG']
Running command ['getSetVariable', 'BB_LOGCONFIG']
Running command ['getUIHandlerNum']
Running command ['setEventMask', XXXX]
Running command ['getVariable', 'BB_DEFAULT_TASK']
Running command ['setConfig', 'cmd', 'build']
Running command ['getVariable', 'BBTARGETS']
Running command ['parseFiles']
--- Starting bitbake server pid 8252 at 2020-07-11 06:17:28.584514 ---
Started bitbake server pid 8252
--- Starting bitbake server pid 13278 at 2020-07-11 06:17:31.330635 ---
Started bitbake server pid 13278
Running command ['dataStoreConnectorCmd', 0, 'getVar', ('BBMULTICONFIG',), {}]
Running command ['getRecipes', '']
Running command ['clientComplete']
Processing Client
Disconnecting Client
No timeout, exiting.
Exiting

where it looks like there are two server processes running which should not be.
In that build there was a process left sitting in memory with its bitbake.sock file
missing but holding the lock (not sure why it wouldn't timeout/exit).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 83385baf60..b3a7f8b419 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -243,7 +243,6 @@ class ProcessServer(multiprocessing.Process):
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
                 if lock:
                     # We hold the lock so we can remove the file (hide stale pid data)
-                    bb.utils.remove(lockfile)
                     bb.utils.unlockfile(lock)
                     return
 
-- 
2.25.1

