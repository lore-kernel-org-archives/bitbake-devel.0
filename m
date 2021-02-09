Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.11515.1612883319048914412
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:08:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d2LufKRD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id m13so22278774wro.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VhbapD8OKUX/5VFuOxfKPNZDmFIUz6yszXbYkyId0vY=;
        b=d2LufKRDqXI/QnMnWE6mlXsY32r7Yj5s1zlkIrBGiKndFux+kZU55rgWEunZojL/aX
         MFsTWDmhozgwAWa1HixnrYOjXWK4OmgVd1rllNj8XTTtC3vJlWYCyEtgC/W+Gh1MS1tO
         bMSLexhGsY47e4J0qkuDqoadtfnjkMltbfFps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhbapD8OKUX/5VFuOxfKPNZDmFIUz6yszXbYkyId0vY=;
        b=NqXOK4iaI/O+d4NS88xOYG54kdiEObU+JiyOdLYwLeP7O5dQkvG6R91JN5WD4WQ4+/
         grOKOEJukXBMe+FDP4bXZplB+APRmXWiYfHJGV3NqIDM43fMsRB/91Rof/UtR9R0503D
         U0ymytyjeUPt8fcRF/PPD4cFIVuW5u8MIPnCEsB8LUwXGuXjwuWpWqtFUAOzkqmbFH4z
         8qB4yESCdkd4UN+m6e4UxIdEm20uRfKPB2dB6+eU5/6ePmPp3HHicJmYi4XqxFvJ1VYv
         zSsP0kkLjd9wqMXluIEYYKparEtPikc3WNvvs26ot+vFxrB3U47trYp+FYv6h7y3tNqR
         t4Mw==
X-Gm-Message-State: AOAM533vMxA5CkeJR4dgfodXP80D4jpp1AwIa/8WM62XbUn+TxMDORl5
	Y30Xh+8N4tQbwjD1Dqj6Wu35euZNrUJBBQ==
X-Google-Smtp-Source: ABdhPJyTeDZfuJLQuOaooRsBXDHorb4SH/OvKCUXYpMSUmtGWnndYUyAyojmNy8kX/XBoXLVDPHY6g==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr26635071wrp.110.1612883317565;
        Tue, 09 Feb 2021 07:08:37 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6e64:a4a9:6e48:217c])
        by smtp.gmail.com with ESMTPSA id 67sm5236280wmz.46.2021.02.09.07.08.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:08:37 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bblayers/action: When adding layers, catch BBHandledException
Date: Tue,  9 Feb 2021 15:08:36 +0000
Message-Id: <20210209150836.1809879-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210209150836.1809879-1-richard.purdie@linuxfoundation.org>
References: <20210209150836.1809879-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a layer, parse error can occur, raising BBHandledException.
Catch this and error, aborting the layer add to meet user expectations.

[YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bblayers/action.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index 5b78195ad4..f05f5d330f 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -50,10 +50,10 @@ class ActionPlugin(LayerPlugin):
             if not (args.force or notadded):
                 try:
                     self.tinfoil.run_command('parseConfiguration')
-                except bb.tinfoil.TinfoilUIException:
+                except (bb.tinfoil.TinfoilUIException, bb.BBHandledException):
                     # Restore the back up copy of bblayers.conf
                     shutil.copy2(backup, bblayers_conf)
-                    bb.fatal("Parse failure with the specified layer added")
+                    bb.fatal("Parse failure with the specified layer added, aborting.")
                 else:
                     for item in notadded:
                         sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
-- 
2.27.0

