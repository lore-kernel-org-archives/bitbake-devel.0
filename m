Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA381C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 12:45:09 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.18683.1750682706815331660
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Jun 2025 05:45:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h3hiJn8O;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45310223677so31322265e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Jun 2025 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750682705; x=1751287505; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Og2dFLay9wmO9V2nMeozqN4YZhYgoNYHVdrfecZnWjo=;
        b=h3hiJn8O8F/QyUNWb8ejdhDmOZDAxoh2Exn3z8B8PWT8icqbNwMdITxwR7iMVmYQ+D
         b6IIMz2s6VNa3XZFt+nesjyzki/2JetfQTHZgYL3T4kz3KK/6KZm+UKIi6nBBuBCSC1c
         EpJZp5eajnDDbr43vfUze0mTGembMHXCYULBqP/EmQyylFWfHGiAtILkvatlAN90mNgh
         eHG0MgiscQYz664h/XgJm+geG1FkCFQjVSTx+jBSHPv++UQ0qgm8E870yggx5NIvoIYB
         3GeebWEfLA8qVrXPhvOKnaLxb3Kw2fj3tU1SBigVr7gVzlkjOHXwRcND0t6epJQF/jJL
         ISuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682705; x=1751287505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og2dFLay9wmO9V2nMeozqN4YZhYgoNYHVdrfecZnWjo=;
        b=vN2OJi61Ds5NpWiTjlEdwCfxRGQYXod6pIKOQEjPTrquKzjeQKwzjT99MqKgwEI3fA
         WwCVnfuCgmQTf4HYMkmC+bB5JBkba7nMVVP3HiG4AdZxpRkt2bgZUzzjLXwluNcYexUO
         v87f7kkT1YAOCcRzxLAiFDJvr3N8Xn3zN2/hIoUPzbOsuNazUSMsrcGVjgMt9Z+M6Kiz
         4gj65WtWZqTnxfKcBJbR0xNOffE5otVtx6pN6XTzKaDnY39H+KMUjY/KUiIAvujR/7qA
         bAGxRZ01hYhxr/dn81HyaCZh1WdkS/JfXnXermrGZPC9yUU5uMX5HRfFF/SGK7z1ijGx
         QQ1g==
X-Gm-Message-State: AOJu0YyX6DG5SSi76ZjxX0Q8f4StzFOyYkQrPFVxz2Nw3Dv5fraMQG0z
	I4G5FhVSe1mRkdcBuBuSlHbW/r8pOm21dTYgqQadoEZJtRxdtS1icaKcuoJAMg==
X-Gm-Gg: ASbGncvEvqXbtqd5As7H83SdHkNVUK42MXEci+ko+fKIxFKHU1jqkVFSI95doaiOQJ6
	IepigmvYrRjnfWdmQEsDV74c+2JhU6MjIrPUj1MWjbn6XngyHes0sHQEJLCfNJ6i+y2GfHlb7/i
	jMT4hf/gZfKZtgULg1oDL9x/ct4Lp576JWvMz1I4Tcp6rwXrdLlKpdIptl9Q4sZSNNlPZPY84Ie
	qt+Nz8bIFtnP85TnbA6NzFseSdLomOtGr9chcm53L0HRKOf23fU1+FbiBcBeBXG3fxwQ54QK9DM
	VxmqE/gMSfvob0VAVhCKHTyZx+YL2g0yr74jfSzboIx22H3y5zNI9W73jKsE3UMwtdJsREVgIkj
	vHBMIbDIKgo19KQSj+ZaT7LK3X08d1LgqDQ==
X-Google-Smtp-Source: AGHT+IEyyYIC1UTQqZ1lbTJ+SEpHs9Xc/+etAbP1xUfNBKJ4yzGWhlhUlZXAoMS04TUP4bHLRJSV+g==
X-Received: by 2002:a05:600c:a08b:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-453698fea31mr104784865e9.15.1750682704790;
        Mon, 23 Jun 2025 05:45:04 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d156esm111181225e9.11.2025.06.23.05.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 05:45:04 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-user-manual: correctly reference UNPACKDIR when describing unpacking
Date: Mon, 23 Jun 2025 14:45:01 +0200
Message-Id: <20250623124501.1545325-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Jun 2025 12:45:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17709

From: Alexander Kanavin <alex@linutronix.de>

Also, drop an obsolete S = WORKDIR/git note.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-fetching.rst          | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index eac3cbdfb59..a2c2432db1f 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -39,10 +39,10 @@ variable and then calls the ``download`` method to download the files.
 
 The instantiation of the fetch class is usually followed by::
 
-   rootdir = l.getVar('WORKDIR')
+   rootdir = l.getVar('UNPACKDIR')
    fetcher.unpack(rootdir)
 
-This code unpacks the downloaded files to the specified by ``WORKDIR``.
+This code unpacks the downloaded files to the specified by ``UNPACKDIR``.
 
 .. note::
 
@@ -51,7 +51,7 @@ This code unpacks the downloaded files to the specified by ``WORKDIR``.
    examine the OpenEmbedded class file ``base.bbclass``
    .
 
-The :term:`SRC_URI` and ``WORKDIR`` variables are not hardcoded into the
+The :term:`SRC_URI` and ``UNPACKDIR`` variables are not hardcoded into the
 fetcher, since those fetcher methods can be (and are) called with
 different variable names. In OpenEmbedded for example, the shared state
 (sstate) code uses the fetch module to fetch the sstate files.
@@ -461,13 +461,6 @@ Here are some example URLs::
    SRC_URI = "git://github.com/asciidoc/asciidoc-py;protocol=https;branch=main"
    SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
 
-.. note::
-
-   When using ``git`` as the fetcher of the main source code of your software,
-   ``S`` should be set accordingly::
-
-       S = "${WORKDIR}/git"
-
 .. note::
 
    Specifying passwords directly in ``git://`` urls is not supported.
@@ -598,7 +591,7 @@ and port, username, and password, and fetches the Head Revision::
    SRC_URI = "p4://example-depot/main/source/..."
    SRCREV = "${AUTOREV}"
    PV = "p4-${SRCPV}"
-   S = "${WORKDIR}/p4"
+   S = "${UNPACKDIR}/p4"
 
 Here is an example that specifies the server URL and port, username, and
 password, and fetches a Revision based on a Label::
@@ -607,15 +600,15 @@ password, and fetches a Revision based on a Label::
    SRC_URI = "p4://user:passwd@example-depot/main/source/..."
    SRCREV = "release-1.0"
    PV = "p4-${SRCPV}"
-   S = "${WORKDIR}/p4"
+   S = "${UNPACKDIR}/p4"
 
 .. note::
 
-   You should always set S to "${WORKDIR}/p4" in your recipe.
+   You should always set S to "${UNPACKDIR}/p4" in your recipe.
 
 By default, the fetcher strips the depot location from the local file paths. In
 the above example, the content of ``example-depot/main/source/`` will be placed
-in ``${WORKDIR}/p4``.  For situations where preserving parts of the remote depot
+in ``${UNPACKDIR}/p4``.  For situations where preserving parts of the remote depot
 paths locally is desirable, the fetcher supports two parameters:
 
 - *"module":*
-- 
2.39.5


