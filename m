Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEC0C43217
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:23 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web12.677.1652205982322914085
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=lCm1NLh9;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.177,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f177.google.com with SMTP id v10so15245788pgl.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ShqqtqrtJ+nE5Ow0Ym8bK7Fy0Vr+EDh8BD8+HEINatU=;
        b=lCm1NLh9zX11D+/W22J5cgoMHz1CQqi03stkZJEr8cvMUd+cn0lqNEzpvWSdH3cdk8
         RC65ckb6bOcRrBL/Uz1CwC3G10dWECL9IndVOjT0b3mVLoqkiGrjRf3Ri8pOSJUDy/Ol
         QpM4heQ98YMI1KmHnSfUn+/SuhSpzgAitevDmRHF5tuZEg0MIxoU+ThnJ4zvYyxDsX5k
         Rj1lOuRh09pB0SUya2YzgfeTOZoXF1RZEw0s6kFrQz1qO8Iwz8xj04vIIEt5iMvwrU05
         2mv5TTd386mZFSeucwGMj9E1zEFn98HUnXA4+vzzUHpwe+XXd60Z/i5fwFsOW1FXZX+R
         nqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShqqtqrtJ+nE5Ow0Ym8bK7Fy0Vr+EDh8BD8+HEINatU=;
        b=AALuhQyPpx/DDfSvxDw65ZDwXlwVx2zFAzHceNg/qlAMMdOCBy/6b6tOspv8UxcWce
         f3NXo7qh6AFaNtSqgxZmxLkUUnsaVcYgTzl0Ye4OKvC2DWFRyqZMZAvkWY+v5W7hRl/M
         HNETBKnie+CbK05NqXLXz8u1MGwqlwkROfCRJ7sYMGKZjDAKTdY/3VH39+45EAc3AGMD
         9lxXxsGaXPyGO+LvdU6MofUHRbDFZxZcEpU/eMYBJcx3BhapDb6FP9/oAZRO9i6uyNtv
         Fa2/3dHmUzMGaV42/9irWXcYJHqKPqUMhF7ibRIbRd3Zu8ksVIEEjvkdM0LCSLbEK79E
         EBIA==
X-Gm-Message-State: AOAM530IdFgE6EBY/JDmi5FP/D8Mm0gN/QRzw0ArI2+tHPzIzd648lF/
	U1fePbTVpykEegf+dJXcQvE/3WJPM+9/i/TP
X-Google-Smtp-Source: 
 ABdhPJwuRyyNkgY+j4I9xhawokXkKwzKfVqKmGeMjL3lBc8tELDZYcloGjcUe+4F91uo2OakH3xahg==
X-Received: by 2002:a05:6a00:230d:b0:4f6:ec4f:35ff with SMTP id
 h13-20020a056a00230d00b004f6ec4f35ffmr21667880pfh.53.1652205981210;
        Tue, 10 May 2022 11:06:21 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:20 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 08/18] fetch2/crate: Drop unused
 import
Date: Tue, 10 May 2022 08:05:33 -1000
Message-Id: 
 <7fcb08de9ab8d65beb8d6129a7e17da348759248.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13688

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 879f17ecd5ba09e217cef74f6a51339b145e8ef5)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/crate.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index aac1221c..f4ddc782 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -13,7 +13,6 @@ BitBake 'Fetch' implementation for crates.io
 import hashlib
 import json
 import os
-import shutil
 import subprocess
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
-- 
2.25.1


