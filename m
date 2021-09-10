Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.6704.1631266188806959398
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 02:29:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DqcnRXrw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id z4so1685561wrr.6
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIu91AAR7yYPDXykuVMhLlEOtJyZhBPW3TV4UKVpSJc=;
        b=DqcnRXrwyoqYeNgILlLVCYtgiyXqTqRjtMo7sFWUi3ZYEeoEptbYYCBNs2rcQdL/UX
         Ts5kS2XaePsBMa6dHr/qwTRELmngSs/jnRymNNL8wB0ZO81dM/S8t+np/7V9pJMlI3vO
         5eEwYwM+nWqLC5gFomM4B25LDmX+01gfhtm6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIu91AAR7yYPDXykuVMhLlEOtJyZhBPW3TV4UKVpSJc=;
        b=kJEXJJ14kw8rnJhvpGLw6QHfl14AzofTZNIMgEmSe+ilefLuOd4WkpNC9m2ShRP4a5
         owlHJpPuKK7pBZkMCm7EL0fzAdcGr+OAELQkAHh2BeePDlp80nJ+8vKDxpyWcS6XljaA
         lYHnLsD9GZSnhEd/VMLnpxPE2OCue/6x4KmCP2aaFMl8U5rquGY3iZnVPAEWDASxxFMa
         g27DcHk4Yh2NFutwAj+QNYRYHtyL2M4jjOCOoWr43DMeCDuQbRajta0qEEnOkOPMPoLK
         Eyeu+tBISL6T1Hg3VtsserA1IGTs2GOarso5gQLvIGrymsi2V6xPQ32KbQCT2LucQLnG
         5c1Q==
X-Gm-Message-State: AOAM533ZS2EHRJeWmf2ir5/zHrF1kpwKtR72/+5gSJlnUBrcDxwWzG2u
	C+mqCpfbc6mvwVdRlpoAWIBZDw+LNHWbQILF
X-Google-Smtp-Source: ABdhPJyigRCl51griXoNYrAU4jjoHoLMMhmJTL3VrfoS79y7YbxNbmP1ZpmSRDj2GVUkSJtcs5yv4Q==
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr8310261wrg.151.1631266187084;
        Fri, 10 Sep 2021 02:29:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id d24sm3655929wmb.35.2021.09.10.02.29.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 02:29:46 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] build: Avoid duplicating logs in verbose mode
Date: Fri, 10 Sep 2021 10:29:46 +0100
Message-Id: <20210910092946.1250124-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "bitbake -v", for task failures you'd see the log output twice. Avoid
this by using the existing "did we print info" switch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 9862e8878e..1e062adb51 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -699,6 +699,10 @@ def _exec_task(fn, task, d, quieterr):
                 event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
                 errprinted = errchk.triggered
+                # If the output is already on stdout, we've printed the information in the
+                # logs once already so don't duplicate
+                if verboseStdoutLogging:
+                    errprinted = True
                 logger.error(str(exc))
                 event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
             return 1
-- 
2.32.0

