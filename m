Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32BCAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 09:27:48 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.47590.1758533261533304216
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 02:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WAeo2gyH;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1417774f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758533260; x=1759138060; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOv33p4rQxjDksscCq08CDxLtn7ywVwyfb0Tp1S+bgw=;
        b=WAeo2gyHE/BkTk5u6gYxmQX18eD92ccPOdM7wEww4qWxX5XskxgwamtXb4dLng2S+f
         IxHHwZcmRlscNZK1SRgTC1Fe2y9ivRZelOYtXNMHDOpl5tJLvFRSLwvj33MDVlIA/RJU
         XDurkF/K8SAk3wBN4ZNsvRXtIx6fQKJ2leviayjSC/C0Al9u12AufvaOIhw3fYVx/Kdz
         jBamR8FP0vS8T5cDtOCXGZ+yojqFyrT9hSiS/6QNmF5w1Fzs/I33FtHsyQlbq7QUvBaB
         fAqzi649nX/Y6KNMvIxYZ5poW05PymI9Cb2an9pPp51TWiV7aw7vHafft6C9sNbsIQZC
         W5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533260; x=1759138060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOv33p4rQxjDksscCq08CDxLtn7ywVwyfb0Tp1S+bgw=;
        b=Gd2NS+HMG50wb1k6F5kz8wUHSjeo0v4Cx3RHcd6wehGgZ3tJn79K6SR+NWkSLv7+ZP
         p3dwSamm/NkLlvUUj8gdeEe8woSuiF3+J3qKfdquftgUv7t1avmnnb7XHCLnbfRATF21
         xKqPII+nideWKha3cFPAHqZLzfQ2xzJsjL/xh2uYmhh0XmfgGG3URAhW/0f2KN0nadLm
         qonDxwQqJpbeZfCzHhphSWpgXrLgta9OvSCXG1nWD0fahx99FNBlIKxDk0TMBeCWy2DX
         f5PKFphPcKVUXY0kDmG0k0wMI6xR5ECwcCULMkieDyGyPvRIzDLIar3NLX2cdM+C7THH
         C0Jg==
X-Gm-Message-State: AOJu0Yx6Z+FMdIHR8is4BeiCdBVjbxum/fGQdBAX5kbxwQxK+EoBcg/L
	VzP0kIL7N01sk62t4IxOkWNyNaPh5RsbHFdKsrYL5c67+pV18RFlY7M6qWLUGw==
X-Gm-Gg: ASbGncsidoubme2AphRQzHRw7pF2C3kegiAMRS5iG2DE0xYb3d7B3bUis2pi7suVKIi
	OZbqlJVHAjjnPbFL6I3tHGIx8u+H1QDTw5sU+kC2tYHucdeu8IMZLuLzd4ZBd1jj8ps/0RLttXn
	S7trJ03arnIyPcmLYl3Zh7MmspM6k5paVnoiJI7kEPbZFwWWVciCypjCQeRr5oKziF1282EDFka
	X8KqxCqtgAiEWUKyPEg1Yj1LcbJA6PDqIutCANeK5fjWOF7Zg6zrg7jBX5XzUbDG6prwi+lSGvb
	gprq5WmlPV2xMj7FgncWPOZURRAEYAdr6Jb7eoQwZVWY3JHjgR48f5USarOkOLzerDeAHiclGHa
	ivt5Q/vxIS3wGeKxZLEk91H7dw5njs9joJYqSkwPWuXW+hm9C84eVQHTAk1hCbPWLx+lNm2Pe3W
	0R8CWvhLodXkQk0VnujvEmmPWsoXnZDaiMbqoCjeBIuWoiP3hXDRxAeOwiCg==
X-Google-Smtp-Source: AGHT+IG29+jF3l7Q0Ts7tzL2d1KfisJLqi8l+FFfFTkEOlq5U3IX0IjKpb9WxUw2nhPKdwQAEUE8+Q==
X-Received: by 2002:a05:6000:440a:b0:3f9:e348:f5c with SMTP id ffacd0b85a97d-3f9e34815b0mr2894522f8f.60.1758533259675;
        Mon, 22 Sep 2025 02:27:39 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm19180194f8f.3.2025.09.22.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:27:39 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/4] cooker: adjust the error message about missing websockets module to mention bitbake-setup
Date: Mon, 22 Sep 2025 11:27:31 +0200
Message-Id: <20250922092731.1993813-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922092731.1993813-1-alex.kanavin@gmail.com>
References: <20250922092731.1993813-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 09:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18069

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fb87368f1..03f262ac1 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -320,7 +320,10 @@ class BBCooker:
                     except ImportError as e:
                         bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
 %s
-Please install the needed module on the build host, or use an environment containing it (e.g a pip venv or OpenEmbedded's buildtools tarball).
+Please install the needed module on the build host, or use an environment containing it:
+ - if you are using bitbake-setup, run 'bitbake-setup install-buildtools'
+ - openembedded-core layer contains 'scripts/install-buildtools' that can also be used
+ - or set up pip venv
 You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts."""
                                  % (upstream, repr(e)))
                     except ConnectionError as e:
-- 
2.39.5


