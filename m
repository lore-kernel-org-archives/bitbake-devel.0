Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.14679.1602851663228400459
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Oct 2020 05:34:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EQwRIbC+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id e18so2669077wrw.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2020 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1kkEIw2f/rLYQ15PgmzV0AZTzZzGsqgaKEG3m48POA=;
        b=EQwRIbC+lVMXMBtS0WltELW4g5yAAmNx/6xCabbahnqhGMDREWH8tA55BaKa4gtvJs
         1ZvaTlXyqF1JFggAG1DWzJLYiYdFE58yVogBlEtQuxh95O9YFKv2qQkoX5JDB/AUsM06
         LA/RiJdFFUxy3WDdKn82j46SN/CpTOvJ8AUPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1kkEIw2f/rLYQ15PgmzV0AZTzZzGsqgaKEG3m48POA=;
        b=TKCwSD7CQm3GXE3BOC1KYzvhySKyigTGM6G6Bs4qxuqIvh/hFED+B+zn7SsBzSwvL/
         0T2eFtWbgh/13eapu+8PV1BQvd39A5pwv/3hV9NgeZoV1tITnly/JHy8npActp6c4Pzq
         8E2mUCUhFmb9gXDIpftm+jmss/jCzEQV7eusltuoaDGYmz/mNoQdiC8j/DS2D1jfxny7
         Se3OadA4ClKmUusjfZE0d4M2uNtvxaUkch9aUey8fIxy6L05pzeDKaNQ8Fse7BWkwA9Z
         fs6vfuzsf2I0Z1XeEyx0JphfHklV1E/2UOmKIp/cHlPitNTs0pi/gL7Jh47OInCGiSMI
         MK4Q==
X-Gm-Message-State: AOAM530ToZO2A6wWJoSwrYTWhZH1k4S9LJqoc/8Y6nQ/VuTzr2R5O8TZ
	3K+wvLfFxIk2eiWwd3kGlIOcc4aiY4KaDQ==
X-Google-Smtp-Source: ABdhPJzKGLZC9V+YDyWXMjKwK1shNWbHuTpkxXvJRFjkCOwsQrzgCTGn9fWe/WUKrLCM5qN4uZtT3A==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr3640358wrs.303.1602851661627;
        Fri, 16 Oct 2020 05:34:21 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (f.7.c.a.0.7.9.b.6.d.5.e.8.7.d.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7d78:e5d6:b970:ac7f])
        by smtp.gmail.com with ESMTPSA id z6sm3429858wrm.33.2020.10.16.05.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:34:21 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <ticotimo@gmail.com>
Subject: [PATCH] ui/toasterui: Fix startup faults from incorrect event sequencing
Date: Fri, 16 Oct 2020 13:34:20 +0100
Message-Id: <20201016123420.3531477-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Toaster has been failing to start correctly when in interactive mode. The
issue is due to setEventMask being called (which triggers parsing) before
the environment has been sent from the UI over to the server. This means
PATH isn't setup, which causes the sanity checks on HOSTTOOLS to fail
in base.bbclass.

The fix is to ensure the environment is sent to the server before
other commands are run.

The pain in debugging this highlights other improvements to the logging
are needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/toasterui.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9260f5d9d7..ec5bd4f105 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -131,6 +131,10 @@ def main(server, eventHandler, params):
 
     helper = uihelper.BBUIHelper()
 
+    if not params.observe_only:
+        params.updateToServer(server, os.environ.copy())
+        params.updateFromServer(server)
+
     # TODO don't use log output to determine when bitbake has started
     #
     # WARNING: this log handler cannot be removed, as localhostbecontroller
@@ -162,8 +166,6 @@ def main(server, eventHandler, params):
         logger.warning("buildstats is not enabled. Please enable INHERIT += \"buildstats\" to generate build statistics.")
 
     if not params.observe_only:
-        params.updateFromServer(server)
-        params.updateToServer(server, os.environ.copy())
         cmdline = params.parseActions()
         if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
-- 
2.25.1

