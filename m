Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4DE7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 15:25:23 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.104351.1733757919836195253
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 07:25:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KZysc6MT;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e398d28cso16207005e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733757918; x=1734362718; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WB76uUejcbcVllCB2DTsu/4SzQBAu9TGFTyteZpl+7g=;
        b=KZysc6MTl2cr26nBtgl4rSYbjz4aS4C0edi8sBBbUS+crMf4MPwRWbxjy42pQgC5S0
         zi/Ue1SOvuSbTmO8YY3sfo6Eqbro/XGx4p5t1dE1ZaYGKaJf7whZs3ASH/lYLl9UC+9P
         LM+GP6VS88tFb+AdcjjEv9WLZg1hYF7Ng2SlvviXmTv/91Wvz7SbQqSNDr8Ck7yzVWxv
         vdjkCw6o7U392P55gu6WCuUZg0cOeKELdNg2CQ3n+a8JodPdwBRxugOdNJhnYxdUgte9
         6Xm3crex4W2efrJyL0yCkCaziWRTs9cv+wpZmIdS72qN4KSwc5EpdMDpq1A7bEk0AnV1
         4g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757918; x=1734362718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB76uUejcbcVllCB2DTsu/4SzQBAu9TGFTyteZpl+7g=;
        b=PynEDrOliO56v4eY0/rGL5eFe7LNjz4oF3oKHUDWEtEeHaEiI395EYtwVbtyckIq5R
         AmKWH2F1jlEB6mnXaZzzDQfO1ilA8FanWUH0AgRVHc5rrxNakaKE0SG9iSLEot8SzrC8
         yMQP7lehrNmAXlurFnLRgetnPSepA0qxkXtvOtXnsPO4a2B7TgJIfZDvIcM2yWdMMqN8
         x3I4nv8AJKy07HGu9bytYdi18FVlCAp9/jvamALlQM6FqMsVwHNE5Q5HiLA4cHvQ5+Nl
         wAIOzoWj0XBuOHfwzBH1tR+vSd7dNbAmtRp8qhh+XZMJwrK6QL23qxIngPks0FD2AJAT
         YYLw==
X-Gm-Message-State: AOJu0YyHof8aHY+3Cleqlj8QCm8ZNn+FjqkfgvrGselrY0SyaIsznlsR
	1N59uE7WSZ7BjBfiqPrQHk9FNn0sayvmgcEJ+5ALYxabD1Hy+cnsiWfVKQ==
X-Gm-Gg: ASbGncveMD2AgttUaHS4PGpHJtcTY5DWFw7Ro5s8KJ2S5yNfS9x8StWdBZYI8vx4WLR
	t8q1l/sdHRCp7Jkzv042NTFFwc2aJbawCG5FEwnVpprkZd59Zf4DXEKrIgSO3XC+WOJAl0+t6y5
	ycvq4MZoLaBme8nBb9RHiWO7UyrwoT3qHsBwC0o0ZGG/CDUkT+LVT7CBgX0Kzeemwca+44A3pDM
	LOb1b8BnXakQtWYqYplSLgXU+FW5S5+xJKDkRg3CchYVW3IJ/yeVsrnGSDJi7lWUYtSGek55oO4
	yQ9d/b04HIw=
X-Google-Smtp-Source: AGHT+IE6kDWbtV7d889ZKFdsxola/UIbUqu7yFUnC40I26C+bmdGdXvEXBQMdGmqHQcbnTFXvgtPMw==
X-Received: by 2002:a05:600c:3107:b0:434:a1d3:a331 with SMTP id 5b1f17b1804b1-434fffb2d1bmr7328415e9.22.1733757916451;
        Mon, 09 Dec 2024 07:25:16 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm198323495e9.44.2024.12.09.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:25:16 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] bitbake-user-manual-metadata: add a section about 'addfragments`
Date: Mon,  9 Dec 2024 16:25:12 +0100
Message-Id: <20241209152512.2496818-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 15:25:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16900

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-metadata.rst          | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 40a0c6f02d9..8e25426895f 100644
--- a/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -754,7 +754,9 @@ share the task.
 This section presents the mechanisms BitBake provides to allow you to
 share functionality between recipes. Specifically, the mechanisms
 include ``include``, ``inherit``, :term:`INHERIT`, and ``require``
-directives.
+directives. There is also a higher-level abstraction called
+``configuration fragments`` that is enabled with ``addfragments``
+directive.
 
 Locating Include and Class Files
 --------------------------------
@@ -962,6 +964,39 @@ the ``autotools`` and ``pkgconfig`` classes::
 
    INHERIT += "autotools pkgconfig"
 
+``addfragments`` Directive
+--------------------------
+
+This directive allows fine-tuning local configurations with configuration
+snippets contained in layers in a structured, controlled way. Typically it would
+go into ``bitbake.conf``, for example::
+
+   addfragments conf/fragments OE_FRAGMENTS
+
+``addfragments`` takes two parameters:
+
+-  path prefix for fragment files inside the layer file tree that bitbake
+uses to construct full paths to the fragment files
+
+-  name of variable that holds the list of enabled fragments in an
+active build
+
+This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
+variable like this::
+
+   OE_FRAGMENTS = "core/domain/somefragment core/someotherfragment anotherlayer/anotherdomain/anotherfragment"
+
+Fragment names listed in this variable must be prefixed by the layer name
+where a fragment file is located, defined by :term:`BBFILE_COLLECTIONS` in ``layer.conf``.
+
+The implementation then expands this list into
+:ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
+directives with full paths to respective layers::
+
+   require /path/to/core-layer/conf/fragments/domain/somefragment.conf
+   require /path/to/core-layer/conf/fragments/someotherfragment.conf
+   require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
+
 Functions
 =========
 
-- 
2.39.5


