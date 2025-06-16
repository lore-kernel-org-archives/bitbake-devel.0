Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CBC71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 09:50:54 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.26731.1750067449964701945
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Jun 2025 02:50:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ef/9ZudF;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2558306f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Jun 2025 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750067448; x=1750672248; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpUVzKEz9LIFxZfQILDHp29aWYfPwF/K+7Fq8Hw972s=;
        b=Ef/9ZudFh1Q4ai0WnnS2h1WN7uzz4YffExX13NmL6TGyphsbMJh0WhqdjsfVp8UQE8
         e3dpQlg4gJCZ2Nd1K9selNVOhZo2DYg291nn5ZascDBELJ0z9VWcK3P7tM33zKadlkZp
         yeRfNRSOMgng+NgPusRrvIJ/9nZU7v9KFd7hoF5H0iA5ZxObIe+dsp7O6Xhd6Yq+aT+v
         rOF3io3IX8DFPnMokZ0kiOtEWiTFKZQv9G95h5ufnn6aoDfxTFxwvicfucTVRqeYModC
         scU0Q+907L/AJSV5voHHOY70vcQwTBH0gSLiZKc++qI7PPoNVoC5PdE1GjuVa/Vu6xjW
         1deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067448; x=1750672248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpUVzKEz9LIFxZfQILDHp29aWYfPwF/K+7Fq8Hw972s=;
        b=keBG+r677qf5GCS9rVCnUojQNGnDXmvwIa8e73Dh397vdFo7Euf4eQ2F8Y+F230eOG
         5vUXNi9F4RJgfWO2jpKcDb03eJBO+QImDPg77PTwHQrTmI4/rxnYLx9uXYEy98KKf4lR
         U8mIL3J5KZs8/p2AunU6E+AGe4ucd7q/NJ1CWwmYDLETM6xMFgrQ5GwlsNM0d49YWCb4
         vjKrXs1J0kFPwkzcyh5vncnGXiZIl922Qwbnn/9rjuDZI5R0MKR540UoCo0yjS9lyi/w
         zGJF+JbmgZ/efn4ICJVomyJ53ER8yhVvuB0YVOs3p6oEF4ldYH6/Cl60J/RRScmY+yjt
         a7JA==
X-Gm-Message-State: AOJu0YysUpmZCl9VVdYmhFRIJdtm30CB4uPVkQkMS/FXsNOebjWKHst5
	saoflsjOWpXH8OgoTd1/jqrP4O6demJWPwBoSuHFZn3MRZKYiNBAFuykJZdKlg==
X-Gm-Gg: ASbGnctlts78bfOBIQn2TmTCVtCtEdEGveoWaVwTmSBRIY1GbzcXmgHH37ChKX+2Wx/
	nc26XSfeusxPAgIA3N/ll3aKFvhkNBIaalyp3ZoFuaiaq9GBysdvaaVqENzmT/GAc9tRajm1RRN
	oWhuY7gOMa0ShvmxH94X9abX6y9LZOF8GZjqcRt/cU708O7P1GTiTN9lTKQB/ZghQX2UZpCEeJv
	nXQiM6L7yTXQGByM5+tN4ikSRX6WcFSPuQQkM0W7gaoKjt/fik/54AadDLPyXNwHInVWfbWLisi
	D2MoOg3fd+zbalP/X6iTy5MdiSHXQEtnkL7E0M4xr6Vkc/fsBofWaiwCaGCKMY6NVLeARcMqOaL
	4N/EDSi+NmcOSmVfVVEfh1dQ=
X-Google-Smtp-Source: AGHT+IFin4qviRsfjB+4+65/gE0EGXhO6NtYBu/r2v+384dA4QY29Z+sPCoFuGAQ8yBiY0k65gT5lA==
X-Received: by 2002:a05:6000:2011:b0:3a4:d975:7d6f with SMTP id ffacd0b85a97d-3a572e91b3bmr7203501f8f.39.1750067448175;
        Mon, 16 Jun 2025 02:50:48 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089b5sm10460161f8f.48.2025.06.16.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 02:50:47 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch2/git: allow overriding default unpack directory with a variable
Date: Mon, 16 Jun 2025 11:50:46 +0200
Message-Id: <20250616095046.2919365-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Jun 2025 09:50:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17702

From: Alexander Kanavin <alex@linutronix.de>

This will allow setting the variable in oe-core such that it matches
S, which in turn will allow dropping S from almost all git:// fetching recipes,
and not having to set it in newly written ones.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 55dd084abce..0af8070080b 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -660,7 +660,7 @@ class Git(FetchMethod):
         subdir = ud.parm.get("subdir")
         subpath = ud.parm.get("subpath")
         readpathspec = ""
-        def_destsuffix = "git/"
+        def_destsuffix = (d.getVar("BB_GIT_DEFAULT_DESTSUFFIX") or "git") + "/"
 
         if subpath:
             readpathspec = ":%s" % subpath
-- 
2.39.5


