Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EE4C54EE9
	for <webhook@archiver.kernel.org>; Wed, 21 Sep 2022 00:59:59 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web09.1238.1663721991114141713
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 17:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=b6Ia5xBB;
 spf=pass (domain: gmail.com, ip: 209.85.210.42,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id
 t8-20020a9d5908000000b0063b41908168so2922698oth.8
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 17:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NHyxI5ppdFEk4ZX84Nsu6GAGCm8UPVK23VJDDC9qNqA=;
        b=b6Ia5xBBIiPpVRvr4IKcMvWnNid0lJOH+lPPCYBUSAKqWfi7wYkRV9PsNUtZXnyCBP
         oyNjDd0QrR0nkuXE599wQGRW9mweFSgZx/3/EUISEOkBx2e48lfNWq33J7LiG7w3hHGw
         HHO6+LAxwg4WNG1c28cZDlrwy+C54/nVbcYi97kXrh9JtNJ3faEeJ6b9v5anvmmL4tIU
         4emufj4Qon2Wf/d9xIE1omfOAl7Cbud6Schf//O4z+U7ERNnoWMz+t0TXpCrhVc/f8YR
         Kdrv7sH9jLQYj29utoR9Yg75iqBS/77ygsi8P+7iowkZwRR5rSFmnyuje9cUYEsG9cpF
         CyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NHyxI5ppdFEk4ZX84Nsu6GAGCm8UPVK23VJDDC9qNqA=;
        b=vREUZmqbeG3FP+1XgFQ5AET9agIVwTGShjwY1GTI/jphild+GxGEKMehfN4e404nqU
         wxKtMUJU2iRa1/9dZYZFtSdo1xxB6zSkJ8XG6sQ04FIpHm54Va/fcLwvcCXIpfuyiiVe
         lF2nwmRsPlo4AA7Qh/9T++MGO3ocrjNsuHWsQ6N80PwHrP2HUkqv2ZqZXjpOqj+3PsTJ
         OmklL3nDEOeCWxE0Iyqxsww2zyxgJgFGYkyzGkP5iOKJcx+cztTyroMOJcBGevwYqPrm
         eTToOTFWRuAA90plPFBGuCTAAsqDYP7hRTjfTlKkSIGriE0Mwz3nL2xZ7KJyJGsyAEJX
         c8OQ==
X-Gm-Message-State: ACrzQf3Gj3CZB7rvsKlwTLZg2CGwO97tarP7W0R72eQnZPaD33LHZOR8
	S1GeSBOehaAVhFVM8r0O74MABjTRnY4=
X-Google-Smtp-Source: 
 AMsMyM78bACY2MYvwxyEIvTOQzP5YsGChMJgogq6iEjLk2HcG09UF2TIsUbzTCgt+J0C2SVmE0mP2A==
X-Received: by 2002:a9d:450a:0:b0:655:f46f:2bed with SMTP id
 w10-20020a9d450a000000b00655f46f2bedmr11215455ote.123.1663721990024;
        Tue, 20 Sep 2022 17:59:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2605:a601:ac3d:c100:4f37:550:d1b1:6f01])
        by smtp.gmail.com with ESMTPSA id
 r125-20020aca5d83000000b0033a11fcb23bsm616039oib.27.2022.09.20.17.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 17:59:49 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: quaresma.jose@gmail.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: Fix a few more logger debug() calls
Date: Tue, 20 Sep 2022 19:59:39 -0500
Message-Id: <20220921005939.344290-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Sep 2022 00:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13986

f68682a7 ("logging: Make bitbake logger compatible with python logger")
replaced several .debug() calls to make them comply with the standard
python logging API, but a few were missed.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py     | 24 ++++++++++++------------
 bitbake/lib/bb/cookerdata.py |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1b6ee3032cd..32a529f0f9e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -425,7 +425,7 @@ class BBCooker:
                         sock = socket.create_connection(upstream.split(":"), 5)
                         sock.close()
                     except socket.error as e:
-                        bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s" 
+                        bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
                                  % (upstream, repr(e)))
 
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
@@ -1277,15 +1277,15 @@ class BBCooker:
                                     except bb.utils.VersionStringException as vse:
                                         bb.fatal('Error parsing LAYERRECOMMENDS_%s: %s' % (c, str(vse)))
                                     if not res:
-                                        parselog.debug(3,"Layer '%s' recommends version %s of layer '%s', but version %s is currently enabled in your configuration. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, rec, layerver)
+                                        parselog.debug3("Layer '%s' recommends version %s of layer '%s', but version %s is currently enabled in your configuration. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, rec, layerver)
                                         continue
                                 else:
-                                    parselog.debug(3,"Layer '%s' recommends version %s of layer '%s', which exists in your configuration but does not specify a version. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, rec)
+                                    parselog.debug3("Layer '%s' recommends version %s of layer '%s', which exists in your configuration but does not specify a version. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, rec)
                                     continue
-                            parselog.debug(3,"Layer '%s' recommends layer '%s', so we are adding it", c, rec)
+                            parselog.debug3("Layer '%s' recommends layer '%s', so we are adding it", c, rec)
                             collection_depends[c].append(rec)
                         else:
-                            parselog.debug(3,"Layer '%s' recommends layer '%s', but this layer is not enabled in your configuration", c, rec)
+                            parselog.debug3("Layer '%s' recommends layer '%s', but this layer is not enabled in your configuration", c, rec)
 
             # Recursively work out collection priorities based on dependencies
             def calc_layer_priority(collection):
@@ -1297,7 +1297,7 @@ class BBCooker:
                         if depprio > max_depprio:
                             max_depprio = depprio
                     max_depprio += 1
-                    parselog.debug(1, "Calculated priority of layer %s as %d", collection, max_depprio)
+                    parselog.debug("Calculated priority of layer %s as %d", collection, max_depprio)
                     collection_priorities[collection] = max_depprio
 
             # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
@@ -1309,7 +1309,7 @@ class BBCooker:
                     errors = True
                     continue
                 elif regex == "":
-                    parselog.debug(1, "BBFILE_PATTERN_%s is empty" % c)
+                    parselog.debug("BBFILE_PATTERN_%s is empty" % c)
                     cre = re.compile('^NULL$')
                     errors = False
                 else:
@@ -1678,7 +1678,7 @@ class BBCooker:
         self.state = state.parsing
 
         if not self.parser.parse_next():
-            collectlog.debug(1, "parsing complete")
+            collectlog.debug("parsing complete")
             if self.parser.error:
                 raise bb.BBHandledException()
             self.show_appends_with_no_recipes()
@@ -1723,7 +1723,7 @@ class BBCooker:
 
         if 'universe' in pkgs_to_build:
             parselog.verbnote("The \"universe\" target is only intended for testing and may produce errors.")
-            parselog.debug(1, "collating packages for \"universe\"")
+            parselog.debug("collating packages for \"universe\"")
             pkgs_to_build.remove('universe')
             for mc in self.multiconfigs:
                 for t in self.recipecaches[mc].universe_target:
@@ -1836,7 +1836,7 @@ class CookerCollectFiles(object):
         """Collect all available .bb build files"""
         masked = 0
 
-        collectlog.debug(1, "collecting .bb files")
+        collectlog.debug("collecting .bb files")
 
         files = (config.getVar( "BBFILES") or "").split()
 
@@ -1923,7 +1923,7 @@ class CookerCollectFiles(object):
         bbappend = []
         for f in newfiles:
             if bbmask and bbmask_compiled.search(f):
-                collectlog.debug(1, "skipping masked file %s", f)
+                collectlog.debug("skipping masked file %s", f)
                 masked += 1
                 continue
             if f.endswith('.bb'):
@@ -1931,7 +1931,7 @@ class CookerCollectFiles(object):
             elif f.endswith('.bbappend'):
                 bbappend.append(f)
             else:
-                collectlog.debug(1, "skipping %s: unknown file extension", f)
+                collectlog.debug("skipping %s: unknown file extension", f)
 
         # Build a list of .bbappend files for each .bb file
         for f in bbappend:
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 9706948ab34..8a354fed7cc 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -356,7 +356,7 @@ class CookerDataBuilder(object):
 
         layerconf = self._findLayerConf(data)
         if layerconf:
-            parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
+            parselog.debug2("Found bblayers.conf (%s)", layerconf)
             # By definition bblayers.conf is in conf/ of TOPDIR.
             # We may have been called with cwd somewhere else so reset TOPDIR
             data.setVar("TOPDIR", os.path.dirname(os.path.dirname(layerconf)))
@@ -384,7 +384,7 @@ class CookerDataBuilder(object):
                 raise bb.BBHandledException()
 
             for layer in layers:
-                parselog.debug(2, "Adding layer %s", layer)
+                parselog.debug2("Adding layer %s", layer)
                 if 'HOME' in approved and '~' in layer:
                     layer = os.path.expanduser(layer)
                 if layer.endswith('/'):
-- 
2.31.1


