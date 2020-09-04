Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.39692.1599230656387543749
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 07:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e8bSuX2p;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id j2so7003645wrx.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNrKOafCQ8z2r+GdoEkOTGbamdi+yadx4yk6kZCYn/k=;
        b=e8bSuX2p9JvAsivdNOMFzyyHgb53TvB6//eFEDTQZ8DWlE+72xRXEzLJ/341KpIW6p
         yskMg/CM8PrHCFV2w2gCBjUPvaoYF6qhlT5g2v4nJbxMFssyO77feDcfbddDEHkEl/AE
         L80qgYd20Vf6W/sRQDAfK/4wdaBDdBJf3AwII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNrKOafCQ8z2r+GdoEkOTGbamdi+yadx4yk6kZCYn/k=;
        b=ZFidai6VZjplXtsX+PS3dquTk+TU6bIbr/oFEJi4wm03mO4XWOj1WRoJBKBLGL460t
         Hd96TANRrDsa35kD93gYPbAuscjU5CM2C36FUdyrpZS8/CMv4B+DDfEPD4ExnhHzWNwu
         SoWXDmaqjMaYB/K9uOJ9UNQuM8R9oEAwfVBk77CgQTwKHj8Wji/yvMhJLfXo2utrH/lq
         CWel/fhr310xNNcKUnBN8cPtiNl6HlJNQoAZ4aPfrxYgb9VaYVaG9ynVL7J2h8w+3h1I
         80tL05F2hvUKIwIgxY24ylYaZLa6KYv+6oLVRb2vqhk9GP41FdX25mKnAW9nUxEq3Bx8
         X2Ag==
X-Gm-Message-State: AOAM530ulH6Ux8afZt24wusWAZxjTNu3b/RC2CjiA0wCq4wv6QHdDXVL
	1XttBiEMUmJc5/8n3mT1tE5WkX0emWEN8Q==
X-Google-Smtp-Source: ABdhPJwubSgCTutP3NQz2c/+eiGIMhx7nckI8KQNnAVLA5R7BKhZpWt8/t+5i8PrU1OINil46oQADg==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr7726083wrw.379.1599230654366;
        Fri, 04 Sep 2020 07:44:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id n124sm11798962wmn.29.2020.09.04.07.44.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:44:12 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] process: Avoid printing binary strings for leftover processes
Date: Fri,  4 Sep 2020 15:44:08 +0100
Message-Id: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binary string printed into the output is ugly, parse this so the
linebreaks come out in the logs and make them much more readable (I
was misssing the information initially despite looking for it).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index c972fe567d..5b4d92dc80 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -295,7 +295,7 @@ class ProcessServer():
 
                 msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
                 if procs:
-                    msg += ":\n%s" % str(procs)
+                    msg += ":\n%s" % str(procs.decode("utf-8"))
                 print(msg)
 
     def idle_commands(self, delay, fds=None):
-- 
2.25.1

