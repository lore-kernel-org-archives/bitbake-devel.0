Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE1E668A1
	for <webhook@archiver.kernel.org>; Sun, 24 Nov 2024 09:30:19 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.63546.1732440609257600634
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Nov 2024 01:30:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GDVEAk0u;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: pascal.eberhard@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43193678216so33261675e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 24 Nov 2024 01:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732440607; x=1733045407; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ifj3yeHABBMPUuTbCTreusvOjteoqh6YsInH+PGI7s=;
        b=GDVEAk0uyiTk61102KV72Nxdw/oAv1/cTckfggA5yRNOW2txh71EWd2AhSIVvSr6r6
         gqvQVq6cxiMz5qGeyJ1EuwYaTNL+zqlGLsntomlS5KSxmScgqd25k4Z5I+/XmTHPYVDK
         ynGWS8sfFFHxHOKFb63dF03q33t9r7brrgOFXhN4y6Op/kOrUQjXc/U2SzIGtPoUrEJy
         Pb3bSSchgTRGtCZ1qCZFDIHWCvpYdI5H35/BoZ3tffXk+43y62BTJp4zlzShEhvt0z74
         vk1CBkkN2IUFAHr5zzy7ig2opB+dtqY22X21TRip/NO/rBzAwMPRwB7YGlyB8ZU/wImB
         Grig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732440607; x=1733045407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ifj3yeHABBMPUuTbCTreusvOjteoqh6YsInH+PGI7s=;
        b=igupt9NiE61z0i22liNzX07Zcyn70nqnuhlleQa4K5OU5N4/+wzzZDIjwejqYtxsrN
         GTQ18cm8g8qN61htuWjfZJoDKDdVoPLugdBwJvzqAOgTQ4nNvfnoWdvt3sXdKSN/Lm6i
         Oea9icxslywZ/wvLuipkZPZX3zq8CT5QL2FrGFBClNVBBuQ18K48TDk6Sd9Hb3WPJIhK
         OglL1eXdoY8w/DyNi3NUwDwMB5GfE0uz74XQbVIsenkP5oWrfmIlGFEHWw27ySgvpRTl
         dZlng6X0tDC+OE8cNZ/WVZCVDwl9uVQnn/L+PIlZLnwAvzzG8cgGugidnjulUVCsfzTi
         ud7w==
X-Gm-Message-State: AOJu0YwsIFWsmAqU3nPUccIb/I9HM01u4CRQmNiy8a7B1LrGVPgkXlKY
	M4AiYpLuyRT8bifgWwuHVtYl4whH0du4Yy+it+j+oeSIRHdaw56zjV9sIw==
X-Gm-Gg: ASbGncsOipQpIP66uQ2a0czd424j6qHhh213SKjpICD4W2FUSvKwTIXfrky5ab3fO+Y
	t8Dbw7hLgtMmisJWLo8cAQ8uVbayTFN0QiMYGmfj+6CNIxkpsPVp7+FvQCplKgHCa+S5kaSlEkA
	m079JljJ8P4ZrXEdBFHQVQucNAeB3IruqLspBeIVGF/OicfMfRLcxmajzbJu+KRo+Xs3G3MNEPR
	5ct8WrJI6Z5BigTHCbhTlD9km81M2EBZ78g+mcu/vchqWVPRVvL5w==
X-Google-Smtp-Source: AGHT+IEJer1ave7Hgzy5VIV7mo2Fup/YZ84/6Ck7I33ui/pgEB2SIFeZiu87nNFwpIVrt5eBtMZt0A==
X-Received: by 2002:a5d:6dab:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-38260b58319mr6747188f8f.17.1732440607225;
        Sun, 24 Nov 2024 01:30:07 -0800 (PST)
Received: from WTFRLVSE288987LL.lan ([2a01:cb15:80fb:95c4::6d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46426d7sm149524855e9.36.2024.11.24.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 01:30:06 -0800 (PST)
From: pascal.eberhard@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
Subject: [PATCH] fetch2: fix unpack of a single zstd file
Date: Sun, 24 Nov 2024 10:28:50 +0100
Message-ID: <20241124092850.742383-1-pascal.eberhard@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 24 Nov 2024 09:30:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16826

From: Pascal Eberhard <pascal.eberhard@se.com>

do_unpack generates a 'Bitbake Fetcher Error: UnpackError' when
uncompressing a single 'file.zst', zstd command line returns the error
'unexpected end of file', and the input file 'file.zst' becomes empty.

The command line is 'zstd --decompress --stdout file.zst > file.zst'.
So the issue is that the input and output filenames are the same.

Fix the output filename when using zstd for a single file.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7ee12f452..f79e278b1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1518,7 +1518,7 @@ class FetchMethod(object):
                      (file, urldata.parm.get('unpack')))
 
         base, ext = os.path.splitext(file)
-        if ext in ['.gz', '.bz2', '.Z', '.xz', '.lz']:
+        if ext in ['.gz', '.bz2', '.Z', '.xz', '.lz', '.zst']:
             efile = os.path.join(rootdir, os.path.basename(base))
         else:
             efile = file
-- 
2.43.0


