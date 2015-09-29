Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 0EE7B7701C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:07 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so198605441pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=24jhmm4v9bJ/tE3px4qLwKt/R4lvvfWuDPoAJPRCkvU=;
	b=m/PbZ/5E6jnj2yykBpc4ijWv7mA8+5ADyJprxBrbQEpta5hY+Z/eOyCa0ptQ9fHAD5
	oI9AZa4EeqDcuPgWwEGNnKCLFUq7IFxHDHwz4Wl6IGzYCneMfXjMFs2HKDYEBHc+EHLC
	CAh5waIQh9LG8w8IZBZLlpimbK8MtgOfb8TVQsq465VF69QEjWVoOQPjAUMPAtcVjoin
	Q5ET9HOe0T4SCCNj0nYQ5hJlvCYzsmFBR561Fpf81fcAj7iw1lNdg+zTgaX6meVITDML
	Ifv9XJ/Yja1WK1RK2/JVOPJ+Pzcn9gAc5FvKfY2c/PaW3m4RbTE5iIuSaDBFnN9bnZA1
	2zkQ==
X-Received: by 10.66.246.162 with SMTP id xx2mr30458115pac.144.1443501848542; 
	Mon, 28 Sep 2015 21:44:08 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:07 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:26 -0700
Message-Id: <07bcc29c563b117da96c20844be0b4e8694457a0.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 16/22] toaster: Special case the openembedded-core layer to avoid duplicates
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:08 -0000

From: Michael Wood <michael.g.wood@intel.com>

If the openembedded-core layer is specified in the toasterconf we need
to treat it differently because we may also get this layer either from
the layerindex source or I can also be provided locally.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9790630..4025702 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -828,6 +828,7 @@ class LayerIndexLayerSource(LayerSource):
         import urllib2, urlparse, json
         import os
         proxy_settings = os.environ.get("http_proxy", None)
+        oe_core_layer = 'openembedded-core'
 
         def _get_json_response(apiurl = self.apiurl):
             _parsedurl = urlparse.urlparse(apiurl)
@@ -872,6 +873,25 @@ class LayerIndexLayerSource(LayerSource):
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(False)
         for li in layers_info:
+            # Special case for the openembedded-core layer
+            if li['name'] == oe_core_layer:
+                try:
+                    # If we have an existing openembedded-core for example
+                    # from the toasterconf.json augment the info using the
+                    # layerindex rather than duplicate it
+                    oe_core_l =  Layer.objects.get(name=oe_core_layer)
+                    # Take ownership of the layer as now coming from the
+                    # layerindex
+                    oe_core_l.layer_source = self
+                    oe_core_l.up_id = li['id']
+                    oe_core_l.summary = li['summary']
+                    oe_core_l.description = li['description']
+                    oe_core_l.save()
+                    continue
+
+                except DoesNotExist:
+                    pass
+
             l, created = Layer.objects.get_or_create(layer_source = self, name = li['name'])
             l.up_id = li['id']
             l.up_date = li['updated']
@@ -882,6 +902,7 @@ class LayerIndexLayerSource(LayerSource):
             l.summary = li['summary']
             l.description = li['description']
             l.save()
+
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
 
-- 
1.9.1


