Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C456ECAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:45 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.5227.1759399775720419928
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YPeW0hrZ;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so401097f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399774; x=1760004574; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNGKXd6PwNbtTT39BOvqkxWCy/1a/V7YkySB8+JPg5E=;
        b=YPeW0hrZN0xvKZTo+UK8oEn/kr1WK74200sbEAXEY4nNqm8e7OECCTGWICr3qBzG/N
         Zo6/pJ7SonvuO2K/x25LhUeMF4GnQ2Kqs88h14Owa3R8M6Y6m8PnNmoj/SYpJSk5GaqE
         GPwb8ZyMtcmL/R+p4/MsPwoGvEyxdKwndo+2qcXTa59iKnrV1RGo9uHTgaLVjsRRSTlM
         ODXQxAt3MjMLBbfL5lIffmylQrduE3GAqIeO9hK7So0M3FvSNltEVsINkBLpYBlQhthM
         WBWRp/1NYCP4XMcwTtWbgM3R70sWsTRv5Mv+w6XP8/L6LwRwUJJxypfKVIEbUfQQk5YL
         eS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399774; x=1760004574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNGKXd6PwNbtTT39BOvqkxWCy/1a/V7YkySB8+JPg5E=;
        b=BO4U0lfvF4AIyynUqPQJWgcabI2CEOuERpKasmyR5E/cUAqXCtlCMxkyoQfVVvNR/r
         ecn7Zf7bkh5xXS+GViV7E+lngiel7hOqHnO0m74nYWm80NNw5QrqCm1VIrQseAhHv51q
         S7zLb9fkVP4HMzkHW7FLvuVRzY/l4JO682pzLW0UnTXA5UTl8aD+vm0GWNdYHKeXhS+9
         6P70Iy45YZ6H3VfRbGHmKv5fdwerfEx8ejXi4n3RjogL6KTGLftRlTNkXHkBgZkdHOZ0
         l+3SmcGsCb7YFsl6/po+g3nH8mKD6+QtA7osYKzvTFcW/Xzg4vUSMbgNbseLDOp2cGqI
         bhWQ==
X-Gm-Message-State: AOJu0Yy0HAJgspOrV0euzLdlH9YjngajJu5wCUTA1fO8rZQeFlLDIxdr
	maIQBtYltwkfb3sF8tNPFQTzcekeyXxnqowEAHqjBh+a0DzoNg5aOfFpiJb0Rw==
X-Gm-Gg: ASbGncv93xwOoexgcemHJNUX/3C5d3Y3a0D4K5Iz/OzIjtWinJI+Bvdrd11mpAiMzmZ
	1ZpRlLNn888YMTkybu/Z6iu0cWKrtATVSFuuA/MRlyTxec3Up8dYba1P0+4opPHKzJ1oUymxfMy
	Pz2D+5zkgeI29B827SSYV+a07Gr7s6PmOxR7bIHeSoWZe1VdjoXauCNg6KMD8mg4r8XgV0Y76Cz
	Rdc8EzD9n4i6bYgQywT9IYHgAzGYh3tjoCN9sz/tvIiVxnl0spNZGAxeERJStbhiY+fa70BJfo9
	rEo6b5Ylzct8smF5oI8ze8azdW27RtDKbU0Zb2ZMleQhkiWDo5esWL6fSOYYIv6kFBX70IsXnnH
	SnAOK9f2cMqpBk1HHwqCquMtepF9oLBE6D98i9gkQq2h92XzLWHrYH8dlED5lypP6K2wjIA/b1q
	EcFtHCi5XdEDSGb5EEsVEAXvFoLB7ky2dN6/TwxyOb6iQm4i7ibGyUw7NNZhaFQF7fRatZ1K9En
	jj29hRP1w==
X-Google-Smtp-Source: AGHT+IHmcFhOT7gRahw1YRS6Ta3XG5VwFk8UvZju/bbtSYmmYGXqPlusrnS/OjH1Td33MpbIJ694Zg==
X-Received: by 2002:a5d:64c5:0:b0:3ea:3b7b:80bb with SMTP id ffacd0b85a97d-4255781e589mr4633715f8f.58.1759399773937;
        Thu, 02 Oct 2025 03:09:33 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:33 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/7] lib/bb/tests/setup.py: unset BBPATH to ensure isolation from the existing bitbake environment
Date: Thu,  2 Oct 2025 12:09:26 +0200
Message-Id: <20251002100929.1054540-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002100929.1054540-1-alex.kanavin@gmail.com>
References: <20251002100929.1054540-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18118

From: Alexander Kanavin <alex@linutronix.de>

bitbake-setup deduces top directory from BBPATH, which, if set, interferes with
the tests' own setup.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index c77e750db..2076613d9 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -181,6 +181,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
 
     def test_setup(self):
+        # unset BBPATH to ensure tests run in isolation from the existing bitbake environment
+        import os
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+
         # check that no arguments works
         self.runbbsetup("")
 
-- 
2.39.5


