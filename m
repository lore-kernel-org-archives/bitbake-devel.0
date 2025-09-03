Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34DCA100C
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 09:55:11 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.8591.1756893303246048190
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 02:55:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=F7nXxn/U;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04679375f6so84742466b.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756893301; x=1757498101; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTB9DzqPEY1Uv6wBA12ADcUMWM1b6VN24fqTPPgYQsk=;
        b=F7nXxn/UitKQIl589bkVHBlbHeUQTUAg7IHT8OUXupfT6uhnGOJyFlpUe2Bj07X/MJ
         dbUei51PjhvhI6CEIWGQErTn8UXiM/gBVRxgbFuouDqt11Y9IeEDVe7K3aYI9wiMS1x2
         c1hPu94g98GJBkcd6ku5SBmTEHImM+ofxenRFgxLMRswghR1NnFezwbAqwSQANMbgfnG
         Pb5NEQKy+ibMnlk4j9Qgw0QJkQBLhwJRME3tJHY+s13vXBmJIWRovr2MjFS2zbONlhpH
         Qs+GbYfMkRg/2bEek52unZLPFGB1z67jHrh9cKTj2BKeEelB8rK6U6ey1E+N4jVulsmp
         FpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893301; x=1757498101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTB9DzqPEY1Uv6wBA12ADcUMWM1b6VN24fqTPPgYQsk=;
        b=imQjwzHtUe33DWz32RDCNx3jIQxj1Ttknj4lifLAyxlwIeI0KXW1Osh0Lzz2dQFkCV
         +hA+du6f30YmB6w2g1Ypy0Qz8fVPSXZK4EH+02J2KdtJfFtIR+/gb0jcRM1yG6qltCnG
         Wp132zYo1Nhr/QEaaZu5fHshrZUcOXCac6vFjd4JolH8xuwnD0cabrrABvxuQw1+pSQ0
         anlyioaJskNy6VhqX8QiNnkx8J22GtefZtPVqFOLDPNifrMGxd6fzjJi2Q6FGuiugll8
         B4NuiHzyA5wRddghLQCzBx2JlJvFs/VpyKgH9bgT1qky3tDCVvi+IvQ4yH3fdBgIEjrX
         l74w==
X-Gm-Message-State: AOJu0YwI7DdxyIL6mOdTRcO16QDZIfzaFy4zA/YcegsAV7zLm482P3rG
	ASb1GuwJhe0ixtR+pkIfWgkqdvVX5h2ehAOzC1HWz2EGBLObFvO7hWP73mr77A==
X-Gm-Gg: ASbGncsIaJGkTJoSZ2TNMrpJix/gS33Gns2aGO1AwdQOy8xnRQUPWw3ICOOXL7mnMw+
	wxXHMuVlaA+P291kbKZGpw1UEqhzr0vE6BQSwASIgrwP0lPScyuA6PRZTFynDO2nLpMiB9TRFsg
	mT1+yEokI9vzz9/kfZrHPj829LRMkR3TxBIiLjG1qUpM9w5KhdmdxMZTXl9M1WT2mNy90vNUEoY
	cPX2LhviKHWV/pXV3Gxb1sn2XFwqnQ6J6q8uxgP6xCudWxVpXyRMZRTSB+4HROjKO2zrOijOi0O
	TPrO0iqjXOWIN4/sOvLb9ULdy2XKn3uceWeZ1dM0t+YY6CLCcbk//wDu3F68ujtt0CJ0A7t9DPN
	DG1arSa49KUl/FvjrzkMClUvd/DTHC/PruxCN6x9dxIJWvVJA0Hk1LQi7J+BgU2+T3fd4BvLzXq
	RLYQ==
X-Google-Smtp-Source: AGHT+IGQ6kHxWQtq5qfL487PIPiuqZ+xp7wN3X01yd3rU3wUlTYitM03/QVVBGO2EsWXSYv/zbQnWg==
X-Received: by 2002:a17:907:7248:b0:ae6:f087:953 with SMTP id a640c23a62f3a-b01d8a30d4emr1592930466b.12.1756893301160;
        Wed, 03 Sep 2025 02:55:01 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0307435422sm1038782966b.78.2025.09.03.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:55:00 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [2.8][PATCH] bitbake: Bump version to 2.8.1
Date: Wed,  3 Sep 2025 11:54:55 +0200
Message-ID: <20250903095455.2691-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 09:55:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17948

From: Martin Jansa <martin.jansa@gmail.com>

To indicate compatibility with python 3.14

[YOCTO #15858]

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index f494eaa13..a2a42a3f6 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.8.0"
+__version__ = "2.8.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index f59c2515b..3fb2ec5d1 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.8.0"
+__version__ = "2.8.1"
 
 import sys
 if sys.version_info < (3, 8, 0):

