Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1002DC433F5
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 16:25:54 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.539.1636820752639588733
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 08:25:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WEbSyVEk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id t30so21229350wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9dNgO6nlPWjeZcFuExlEOEXXvjJkhYSWVl+vALymf+c=;
        b=WEbSyVEk9XP5wrmKFjwjRyWKmghXtDBcX76Bqra6E5lI42SPnDU5Wz+fZhijnoMY+J
         S+aDuWU1XTTTQJbiQs9zHzZWH8DpCe5fEp47GnEGMPqCGvky0dHdersI6ioFf4uafD1x
         jj/tds3PhaqHaZbPPIRZrV3FTr7uID7WMMMuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dNgO6nlPWjeZcFuExlEOEXXvjJkhYSWVl+vALymf+c=;
        b=NDYPOaQwn2toxtXxPeqsunlfgz1uy4mbkTY3Ze64/Hb7GtCveE/yMIoWZOFlG36iFm
         LIy1boyvphMyTWMI29AGjmnA8bI7l9kjJhZLA+lBIF39vBMZjeCBTBUYzEkvb9/Zn2Aj
         FGUtSrljgj4cJWxghKaKoiPFHL05ZO9MMVqsysG+ObRVLf3X4IjSdLVMDSCrW0WshCWC
         dn5LWkDXdZUbt4icR7Mg0z1ExTBiXeaWqPEpD1fKOXwoTR/kGnATK8lTEApgLq1XsrZT
         k+0Nue6NoauBj36vaFfn0XWd6Oe6zaoVrie3ySqlz+8yUCK8M3rdcUO4eRaNqVAElXY1
         5NmQ==
X-Gm-Message-State: AOAM532PeFjWalnQg/OIVy7lXh5dVVcmnL1+2otNqrdwoGjKYWlnqkXr
	fuyewjNshzi6lz/+lXzWZICb4l/KiMvRVg==
X-Google-Smtp-Source: 
 ABdhPJwV92IS4fT+bb725ePmDHV6tMdSZwEKCNXNdXv3okbZlYQP15pWDChE9Yjy0mCHvfV9UmjpdA==
X-Received: by 2002:a05:6000:1862:: with SMTP id
 d2mr29468956wri.203.1636820751012;
        Sat, 13 Nov 2021 08:25:51 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4f1d:7b2:7d47:57f5])
        by smtp.gmail.com with ESMTPSA id
 b14sm11331714wrd.24.2021.11.13.08.25.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 08:25:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] cookerdata: Set TOPDIR explicitly and fix broke
 findTopdir()
Date: Sat, 13 Nov 2021 16:25:48 +0000
Message-Id: <20211113162549.3931833-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211113162549.3931833-1-richard.purdie@linuxfoundation.org>
References: <20211113162549.3931833-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 16:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13039

TOPDIR is set internally deep within the parser to os.getcwd(). Rather
than do that, set it explicitly if not set. Note that modern code will
almost always have a bblayers.conf file which would have already set
TOPDIR before this new code.

Also fix findTopdir since the conf/bitbake.conf codepath is just
plain incorrect, it would find build metadata, not the current
build directory that bitbake would use. Again, the use of bblayers.conf
means hitting the fallback code was unlikely.

This change makes everything clear and explicit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 592bc2968e..397b43dfa7 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -210,7 +210,7 @@ def findConfigFile(configfile, data):
 
 #
 # We search for a conf/bblayers.conf under an entry in BBPATH or in cwd working
-# up to /. If that fails, we search for a conf/bitbake.conf in BBPATH.
+# up to /. If that fails, bitbake would fall back to cwd.
 #
 
 def findTopdir():
@@ -223,11 +223,8 @@ def findTopdir():
     layerconf = findConfigFile("bblayers.conf", d)
     if layerconf:
         return os.path.dirname(os.path.dirname(layerconf))
-    if bbpath:
-        bitbakeconf = bb.utils.which(bbpath, "conf/bitbake.conf")
-        if bitbakeconf:
-            return os.path.dirname(os.path.dirname(bitbakeconf))
-    return None
+
+    return os.path.abspath(os.getcwd())
 
 class CookerDataBuilder(object):
 
@@ -417,6 +414,9 @@ class CookerDataBuilder(object):
                         " invoked bitbake from the wrong directory?")
             raise SystemExit(msg)
 
+        if not data.getVar("TOPDIR"):
+            data.setVar("TOPDIR", os.path.abspath(os.getcwd()))
+
         data = parse_config_file(os.path.join("conf", "bitbake.conf"), data)
 
         # Parse files for loading *after* bitbake.conf and any includes
-- 
2.32.0


