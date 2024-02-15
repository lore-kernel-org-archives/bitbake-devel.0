Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E34C48BEC
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 20:45:44 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web10.1459.1708029939740111000
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 12:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WO0KpYOZ;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d1094b549cso18665031fa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029937; x=1708634737; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p4ftYp6xpxvljAVFhFhn1ZvAK1RlHnmjRgP6iwnnX4=;
        b=WO0KpYOZ7zACtdA8u5+mOul1D862nqy+it0OAaO0K5tFk2fxVkEfh2AWzZ+q7tC11w
         s+tHbNYT6V1qxmhDUZaBVOQYYadFFhmBixY3Qi1kmhwKApOZ6/bhNCGRtcPU0SSSgKe2
         nPEP9F0eHtUhy9EUOsolmOOHd93TxbmZfksXFFjcMIOulp9bUJQCVI52bRb6bopGJhZT
         W7mE3aBAFvYZ1gvktVhWjgjGXjvDy3ddbKwjP9YxGHxKffJPcR/bd0in9shmaCyqSOzF
         yOPVopw8h/ZDyvjw/eF1XRmVYNhRRKXTaWFLZN01Fq2b0dMZhzQ3WagSMkAVCg2DcjyR
         7zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029937; x=1708634737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p4ftYp6xpxvljAVFhFhn1ZvAK1RlHnmjRgP6iwnnX4=;
        b=ukgc9RBqd3T+xYd4ts+m5ph+f2OvOgcJh/IAq/+KuGxzAvkbFHEQBUr3vLkjkY77bB
         PGx7h75GE189nLP768tG8fEziQnqZZVhR5lv+mxdykR9Wium2S7QgUrzeYpu/xgiY04U
         qx/LnDy7N7RKvmlz7CrGJCx3cUq7gTDQbE1Apfp2X/ukLTITlpblcW4/lPOTUpltTZbU
         8H8akGuTl7/HKqrd87SeTz0G+FBa42a+FIddrMO95EILy4pZED5V0crBJpyvZwAEWKSi
         5VEKgvX+QXAp3eP8c4hwiPiNS9TaTX28k0zptQxLVYIkGY7s9viTH31BHea1cAK2NKX/
         6diQ==
X-Gm-Message-State: AOJu0YyMP9TAOTHSxU8gY5jtXUa8c9u8bDDSydK2U8jPJTLdO+vy53J4
	ASg9GItuNPMzumL+Lxc5zOLQgg95IYBUuBHy6Ahlj+7jSQiOF07eGMQfj0QytL0=
X-Google-Smtp-Source: AGHT+IETOINXnnbp9Wk2uki1xEgic99st0xfbAXZQoiyUTlIBNBaASDtS7FZOjBE/Zr5GKa3fzfayg==
X-Received: by 2002:a05:651c:221b:b0:2d0:e70f:84a7 with SMTP id y27-20020a05651c221b00b002d0e70f84a7mr2783555ljq.19.1708029937523;
        Thu, 15 Feb 2024 12:45:37 -0800 (PST)
Received: from wsadrian16.fritz.box ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id er17-20020a056402449100b0056058f2603asm883058edb.3.2024.02.15.12.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:45:37 -0800 (PST)
From: Adrian Freihofer <adrian.freihofer@gmail.com>
X-Google-Original-From: Adrian Freihofer <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@gmail.com>,
	Adrian Freihofer <adrian.freihofer@siemens.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][kirkstone][PATCH 3/3] bitbake/lib/bs4/tests/test_tree.py: python 3.12 regex
Date: Thu, 15 Feb 2024 21:44:52 +0100
Message-ID: <20240215204524.320874-4-adrian.freihofer@siemens.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240215204524.320874-1-adrian.freihofer@siemens.com>
References: <20240215204524.320874-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 20:45:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15903

From: Adrian Freihofer <adrian.freihofer@gmail.com>

Python 3 interprets string literals as Unicode strings, and therefore
\s is treated as an escaped Unicode character which is not correct.
Declaring the RegEx pattern as a raw string instead of unicode is
required for Python 3.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bs4/tests/test_tree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bs4/tests/test_tree.py b/lib/bs4/tests/test_tree.py
index 8e5c6642..cf0f1abe 100644
--- a/lib/bs4/tests/test_tree.py
+++ b/lib/bs4/tests/test_tree.py
@@ -585,7 +585,7 @@ class SiblingTest(TreeTest):
                     </html>'''
         # All that whitespace looks good but makes the tests more
         # difficult. Get rid of it.
-        markup = re.compile("\n\s*").sub("", markup)
+        markup = re.compile(r"\n\s*").sub("", markup)
         self.tree = self.soup(markup)
 
 
-- 
2.43.1


