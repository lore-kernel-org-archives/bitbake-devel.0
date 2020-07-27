Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.67019.1595886897705668716
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jul 2020 14:54:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dxydeF0a;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id r2so11229305wrs.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jul 2020 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkxBND/Fnaj7t7PLQSb/gBoKIH8swDxpmYeQ0CIj6sk=;
        b=dxydeF0aDg/LOYrgfCzr/J9ukHwf0tnlpPx/lknuHRdyv5M7OZzSy+47O6LqLq6Gyk
         t6nzTvfTuxXpX+IiHm9W5qL2/UDW0IgPPTaFSELq1uMhjOtvvNWCC6GBH+FSUlcwC0SB
         DZsEQOSd07Qs/tS9ZlzAxN0XaQ85Igtt22fXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkxBND/Fnaj7t7PLQSb/gBoKIH8swDxpmYeQ0CIj6sk=;
        b=quktITfQkXbd7YAWJtHZKPRxDKcqrBTEz3r0LEjBgqjzu8keac40qI12wIIi69EWAS
         2O2z9ettSmOw0Hp8vWXpzonQCwD8XyaM3UzNru1PeW0DGiUDmT3rHY99Dx7lTlYJOJhm
         VUKOLjYNdKzt38OaN3kFybaXfU+xpd758sq8233kJ7MhQ9thxvBxCanrnkUsmMxl5KP/
         Du/snzW3rPEYykUyQwfDY1rp1vChyHfeqEpLcvxtNcmatKDJAxGeNuFNzgpmuQMTnFOv
         576/AF7qkBzzR7C3zjQoLnjgSqkOFX82mJ+LU+C6w/I5MCAxHxtVMCgYIV+PpO1JRCwl
         LO5w==
X-Gm-Message-State: AOAM530+GPFoJZbJR+ewy522xBSJIdDgg4rvZy7lNMRE0xSFNU4UrVAM
	hoe40DZPD6QvnmOGCRkE8+TMhTb6PndZOw==
X-Google-Smtp-Source: ABdhPJzBOGvz3bhQZj/VGsa/DPpwmee/fXTcpHVb7PiSjCzr8nLmS/28rEHCH4qlUXS8yrtr2jppjQ==
X-Received: by 2002:adf:a4c8:: with SMTP id h8mr21868876wrb.262.1595886895673;
        Mon, 27 Jul 2020 14:54:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (4.0.f.e.b.e.7.9.7.7.5.0.0.c.1.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c1c0:577:97eb:ef04])
        by smtp.gmail.com with ESMTPSA id t25sm1078422wmj.18.2020.07.27.14.54.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:54:52 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] server/process: Fix UI first connection tracking
Date: Mon, 27 Jul 2020 22:54:50 +0100
Message-Id: <20200727215451.319333-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're only meant to be doing UI connection timeouts on the first connection
but haveui changes for each connection. We need to add a specific variable
to track this correctly and get the intended behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 9ec79f5b64..5a87f0820d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -47,6 +47,7 @@ class ProcessServer(multiprocessing.Process):
         self.next_heartbeat = time.time()
 
         self.event_handle = None
+        self.hadanyui = False
         self.haveui = False
         self.maxuiwait = 30
         self.xmlrpc = False
@@ -188,6 +189,7 @@ class ProcessServer(multiprocessing.Process):
                     self.command_channel_reply = writer
 
                     self.haveui = True
+                    self.hadanyui = True
 
                 except (EOFError, OSError):
                     disconnect_client(self, fds)
@@ -200,7 +202,7 @@ class ProcessServer(multiprocessing.Process):
             # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
             # one. We have had issue with processes hanging indefinitely so timing out UI-less
             # servers is useful.
-            if not self.haveui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
+            if not self.hadanyui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
                 print("No UI connection within max timeout, exiting to avoid infinite loop.")
                 self.quit = True
 
-- 
2.25.1

