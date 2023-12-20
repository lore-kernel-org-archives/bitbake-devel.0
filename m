Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991ECC3DA6E
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 17:45:22 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.27568.1703094312641724018
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Dec 2023 09:45:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e/pmqHzD;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: rybczynska@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso73871375e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Dec 2023 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703094310; x=1703699110; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfrP/23SrA4hrA7BhGmuLuMU6GuTsqkPhTej/R15ClU=;
        b=e/pmqHzD/U6re7c+d5uxIEpfo/c9IguKwJ7Av/JExjN+R3sOf68UhwWkgKcvN2kyDf
         R1OJQzUgTJXXD8T6aoja41opyDpBlcdWmtXYI+l3C7SjwweD2TOG1KBueXz/eWCvMqUQ
         O2IkuBX6VqHQnNA/TX8kQJ5fjh3psbrklZc9FqQfsHKh2v6Xeb8ep6+lAsAWX3lkDEDY
         PilKXhtjKtIp/kuAde8z9Q+3OHLFyyLOS0qNu6gqodxlCKhdxzG0HEkshVDL6yZ2ywKH
         fI+D2sex/OHEX84v1OWGI4FsHwPdrT+3kyg6GrEkSLyjfE9WiZONEPzLNnOvNMz9iWnM
         xyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703094310; x=1703699110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfrP/23SrA4hrA7BhGmuLuMU6GuTsqkPhTej/R15ClU=;
        b=neEB3cpiWzVQ/IDkD0pMqar3n9bjFQ5yLJDVdk0EkYcKDrHjl/MU6KhGpasaaatih+
         OsmBhejLCZLJ7IVNI1n0Lhuf/+pT0HQCVjYx5w2Rwz6ZtypxBNnGxuSw0lqQAGya2U0e
         EHLh2VeuRc3ukdldSq8EiFD0kSLnlAP6xWmVgkKpyUljnVZb6WYopxTMtl7YYEm8M/lG
         yOC18lM2rJgNIHTwF+HF2Ye8ErfJXhUCvbLKwFc/rsKXDH/v96mwupR++U70BNi23AOK
         KhbVyfpZ/ZHoIjO/nrR9xSGkZtvq7us9qZKZG/ZGRPA1sP3ptorCKExWOB2QhT+uJ8v+
         XMig==
X-Gm-Message-State: AOJu0YzMYDdLSJOST4KBwz32eBx9/9ukAtgkgX84EjUcvPNFiti38E+3
	H2T4e97fu47Y5cYAX5fpMaeqQ8fvmGgcnw==
X-Google-Smtp-Source: AGHT+IESJXmvnWrX1usoPDmQoSYGNhZf92YMPvQpooRjtYcVtkWA33Dok7g0Z1sKgZuYbgwO/3PfYA==
X-Received: by 2002:a05:600c:a05:b0:40b:3d6e:16b7 with SMTP id z5-20020a05600c0a0500b0040b3d6e16b7mr57361wmp.33.1703094309830;
        Wed, 20 Dec 2023 09:45:09 -0800 (PST)
Received: from localhost.localdomain (91-161-217-16.subs.proxad.net. [91.161.217.16])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b004053e9276easm7992085wmo.32.2023.12.20.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:45:08 -0800 (PST)
From: Marta Rybczynska <rybczynska@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marta Rybczynska <rybczynska@gmail.com>,
	Marta Rybczynska <marta.rybczynska@syslinbit.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] toastergui: verify that an existing layer path is given
Date: Wed, 20 Dec 2023 18:44:56 +0100
Message-ID: <20231220174456.9277-1-rybczynska@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Dec 2023 17:45:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15696

Verify that an existing layer path was given when adding a new
layer.

Manually using the shell for globbing is unnecessary, use the glob
function instead for cleaner code.

Signed-off-by: Marta Rybczynska <marta.rybczynska@syslinbit.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastergui/api.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index b4cdc335..a06ffc00 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -11,7 +11,7 @@ import os
 import re
 import logging
 import json
-import subprocess
+import glob
 from collections import Counter
 
 from orm.models import Project, ProjectTarget, Build, Layer_Version
@@ -234,13 +234,11 @@ class XhrSetDefaultImageUrl(View):
 
 def scan_layer_content(layer,layer_version):
     # if this is a local layer directory, we can immediately scan its content
-    if layer.local_source_dir:
+    if os.path.isdir(layer.local_source_dir):
         try:
             # recipes-*/*/*.bb
-            cmd = '%s %s' % ('ls', os.path.join(layer.local_source_dir,'recipes-*/*/*.bb'))
-            recipes_list = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,stderr=subprocess.STDOUT).stdout.read()
-            recipes_list = recipes_list.decode("utf-8").strip()
-            if recipes_list and 'No such' not in recipes_list:
+            recipes_list = glob.glob(os.path.join(layer.local_source_dir, 'recipes-*/*/*.bb'))
+            for recipe in recipes_list:
                 for recipe in recipes_list.split('\n'):
                     recipe_path = recipe[recipe.rfind('recipes-'):]
                     recipe_name = recipe[recipe.rfind('/')+1:].replace('.bb','')
@@ -260,6 +258,9 @@ def scan_layer_content(layer,layer_version):
 
         except Exception as e:
             logger.warning("ERROR:scan_layer_content: %s" % e)
+    else:
+        logger.warning("ERROR: wrong path given")
+        raise KeyError("local_source_dir")
 
 class XhrLayer(View):
     """ Delete, Get, Add and Update Layer information
-- 
2.42.0


