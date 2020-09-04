Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.39613.1599230658249991088
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 07:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eVy/6bm9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id z1so7048231wrt.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lKBXpAxanDnN69rWbvDeiU/wrnyKKWiTck/oW0xGTqQ=;
        b=eVy/6bm973686jEMLoM+ky6BNrnTaiFklR+vaV4pVdg8BdcsXZ1aOB2wq6UQrScxJo
         vOR2osJP8Nr4DhRfxoOo2XWTgzInzITdufNzYcEZ5gNvyQD7VxwVZUM2EgmmR1h8Mu0k
         zV0+/TgVJCAnSEjliRV/62Ko4Nq4L8CCUoibM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKBXpAxanDnN69rWbvDeiU/wrnyKKWiTck/oW0xGTqQ=;
        b=FCbfgM80LRQd31tQbEYTRqFfSOn6pC0vbKMHYlWOZ/qpfJPFBm6ie3+ejED4qNu7Hg
         4IkvBTtfNpvv+iZUYmfatcl2+ABKXy2NOXVuD1lCsgzKSxcvWyUoH+gqQgNL8g39VB/d
         Q/5sO5xYHCyOPuXclmumUmdEgiZA3D3kVd3x+ECLEXbAIMuBr/q4RGY3hIDsbqNhtkti
         CURqlp/M5IR0X5EOdfV3bAMDKZ0knucjFNhDZwR4ER7iwHpEY7FQPfaUIXJ4/oRXEXXp
         n3PPZhmDcXOwrYfSzaMDqai72tNIOt8lyGl8GO7YI5y2VolJFM5DiVfY68kl+iNpxRXI
         lehA==
X-Gm-Message-State: AOAM530ucR0cLxzjNUrbRf51ARpIp68ViHem6I2if8E+zcBX6lBs2E0H
	yGtVHVQauy1lz/8U9S0Ymv2S3Meas3hQTA==
X-Google-Smtp-Source: ABdhPJzIuLxgdjAPFcsAz4BXc5NsEe2J6ZixrKZAWI49QejKNSDxEI9EIlUDxNrhsE2ixDOzesjkMg==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr8291876wru.10.1599230656516;
        Fri, 04 Sep 2020 07:44:16 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id n124sm11798962wmn.29.2020.09.04.07.44.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:44:16 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] server/process: Don't show tracebacks if the lockfile is removed
Date: Fri,  4 Sep 2020 15:44:11 +0100
Message-Id: <20200904144411.1817481-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
References: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lsof/fuser error if the file doesn't exist. It can be deleted by something
else so ignore this if it happens and loop.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 47e687f4ef..0871e50ce3 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -297,6 +297,9 @@ class ProcessServer():
                 procs = None
                 try:
                     procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
+                except subprocess.CalledProcessError:
+                    # File was deleted?
+                    continue
                 except OSError as e:
                     if e.errno != errno.ENOENT:
                         raise
@@ -304,6 +307,9 @@ class ProcessServer():
                     # Fall back to fuser if lsof is unavailable
                     try:
                         procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
+                    except subprocess.CalledProcessError:
+                        # File was deleted?
+                        continue
                     except OSError as e:
                         if e.errno != errno.ENOENT:
                             raise
-- 
2.25.1

