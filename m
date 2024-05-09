Return-Path: <hieu2.nguyen@lge.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E30C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 10:24:29 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.52])
 by mx.groups.io with SMTP id smtpd.web11.6821.1715250266872652175
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 May 2024 03:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lge.com, ip: 156.147.23.52, mailfrom: hieu2.nguyen@lge.com)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.52 with ESMTP; 9 May 2024 19:24:26 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hieu2.nguyen@lge.com
Received: from unknown (HELO hieu2-nguyen-worker-2204.bee-live.svc.cluster.local) (10.185.60.36)
	by 156.147.1.121 with ESMTP; 9 May 2024 19:24:25 +0900
X-Original-SENDERIP: 10.185.60.36
X-Original-MAILFROM: hieu2.nguyen@lge.com
From: Hieu Van Nguyen <hieu2.nguyen@lge.com>
To: bitbake-devel@lists.openembedded.org
Cc: alexandre.belloni@bootlin.com,
	richard.purdie@linuxfoundation.org,
	pkj@axis.com,
	nvhieudt11@gmail.com,
	Hieu Van Nguyen <hieu2.nguyen@lge.com>
Subject: [PATCH v2] bitbake-layers: Support add-layer to prepend
Date: Thu,  9 May 2024 19:24:24 +0900
Message-Id: <20240509102424.1073669-1-hieu2.nguyen@lge.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 May 2024 10:24:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16194

As you know, layer order in BBLAYERS can affect in parsing recipes process,
in some cases, users want to add a layer on the top of BBLAYERS variable

So, add "--prepend" option for bitbake-layers to support add-layer to prepend

Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
---
 lib/bb/utils.py        | 8 ++++++--
 lib/bblayers/action.py | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ebee65d3d..f1634da0a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1414,7 +1414,7 @@ def edit_metadata_file(meta_file, variables, varfunc):
     return updated
 
 
-def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
+def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None, prepend=None):
     """Edit bblayers.conf, adding and/or removing layers
     Parameters:
         bblayers_conf: path to bblayers.conf file to edit
@@ -1424,6 +1424,7 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
             empty list to remove nothing
         edit_cb: optional callback function that will be called after
             processing adds/removes once per existing entry.
+        prepend: optional support add-layer to prepend
     Returns a tuple:
         notadded: list of layers specified to be added but weren't
             (because they were already in the list)
@@ -1484,7 +1485,10 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
             for addlayer in addlayers:
                 if addlayer not in bblayers:
                     updated = True
-                    bblayers.append(addlayer)
+                    if prepend:
+                        bblayers.insert(0,addlayer)
+                    else:
+                        bblayers.append(addlayer)
             del addlayers[:]
 
         if edit_cb:
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a14f19948..8ef89fc09 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -49,7 +49,7 @@ class ActionPlugin(LayerPlugin):
         shutil.copy2(bblayers_conf, backup)
 
         try:
-            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
+            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None, None, args.prepend)
             if not (args.force or notadded):
                 self.tinfoil.modified_files()
                 try:
@@ -269,6 +269,7 @@ build results (as the layer priority order has effectively changed).
     def register_commands(self, sp):
         parser_add_layer = self.add_command(sp, 'add-layer', self.do_add_layer, parserecipes=False)
         parser_add_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to add')
+        parser_add_layer.add_argument('--prepend', action='store_true', help='Prepend layer directory/directories')
 
         parser_remove_layer = self.add_command(sp, 'remove-layer', self.do_remove_layer, parserecipes=False)
         parser_remove_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
-- 
2.34.1


