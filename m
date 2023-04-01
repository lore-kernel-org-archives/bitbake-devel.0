Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB8C76196
	for <webhook@archiver.kernel.org>; Sat,  1 Apr 2023 15:21:19 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.23648.1680362470582773504
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Apr 2023 08:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=dB/mnTAc;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id e18so25194009wra.9
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Apr 2023 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680362469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/kfpD2nIthkdkLxMm9aFPHPddEwAuRGeaz4Y2MmK+0=;
        b=dB/mnTAcsiAcmfCAcMmh6HEgVeOmwc/ky9cGopzTiaBpTIXgNhtFRAX44MKafDTSqi
         +M79D4017c9KMqHXE3+0T6tC7/nxfqLiyCSkeboI0X/l7gkWkOKcwmYS94oSooNGR703
         4vBjHYzoL31Mx+Ru3SCi0U+jdzQ/A7i6c2VSjE48FaBJq51tw9UCQkVtjBw7/DxxLXgU
         a9ahjfUgn1wKCVkD1nWXS5sPExlijOZQSxySYE0AaTf4dJ5cvzeDEg+ZDz2algZ4g3Vc
         gjzXNZ0DEdrIyCew4j/FDCLxdru5eQk3VPc27WGcqTWMLCtGth6XE8uc0V/YW8/CaSL1
         s2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680362469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/kfpD2nIthkdkLxMm9aFPHPddEwAuRGeaz4Y2MmK+0=;
        b=XwXd5BqOuSt6JGxeE9k5N4799Ieb2NQWmt4tJIjwU7m3Vgb/hQ35O/zfS2qQ8VZzGG
         ibSm6RZXp8STNVTJ1rkBVZMY8gCiFcGh2/30R5OOxpJ/ox8Npz7vpN9l/Ocu4E0G2ihM
         jCfKroQXj8rLa9bFEHanax73rf2oRTILtrtXbkctgAoiJ/GUGpQQ6TQ4yjsm8WzKUcGZ
         ms9LV1lCFgDibvrgT4yI5e5RAHo9R8H/DJlm6DIEXelFCCoZYSHM1Qf3KUKPCkogMw7j
         DeJLb/NeGFl1KWAg1Qv+g0T4oro4vDau3VPCT8+lXnh8EyJj4ALwBXmb4AH2ORo6bIdT
         1Icw==
X-Gm-Message-State: AAQBX9cehEbp9q9/NkETA9f4c+T+5vcm0U22xS9TCotu5LXQYE/2rPwr
	xv8bbffavtEal44fKoLTJNVXzkB58JA=
X-Google-Smtp-Source: AKy350YzgBIKjifmhytffdaJLkDoqvLzQ900Ne3zYLy3t6xx5JPOzJmjsspNBOu28Msfcxt5V/glMg==
X-Received: by 2002:adf:f852:0:b0:2cf:efc7:19ad with SMTP id d18-20020adff852000000b002cfefc719admr21726672wrq.53.1680362468589;
        Sat, 01 Apr 2023 08:21:08 -0700 (PDT)
Received: from work-pc.. ([2a01:e0a:8d5:c6c0:b18f:6443:9f2a:ffc7])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c224e00b003ef5f77901dsm6288232wmm.45.2023.04.01.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:21:07 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: martin.jansa@gmail.com,
	Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [PATCH] fetch2: Display all missing checksum at once
Date: Sat,  1 Apr 2023 17:21:01 +0200
Message-Id: <20230401152101.19037-1-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Apr 2023 15:21:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14629

From: Frederic Martinsons <frederic.martinsons@gmail.com>

Instead of only display the first and stop.
For recipe (crago based) that can contains several artifacts
to fetch with their checksum, it will particularly handy
to display all of missing one.

An example of error message would be

NOTE: Executing Tasks
ERROR: zvariant-3.12.0-r0 do_fetch: Missing SRC_URI checksum, please add those to the recipe:
SRC_URI[anyhow-1.0.70.sha256sum] = "7de8ce5e0f9f8d88245311066a578d72b7af3e7088f32783804676302df237e4"
SRC_URI[chrono-0.4.24.sha256sum] = "4e3c5919066adf22df73762e50cffcde3a758f2a848b113b586d1f86728b673b"
SRC_URI[serde-1.0.158.sha256sum] = "771d4d9c4163ee138805e12c710dd365e4f44be8be0503cb1bb9eb989425d9c9"
SRC_URI[system-deps-1.3.2.sha256sum] = "0f3ecc17269a19353b3558b313bba738b25d82993e30d62a18406a24aba4649b"
ERROR: zvariant-3.12.0-r0 do_fetch: Bitbake Fetcher Error: BBFetchException('There was some missing checksums in the recipe')
ERROR: Logfile of failure stored in: /home/jenkins/yocto-poky-master/poky/build/tmp/work/core2-64-poky-linux/zvariant/3.12.0-r0/temp/log.do_fetch.1025
ERROR: Task (/home/jenkins/yocto-poky-master/poky/meta-selftest/recipes-extended/zvariant/zvariant_3.12.0.bb:do_fetch) failed with exit code '1'

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 lib/bb/fetch2/__init__.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 31729885..1a86d8fd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -560,7 +560,6 @@ def verify_checksum(ud, d, precomputed={}, localpath=None, fatal_nochecksum=True
     file against those in the recipe each time, rather than only after
     downloading. See https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571.
     """
-
     if ud.ignore_checksums or not ud.method.supports_checksum(ud):
         return {}
 
@@ -605,11 +604,7 @@ def verify_checksum(ud, d, precomputed={}, localpath=None, fatal_nochecksum=True
 
         # If strict checking enabled and neither sum defined, raise error
         if strict == "1":
-            messages.append("No checksum specified for '%s', please add at " \
-                            "least one to the recipe:" % ud.localpath)
-            messages.extend(checksum_lines)
-            logger.error("\n".join(messages))
-            raise NoChecksumError("Missing SRC_URI checksum", ud.url)
+            raise NoChecksumError("\n".join(checksum_lines))
 
         bb.event.fire(MissingChecksumEvent(ud.url, **checksum_event), d)
 
@@ -1728,6 +1723,7 @@ class Fetch(object):
         network = self.d.getVar("BB_NO_NETWORK")
         premirroronly = bb.utils.to_boolean(self.d.getVar("BB_FETCH_PREMIRRORONLY"))
 
+        checksum_missing_messages = []
         for u in urls:
             ud = self.ud[u]
             ud.setup_localpath(self.d)
@@ -1739,7 +1735,6 @@ class Fetch(object):
 
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
-
                 if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
                     done = True
                 elif m.try_premirror(ud, self.d):
@@ -1811,13 +1806,20 @@ class Fetch(object):
                     raise ChecksumError("Stale Error Detected")
 
             except BBFetchException as e:
-                if isinstance(e, ChecksumError):
+                if isinstance(e, NoChecksumError):
+                    (message, _) = e.args
+                    checksum_missing_messages.append(message)
+                    continue
+                elif isinstance(e, ChecksumError):
                     logger.error("Checksum failure fetching %s" % u)
                 raise
 
             finally:
                 if ud.lockfile:
                     bb.utils.unlockfile(lf)
+        if checksum_missing_messages:
+            logger.error("Missing SRC_URI checksum, please add those to the recipe: \n%s", "\n".join(checksum_missing_messages))
+            raise BBFetchException("There was some missing checksums in the recipe")
 
     def checkstatus(self, urls=None):
         """
-- 
2.34.1


