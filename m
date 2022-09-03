Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F01C54EE9
	for <webhook@archiver.kernel.org>; Sat,  3 Sep 2022 11:59:08 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.2359.1662206346446362531
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Sep 2022 04:59:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iEmoW00A;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id c11so1098837wrp.11
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Sep 2022 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=/EEXQMoHNZEjb8d5RWYNtiqJI47rFqJ8880rsvCw8/Q=;
        b=iEmoW00A+g26bDaaiHl6Xca/BJZJ5zED7i0CFWGcbcxpetAnBL9oLkfkGc/rf/Seny
         lLv8AltI4GyR5TJWVHieOC4wKDQ36o0uB7EHfhvGI5YrlLZXbpnMcpcNKSdmNAdv57q4
         DKmYLL/cvrhuaat9xeUmp8eibAUHtTAWk/Nwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=/EEXQMoHNZEjb8d5RWYNtiqJI47rFqJ8880rsvCw8/Q=;
        b=bRoMHGnfEMII1zxXNVE8MGQAsp/zRKLofkS8XTaHKLA4ZMV1FxdxTPeW1bofTPhju3
         RYgJQ3fca9gvH3kb1JB1bhaGv075/Yiq5sWIv9LSxFLqLOMeXtvq1Lh7UZ325qPQFI7i
         Knra4Uqiqpl01TXDmxKagoMdz3kAyYa1oqjBJUMw7pzZ16PljYhABZtD0ho5TBwO6shX
         2Vupj7bWlsT7pwsYSwOBKx1Y6UxB7r5jwx1rfrZY+sTOzQ958eTdGZy6u1sL+ELAFGbW
         EelSo3n0eVNnMVc9MdkScT5el5Yfl8C7fFTzmAHne35e4fjp0A2iOSjeXYdC3IfCh3SC
         vJoQ==
X-Gm-Message-State: ACgBeo1TVl+Z7jArXR6hHm6HUR1bB47iPIkE4JF8xrUHd2v9LTpDPdm8
	I4kKPAO6JGbHCE9MHFmK1Ckvv78yyEHBeg==
X-Google-Smtp-Source: 
 AA6agR7xRSCKNR77rx6IdDDgfTH0hPvG8CBU977Ur2RFfpP/Sr3HnH+9+uoSfDcqLtuDVjw/QEnrOg==
X-Received: by 2002:a5d:6c6a:0:b0:225:6138:5b9d with SMTP id
 r10-20020a5d6c6a000000b0022561385b9dmr19877849wrz.451.1662206344340;
        Sat, 03 Sep 2022 04:59:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b434:62b3:32b4:c2b0])
        by smtp.gmail.com with ESMTPSA id
 s8-20020a1cf208000000b003a83fda1dc5sm4844753wmc.44.2022.09.03.04.59.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 04:59:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] wget: Avoid bad checksum race issues
Date: Sat,  3 Sep 2022 12:59:00 +0100
Message-Id: <20220903115901.377912-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 03 Sep 2022 11:59:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13955

If two recipes have conflicting checksums for a file, the code will currently
remove the existing file when a mismatch is downloaded, even if another task
successfully fetched it.

This changes the code to verify the checksum (if possible) before replacing
the file. This removes a potential race window and stops builds failing
everywhere from one incorrect checksum.

To make this work, we need to be able to override localpath and avoid
NoChecksum errors being logged.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 11 +++++++----
 lib/bb/fetch2/wget.py     |  5 +++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0fb718b23e..e6dd79c4aa 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -545,7 +545,7 @@ def mirror_from_string(data):
         bb.warn('Invalid mirror data %s, should have paired members.' % data)
     return list(zip(*[iter(mirrors)]*2))
 
-def verify_checksum(ud, d, precomputed={}):
+def verify_checksum(ud, d, precomputed={}, localpath=None, fatal_nochecksum=True):
     """
     verify the MD5 and SHA256 checksum for downloaded src
 
@@ -563,13 +563,16 @@ def verify_checksum(ud, d, precomputed={}):
     if ud.ignore_checksums or not ud.method.supports_checksum(ud):
         return {}
 
+    if localpath is None:
+        localpath = ud.localpath
+
     def compute_checksum_info(checksum_id):
         checksum_name = getattr(ud, "%s_name" % checksum_id)
 
         if checksum_id in precomputed:
             checksum_data = precomputed[checksum_id]
         else:
-            checksum_data = getattr(bb.utils, "%s_file" % checksum_id)(ud.localpath)
+            checksum_data = getattr(bb.utils, "%s_file" % checksum_id)(localpath)
 
         checksum_expected = getattr(ud, "%s_expected" % checksum_id)
 
@@ -595,7 +598,7 @@ def verify_checksum(ud, d, precomputed={}):
             checksum_lines = ["SRC_URI[%s] = \"%s\"" % (ci["name"], ci["data"])]
 
     # If no checksum has been provided
-    if ud.method.recommends_checksum(ud) and all(ci["expected"] is None for ci in checksum_infos):
+    if fatal_nochecksum and ud.method.recommends_checksum(ud) and all(ci["expected"] is None for ci in checksum_infos):
         messages = []
         strict = d.getVar("BB_STRICT_CHECKSUM") or "0"
 
@@ -627,7 +630,7 @@ def verify_checksum(ud, d, precomputed={}):
     for ci in checksum_infos:
         if ci["expected"] and ci["expected"] != ci["data"]:
             messages.append("File: '%s' has %s checksum '%s' when '%s' was " \
-                            "expected" % (ud.localpath, ci["id"], ci["data"], ci["expected"]))
+                            "expected" % (localpath, ci["id"], ci["data"], ci["expected"]))
             bad_checksum = ci["data"]
 
     if bad_checksum:
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index b2b542e1dc..821afa5b58 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -132,6 +132,11 @@ class Wget(FetchMethod):
 
         self._runwget(ud, d, fetchcmd, False)
 
+        # Try and verify any checksum now, meaning if it isn't correct, we don't remove the
+        # original file, which might be a race (imagine two recipes referencing the same
+        # source, one with an incorrect checksum)
+        bb.fetch2.verify_checksum(ud, d, localpath=localpath, fatal_nochecksum=False)
+
         # Remove the ".tmp" and move the file into position atomically
         # Our lock prevents multiple writers but mirroring code may grab incomplete files
         os.rename(localpath, localpath[:-4])
-- 
2.34.1


