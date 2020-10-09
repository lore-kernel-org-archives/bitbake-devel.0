Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.549.1602262287360203647
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Oct 2020 09:51:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L6O+o+ak;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id n15so11002414wrq.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Oct 2020 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wEWq22EjgdMbkDH6CvRHIp37Yj7xHJQLaeBhW5k6dw=;
        b=L6O+o+akiHEHnhkWSKdxsrN/O7TOiKwCZHjC1IO07zD3xHzF0b6jAUFjRdvLrHxq4K
         /Tb1xOA/ipmtZH7/zLDhVmVXV8q0CwZUgxnzlFErrGm1MAlpAKaDyfQ+CnMUXYbzlp7P
         h37LwFE1WpYgfs3a1vVjnXpdAJ2b65dsspyAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wEWq22EjgdMbkDH6CvRHIp37Yj7xHJQLaeBhW5k6dw=;
        b=EzMTAn4kZXlmJL+NeFOsc3DhnQ5MUoSTXVmKeummOoPSN5ZBxnEesU2SjfXJYOyfCG
         WWgscm66VUrOLheJDGbNiCS7JXaPpNDX/oib5kSD8474zZrEnsLVyKmLWVhWYWNY7eF8
         nM8EGW1zXkh7TQAKknmeBn+gvtcEpX7lj+mX/FSfgJpzREEQzmlCdA0BKyPHAjNsEHlH
         lqYcAVWk87GK0kV13LzmjIZXgRjyCqWJRFM/CoqAzcjKJWTq6bYrdZqjguxev9UHTeGJ
         uUw5TTorezaVjcDxD11XlLZIAwr+UQ1ijMKcC841bMAy5sz5Pq5yVhQg5YGGObgp4vyP
         YLQA==
X-Gm-Message-State: AOAM533DEPuxZQehBLnOAk7nImqoSLfmGDn06pu+7Vs1h5hyrT5nnuPs
	4QBcgcl1RKpLg9j+x0waV7kkrXH0M0CGfw==
X-Google-Smtp-Source: ABdhPJzRm8dHoRROPiPUrbAikwNTkgAguZGoqg6TPs5kCQ/zVBm8Q0sisNZfmnHSrqBRDMBC5lKkLw==
X-Received: by 2002:adf:aac7:: with SMTP id i7mr2182268wrc.231.1602262285527;
        Fri, 09 Oct 2020 09:51:25 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (0.6.6.4.7.a.b.4.4.1.e.0.e.3.c.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:2c3e:e14:4ba7:4660])
        by smtp.gmail.com with ESMTPSA id c16sm13591026wrx.31.2020.10.09.09.51.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:51:25 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] command: Ensure exceptions inheriting from BBHandledException are visible
Date: Fri,  9 Oct 2020 17:51:23 +0100
Message-Id: <20201009165124.3293429-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous changes allowed BBHandledException to be detected but not exceptions
which inherit from it. Fix this. The code really needs totally reworking
to preserve the exceptions.

[YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index f8c6a03bb9..dd77cdd6e2 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -81,8 +81,12 @@ class Command:
                 result = command_method(self, commandline)
             except CommandError as exc:
                 return None, exc.args[0]
-            except (Exception, SystemExit):
+            except (Exception, SystemExit) as exc:
                 import traceback
+                if isinstance(exc, bb.BBHandledException):
+                    # We need to start returning real exceptions here. Until we do, we can't
+                    # tell if an exception is an instance of bb.BBHandledException
+                    return None, "bb.BBHandledException()\n" + traceback.format_exc()
                 return None, traceback.format_exc()
             else:
                 return result, None
-- 
2.25.1

