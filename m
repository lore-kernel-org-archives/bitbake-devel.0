Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A3DC6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 12:13:07 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.10493.1678968776622994516
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 05:12:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=J9DsskBo;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id m18-20020a05600c3b1200b003ed2a3d635eso947853wms.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678968775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fcRLWYmM91fxONrxfhRxHzk+LRJH7kMfHNnPhZGCxc=;
        b=J9DsskBoKrNAy3G183jAzMKjWiBPhRddUruJLdxNAepqvn//9R7M262S3Iyie4lzq+
         iEj4KS1f3RHXr+2B8QanJH98CXUPFkD96G37M8pXZjhvzqmLUaoM/wXxZYgSJ21hExnr
         kYLKMXcm9FEnS0ykQU5Cs7IBm+r+fJvBy0p2YulnVj9ZBUE7HOsUdPVoF6GUU6kKQLPP
         ey0vrn0cEein+LJa/RmYVO6T9jeCyhnidpO9JxV0JqLsg31p3PtBewgHera33Pnm3efl
         g1TFlKKgm2Cl6NC7ruHwmOop1B7e0nOFrHEgHAZLrNMsOW1jFKQFqQ9ejN9KCa+fCtrb
         jA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fcRLWYmM91fxONrxfhRxHzk+LRJH7kMfHNnPhZGCxc=;
        b=6hJh+0nWHy/LB5v7OGAjE1+FHuoqnLD5Tz6EBjhE3GJi4v3KqT5KyNTcRfIWoaHpAz
         xX6avyN7aFFq9nn0Hh3/wOSMQ59ZsRxlmDAnZklx7otfvJoXjiD1ytcprcbVtx45aneO
         NIZQS0Fd2FCgXyvHi11hqo5xMMcp0cfUmdqqhbmp3xIO5eWMp3fieiRuZQCmjlvtRR1Y
         PRn5eGdwUVFSOlEfVamaWirW/n37AAWBX0jN5MnO+5/P1pxayNZikiLk56X83urMOu0i
         SKl/obvHQ4HjgBagIGwyg4rs7/5RQ4iS358QZHUF06qiLDYEp62Y8NRRPhyp/kExMddi
         UCCQ==
X-Gm-Message-State: AO0yUKW/QOXjHjxCCcN1JiuTk6P9dA5fYU6Ki4tRIUGn6D/j5TbTtH0s
	s9d6FtlghhBQKwi7dSi6jpFbTV/x070=
X-Google-Smtp-Source: AK7set/DXCNTRBacqfL4pq64u4WKHzaf12hD5YJU6WnA+DlBf7Va0SaRjGh1g5g5mKcxUaj8hZ6yMQ==
X-Received: by 2002:a05:600c:1e20:b0:3eb:376e:2bb7 with SMTP id ay32-20020a05600c1e2000b003eb376e2bb7mr20697488wmb.3.1678968774658;
        Thu, 16 Mar 2023 05:12:54 -0700 (PDT)
Received: from work-pc.core.sigfox.net ([2a01:e0a:8d5:c6c0:65ad:993a:17fa:6608])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003e8dcc67bdesm5039971wms.30.2023.03.16.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:12:54 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [PATCH 1/3] cargo-update-recipe-crates: generate checksum for each crates
Date: Thu, 16 Mar 2023 13:12:47 +0100
Message-Id: <20230316121249.28209-1-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 12:13:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14584

From: Frederic Martinsons <frederic.martinsons@gmail.com>

This is related to checksum verification introduction from
https://patchwork.yoctoproject.org/project/bitbake/patch/20230315131513.50635-1-frederic.martinsons@gmail.com/

I also choose to raise an exception if:
 - no crates can be found
 - no Cargo.lock file exist

Otherwise the generated inc file will silently be emptied.

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 .../cargo-update-recipe-crates.bbclass        | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/meta/classes-recipe/cargo-update-recipe-crates.bbclass b/meta/classes-recipe/cargo-update-recipe-crates.bbclass
index 697460d215..daa363b0dd 100644
--- a/meta/classes-recipe/cargo-update-recipe-crates.bbclass
+++ b/meta/classes-recipe/cargo-update-recipe-crates.bbclass
@@ -16,11 +16,14 @@
 addtask do_update_crates after do_patch
 do_update_crates[depends] = "python3-native:do_populate_sysroot"
 do_update_crates[nostamp] = "1"
+do_update_crates[doc] = "Update the recipe by reading Cargo.lock and write in ${THISDIR}/${BPN}-crates.inc"
 
 # The directory where to search for Cargo.lock files
 CARGO_LOCK_SRC_DIR ??= "${S}"
 
 do_update_crates() {
+    TARGET_FILE="${THISDIR}/${BPN}-crates.inc"
+
     nativepython3 - <<EOF
 
 def get_crates(f):
@@ -28,19 +31,52 @@ def get_crates(f):
     c_list = '# from %s' % os.path.relpath(f, '${CARGO_LOCK_SRC_DIR}')
     c_list += '\nSRC_URI += " \\\'
     crates = tomllib.load(open(f, 'rb'))
-    for c in crates['package']:
-        if 'source' in c and 'crates.io' in c['source']:
+
+    # Build a list with crates info that have crates.io in the source
+    crates_candidates = list(filter(lambda c: 'crates.io' in c.get('source', ''), crates['package']))
+
+    if not crates_candidates:
+        raise ValueError("Unable to find any candidate crates that use crates.io")
+
+    # Build a list of crates name that have multiple version
+    crates_multiple_vers = []
+    tmp = []
+    for c in crates_candidates:
+        if c['name'] in tmp:
+            crates_multiple_vers.append(c['name'])
+        else:
+            tmp.append(c['name'])
+
+    # Update crates uri and their checksum, to avoid name clashing on the checksum
+    # we need to rename crates of the same name but different version
+    cksum_list = ''
+    for c in crates_candidates:
+        if c['name'] in crates_multiple_vers:
+            rename = "%s-%s" % (c['name'], c['version'])
+            c_list += '\n    crate://crates.io/%s/%s;name=%s \\\' % (c['name'], c['version'], rename)
+        else:
+            rename = c['name']
             c_list += '\n    crate://crates.io/%s/%s \\\' % (c['name'], c['version'])
+        if 'checksum' in c:
+            cksum_list += '\nSRC_URI[%s.sha256sum] = "%s"' % (rename, c['checksum'])
+
     c_list += '\n"\n'
+    c_list += cksum_list
+    c_list += '\n'
     return c_list
 
 import os
 crates = "# Autogenerated with 'bitbake -c update_crates ${PN}'\n\n"
+found = False
 for root, dirs, files in os.walk('${CARGO_LOCK_SRC_DIR}'):
     for file in files:
         if file == 'Cargo.lock':
             crates += get_crates(os.path.join(root, file))
-open(os.path.join('${THISDIR}', '${BPN}'+"-crates.inc"), 'w').write(crates)
-
+            found = True
+if not found:
+    raise ValueError("Unable to find Cargo.lock in ${CARGO_LOCK_SRC_DIR}")
+open("${TARGET_FILE}", 'w').write(crates)
 EOF
+
+    bbnote "Successfully update crates inside '${TARGET_FILE}'"
 }
-- 
2.34.1


