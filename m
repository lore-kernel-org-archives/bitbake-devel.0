Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.2783.1615662320298606708
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Mar 2021 11:05:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=fBK3PIPR;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.51, mailfrom: steve@sakoman.com)
Received: by mail-ot1-f51.google.com with SMTP id t16so5192692ott.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 13 Mar 2021 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LU6iA9SqJQJLISGECj9GSMR/BmQnLRRrdComnDF9d+E=;
        b=fBK3PIPRJsT7N0GT11v3GvllaEgSdI1Q77q2vZlaRE6g86vxz0Li3TU+pS05FJWQUf
         kHalFqEw7u2yDrSZOd5BFFmPB3ODXeWbWt1kDPJ5J1kwST0zt5NbF/XwagP8KIHHz282
         teS/Z9KkVQRNPt67RtJW2S8PaUiDLxHKIPIw40aKW0EyoUXC7Y3EbQnR2YWwV6oPExGV
         zLVIwdAMPnMdEXgGb9w8Giq5zgElgaXZ8ebCdZOMFPArnqAgCvow2kTRa5R45L4J0zud
         TVHDDyy4aiBOg33c8vrQGpJQ3Lma1+mITlis+tdCooZwPA12ZDaFYu3F3qnpcK2T+QyM
         Znuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LU6iA9SqJQJLISGECj9GSMR/BmQnLRRrdComnDF9d+E=;
        b=CvYQZ7v3tDnV43CMc+ifT34ciWdEfCxXkemz3rZUC4GVwygfO3G9mU82PZQG68FlTN
         bh1w/X5T7ZnSwNewCyGgwRE6Y6FLFQNdDUjRaeSzWPs1TE/cX+vxyIzlODXz0BupF9RM
         /tW13CqMNCgaRXfSDAtBSkk1tfwxxPSyQA4QBBNgpQ4oFGs4wK5lvIyYEIj6EJDbXOck
         c8OI8wrSKO4189b36wZxmyG3oXsfhrOUwhp1h5bpQFS6+jV4F1TahxMtbQr/1CHAfy7N
         dt13IuqgKNR5q4gdvi++oZxMqgbhYFCTSBPE47C7gmtVcdQhnblG/yXzQK80gVU8p/jb
         A89Q==
X-Gm-Message-State: AOAM530OlwWSK2t/lV2lEMTf3adLr1NzNIFtXOR+6O5R35I8kFKpu0GS
	ttNmj1kT5wiJ7vr6ieYdATfyALrbdbHOlTHb
X-Google-Smtp-Source: ABdhPJzEoA8gten3sgen32C/fjRNYK8Tx541OAivB+Ojjyx8RhNPccteOgLIr7dzRYIqdXW/SgW5sA==
X-Received: by 2002:a9d:7f1a:: with SMTP id j26mr7954388otq.244.1615662319206;
        Sat, 13 Mar 2021 11:05:19 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id o63sm4056160ota.6.2021.03.13.11.05.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 11:05:18 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] runqueue: Fix task execution corruption issue
Date: Sat, 13 Mar 2021 09:04:51 -1000
Message-Id: <cd74cd9b9131cbc2d0271de385834b2ef0c6c473.1615662134.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615662134.git.steve@sakoman.com>
References: <cover.1615662134.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen occasional issues where linux-yocto:do_compile_kernelmodules would
run without do_shared_workdir running before it. do_shared_workdir is an
setscene task but never has an sstate object generated so it will always
rerun. This should not happen since compile_kernemodules should only
execute if a setscene that depends on it didn't run and that should trigger
do_shared_workdir not to be marked as covered.

The issue is that build-appliance-image:do_package is one of the tasks which
covers linux-yocto:do_compile_kernelmodules but it is also a noexec task
and has a dependecy on pseudo-native:do_populate_sysroot.

In the problem case, pseudo-native:do_populate_sysroot is unavailable but
marked as covered since it is noexec. The "harddeps" code then also marks it
as notcovered. No task should ever be both covered and notcovered and this
is where the problems come from.

The solution is for the harddeps code only to to fail tasks if they've not
already been handled in some way. The code is assuming code couldn't have
handled revdeps at this point but we now have clear evidence they can.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f66556bbb38449789ceea2fd105e9f68df7fb660)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 30cab537..6186a83f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2421,6 +2421,9 @@ class RunQueueExecute:
 
         for dep in sorted(self.sqdata.sq_deps[task]):
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
+                if dep in self.scenequeue_covered or dep in self.scenequeue_notcovered:
+                    # dependency could be already processed, e.g. noexec setscene task
+                    continue
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
-- 
2.25.1

