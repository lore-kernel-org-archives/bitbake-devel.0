Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.6807.1631265311644058708
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 02:15:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NGql9Ktv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso855879wmi.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dK86HNv2FARn0+aSVKCEcNo16mMRpIAyRGBFRlaxz08=;
        b=NGql9Ktv+I3gNjluEvqvwiclPvrW7JSFHuVVnnim8FAjdV/sFz4jRXRQ76ZGq2CTor
         fTRdYrWCQtRzdp8c7Ra01wqUCU+XDF8Zan+UCH52rvM29DoHcuDwJu1yGCxz8EHZOAYv
         qdyayyPGawh8H896Z5meIzzXLx9fQAn3N9f14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dK86HNv2FARn0+aSVKCEcNo16mMRpIAyRGBFRlaxz08=;
        b=Bj7GwbomoBCSwAqgxb+Fi2XZQj9OuH4gyuFkXGiTLWYWh4g6fG87i6+xmwlHN6LM8/
         rYz3gfNtLV8gSxw+yNG0EeFHr84ESmky4iH/RsNiOOkLEmDC2V/oAENaBchQUGjboA6a
         9xb/TBZBvY8fDpOykjPfnoSJ4zw3GhVD4oHGMVO3XzvVJ97+23V1mbaYNml+bxYK8Mtx
         1edLd8NaC7uX1EvdZuoemHkVRd/wD7PXkz9pxwXm/O1wvHKtSY2rfWfbJ3cCb7fR0vkt
         zuOL3GCapqcPeP5NYkXJuCh5p0nSw+De6v3TPXmbsZoI98zWNm29B1C3/5x6GupM1aIK
         MaEg==
X-Gm-Message-State: AOAM532LVR4LHmU2kYM+qYdFUV3gCdmKmjHW2mESsVbQFXrTWZtziFik
	uIT8DQ3omsi7EQ5EiplBRhVKnB9ZeS+jJUHL
X-Google-Smtp-Source: ABdhPJyZ2TEoMknUTgL6XOdhDcx4+9HBkNXPmWkr4aPL91XLwS2Gnii2wqzYBdRz7Nz95dsgNtyzoA==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr7419845wmc.98.1631265309828;
        Fri, 10 Sep 2021 02:15:09 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id d29sm4372893wrc.6.2021.09.10.02.15.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 02:15:09 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] build: Handle SystemExit in python tasks correctly
Date: Fri, 10 Sep 2021 10:15:07 +0100
Message-Id: <20210910091508.1249752-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910091508.1249752-1-richard.purdie@linuxfoundation.org>
References: <20210910091508.1249752-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a python task fails with sys.exit(), we currently see no TaskFailed event.
The high level code does detect the exit code and fail the task but it can
leave the UI inconsistent with log output.

Fix this be intercepting SystemExit explicitly. This makes python
task failures consistent with shell task failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index ab3344c460..9862e8878e 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -694,7 +694,7 @@ def _exec_task(fn, task, d, quieterr):
         except bb.BBHandledException:
             event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
             return 1
-        except Exception as exc:
+        except (Exception, SystemExit) as exc:
             if quieterr:
                 event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
-- 
2.32.0

