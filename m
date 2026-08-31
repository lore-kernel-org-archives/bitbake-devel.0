Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E34C61DF0
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 03:33:39 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22124.1788147213451425440
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Aug 2026 20:33:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pzOI7+W/;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90e7bde5596so16055546d6.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 20:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788147212; x=1788752012; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cz5x6GE63uEiWTJ3RX7RHhy2+jY0Xfec3Q7oV2x+f10=;
        b=pzOI7+W/j6RPmIfjgzgKImCEf8QeIKuugEbGyNooIUk2ZNzuxhDf1itnmnpL+JdrM/
         yufuaZwwGH/h5q7am6C5w5Z3hLmOhJvVbsQknA2zRxrCs4ihhV+kJTDk9++CTVOzQhqM
         yCbNl6sutBmRuTpVNQycNc/8cwlF9rJUsshJSi3V1g/3x98WiY7mGkV1MXXudonWVoG+
         A6rx3kyzBl4cpBZypBMK1vlwyFibD3ZpDmY3IhhWgqnPodvBsy/UFl7t3AhY2SqLKPTJ
         LAHqRXGKiAWW1YUOHU0giCfSzOgstTT/tZEZsqPj872Bl116n3fDmnAqtWDPFtv1EyBJ
         378g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788147212; x=1788752012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cz5x6GE63uEiWTJ3RX7RHhy2+jY0Xfec3Q7oV2x+f10=;
        b=LmaT3RzbO3CsZ8bjNlh9fWmHlzzG+h596NtZGRDCCBI9lar9cesjOCLcUMwpKAnhZg
         jQarWtCWg1sYrnhOBc9vYfG7B9IViwT6aVd86ZRfjePxos8JVCODrQkfisatnodB2u98
         HTTTHPeZjfAoOSzgAoJgcu/dp723hbWg+E8LIb8q0J/GmezxGLYsxbscNCo2xrQPRhLT
         JVhMtrdBYX0tLdVEdEkckMmfifZuoqITWU2JoxTfKJEwPlqC4Gs+nBzOA0XCteler3NT
         2h05yO893BvhFJHhx5M9X6l6lKUllXcDjlbDMxJx8MXyIuN1Z8suNBAf/h+yeEzPMZTV
         2wJQ==
X-Gm-Message-State: AFuF++kj7NVaWjmkvh/P+v1DXpybU1u/8ArYMZzSgO++pqiS+kZEbeBo
	ZJahLcMiFr1Y2CAg02UTXzYc48tHapGFYw7X4fAdCzFRDi7hhnq9okAS
X-Gm-Gg: AYBFou2H7kwndXItzRMYi62VcEERXl3VxmYnrTI6Bx0P1FAhHwRFow+Bfa8Xmc1/XRV
	r26ULjoqYvDPmh+/Sc7ucaZH4kS59y7C10ra3bCmyelEYJ5W9yeYvUwiGe1y72H2EiFh+hBGk+k
	xxmHjyIQ27IZmaFZN1niCnnngiVSIkjs2VPrqceYfOQUSjW0DH/AQvACFlDtranJP4QFh1XiDPU
	9xm0J9A7B2MUkyKmNU/5Op/nZYSrbDCRkMm7Ee1cTEH4Z0o64hgTCUNpsOL0nyhhuGvydtdMrrh
	mzUESNJXffVvJwHk96s32YCz1ZIcwpcdn+DLVOIaQgBOfN5/TY0MR6i+hkZGoeMn9coYm6+u0iD
	eZeWqA402Oq4Lw5TUmX6qHx2Jmfkjo2AMxqJsib7ZjlEN9KmRWYPoj6Cg2gtKhcsUD3LeaMECcU
	vsEqQ3v5h8uo7KpGrL6yrXW4uNR9d+/TZ4R1EnBtQSelGN3vdV7niPaFLRFVedrzlmlZYxz00Ys
	/hwdWwhMTVko5O17/YskjkLxP2lSA==
X-Received: by 2002:a05:6214:529d:b0:90c:e89f:14b7 with SMTP id 6a1803df08f44-90ce89f187cmr223786916d6.20.1788147212296;
        Sun, 30 Aug 2026 20:33:32 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444db01sm75128216d6.7.2026.08.30.20.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 20:33:31 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: continue the eventmask example onto its second line
Date: Sun, 30 Aug 2026 23:33:29 -0400
Message-ID: <20260831033329.4072643-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 03:33:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20132

A value ends at the closing quote on the same logical line, so the example
does not parse as printed.

AI-Generated: codex/claude opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b0535b5dd459..111e8fe58b4f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1902,8 +1902,9 @@ and the content of the :term:`FILE` variable::
        print("The name of the Event is %s" % getName(e))
        print("The file we run for is %s" % d.getVar('FILE'))
    }
-   myclass_eventhandler[eventmask] = "bb.event.BuildStarted
-   bb.event.BuildCompleted"
+   myclass_eventhandler[eventmask] = "bb.event.BuildStarted \
+                                      bb.event.BuildCompleted \
+                                      "
 
 In the previous example, an eventmask has been
 set so that the handler only sees the "BuildStarted" and
-- 
2.50.0.173.g8b6f19ccfc3a


