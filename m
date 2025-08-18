Return-Path: <mohamedaymanworkspace2@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A23CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:33:48 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.80198.1755534823316459946
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Aug 2025 09:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R55AFjrt;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: mohamedaymanworkspace2@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so19200905e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755534821; x=1756139621; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=R55AFjrtc3L8Uyx4NOjqhHHG/QdD9C5stQ+K3DgEYjSvoG+IvKBvOf12MK6+M/lG11
         RC5W879eVKg9EbZOMcQ7w5RhHSRtiGJ+P+TGjbtA18UBl06k4+M46PmZrMPK0P9X43ph
         zsTN94mUPQUj+pEMEarPehGJX9i86E4juAL1+V0t8SeuvI+L7jRG7jV6mn7Lko9HwSVC
         sRiWxRcnTcWoQxl3I8zeA45ihoP45kyUYPAWXe4d4lKK1sjjyn46i6WCElQYrBWxRfuv
         NwdFJk2lQ/GchTugtlxIkQC3+pMtYugGKwX8IfHG5tD0P8fKYeTaRNmadKPwTXxTKUOD
         Sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534821; x=1756139621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=SPCzf4174jF1OuyOOzFuBTY7YdZ13stAyMHZJIA5ez9fPRNHYrPswDwj+NdxiCC6cx
         02CgbxljBRhzgT3p5tddwdsfGZ/c/lRcMyrJAfnGfxFpQ68OkkyG/C6EBdIB3KB6WyZ/
         CTscF4pApj3d5x8h2BYiYevueLnwbdnc9CiMmWJ6K4lHeQK9oNBuxNJbbwOT+z9yOf44
         NY9x7ERGX5dgC33MrO2LZz6VRnyZ9+a6weO4cmcvWbjBZS0GWbQMEIVAkRUvifXHdETL
         HrvIVNDvQWcZhT4Ird87UVegszkMuoZO6ebmwruvu38BbyGOD4z+mfOI5k1G7BVM8dMw
         ebGg==
X-Gm-Message-State: AOJu0YxbVXb1Uu5LDBPg9Jaa89LRRpj+TyglvE15qggFdc9BEqjwCc/k
	NNN8bCGlJGVcLD3FPFb7SmImvjpCKteqeeRCJxBQN3o9TQZjOmnGIVJjxSFRYS6R
X-Gm-Gg: ASbGncusnfIib8I7ToZUsvrn0nqaqqvwaHkxwzZvSdT0x6DEvSevZn6mmRKWdo4H0Lw
	83/lZGs1PbtdzKCCenpnp1ldn1WeK7RssLcK9W/eIqUvVVOvCPu7zE5XfvMtOXaTnPiqe/AMRqv
	G79JpyYNetme/vhLsn1Dv4R+HkhvOMSFxv9QX1HUCfSKNgRMwgHWpVOiSO1yzV4c+EPEiyIxmmv
	PWxcXsSbwiByRl9bLEowmBA3JvE4jyxLSTSW0dhIVgFaWUZCUmkG8FmhaU7b8dCnwnxpVJU1AqN
	xbJaht6xCMWYR+guCvfKndqCtQ/77lICkgU/DyIU8oTRkbl6aLBU/CYRonZdwAoaKLwLWGm/QkB
	k+FiRehH9DFxCMlKCfmsNVSw65SrG2L616Ub/eS2sxGfnXofCOsc=
X-Google-Smtp-Source: AGHT+IFydVjBQltEWO0/fhvLJiBy1VWH7S1FDX1o6ZsH18tMPus9KD9llMILvd80YcIbszZl2Jpp7w==
X-Received: by 2002:a05:600c:b90:b0:459:eeaf:d6c7 with SMTP id 5b1f17b1804b1-45a218578fbmr94516605e9.26.1755534821414;
        Mon, 18 Aug 2025 09:33:41 -0700 (PDT)
Received: from ST.. ([196.221.32.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c773e57sm190286305e9.23.2025.08.18.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:33:41 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
Subject: [PATCH] doc: improve BitBake README testing instructions
Date: Mon, 18 Aug 2025 19:33:36 +0300
Message-Id: <20250818163337.3440-1-mohamedaymanworkspace2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 16:33:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17881

Clarified the testing section by:
- Adding context on setting PATH before running selftests
- Documenting how to install pytest using pip
- Providing an example command for running pytest on lib/bb/tests

These additions make it easier for new contributors to run the
testsuite and ensure consistent testing practices.

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
---
 bitbake/README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/README b/bitbake/README
index e9f4c858ee..938eec47ce 100644
--- a/bitbake/README
+++ b/bitbake/README
@@ -54,10 +54,17 @@ The assumption is made that this testsuite is run from an initialized OpenEmbedd
 environment (i.e. `source oe-init-build-env` is used). If this is not the case, run the
 testsuite as follows:
 
+# ensure local tools are on PATH and run the selftest script
     export PATH=$(pwd)/bin:$PATH
     bin/bitbake-selftest
 
 The testsuite can alternatively be executed using pytest, e.g. obtained from PyPI (in this
 case, the PATH is configured automatically):
 
+# install pytest into a virtualenv or pipx (recommended)
+python -m pip install --user pytest
+
+# run tests (example)
+python -m pytest lib/bb/tests -q
+
     pytest
-- 
2.34.1


