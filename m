Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF6E77180
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 13:31:12 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.101333.1733751062673931713
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 05:31:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b6tV7NJF;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385deda28b3so3408391f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 05:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751061; x=1734355861; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DaWVtEraI96EotCAFZpzZ5DvNz5Q/jDTFWC2/H+Z2fE=;
        b=b6tV7NJFJ3dsOdPp6Z8c79IjZfCilzThlmQdXPG8GnqmF/3AxQSGOB64Oe49rVXAmW
         VMxyf7SuVImlPuJ+8Bm3MlbtVhXb6Nxl1RMSEfhr97zylBBlnbxkPdZaHcXdvVMgHDUs
         1ojTwqO7RZuBKOWbLiKggh6HhRKYdnnfSyhz2NuB+ACc6JsM5VW83DaxBJse1wkB4t9f
         V91JTllAAXowUzznMOgQs6XnZLVTX1DKIOZca/6derR/RJMAwYS5u6wTeqXzbzr6aYCH
         Eh/8VBsPYabta49qA9VZUV03Rd2l7uYqS8yqfrjIRpsv5FvDDkDrsQkrIS0qM5r3jzLO
         SgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751061; x=1734355861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaWVtEraI96EotCAFZpzZ5DvNz5Q/jDTFWC2/H+Z2fE=;
        b=nFwbXLdteKSa26X1hhAY7wDwKz1RIP1fXbk2cVhDkqNQmuClElXiZbs77e5+jDLKiP
         ZdLgkYUj0PBGJXDFP1KqyhWsGJy8cSyPocPtKQiGbqgLLZOvb/BhNQjg119zvKjzkO6R
         b7ejEUjiESSC70ZPJPHqN9QvBkQjj64s4c3WDRyZZsrcfdFqXFNhOVM8Ehqou3q5JYGZ
         A7/hNpsJZNPOnGzfpDZrQpj9l9JBPzR5SCNuYe5qyvRM+OXVor3wZtj0Gk1siSLUscyK
         JUyld8Zc3mEvIJfSkNpTXnKWWWG9JrClhU9mBqaF1GsUn6EGEtSUA2/q4isvXsbd76HG
         S7Og==
X-Gm-Message-State: AOJu0YzzIvn+HdS16qLoOYnOnczievcwAWoBl5dJeJmrL7eyIdOVyaqr
	pqBbL4CHb5B406Nhn+Pp186wHpcqBtl4gqSuHuQ6z2U9bTRuAAxOTTt2Ww==
X-Gm-Gg: ASbGncu8IsHSZcut2MHikZmOFkZd/AHUnTLARneYZBExh0iWhSX2V8GhFs0kJmkM7BU
	7sKOljvsTQuO74vvaGMXRJDIYHoB5hzmH7X9kkbdy17mh9GbZnandmTATcR6EVs6++MW4/rb6NQ
	AE6mFxIztffR0mGjehu6m1Uxe6XgTcVzMEUHoWBN7PltJfeeGQNn/V4gbKK7pJA+GoOow2RSxgI
	GyDoGf6toJwcU9CkhthHTK1O8CR1+gnGpfR8Is1uWt8DP0fHmn8WiCOfyRG9y5ui8Pb/LW+iPWo
	m2rfW3FePi8=
X-Google-Smtp-Source: AGHT+IGRJRVEtWQ5rOOZS6KVPbdPoQCjn7vaShWpfRjgfibYsQIxIAfzwcDkOYs7N9L9vWzU2me76g==
X-Received: by 2002:a05:6000:79d:b0:385:c511:240a with SMTP id ffacd0b85a97d-3862b37c2f8mr10254197f8f.25.1733751060689;
        Mon, 09 Dec 2024 05:31:00 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46cd3sm12975313f8f.55.2024.12.09.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:31:00 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-user-manual-metadata: add a section about 'addfragments`
Date: Mon,  9 Dec 2024 14:30:53 +0100
Message-Id: <20241209133053.2494088-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 13:31:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16897

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-metadata.rst          | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 40a0c6f02d9..16e4946b282 100644
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
@@ -962,6 +964,37 @@ the ``autotools`` and ``pkgconfig`` classes::
 
    INHERIT += "autotools pkgconfig"
 
+``addfragments`` Directive
+--------------------------
+
+This directive allows fine-tuning local configurations with configuration
+snippets contained in layers in a structured, controlled way. Typically it would
+go into ``bitbake.conf``, for example:
+
+   addfragments conf/fragments OE_FRAGMENTS
+
+``addfragments`` takes two parameters:
+
+-  path prefix for fragment files inside the layer file tree
+
+-  name of variable that holds the list of enabled fragments
+
+This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
+variable like this:
+
+   OE_FRAGMENTS = "core/domain/somefragment core/someotherfragment anotherlayer/anotherdomain/anotherfragment"
+
+Fragment names must be prefixed by the layer name where a fragment file is located,
+defined by :term:`BBFILE_COLLECTIONS` in ``layer.conf``.
+
+The implementation then expands this list into
+:ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
+directives with full paths to respective layers:
+
+   require /path/to/core-layer/conf/fragments/domain/somefragment.conf
+   require /path/to/core-layer/conf/fragments/someotherfragment.conf
+   require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
+
 Functions
 =========
 
-- 
2.39.5


