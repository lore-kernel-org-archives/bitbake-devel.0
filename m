Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02191C46467
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:31:23 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.116779.1673706678672375249
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Jan 2023 06:31:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mt2zIk+R;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id ja17so16962390wmb.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 06:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNe7KINzmuq2udggfbBvImcg/mXv/4Xh7h5HyLz47+U=;
        b=Mt2zIk+RRZHq79E4t93mM7SBjN8kGDSPEuWwRDiQ+h1SPp8cYidV3PAn5KTAmNGe3T
         RJ9PQg98t4hIffN0hv0PRuodORhaqsMpqQog7V2k1JF4I56PoduryemBRt3CM7Iy9z/G
         d2Y4v5octhfZVFB//3pC46aj1VFlpx0P0IyxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNe7KINzmuq2udggfbBvImcg/mXv/4Xh7h5HyLz47+U=;
        b=krnUoMlVgC8Rf7WBfFA+XAN0Hcw4Voulrw6g+GYjL0FMKH7j7sggQpCRG3QbDw+fZ3
         I09qqMl+b4pe8f9AraxOEkF8tV5E6ANoCB7nbz0hrEM333UIAIOKBzSiM+7nPSVTOs5l
         bqyupg4Y6Aas+FwTeLuHkBxo2N5rnqQYrw8rC0o8au7pa6cmxU2cxkbXIWI7f5cSazrs
         9V2IA/XAZweGX16dBJwVYnA/zaPTzNVemu6xIJCOJRdUf75U9oyx1ZPh0j1mhJ9RmFaV
         9hRLst8b6+alXJSBEESXTKCDtnolfPEFbBikom6+5IF5ENUkr7/HB762EOI0N4wIHYGM
         VUfg==
X-Gm-Message-State: AFqh2koZP8vEwzTDaRe3lQg4WgQc5evQCZDCoVMfHsQhdQp6qfVeCWur
	LDTilvYR50hV3DQemBhHfiQbUANsZ0mICfN7
X-Google-Smtp-Source: AMrXdXujqtsnltt9FfQDwGxl4EDDcP4ur9nZyEIzJHZZGVwKzBdcDXtg70ndRLrRYp/6ZNlgl8PI6Q==
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr61601924wmc.13.1673706676640;
        Sat, 14 Jan 2023 06:31:16 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9575:dc1:804e:bc61])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003d9b89a39b2sm31317840wms.10.2023.01.14.06.31.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:31:16 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Improve lockfile handling at exit
Date: Sat, 14 Jan 2023 14:31:15 +0000
Message-Id: <20230114143115.1694084-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 14:31:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14316

If memory resident bitbake is active and the build directory is renamed upon
build completion, several bad things can happen:

* the old build directory could be re-created to contain a lockfile
  leaving an empty directory behind
* a lockfile for a new build could be found and attempt to be locked

This patch avoids creating an empty directory (not perfectly, but should
work in the majority of cases - an empty directory is cosmetic).

It also now compares the lock file contents to it's own pid and
just exits if it doesn't match, it is clearly then belonging to some
new process.

This will be combined with bitbake shutdown calls on the autobuilder to
ensure "saved" build directories, or build directories being deleted by
clobberdir don't do strange things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 588a3ae04d..4bd68b1e7f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -362,20 +362,21 @@ class ProcessServer():
             except FileNotFoundError:
                 return None
 
-        lockcontents = get_lock_contents(lockfile)
-        serverlog("Original lockfile contents: " + str(lockcontents))
-
         lock.close()
         lock = None
 
         while not lock:
             i = 0
             lock = None
+            if not os.path.exists(os.path.basename(lockfile)):
+                serverlog("Lockfile directory gone, exiting.")
+                return
+
             while not lock and i < 30:
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=False)
                 if not lock:
                     newlockcontents = get_lock_contents(lockfile)
-                    if newlockcontents != lockcontents:
+                    if not newlockcontents.startswith([os.getpid() + "\n", os.getpid() + " "]):
                         # A new server was started, the lockfile contents changed, we can exit
                         serverlog("Lockfile now contains different contents, exiting: " + str(newlockcontents))
                         return
-- 
2.37.2


