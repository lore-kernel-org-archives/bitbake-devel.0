Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7309CD68E8
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 01:49:54 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.81378.1696902589726223844
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 18:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l82j1i6A;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: bhstalel@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso8973524a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696902588; x=1697507388; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/KFaK74zfqHAk+xxXZ9lak0HdwG2LwT278/WeQn04w=;
        b=l82j1i6AZLzIdKvFjUOE2RXmqeaWn+KcSd0VVjbNhkMIeAZAC8Hrx2VQSNwgJulCHr
         MtrO8hidfix6PAMJlNS/7DwilpIjsDiP9haqIhPgQBpPDkc99xWG0PnmEPg2IfUngPir
         vzmyg7GmX8OAaHEXNvXHOv49nc/b90S2KBB1Y7edIOx+zBnnyvgSAjxY2zAxxuDlBTO5
         vH1n0wvnF0JvGJTlevI7qEgg5y+AEcjuXEhNYL9RClbfnuy8RCRSJIxvRgiXl+6P4XAx
         eSqoTVhWfXDmMRAzIEIJAf9QOSSus1PTU9XAdjhAf+qRPyVzY9ctWaVh7Z6U2FexP6e3
         sVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696902588; x=1697507388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/KFaK74zfqHAk+xxXZ9lak0HdwG2LwT278/WeQn04w=;
        b=SQz/4j5HuIqUjijWEA3Ts0fLD6OPrbxKElSRi21oJdWS3bmCmoRo/dmUnlY1QidGTb
         1hFopOAfgUssJ2BCA/dcP+lBW+V3BQ10z5FS1ksekiNJmYYyyWvPPsgMmlLz1O5kGCQU
         OPio5a9fCDN8llIOLC6p+E1fP60kNQGKh9ACP8CxzPDbJvv7TvbmaiYvfjwPoOCpoQZ4
         nqBnTZjEFI8R0biKw/G+Fpg8xfPG+jKjeRc99ED651MefMNqv8d0PHUEeji6YcBqaBiv
         iCskRKlwAfVHb6naYG+tVY1cn2bmR7N8ERBPuRbEYAuqQE8Qe35yxPCyct+6ESztXDlI
         olOg==
X-Gm-Message-State: AOJu0Yx96R87IxAe2mh8GOhTV8gZLNSxJgR9uFhtmgFGSaNvy3r/9mvZ
	DbJVkQROPVJNb8yPnbrtEEQJfSRBCd9Jaw==
X-Google-Smtp-Source: AGHT+IHaRcwsUexDAbRZEHn4RNJGIySKOaWRoAOTBrFr45fXwcxJZbcai6f0F2aFz/E33K9cSV4Aww==
X-Received: by 2002:a17:906:30cc:b0:9a1:c447:3c62 with SMTP id b12-20020a17090630cc00b009a1c4473c62mr14678494ejb.49.1696902587712;
        Mon, 09 Oct 2023 18:49:47 -0700 (PDT)
Received: from localhost.localdomain ([197.27.71.101])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090627da00b0099b7276235esm7642009ejc.93.2023.10.09.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 18:49:47 -0700 (PDT)
From: Talel BELHAJSALEM <bhstalel@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Talel BELHAJSALEM <bhstalel@gmail.com>
Subject: [PATCH] Ensure that BBFILE_COLLECTIONS and BBPATH exist at add-layers and parsing
Date: Tue, 10 Oct 2023 02:48:35 +0100
Message-Id: <20231010014835.947330-1-bhstalel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 01:49:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15199

Empty layer.conf is added to bblayers.conf and not shown by show-layers.

It will have no effect on BBFILES or BBPATH so no need to add it in the first place.

Other than this, when working with the layer.conf variables, I noticed the following:

1) No BBFILE_COLLECTIONS will lead to no effect for BBFILE_PATTERN, so BBFILES on its own work well.
2) No BBFILE_COLLECTIONS and no BBPATH with BBFILES set to a directoy will work as well but custom inherits will fail only if the recipe matches: meta-*/*.bb.
   So checking on BBPATH will also fix this.

In conclusion any messing around with layer.conf's variables will lead to unexpected behavior.

Making sure BBFILE_COLLECTIONS exist will ensure:
	- error if no LAYERSERIES_COMPAT
	- error if no BBFILE_PATTERN
	- warning if no BBFILES
	- Layer shown in (bitbake-layers show-layers)

Making sure BBPATH exist will ensure that classes and conf found regardless of BBFILES content (it can be a directory that will trigger find_bbfiles)

Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
---
 bitbake/lib/bb/cooker.py       |  2 +-
 bitbake/lib/bb/cookerdata.py   |  7 ++++++-
 bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2adf4d297d..f163d3a2a3 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
             for ignored in ('SCCS', 'CVS', '.svn'):
                 if ignored in dirs:
                     dirs.remove(ignored)
-            found += [os.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))]
+            found += [os.path.join(dir, f) for f in files if (f.endswith(('.bb', '.bbappend')))]
 
         return found
 
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index ec3741cc1d..fd1e0cf06f 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -18,6 +18,7 @@ from functools import wraps
 import bb
 from bb import data
 import bb.parse
+from bblayers.action import ActionPlugin
 
 logger      = logging.getLogger("BitBake")
 parselog    = logging.getLogger("BitBake.Parsing")
@@ -377,7 +378,11 @@ class CookerDataBuilder(object):
                     layer = layer.rstrip('/')
                 data.setVar('LAYERDIR', layer)
                 data.setVar('LAYERDIR_RE', re.escape(layer))
-                data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
+                layer_conf = os.path.join(layer, "conf", "layer.conf")
+                res, msg = ActionPlugin.do_check_layer(layer_conf)
+                if not res:
+                    bb.fatal(msg)
+                data = parse_config_file(layer_conf, data)
                 data.expandVarref('LAYERDIR')
                 data.expandVarref('LAYERDIR_RE')
 
diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index 454c251410..5a2fcf7f8f 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -23,6 +23,27 @@ def plugin_init(plugins):
 
 
 class ActionPlugin(LayerPlugin):
+
+    def do_check_layer(path):
+        """
+        make sure that BBFILE_COLLECTIONS and BBPATH are found in layer.conf
+        they should exist in non-commented lines
+        """
+        def _is_found(var, line):
+                return var in line and not line.startswith('#')
+
+        with open(path) as layer_conf_fd:
+            lines = layer_conf_fd.readlines()
+            find_result = {}
+            for to_find in ['BBFILE_COLLECTIONS', 'BBPATH']:
+                for line in lines:
+                    find_result[to_find] = True if _is_found(to_find, line) else False
+                    if find_result[to_find]:
+                        break
+                if not find_result[to_find]:
+                    return False, "Specified layer configuration %s doesn't contain %s\n" % (path, to_find)
+        return True, ""
+
     def do_add_layer(self, args):
         """Add one or more layers to bblayers.conf."""
         layerdirs = [os.path.abspath(ldir) for ldir in args.layerdir]
@@ -37,6 +58,11 @@ class ActionPlugin(LayerPlugin):
                 sys.stderr.write("Specified layer directory %s doesn't contain a conf/layer.conf file\n" % layerdir)
                 return 1
 
+            res, msg = ActionPlugin.do_check_layer(layer_conf)
+            if not res:
+                sys.stderr.write(msg)
+                return 1
+
         bblayers_conf = os.path.join('conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
-- 
2.25.1


