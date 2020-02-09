Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
	[209.85.216.54])
	by mail.openembedded.org (Postfix) with ESMTP id CD06060EE7
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:23 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id ep11so3082361pjb.2
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=WQ7yZj3pSrN8ZeyfYDFvr722Dn/LBYkMSJQuJ3+NyGo=;
	b=EmwpAAnGgSkWK/VUkqm0694utAKl9DzW0ee1CIbA8FY5VEFZ7DlXr+Ro+lfcit0phT
	taDiRSAt5gZ28yv21Tv5NgMC8vSZW4FyoVNwIIrT5GyHDfLxqidygDeqH2UCP0jjEkFn
	On1EkmsuuCRhEABxgv2ib853KN3wO/f7b5TX8nTvYvLc7p1KBpVDsLqQbxeX7MIiapbr
	6uVLQuSiuLIQBwjobysIEQYqtAxafFYZcYXJblprEXTY/X/HCtW0r+AQQisqUui4S1Wc
	V7rQxKDgqzLC4ZcNadNxKkpFYDW9/GEtDLPOoheee7og1ONvJG9wa6Q+t4QbyN3UC54O
	2wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=WQ7yZj3pSrN8ZeyfYDFvr722Dn/LBYkMSJQuJ3+NyGo=;
	b=UJm/9mkonX9mtlkU5bl96TW18B5P74xNT24To61Qwf/wXXZNT3agBxqL2C7PxBOAVq
	eSQBlj1BcIZP44gcF2cMeWQJPhE9rxXBe69biAJyCdYbF47xU3QuZ8rfUVblpEFnUVD4
	OM3evQEAZspvOAWLk1Lg/nzI8NPybwIWkLix6aIx1yX1ey+Jqoc+xzah9eB4Ktuy+JV2
	mrpoRznWQAkqhRwj953xzFSCrca9eo1lORCzXhVvbOf2SH+GycmzwSIbbFrj/Yl+hgms
	2f8EjwFr+6WrhC2CZU1JEKs5w5o3XS7hGJNXB4L2QN5mLLZH5YyetrP/Bh8zkUZYpgwU
	nKAQ==
X-Gm-Message-State: APjAAAUYi01EWG/TZXL5n7L6sUf43YdAn/Cvv9vfJxFp8KDGQMKEPVoV
	IZIcPnPTO9B0htF1qAAxCy8SN0Cq
X-Google-Smtp-Source: APXvYqwEDdWwzWkuUxRe1AmxMUok/0y/lufEbkPu76fy3DQQg76ObaZqIYC4CwEmzZjfa3fPOAnk2Q==
X-Received: by 2002:a17:902:7e4b:: with SMTP id
	a11mr8683567pln.61.1581264204708; 
	Sun, 09 Feb 2020 08:03:24 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.24
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:24 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:15 -0800
Message-Id: <95687be83e716220eb3893b67428f97fd59fc2c5.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 7/7] siggen: Avoid cache mismatch issues with locked sigs
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 09 Feb 2020 16:03:23 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If locked sigs are in use this function makes little sense, need to
avoid generating mismatch warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 27ad9c1d468fba858a4adeb56b605227b415ae0f)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/siggen.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 96807c46..ffd8fcaf 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -515,6 +515,10 @@ class SignatureGeneratorUniHashMixIn(object):
         if self.setscenetasks and tid not in self.setscenetasks:
             return
 
+        # This can happen if locked sigs are in action. Detect and just abort
+        if taskhash != self.taskhash[tid]:
+            return
+
         # Sanity checks
         cache_unihash = self._get_unihash(tid, checkkey=taskhash)
         if cache_unihash is None:
-- 
2.17.1


