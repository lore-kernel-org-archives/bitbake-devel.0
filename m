Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E545C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 11:21:35 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.5149.1657884085880378143
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Jul 2022 04:21:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C0j+O0zb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id b26so6335604wrc.2
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Jul 2022 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sh4ArDDLniMpG1XSLpPmVwuscewd49TpH6Ys3gn3b0=;
        b=C0j+O0zbY6DzQLlr5fepxVJrz2+QVAQm6Wm9g7c2d+Z816OzLWePmBPxTRMDAGN3SI
         0OuynkTiJc57PSScuayKJyRy+N7XX7G569LLutMXapLUdPty8acp9tmUnc6WlDDCgZIw
         1AN7SP3z4Ix+z//ONyR8QxKaALDAKS9CRBdLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sh4ArDDLniMpG1XSLpPmVwuscewd49TpH6Ys3gn3b0=;
        b=PZBPxccPlvWC7lPo0VF7hUAzQE6i9ZEZzYKvDw3V0VcvM0d+RMxqnyS593eoZc2Qo2
         9wP10BtMuBSRq21h9SMeEIKiznEZNwrG+cfpljrRdq4z7uuEVt5lNb7rmnGxjACPUl1v
         pURei7/pzUp+VJ1FEoXCumrCWtr6VU4/pY/e9T+dRRI6tXjtLTR//Rr3tC1pg8ixr9lV
         jD+UxU0y4Unh5zA/UcWAYZDmPOJJXh3bmxiFQ9+T2eR+EqceLGtpDam7CLDmFbjDjysY
         mVZIHTEVCf+irPWkuu9hcIFvpqxA9ATy185BoV5MHo3nm/t8aoTknqgCK87ScyxYa/vI
         q7Nw==
X-Gm-Message-State: AJIora/awHa5M66ZxDP5SN+tgmPjN9wLn14/y9VheBDm3bNrz4vfjTYZ
	1Cy/LDM42gu6Mb30xu+9LdSXHIKIuenGQg==
X-Google-Smtp-Source: 
 AGRyM1s00SZIMbeVKTUZAmm1k1RrK9e84y2d4X5clcSsPAx3rZJcq1Y/wpb0jcpWuxn5nJoRjsUe+A==
X-Received: by 2002:adf:e40a:0:b0:21d:aa00:a48 with SMTP id
 g10-20020adfe40a000000b0021daa000a48mr11687561wrm.158.1657884083702;
        Fri, 15 Jul 2022 04:21:23 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ef6a:f831:81f1:d696])
        by smtp.gmail.com with ESMTPSA id
 d15-20020adffbcf000000b0020fff0ea0a3sm3628229wrs.116.2022.07.15.04.21.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:21:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2: Drop DL_DIR fallback for local file fetcher
Date: Fri, 15 Jul 2022 12:21:21 +0100
Message-Id: <20220715112122.634528-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Jul 2022 11:21:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13829

A long time ago, we made DL_DIR a final fallback for the local fetcher.
Since then we added checksum support and task hashes and the world
has changed. There were warnings added some time ago if this fallback
triggers and it is now time to drop it entirely.

The original use case was for sstate however the sstate code now sets
FILESPATH correctly so DL_DIR is no longer needed.

There have been a few small bugs exposed by this change, missing mkdir
calls and some minor test issues that needed tweaks. In general this
simplifies and improves the fetcher code flow though.

This completes a cleanup that ensures local files are correctly covered
at parse time which ensures rebuilds and reparses happen at the right
times.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 16 ++++++----------
 lib/bb/fetch2/local.py    |  8 --------
 lib/bb/tests/fetch.py     |  2 ++
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cd7dc4f132..3eda9bbe70 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1220,25 +1220,21 @@ def get_checksum_file_list(d):
     SRC_URI as a space-separated string
     """
     fetch = Fetch([], d, cache = False, localonly = True)
-
-    dl_dir = d.getVar('DL_DIR')
     filelist = []
     for u in fetch.urls:
         ud = fetch.ud[u]
-
         if ud and isinstance(ud.method, local.Local):
+            found = False
             paths = ud.method.localpaths(ud, d)
             for f in paths:
                 pth = ud.decodedurl
-                if f.startswith(dl_dir):
-                    # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
-                    if os.path.exists(f):
-                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f)))
-                    else:
-                        bb.fatal(("Unable to get checksum for %s SRC_URI entry %s: file could not be found"
+                if os.path.exists(f):
+                    found = True
+                filelist.append(f + ":" + str(os.path.exists(f)))
+            if not found:
+                bb.fatal(("Unable to get checksum for %s SRC_URI entry %s: file could not be found"
                             "\nThe following paths were searched:"
                             "\n%s") % (d.getVar('PN'), os.path.basename(f), '\n'.join(paths)))
-                filelist.append(f + ":" + str(os.path.exists(f)))
 
     return " ".join(filelist)
 
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index e7d1c8c58f..0bb987c644 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -57,12 +57,6 @@ class Local(FetchMethod):
             logger.debug2("Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
             searched.extend(hist)
-        if not os.path.exists(newpath):
-            dldirfile = os.path.join(d.getVar("DL_DIR"), path)
-            logger.debug2("Defaulting to %s for %s" % (dldirfile, path))
-            bb.utils.mkdirhier(os.path.dirname(dldirfile))
-            searched.append(dldirfile)
-            return searched
         return searched
 
     def need_update(self, ud, d):
@@ -78,8 +72,6 @@ class Local(FetchMethod):
             filespath = d.getVar('FILESPATH')
             if filespath:
                 locations = filespath.split(":")
-            locations.append(d.getVar("DL_DIR"))
-
             msg = "Unable to find file " + urldata.url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
             raise FetchError(msg)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 20d7953f35..7fcf57e7ea 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -468,6 +468,7 @@ class MirrorUriTest(FetcherTest):
                 "http://.*/.* file:///someotherpath/downloads/"
 
     def test_urireplace(self):
+        self.d.setVar("FILESPATH", ".")
         for k, v in self.replaceuris.items():
             ud = bb.fetch.FetchData(k[0], self.d)
             ud.setup_localpath(self.d)
@@ -925,6 +926,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_fetch_file_mirror_of_mirror(self):
+        self.d.setVar("FILESPATH", ".")
         self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ file:///some1where/.* file://some2where/ file://some2where/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         os.mkdir(self.dldir + "/some2where")
-- 
2.34.1


