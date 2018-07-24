Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A7B2D75260
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Jul 2018 02:29:16 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w6O2THwe024629
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 19:29:17 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.399.0;
	Mon, 23 Jul 2018 19:29:17 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 23 Jul 2018 22:29:10 -0400
Message-ID: <20180724022914.185634-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180724022914.185634-1-mark.hatle@windriver.com>
References: <20180724022914.185634-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/5 v2] bblayers/layerindex.py: Fix addition of layers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 24 Jul 2018 02:29:16 -0000
Content-Type: text/plain

When a layer is added it needs to be in a list, otherwise the system will
error such as:

    Specified layer directory / doesn't contain a conf/layer.conf file

Additionally, instead of calling the add layer function over and over, it
is better to add all of the new content in one command.  Otherwise the
order is important as the system now checks if the layer can be added.  For
instance, trying to add meta-python:

   Layer                Required by          Git repository                                          Subdirectory
   ===================================================================================================================
   meta-python          -                    git://git.openembedded.org/meta-openembedded            meta-python
   meta-oe              meta-python          git://git.openembedded.org/meta-openembedded            meta-oe
   openembedded-core    meta-python          git://git.openembedded.org/openembedded-core            meta
   Adding layer "meta-python" (.../oe-core/meta-openembedded/meta-python) to conf/bblayers.conf
   ERROR: Layer 'meta-python' depends on layer 'openembedded-layer', but this layer is not enabled in your configuration

The system would try to add meta-python before the dependent meta-oe.  Adding
them both at the same time resolves this issue.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bblayers/layerindex.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 9af385d..53c858d 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -239,19 +239,22 @@ class LayerIndexPlugin(ActionPlugin):
                     return 1
                 addlayers.append((subdir, name, layerdir))
         if not args.show_only:
+            localargs = argparse.Namespace()
+            localargs.layerdir = []
+            localargs.force = args.force
             for subdir, name, layerdir in set(addlayers):
                 if os.path.exists(layerdir):
                     if subdir:
-                        logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % subdir)
+                        logger.plain("Adding layer \"%s\" (%s) to conf/bblayers.conf" % (subdir, layerdir))
                     else:
-                        logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % name)
-                    localargs = argparse.Namespace()
-                    localargs.layerdir = layerdir
-                    localargs.force = args.force
-                    self.do_add_layer(localargs)
+                        logger.plain("Adding layer \"%s\" (%s) to conf/bblayers.conf" % (name, layerdir))
+                    localargs.layerdir.append(layerdir)
                 else:
                     break
 
+            if localargs.layerdir:
+                self.do_add_layer(localargs)
+
     def do_layerindex_show_depends(self, args):
         """Find layer dependencies from layer index.
 """
-- 
1.8.3.1


