Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E3C54EE9
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:40 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.5260.1663079251445711340
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=xdqVwQm+;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id
 x1-20020a17090ab00100b001fda21bbc90so15816864pjq.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=VaRm9ErnvSCkuTySdvMbJmOPKg9vQHtdygFQjhkjY3k=;
        b=xdqVwQm+74NNvvOSRojp4tGZ0tOz/NiTw6QBmk83QWOleozY9sGRPC/RhSSiGrOPIE
         /xPqgIRk88AyQHQ3fgbyr3aNha7lBZf+/4n9Gn0i9vHRfcwWt86FwfgeMrNb0Ye5YZy8
         Hj/qz18RNoPerBqwXNAG2wyRNzjVUzwfhee7VP1Yy58qEYn25rA8sJEa5zhqI+C0lRdC
         kfR+HEeirzaIVSOHBOqA1hBIjYR8YyOUrt+5cYMFrxcbH9yZ6oyM76UTXMYfTRVrT9Ju
         sMXHWLL0rKNzt1rg0xk9Jeif5ff6oORjM6TNvCtfXZjiazqExHIiw1H1kEchKbl+SzlM
         TF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VaRm9ErnvSCkuTySdvMbJmOPKg9vQHtdygFQjhkjY3k=;
        b=5iAsrLBPJuxU18iBWGJVP+AolqLuD617Fd+1yR2o4POdgb5p5wh0il2A+r93GI8bOY
         2PoH/L3jymT1RU0N7CZd9HssCo+tb3ypiXr/rBJy7dxauz3sgxiNjoYliu9awJfv+iL8
         6oY3EAGjou7NOaOIrkIzBcnd43AjOoIGjj8a7LdVVffjpkfsgGaRla1DbCdj5f8/fJ4l
         vmjtin41CRynw1R/T27miU7DXwZkWmyAg3RcBFMMHkqp3I3+m0wgDM2OgbIh1mdeRbi4
         fy3oqEfsgsuNbWSrMhZ5Y6bdv0n5xZ+ZW3pCezYuP3Ba9KnbCGUJYDmcnzDqyExhLvzc
         xegw==
X-Gm-Message-State: ACgBeo1v4VxtCM31zvylrEMMh5eUcDFc+BLwDCgvTy4UGrFKjKLzQlZu
	Z76tghGNdZoPv7JG0K+/+z4Sy/6y/0j+D102
X-Google-Smtp-Source: 
 AA6agR5nQKiCO3eUz81V95MEBqdVxLuwDV6UfV3NajT/ibl2uDmuvXGjnf8mHKe2j1CPW0DiWGOUCA==
X-Received: by 2002:a17:90a:644e:b0:200:422c:6b1 with SMTP id
 y14-20020a17090a644e00b00200422c06b1mr4269367pjm.183.1663079250237;
        Tue, 13 Sep 2022 07:27:30 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:29 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 12/14] bb/utils: remove: check the
 path again the expand python glob
Date: Tue, 13 Sep 2022 04:26:42 -1000
Message-Id: 
 <13a291b79a9fc6a217433a40a7f28d21d8dd3bd5.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13973

From: Jose Quaresma <quaresma.jose@gmail.com>

When we call the remove with recurse=True we first check if the
remove operation is safe in _check_unsafe_delete_path.
But the check is been done on the path instaed of the expanded
python glog.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(cherry picked from commit 7236488b898309ec5f1880936ddae22a28ccf5d3)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 29801765..e92d5feb 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -694,8 +694,8 @@ def remove(path, recurse=False, ionice=False):
         return
     if recurse:
         for name in glob.glob(path):
-            if _check_unsafe_delete_path(path):
-                raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % path)
+            if _check_unsafe_delete_path(name):
+                raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % name)
         # shutil.rmtree(name) would be ideal but its too slow
         cmd = []
         if ionice:
-- 
2.25.1


