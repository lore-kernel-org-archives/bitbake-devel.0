Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA880C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 13:43:45 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.5775.1660139023504136489
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:43:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CqUWmtea;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id ay12so5004636wmb.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=v0UY2WKrjXoHCGp3G7AZCm4u3PovMkmNFKUD9ciWXLg=;
        b=CqUWmteamYhJki2xZ7b2QXYxsYgZplhl1AlvBXKdVARpgG5Klpc//UsxLu2UzrWucr
         D3RAFgx94L2p35KrS8OEeWD8gwaeiaO9J2SpF7H4EGd+hiHaOoUslSOV0Y5gwG2v4P0G
         yaKXEWL4WzSIGBNKnBFOyv41g98HvjGeoYNjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=v0UY2WKrjXoHCGp3G7AZCm4u3PovMkmNFKUD9ciWXLg=;
        b=y0AWikY+V7RJqaC6SKkT6GxB3CR9NqkCL8C3r19LVmeI/4/g6NsKEWCTP3b1GhuqBX
         mnz7Fe7DGLpr2Yuz6oFQVfxoQXpKe5JPbjjBOmwLNChbFxiAUORifusvHXB//EX12Jhu
         9m/I9DqzrtdYrv6Jl056xwDYYiBD37n2SIOniU8CgAXA4E1XMij8XcXuN4srL3TEpbt4
         uG85g4LpYHRvxWRnO7TSKQ3sgwmGhChoPHdDlbXEd5OrooSwbasLp9MdtsIjPPi7RUGO
         iGb6XQjAXdNvnNJzEVuiPkSBSzCbShiRgecqp8vh4FFUetkGWhNp8sJirpCjaEFjia0w
         m/Hg==
X-Gm-Message-State: ACgBeo0XgoIclshFqLOvNPr5Z+5nXBrI5jtQN0GqJP9mHU8ZgZAM8WN/
	sfSdBxWC7m76951p2jkrX3Opp5qZfAzVew==
X-Google-Smtp-Source: 
 AA6agR5KGXcHWIzdKX3dJKKPyUXpskmr1ci9umVZQapjZ+uWbR5U4JLm/Lkd+d4hzhjPiTIl5ZgnhQ==
X-Received: by 2002:a7b:ca58:0:b0:3a5:3c1c:6d71 with SMTP id
 m24-20020a7bca58000000b003a53c1c6d71mr2592613wml.118.1660139021760;
        Wed, 10 Aug 2022 06:43:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c154800b003a540fef440sm2917768wmg.1.2022.08.10.06.43.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:43:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] BBHandler/cooker: Implement recipe and global classes
Date: Wed, 10 Aug 2022 14:43:37 +0100
Message-Id: <20220810134337.420149-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
References: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 13:43:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13882

We have some confusion for users since some classes are meant to work
in the configuration space (or "globally") and some are meant to be
selected by recipes individually.

The cleanest way I could find to clarify this is to create "classes-global"
and "classes-recipe" directories which contain the approproate classes and
have bitbake switch scope between them at the appropriate point during
parsing. The existing "classes" directory is always searched as a fallback.

Once a class is moved to a specific directory, it will no longer be found
in the incorrect context. A good example from OE is that

INHERIT += "testimage"

will no longer work but

IMAGE_CLASSES += "testimage"

will, which makes the global scope cleaner by only including it where it
is useful and intended to be used (images).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py                   |  1 +
 lib/bb/cookerdata.py               |  2 ++
 lib/bb/parse/parse_py/BBHandler.py | 29 ++++++++++++++++++-----------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2adf4d297d..1b6ee3032c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -402,6 +402,7 @@ class BBCooker:
         for mc in self.databuilder.mcdata.values():
             mc.renameVar("__depends", "__base_depends")
             self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
+            mc.setVar("__bbclasstype", "recipe")
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d54ac932e5..b3a171509b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -254,6 +254,7 @@ class CookerDataBuilder(object):
         filtered_keys = bb.utils.approved_variables()
         bb.data.inheritFromOS(self.basedata, self.savedenv, filtered_keys)
         self.basedata.setVar("BB_ORIGENV", self.savedenv)
+        self.basedata.setVar("__bbclasstype", "global")
 
         if worker:
             self.basedata.setVar("BB_WORKERCONTEXT", "1")
@@ -448,6 +449,7 @@ class CookerDataBuilder(object):
 
         # Handle any INHERITs and inherit the base class
         bbclasses  = ["base"] + (data.getVar('INHERIT') or "").split()
+        bb.warn(str(bbclasses))
         for bbclass in bbclasses:
             data = _inherit(bbclass, data)
 
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 1189114341..18e6868387 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -44,17 +44,24 @@ def inherit(files, fn, lineno, d):
     __inherit_cache = d.getVar('__inherit_cache', False) or []
     files = d.expand(files).split()
     for file in files:
-        if not os.path.isabs(file) and not file.endswith(".bbclass"):
-            file = os.path.join('classes', '%s.bbclass' % file)
-
-        if not os.path.isabs(file):
-            bbpath = d.getVar("BBPATH")
-            abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
-            for af in attempts:
-                if af != abs_fn:
-                    bb.parse.mark_dependency(d, af)
-            if abs_fn:
-                file = abs_fn
+        classtype = d.getVar("__bbclasstype", False)
+        origfile = file
+        for t in ["classes-" + classtype, "classes"]:
+            file = origfile
+            if not os.path.isabs(file) and not file.endswith(".bbclass"):
+                file = os.path.join(t, '%s.bbclass' % file)
+
+            if not os.path.isabs(file):
+                bbpath = d.getVar("BBPATH")
+                abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
+                for af in attempts:
+                    if af != abs_fn:
+                        bb.parse.mark_dependency(d, af)
+                if abs_fn:
+                    file = abs_fn
+
+            if os.path.exists(file):
+                break
 
         if not os.path.exists(file):
             raise ParseError("Could not inherit file %s" % (file), fn, lineno)
-- 
2.34.1


