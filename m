Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.26195.1594155892489223248
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 14:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DfUJiKrv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id z15so35457387wrl.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTLD6ue/SWefF0nD4GZiYv2qqYjcSqZHZVpWR2d+KeM=;
        b=DfUJiKrvskGGJJOMNzOoK3v5CoQfzFbwXkhHnPs0r8NtW8gfOi29UjP7OmXivEeBbJ
         /enw7AtLNgQTsplzplJ7DtJAtCtB0OoHsacwGN8jdGDD1jFyjWZP0H4B/gyOq6WnS/M0
         T2HaiWeY1sSeNDldHBrj68v/TAojy/vxZ+iWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTLD6ue/SWefF0nD4GZiYv2qqYjcSqZHZVpWR2d+KeM=;
        b=prRfnIArOfL0JsEMbUF3sxfFks7P6S17I7J8OJeWxh/l9OiZ7AdZZQfUkO+jDOuyLq
         AV6ltfX0rS57f2cp6yl1Is1OFLTJAiQaUuzWGtNS8L37fNrZKOnGNmt0ro0LaCkRkJ/x
         CQ+Vsz/aHlPcghBHVqAEqIxJUcw9df+2pLlnZDUV37EjAkfZsPkMVEK6VJnUReW3cJnp
         5mGiPrhsAIUzfjx09g9EoN3gkPAIfzvrJkBRC3RWgJItgYUWujHOwaR11TYQl0TJS+6m
         ywVf64WdVQjxplfCDnbKOo8XTGY6Waz2cZtLgC6F1NXYrfgM81w9mM1H7yVlUH9oDGRO
         g2iQ==
X-Gm-Message-State: AOAM5333WrTqxMQ+92LE9+lfrFLpRa6Tx8QvWqCBnPU7OU9dxW3t4AV6
	mEmlpNkG1UbVzbUX98Ig9qNyKYbjWFFoCw==
X-Google-Smtp-Source: ABdhPJxpGM9Pw/fUAblcMtJ3olPXHoj65V9eZuYtL1MIoCnDNUJshGiVCjNp/XrZpuFlIKzK0tEVnQ==
X-Received: by 2002:adf:9148:: with SMTP id j66mr52859107wrj.311.1594155890789;
        Tue, 07 Jul 2020 14:04:50 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id v15sm2484745wmh.24.2020.07.07.14.04.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:04:50 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Increase timeout for commands
Date: Tue,  7 Jul 2020 22:04:49 +0100
Message-Id: <20200707210449.351137-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're running into this timeout on loaded autobuilders in situations
where things should otherwise succeed. Log a note in these
cases and continue to try for longer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 69aae626eb..83385baf60 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -331,7 +331,9 @@ class ServerCommunicator():
     def runCommand(self, command):
         self.connection.send(command)
         if not self.recv.poll(30):
-            raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server")
+            logger.note("No reply from server in 30s")
+            if not self.recv.poll(30):
+                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
         return self.recv.get()
 
     def updateFeatureSet(self, featureset):
-- 
2.25.1

