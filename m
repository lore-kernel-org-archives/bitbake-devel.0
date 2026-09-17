Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E324C982DF
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:21 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1874.1789683435102233444
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=QVmfTxjn;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso521725e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683433; x=1790288233; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4p06dazv7lsL4h5jv8LyDYtG4pQpyAhvuN7/g1+0Gi8=;
        b=QVmfTxjn7Yd7gr155Vgz+5JtYcmUmYoTmM8IGpTEq2/hADvE1XGCuj4NmVxDPD+FAa
         /wuqqe4uDJSIvedcvJFE65kWwiEncoIMryLxJYHBYCE9VMkJmGfGqg7Rv54n+T+XKyEj
         wizSOB6Qm+3XWdlQ5htN47CNXALcf5SHI9p8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683433; x=1790288233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4p06dazv7lsL4h5jv8LyDYtG4pQpyAhvuN7/g1+0Gi8=;
        b=NPcKzTqGI8RGra5x1fQAQ5mNx9O4BF3nMA4qg6Ffcpgg8b06iMtxTDAb+DmPhgdPEH
         SiClmWOOR/4ZfdwRQLMyTyn/UWyyK9hUn/OELLnxlLDqdEe0ZqcoxwURUtOhTpU04IUS
         fvJ5iNQnMCSuIRcnJ2UL4CxY2v+4V+1fVE4wunlXqKIC23NPWB09h7HfHCEgtWC2xxwY
         IjLThl5FHjrQZvnBwP7n9AKnxhyz0vx30MD7rPIWMpwu3YHEIbpSoz0w4GI10M2iT1vM
         urg0kpJBxm+0oncw5efRcs/nYc0FaaoEJedVb8CpNI2x+WWO+RP7/itAqXjO5nIz79GW
         /yhg==
X-Gm-Message-State: AFuF++k3kl2+5Dw5sfjtB9o63pmXkoYVDrznpToz8uW+KHDk4l2m4NdA
	6USW7EITk/WdbUwGTSu1Kt7zhpTfU6S7P5X4cSBrXiQTEwMuueavsH6+l58veelibhgcD+987z9
	Pauc56nI=
X-Gm-Gg: AYBFou3ppTSRtOMBdmsltX4cqQmITRUwgCY42NnUVaIxJIIarpyhztEPRLuGnfb5sna
	HRd6zWUnT3s4cMxQEQa2bmdTHliyVXrye3eTN/DTjmU9k86Yv6aPJRoHqSTH3eO07NgiTfZHOol
	oMhuDBK0YueFNU+C1a0m1fS5RyfD0C7Lvgi4eeyeg3yFz5Wtv6XWg4ENf6ymALLDTTkO54RFqLD
	gLvwNCtcBLoXWnqyszDSs1c/1YBeaqu67JjTlqwOFWrVaA51qKKA1cTVE31gWcZPHr6YHOYYCXw
	9DtKV4UJTXIHeUQ8x8Su1jedVYrJew0quMqzlZWh8lmGVMCsauUb+9/Ok4ZA2OiioH1bMo6xeyb
	+h5+FNFbx4BX8GDIMbHiCdGEjYD4BtPCkM6UPDVFLOWlZ8MlMnlmbHkhGgKQDPRSnTpA6kjOB8r
	NU2b8XkTurG8m2jLLv02Ey2suBRamjJnYWsFukQyuepJJQgqSzNEKUgCHBM7Yw94q4v36yI+XpM
	aaLZ9awvu3fTwGGPw88Kx840q5OZXrSzjfvmqZLf2BNBrac42ybmaXE68dVDkPz60JN4w4GO/I=
X-Received: by 2002:a05:600c:34d0:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49fc56ef520mr3417955e9.12.1789683433370;
        Thu, 17 Sep 2026 15:17:13 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 3/7] fetch2/crate.py: add filter_regex parameter to latest_versionstring
Date: Fri, 18 Sep 2026 00:17:01 +0200
Message-ID: <e4e3fb0852029da0d24084debe6f84ac1b2e3b58.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20226

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 592477f225868e227110477f52691e031903430a)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/crate.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index eb1fd5719..6133d3756 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -13,6 +13,7 @@ BitBake 'Fetch' implementation for crates.io
 import hashlib
 import json
 import os
+import re
 import subprocess
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
@@ -155,18 +156,20 @@ class Crate(Wget):
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Return the latest version available when versionsurl is the [name]/versions URL.
         """
         from functools import cmp_to_key
         json_data = json.loads(self._fetch_index(ud.versionsurl, ud, d))
         versions = [(0, i["num"], "") for i in json_data["versions"]]
+        if filter_regex:
+            versions = [v for v in versions if re.match(filter_regex, v[1])]
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
 
         return (versions[-1][1], "") if versions else ("", "")
 
-    def latest_versionstring_from_index(self, ud, d):
+    def latest_versionstring_from_index(self, ud, d, filter_regex=None):
         """
         Return the latest version available when versionsurl is a Cargo index
         file.
@@ -181,5 +184,8 @@ class Crate(Wget):
             if not data.get("yanked", False):
                 versions.append((0, data["vers"], ""))
 
+        if filter_regex:
+            versions = [v for v in versions if re.match(filter_regex, v[1])]
+
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
         return (versions[-1][1], "") if versions else ("", "")

