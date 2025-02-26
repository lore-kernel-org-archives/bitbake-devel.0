Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E842EC18E7C
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 16:50:42 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.10654.1740588632817503430
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 08:50:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GsLufi8H;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so208925e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588631; x=1741193431; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMeUosrDu0LhnYu+iW5+Veq0iXUpBAg7kIt8W7dipPg=;
        b=GsLufi8Hfy+ZtoML4He4ytJYJQHfkUAUAOgZfH+fV3SI5foTn1tWIzGryN1kUhQmrv
         RZarczVaVwowiDAs/Z5nPMHTSYaikqP7kNhradcxvwPdmMz+ANt9yOBMPh6mTcdUZxi1
         gndrTfem7uMCBTRoyidN2GlWfF8WpFeuDlHRAeVRS0zX3cc1/hqTb71cxGMq2eCWO0VG
         KlnrmZo0hhBv9VrdWhqRxC9yZw1xuP3+phgDOmqHJSAkxabidBKUW4RFOagcYvYR6iie
         DLpMtbUwVRRcaOdC9WHOsvM0EtrnC+cWjxVGvtnnPIQbn1DhRWwFSuFl+/w88svEDSxL
         Vq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588631; x=1741193431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMeUosrDu0LhnYu+iW5+Veq0iXUpBAg7kIt8W7dipPg=;
        b=QQcbHkQie9RQ/clPtYjCaNDae/mqm+JT12UoRfzQ989MzMH+d65xtuycWIKbmVfWFf
         jvoJ/waRPiA2HxJCnVtIG3cCMVVjSWlkh3pJfp/IvkVfHkgy3h+mv6vtnJItgmxLD8BM
         iT9mjQMd4oXJdq2b2aWFyCLu3K0VKT39pY9GVrAoCd47aepLwYvtdTetI1gu8sZ0gLwd
         7glDF3LwyFCZUojQebhKaKlZVKB/dIZ3cBr6gRzfzBiNnlDWd8M6F3/79Dx5i0k+49LP
         +ZomjmGShWWgKvoc31mLIn75IEK2w/S2Br1EL1PoVxxDwgrWfyI5qLt93mrdHkB2MzCt
         H0Vg==
X-Gm-Message-State: AOJu0YyXRyOCIG75j37hzsSvY34YsP+MUnqIkScByNqZF4xyw5atOiwL
	Yhj326qfvYOtaZbBTjphmO/JeqRj+qlr2Gs5B3NfQe299oEEol6HKk7ZiqVl
X-Gm-Gg: ASbGncsFfQ7abHXOGmFKvKj358FQTZanZQrAe/9P2NhfK5DJWYw13VP6awVbpl1yHoX
	TLET4+Rjzd/JI2p8q0Bej1b/0ZChr6VLRRz9DbB2Lda1z5mzSTM26FTzWyZFAMssMCZ8alyWUk8
	sAl+CMl3yRGvrp74HRWCOnwPUjHT/AepTeRwq55LO6Jv88xhnwAwt33qlJzHK8JBHFvRp4yr73D
	e/i7dBEFoNXHhUbUxKlzxvZLcGaT6uphnrcbwAvJsqMfy6pU3h9bhR6+a+9CFEvEGA/lTFTDuZM
	WSWUlep+efNmrEjn0ueydrPPAhRsR8Ip47/YwjeRHdmW47aNqT+wFW+bCPsVGB4=
X-Google-Smtp-Source: AGHT+IHplUS1tv3ZvsT6IjOnjHX1FrEhXE+CXEmm/he5lZj3/vUWz/LTQUanF/f1e//bbVuqVT1Isg==
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id 5b1f17b1804b1-439ae1eacfdmr193790335e9.12.1740588631011;
        Wed, 26 Feb 2025 08:50:31 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5442c0sm27095945e9.32.2025.02.26.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:50:30 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] lib/bb/cooker.py: produce an error when BB_HASHSERVE_UPSTREAM cannot be used due to missing python module
Date: Wed, 26 Feb 2025 17:50:17 +0100
Message-Id: <20250226165017.561683-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 16:50:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17332

From: Alexander Kanavin <alex@linutronix.de>

Previously if the websockets module was not installed
bitbake would only print a warning and continue, resulting in a degraded user
experience due to inability to use the configured sstate server.

Let's consider that as fatal misconfiguration, so that users can address
the issue properly and not wonder why builds are taking forever.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/cooker.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5b885cddd7e..e21815daad8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -316,8 +316,14 @@ class BBCooker:
                     try:
                         with hashserv.create_client(upstream) as client:
                             client.ping()
-                    except (ConnectionError, ImportError) as e:
-                        bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
+                    except ImportError as e:
+                        bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
+%s
+Please install the needed module on the build host, or use an environment containing it (e.g a pip venv or OpenEmbedded's buildtools tarball).
+You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts."""
+                                 % (upstream, repr(e)))
+                    except ConnectionError as e:
+                        bb.warn("Unable to connect to hash equivalence server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
                                  % (upstream, repr(e)))
                         upstream = None
 
-- 
2.39.5


