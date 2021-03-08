Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.38163.1615219083151182423
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Mar 2021 07:58:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZvQLoqK4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id w11so11982773wrr.10
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Mar 2021 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuDtNLgpgD0lawru1H18oe+DzYuONrLxgj538REo5r0=;
        b=ZvQLoqK49nvHQK7Ocqn/XD+2fFSC4jRLG3aR69Q0n+DVNhiOFwrjj8pEWF/ANnhin+
         v0tu94y07jPQLdJ9agsUR1XPGVW3PecYjimJlSJ33LnLndzZG8uP+V+9eSnIE6PQbMMF
         8Hrj1ms/HDqfooQZm4LtntYT6jF53a7OxM5Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuDtNLgpgD0lawru1H18oe+DzYuONrLxgj538REo5r0=;
        b=eQLIhAoMLJ7Pv1wO37Oj+fw+kB/bcXj6n3mjL0FOvlGAd+CtIeRdD/VWvvpJpWdH1h
         yBPX2KjTkVK6FY6YvwtUflNViZAnBgHQ/u6kp/zcCeB8kM1l4sdGdL0LoH7Q1QPWntAG
         pM9teoN+gieocv+upDdwjqw0u6KkHyp7/GzM00utXh41/8rLK8gdX2FozAKAZDEGjhs8
         YWIE0dPsHSHI88Nd+IlOhi8UlfClNKd0hJk+VI7Wn96Q2+k3DFTHt9F3Zn5YvlXzJ09a
         4hZSEPrSAmef1CTdurLFErGq+mUzVrL80/laO+3IwvOXRDAUZrCD7Vmq0X7pEQQazi2s
         FryA==
X-Gm-Message-State: AOAM533ovlVnJJYDNXAXynfIpsFMZ1S7POUe4ZMju+MHAoorDiiGbK9J
	yiI/BOkVCmRmFuUHUKmEJqKwU4Rg2L2Qlw==
X-Google-Smtp-Source: ABdhPJzBJsCPYgwFCeuQhRO5RPRV5qSJKpWii93xqWyxdi2qq1VMUsll7op23HbWFQHoZ7KLPMmzBQ==
X-Received: by 2002:adf:c401:: with SMTP id v1mr14819750wrf.242.1615219081344;
        Mon, 08 Mar 2021 07:58:01 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3242:e265:217d:9509])
        by smtp.gmail.com with ESMTPSA id f7sm21711709wrm.36.2021.03.08.07.58.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:58:01 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Fix task execution corruption issue
Date: Mon,  8 Mar 2021 15:57:59 +0000
Message-Id: <20210308155800.2410990-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b54f514f92..9934708664 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2444,6 +2444,9 @@ class RunQueueExecute:
 
         for dep in sorted(self.sqdata.sq_deps[task]):
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
+                if dep in self.scenequeue_covered or dep in self.scenequeue_notcovered:
+                    # dependency could be already processed, e.g. noexec setscene task
+                    continue
                 logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
-- 
2.27.0

