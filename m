Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web12.7842.1594823258257100761
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=AiVhtl/a;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id f16so3052452pjt.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=o4AZ+tTSm3+ttVpnoRGhVqRfh56gcriIJCml9v8T8Vs=;
        b=AiVhtl/awm7/lBPao8wWTJhigcob+bj5TPY/k3dVJYiWtCaDw1a7sx0GurTmSCUkVZ
         0YkVDdRSPLG7r2w25ZExFnZQhb8ELj6Fi1Zia5seYsTkl4m8wzAcajpZjMW1yI9vmaty
         cqvs2xew7tJka66N19v7cVlQIMbMHxpMgmO2PkxmvSNeWXoZuEMDAtnfRHfkg/BshM8T
         1797RWOw/CAljpKAdn2Nqrmo81NrLYW6KMz3sPvAvXXb+lY/LpKqlmghxktfNWl07/pZ
         wzvZz7reJ5GUDtPzlE/4t4VMikMmpvelnDIkaTZ/qlfBa5FGpjc0oHvfc73Efal+qYoa
         Allg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=o4AZ+tTSm3+ttVpnoRGhVqRfh56gcriIJCml9v8T8Vs=;
        b=mOibtSSgtdj/UbxwVs7NrZKhidBfvEp1+v2LrZUJMs6QF7gKNeK8aWGQegWkqguTXS
         dqEzfGLV4AvsnmRMBrBrQXJnfNW4/k1D+1zH+mlPqh+DSpNnbOIsT4BH9V1MBYt9yv4n
         IBf0C2ne8ADWtFgMXH6o7muUuHG21IHSNLS4HGikz14GtpWVdH5/jNhhoGovSAWSKq/D
         h79hswwQLLjcocMY/rQboYP+mI9uuTsIOM9UBF9Hd7EJZDelInqsOQlWDVxUxd6Er4Rw
         ZhWJlfv9jYjih9yoCkQ4165MEhQ+pyhQg14w9MDs5hlAQl57r6TAGTZkX16nLf6Sms3i
         yf1A==
X-Gm-Message-State: AOAM531jaAiJxWxkWcfDFA5yQhS2B5gEHoLsP014Hy5Mtz1gTy6fhtck
	WtBXP6XaY+Hn+7WbCG1BLXnZXyyPnMymkw==
X-Google-Smtp-Source: ABdhPJwxsxKD9bAvjLRuxp1DeJViCAFiwYXDIH/fAngVUa5vfYdS28BgqrlKeNOCh03z0ybQGbQ17A==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr8590706plo.220.1594823257332;
        Wed, 15 Jul 2020 07:27:37 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:36 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 7/8] server/process: Fix a rare lockfile race
Date: Wed, 15 Jul 2020 04:26:49 -1000
Message-Id: <de919782f488a83b80d7c40896bf5b2596f1f65f.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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

(cherry picked from commit e1a7c1821483031b224a1570bfe834da755219cc)

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 83385baf..475931a7 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -243,7 +243,7 @@ class ProcessServer(multiprocessing.Process):
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
                 if lock:
                     # We hold the lock so we can remove the file (hide stale pid data)
-                    bb.utils.remove(lockfile)
+                    # via unlockfile.
                     bb.utils.unlockfile(lock)
                     return
 
-- 
2.17.1

