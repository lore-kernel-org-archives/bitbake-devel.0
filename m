Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.16016.1599303297051919257
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Sep 2020 03:54:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JeIVATu3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id e17so9034601wme.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Sep 2020 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UV5jHE/qT+EK4dFV33t2TJFl4y/KsR90oMIix6UHwFI=;
        b=JeIVATu3cUbKOmLI1fHBG6097Ndzb+bQL0lnOgfm4et4SeWROlAO6NVabcgUhPlV/F
         S6+3izYmO+lSXFSi7kGTKka+MxgHsPI5/Pgb1JBy8DBR32WKdwh0oszqY4wii3C7F/12
         L8lzfbLAJWpDvugzuLUHEt9DT7QR8GLyhghLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UV5jHE/qT+EK4dFV33t2TJFl4y/KsR90oMIix6UHwFI=;
        b=Xd5X5yOiWR3IIUCbMQW2dlY7ZpCWpey1cvjSMVCs5Pvh1TaVbxaAwPm+dLHOo2SlTJ
         whpD9dnKq/zTehnEgz0KdQmHhKSMshdd3TknUFANyFnr0B1CLi6PPGGyjBWeqL7bHU06
         q4pcK01d3eqWZjS/6kZVSm1QZMQ9gDC/9JuECzsV3Rlha35JbDmxgCU5NTGVhGucR3vB
         UgYHmQszAOhVW0ygiHHdfc/zYWmo0UUa6jwfJgjVcp/070sSxWlUIQ56WgRwFVsbWuAT
         SSa79Fd9nGuwjXpcBeasm8IUeEQW+tJQK0MwL+K794PSOgWRj6rXyZKu4ppIPK0kfED+
         r+xg==
X-Gm-Message-State: AOAM533faXMH9/5UKsbuRGOJ0tTc25DQvCrOXNGkXCj7NUgWLunwv8Sj
	wBI9R25ySxL4nAAEKbBckYiboImGbNRFOA==
X-Google-Smtp-Source: ABdhPJxwk2BPBgqcEsrMXCKN7hSfg67GaKcUr3v/6KOPAE6Uqg/JHVykjSi8gZxaibbV/G3q59uGJg==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr12225172wml.50.1599303295018;
        Sat, 05 Sep 2020 03:54:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id o4sm16630809wrv.86.2020.09.05.03.54.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 03:54:54 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Ensure parser is cleaned up
Date: Sat,  5 Sep 2020 11:54:53 +0100
Message-Id: <20200905105453.1849187-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During cooker shutdown, its possible the parser isn't cleaned up. Fix
this (which may partially explain why threads were left hanging around
at exit).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 30d7278505..d6c8e21570 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1674,6 +1674,7 @@ class BBCooker:
         return
 
     def post_serve(self):
+        self.shutdown(force=True)
         prserv.serv.auto_shutdown()
         if self.hashserv:
             self.hashserv.process.terminate()
-- 
2.25.1

