Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.8012.1628167056695746056
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Aug 2021 05:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KsS17iVY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id p5so6358807wro.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Aug 2021 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tqo0PeqPaA7jUvDOGbI/bOUQNTrPVK6ntTKSRzw4bv4=;
        b=KsS17iVYGc3/bV2uvN/r/AEC2Wsec80AVLA5cI3Wn8vyUXaFm6Ue8wH6CYRKiL+a/b
         fHfmLqBkcF5GUQXVFpqS8nZ3ML9vGgTvJtx6F6HUCWBKR/ULi6oBwAhzLWAggK3MDZS2
         qzK+x1rumd/WdkzVjfmqH6R0k3w8+AhwBRXDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqo0PeqPaA7jUvDOGbI/bOUQNTrPVK6ntTKSRzw4bv4=;
        b=ZIYB81e7Jrw3ZBn+F4dh9JWI+Dl1+zY7RvuL5ORiVRQVyDH+VsNSg0prQwHGM9y2ma
         04Qch0kH7gNag2A995E4VcmK6FDt81jWvt9nYkoWAuI7TirMNKqJUsMpwZWn7qi+2HXc
         dUZAZ/uPs1cpKGViufMgBbyeAJx+mClAUC+JyhkgcT3x7HIPY4dwE/iGnzxvGtY3ExgJ
         PsEhouSwBGEgd8p6K+iT6HbIDMsU1r0MCNfgHGwdPZpb/S1OA4/mvfE9hJcLOOl+onHx
         rznPpO3Fi6W7QzSFRviqylXIis+XYfJsTAwg82A8fllmEgmCsufzYD8okGptda66WGzU
         mENQ==
X-Gm-Message-State: AOAM532sDLVpmxYiY4r9DM0hD1dgD+1W3arP87BqlbdpQWGZX/NmSAVD
	kELMQz14XSe2eoimYY5Dv3W+ozQFAbzyAQ==
X-Google-Smtp-Source: ABdhPJw04rUjRsnI7pGHpE7HaI/JynMq38iMgz5POuJ/aj8gM6WMHHeBW5u3uYva4opxREZZPrMYIg==
X-Received: by 2002:adf:d20a:: with SMTP id j10mr5026857wrh.152.1628167055071;
        Thu, 05 Aug 2021 05:37:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ea47:91d3:ba71:9eb4])
        by smtp.gmail.com with ESMTPSA id a24sm2106291wmj.42.2021.08.05.05.37.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:37:34 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] command: Ensure we catch/handle exceptions
Date: Thu,  5 Aug 2021 13:37:31 +0100
Message-Id: <20210805123733.3572421-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
References: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an exception occurs in early setup, bitbake could just hang. Return
the exception rather than doing that.

[YOCTO #14408]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index f530cf844b..a81dcb1366 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -65,9 +65,17 @@ class Command:
 
         # Ensure cooker is ready for commands
         if command != "updateConfig" and command != "setFeatures":
-            self.cooker.init_configdata()
-            if not self.remotedatastores:
-                self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
+            try:
+                self.cooker.init_configdata()
+                if not self.remotedatastores:
+                    self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
+            except (Exception, SystemExit) as exc:
+                import traceback
+                if isinstance(exc, bb.BBHandledException):
+                    # We need to start returning real exceptions here. Until we do, we can't
+                    # tell if an exception is an instance of bb.BBHandledException
+                    return None, "bb.BBHandledException()\n" + traceback.format_exc()
+                return None, traceback.format_exc()
 
         if hasattr(CommandsSync, command):
             # Can run synchronous commands straight away
-- 
2.30.2

