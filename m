Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F3810F3DC8
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 13:56:40 +0000 (UTC)
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51887.1774878906414347544
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 06:55:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=cESkewUf;
 spf=pass (domain: qbee.io, ip: 209.85.167.66, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so1053896e87.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1774878904; x=1775483704; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+HyFQTtqgOJKmweCRC/Rqjm1sYUk9gMXobc9DPYYXA=;
        b=cESkewUfnWeJ61XVjOCW2emsBJLtbUJF4NF+z4hDFz3TzxWMuNdx2CA0Fw4Z1jE6FJ
         Ua6Py7sewg7qkkOhClN363IuhAje8rGtvzWUcVABblK+cESPZTpGNJjA6NAmvoojiJPA
         SaeJY/L5gmFfGoVtPWMcPFqfgih/7rqM11/PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878904; x=1775483704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+HyFQTtqgOJKmweCRC/Rqjm1sYUk9gMXobc9DPYYXA=;
        b=OpA4qeyQZkPhJBVpc0TzZUgk6q7FPefo/CZ+MTfNNfeJIp5P7UckPqTNEiAEw1eiK7
         7n9apNY4d4DiDOUsIFdHe7iYDCmm5WmnfrSOseH/zS81QsOkIl7pXUW5H6hZVIVsJBxA
         1V6L4drn4gVqkw2Hsh+jujKdlWWMBjvaV2BOOpbbN9qeAuiZe7jpzCpqiytB0+7FjtHe
         C88d05kosSfTmhK8Lj9VfBFZUUFWqDX+PNx1ya8Ngfxa3auuIK2Ne5chpyujwLW0Xy0e
         TBDMbN0jmIkiSc/DXJNbYNl6NWxpOPUL9HOf4ufi9NDVZlCEjKmNNnY4JJhcKnHYSQ/s
         nFQQ==
X-Gm-Message-State: AOJu0Ywy0NQKIBPKlmnDn+tzhGlR0u6ZdBqQ3EcasG4wYsHqlv7g96X+
	yVLWlLm+NzLBEUrrZBfFqTL46tulKU/qRy7NwtGMjPNaFycjXaJ55vJy9RDwhk5/Xfdqjvj8fC7
	s95hQAUoskZ1f
X-Gm-Gg: ATEYQzyjVjoTBLrSFk0Rm+JBzcKLLsELwwbrbsf7HaaUackCEraM8q8dXhjfFJts5IF
	whYoPvfUnShqeAmfvqOfOpuUSDhOihZhmsHNLeAi+ozWVFN5GJ51YZKfsS0bKUUlfaRlij6nPvp
	uJHMpOzThAo1Dsi+4NYPcu3jAWGRxwpUWGwCVzDO2y+gPIBwJx2rL+NdWcmBk4gVLlu2Ez/8/+s
	O9TeNBy2hxg5cjZiPTbiOx2uOtwE+F4j1pAmh8whzX9eIP4Gvv815ndvQhr//xg8/kCBZ60qLUN
	rMR0mDjReNh5uw3FAHvrNutRaof/T7dymg+UkDO3hluHFfh8qjHKbqsvBMsdjxMPuxg0q7SScaV
	X0AbSwg7WUCk7C4Qa9Sb6P1Zyb91jm2TurifxSw5UnOLIdkGMCaizolo+vN2Pqiwbk87XickA+E
	WRaDMLGn3T56IHTET3kFJ3+DrOF5W3artZdJ9szEcX8NQ11gwMdUTH
X-Received: by 2002:a05:6512:6d5:b0:5a2:7865:3672 with SMTP id 2adb3069b0e04-5a2ab920700mr4575951e87.28.1774878904112;
        Mon, 30 Mar 2026 06:55:04 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5a2b13f4329sm1667694e87.3.2026.03.30.06.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 06:55:03 -0700 (PDT)
From: =?UTF-8?B?UGlvdHIgQnVsacWEc2tp?= <piotr@qbee.io>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindexlib] Prevent loading unnecessary resources from layerindex-web
Date: Mon, 30 Mar 2026 15:54:48 +0200
Message-ID: <20260330135449.29161-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 13:56:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19281

When I was using `bitbake-layers layerindex-fetch ...` I noticed it being quite
slow. Upon further investigation, I found that the call to `load_layerindex()`
inside layerindexlib was called with the deafult `load` argument.

The deafault was set to ['layerDependencies', 'recipes', 'machines', 'distros']
where the `layerindex-fetch` effectively requires only ['layerDependencies'].

So whenever a `layerindex-fetch` is used, we pull for example 'recipes', which
is about 18-20MB in size - it takes time to produce that response by the
layerindex-web and ship over the internet, just to be discarded.

This change addresses the issue by setting a "sane" default (empty `load` list)
and sets a correct, explicit `load` list whenever it's needed (e.g. toaster)
by the caller.

Lastly, there seems to be an error when the cooker index is loaded in the
process with the `load='layerDependencies'`, that's incorrect, as the
implementation expects also a list, so that's corrected as well.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 lib/bblayers/layerindex.py                       | 4 ++--
 lib/layerindexlib/__init__.py                    | 6 +++---
 lib/toaster/orm/management/commands/lsupdates.py | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 308a5532d..2ba1103a3 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -116,7 +116,7 @@ class LayerIndexPlugin(ActionPlugin):
 
         # Load the cooker DB
         cookerIndex = layerindexlib.LayerIndex(self.tinfoil.config_data)
-        cookerIndex.load_layerindex('cooker://', load='layerDependencies')
+        cookerIndex.load_layerindex('cooker://', load=['layerDependencies'])
 
         # Fast path, check if we already have what has been requested!
         (dependencies, invalidnames) = cookerIndex.find_dependencies(names=args.layername, ignores=ignore_layers)
@@ -137,7 +137,7 @@ class LayerIndexPlugin(ActionPlugin):
 
             for remoteurl in _construct_url(apiurl, branches):
                 logger.plain("Loading %s..." % remoteurl)
-                remoteIndex.load_layerindex(remoteurl)
+                remoteIndex.load_layerindex(remoteurl, load=['layerDependencies'])
 
             if remoteIndex.is_empty():
                 logger.error("Remote layer index %s is empty for branches %s" % (apiurl, branches))
diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index c3265ddaa..e693e5c11 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -174,15 +174,15 @@ class LayerIndex():
         return res
 
 
-    def load_layerindex(self, indexURI, load=['layerDependencies', 'recipes', 'machines', 'distros'], reload=False):
+    def load_layerindex(self, indexURI, load=[], reload=False):
         '''Load the layerindex.
 
            indexURI - An index to load.  (Use multiple calls to load multiple indexes)
 
            reload - If reload is True, then any previously loaded indexes will be forgotten.
 
-           load - List of elements to load.  Default loads all items.
-                  Note: plugs may ignore this.
+           load - List of elements to load. By default, an empty list is used to keep things lean.
+                  Callers need to specify a minimal set of elements to load, such as ['layerDependencies'] for dependency resolution.
 
 The format of the indexURI:
 
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 0ee00aa15..153b26f60 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -105,7 +105,8 @@ class Command(BaseCommand):
             url_branches = ";branch=%s" % ','.join(allowed_branch_names)
         else:
             url_branches = ""
-        layerindex.load_layerindex("%s%s" % (self.apiurl, url_branches))
+        layerindex.load_layerindex("%s%s" % (self.apiurl, url_branches),
+                                   load=['layerDependencies', 'recipes', 'machines', 'distros'])
 
         http_progress.stop()
 

