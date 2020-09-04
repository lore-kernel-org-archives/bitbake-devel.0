Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.40164.1599230657554143845
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 07:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K6nLgT3X;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id m6so7046211wrn.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MS9Vzy6EXJDbhvB9dIzkoQY4aTAj9aKOFVJOoFMw7oU=;
        b=K6nLgT3XxpRn41pThsx7Z1u0y6V9w+d7vOtw8uCLOStDxkR3AEhudLSzjmUToIlrmx
         ZOUrAAznfVlLkcOR0Ch0H3ZLubMh2pUSKg0wlkwnKZv8cAjburM+azX+zeJgpIo3zEkz
         c86fvD0943o2CHPzHJaODfAR+zh+1f4LXb7SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MS9Vzy6EXJDbhvB9dIzkoQY4aTAj9aKOFVJOoFMw7oU=;
        b=Oj6jLH2AjhEa5y9fxobXaL4qW/dpeaDvldA5xmXleLPIY8yBMIz0DbzsG3JGYPlRoj
         q1KLD2pwGrJ6jG9UTQBH+SSgNGfLEmUmVddUoiP5Gkuw7Fc6GgOo6x5VPRCUA4+XkWkA
         jC+fu4YY/qwzJ9D9awDltiuHnBKrPNaoETfnrN2om+zR1XmnhZl1c2Ak8GopVO0XHdLX
         JR0qUuXWV8Wnlf13QuUD23f3ms4f7H98lh5A1fd9+PA6wGfyLdH9v15/ycClO2IWIHst
         JX/EfHVxMjZI+FToH3YZsfIJ8kk/FFAPSkULqL19vMRXSTq0GTcYS5caMWzgabGwyt5C
         zZEw==
X-Gm-Message-State: AOAM533jJvoH5n7gT6SoG3NGVcMsgQb4ztxqkspNkh45eAUmIqkWP+xX
	5hZzW5VXIDL8+cJIQWHoRe8MUrO8JpvkeQ==
X-Google-Smtp-Source: ABdhPJzrhambYdA1WL1xscfnKu3pySYUM32a9P7hdvkJ5pedYv81rrHD/glBtR780qtiqVCtzU1lmQ==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr8216354wrw.324.1599230655804;
        Fri, 04 Sep 2020 07:44:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id n124sm11798962wmn.29.2020.09.04.07.44.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:44:15 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] server/process: Ensure we don't keep looping if some other server is started
Date: Fri,  4 Sep 2020 15:44:10 +0100
Message-Id: <20200904144411.1817481-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
References: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shwoing "leftover process" messages when a new server has started and is being
used by some UI is horrible. Compare the PID data from the lockfile to
avoid this (and the ton of confusing log data it generates).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 2be4588a4f..47e687f4ef 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -266,10 +266,21 @@ class ProcessServer():
         # Finally release the lockfile but warn about other processes holding it open
         lock = self.bitbake_lock
         lockfile = self.bitbake_lock_name
+        with open(lockfile, "r") as f:
+            lockcontents = f.readlines()
+
         lock.close()
         lock = None
 
         while not lock:
+            try:
+                with open(lockfile, "r") as f:
+                    lockcontents2 = f.readlines()
+            except FileNotFoundError:
+                return
+            if lockcontents2 != lockcontents:
+                # A new server was started, the lockfile contents changed, we can exit
+                return
             i = 0
             lock = None
             while not lock and i < 30:
-- 
2.25.1

