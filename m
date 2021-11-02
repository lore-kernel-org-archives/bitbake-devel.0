Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD6C433F5
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:46 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web09.944.1635865065039188723
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ffi/SfQS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id
 r9-20020a7bc089000000b00332f4abf43fso1758893wmh.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G8AzJUVodfvfCenlrauONFjiYx+37JKAz8it42UgNeo=;
        b=Ffi/SfQS+PT6nMGKSsRYK4YEMHuA1s7jyUaDygbgCxhc50ygRuaom7cMW1VxHWQCf6
         FBbGOkMbZykMCEmdkT7d40hQmCbpPFKdtbOJJqXIKspbVbOh+asIyEo5sUubDOhBB6aw
         0YrbyvRRhQcSzC+XclG1a27zIfl7UJJ9k9fdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8AzJUVodfvfCenlrauONFjiYx+37JKAz8it42UgNeo=;
        b=M8RXPzv53Ad1eLkr1IVvRluTW53bGHND5OQqgsCL7o9ML/eUk7nvGrlQJCwPM5v6VK
         TJpzqnwA7CB51Am5LCQBTo286wbgsgCWuoTZkm7frwMDRKdR2kLBIJrCFacs4vxBDz4g
         KYt9Pcrk9UdOrBhXkw9NPbpPNhr6jeJmGDUYcB8q3BwYnohPT9x1h0v5DXkINey0AFgJ
         AD6r8O5HnJcRBZpoX5DrTgVemL9/qUDmFvLyajNXI8XHL/Lf7wYMeYirQ4eniyIOtWfz
         MFy2m3/D7jNntHLIweYqA3vpd4dO3EECKgPJAMvMYn3P/CD3yLuPfzZo+6AtGyI6vVLN
         Lf/g==
X-Gm-Message-State: AOAM532+j1QD8dnfYA6bmR8/wujm/uPoX5wdjKXrXHff6YT8ou0zDsOr
	wxwKDhqr6VaLyUdn9olq+wVLaDaqrKw4yg==
X-Google-Smtp-Source: 
 ABdhPJxVPCWNB2NnODI6bzFMUPFp4R3dF7rbc5Zs8LcV9lVSvM2syMALbnr/xy4VUeuXmgXyImQNgw==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr7487985wmz.131.1635865063449;
        Tue, 02 Nov 2021 07:57:43 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 q26sm14916634wrc.39.2021.11.02.07.57.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:57:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/5] daemonize: Avoid unclosed file warning
Date: Tue,  2 Nov 2021 14:57:39 +0000
Message-Id: <20211102145742.3550251-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
References: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:57:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12862

In theory we can leak the so file descriptor so refactor the code
to avoid that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/daemonize.py | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index c187fcfc6c..40fabd0c0a 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -74,26 +74,26 @@ def createDaemon(function, logfile):
     with open('/dev/null', 'r') as si:
         os.dup2(si.fileno(), sys.stdin.fileno())
 
-    try:
-        so = open(logfile, 'a+')
-        os.dup2(so.fileno(), sys.stdout.fileno())
-        os.dup2(so.fileno(), sys.stderr.fileno())
-    except io.UnsupportedOperation:
-        sys.stdout = open(logfile, 'a+')
+    with open(logfile, 'a+') as so:
+        try:
+            os.dup2(so.fileno(), sys.stdout.fileno())
+            os.dup2(so.fileno(), sys.stderr.fileno())
+        except io.UnsupportedOperation:
+            sys.stdout = so
 
-    # Have stdout and stderr be the same so log output matches chronologically
-    # and there aren't two seperate buffers
-    sys.stderr = sys.stdout
+        # Have stdout and stderr be the same so log output matches chronologically
+        # and there aren't two seperate buffers
+        sys.stderr = sys.stdout
 
-    try:
-        function()
-    except Exception as e:
-        traceback.print_exc()
-    finally:
-        bb.event.print_ui_queue()
-        # os._exit() doesn't flush open files like os.exit() does. Manually flush
-        # stdout and stderr so that any logging output will be seen, particularly
-        # exception tracebacks.
-        sys.stdout.flush()
-        sys.stderr.flush()
-        os._exit(0)
+        try:
+            function()
+        except Exception as e:
+            traceback.print_exc()
+        finally:
+            bb.event.print_ui_queue()
+            # os._exit() doesn't flush open files like os.exit() does. Manually flush
+            # stdout and stderr so that any logging output will be seen, particularly
+            # exception tracebacks.
+            sys.stdout.flush()
+            sys.stderr.flush()
+            os._exit(0)
-- 
2.32.0


