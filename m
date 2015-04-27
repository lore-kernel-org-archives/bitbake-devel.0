Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 6595B65CAC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Apr 2015 14:24:24 +0000 (UTC)
Received: by widdi4 with SMTP id di4so101532509wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Apr 2015 07:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=d3huQufJstKfZ0HyB3CNlshta674SLcOXEnGtsjZuSo=;
	b=I4yKCQfOigHcBTbyPU4mM+TQ1SKfhYDMlmMtgWqgn4n4UU36xq4Hk3caNpaeo2JDnT
	RkKAkSpo7ZIVqPyPFP8aiAozA1JoG7KmTxD+F2clMRXej/NwCFaWAVeFLfkGd7vEq4+e
	h8hUdUt+dIxaPBx87YWpORgV3PqR1w1NIvlt1OPqZdxJgGJ7ij8TGYjQG2fWbOBd53dz
	KhVA/4dvI9rWFAJ9I3jrIFYC4yW21owsJTF9R/VSsMAK5ebjEDw8wDpoZ1YUJ7vXVmDp
	Lq0YLVvkUoChbQGtXC2FoQgMKTn1DvyX6uPd10+iEDtuzj5pbOYWSY1C5cdm720hbqIv
	DHSA==
X-Gm-Message-State: ALoCoQnhz7T3gHhveZSU0HSUl1Uq6c/TtjzarKXJ1ibOCApkELjZP8rlkl7VsmWEVRrR3CE8iofq
X-Received: by 10.180.7.134 with SMTP id j6mr21543407wia.9.1430144665883;
	Mon, 27 Apr 2015 07:24:25 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	dz4sm11849699wib.17.2015.04.27.07.24.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 Apr 2015 07:24:25 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F37B956133F; Mon, 27 Apr 2015 15:24:25 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Apr 2015 15:24:25 +0100
Message-Id: <1430144665-17540-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 1/1] Revert "toaster: add layer source in admin throws an error"
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
X-List-Received-Date: Mon, 27 Apr 2015 14:24:25 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This reverts commit 4de721aa75a4aaad186312443726e6daa764934b.
---
 lib/toaster/orm/models.py | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b9bb896..cccf7f3 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -646,25 +646,17 @@ class LayerSource(models.Model):
         raise Exception("Abstract, update() must be implemented by all LayerSource-derived classes (object is %s)" % str(vars(self)))
 
     def save(self, *args, **kwargs):
-        if self.sourcetype == LayerSource.TYPE_LOCAL:
-            self.__class__ = LocalLayerSource
-        elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
-            self.__class__ = LayerIndexLayerSource
-        elif self.sourcetype == LayerSource.TYPE_IMPORTED:
-            self.__class__ = ImportedLayerSource
+        if isinstance(self, LocalLayerSource):
+            self.sourcetype = LayerSource.TYPE_LOCAL
+        elif isinstance(self, LayerIndexLayerSource):
+            self.sourcetype = LayerSource.TYPE_LAYERINDEX
+        elif isinstance(self, ImportedLayerSource):
+            self.sourcetype = LayerSource.TYPE_IMPORTED
         elif self.sourcetype == None:
             raise Exception("Unknown LayerSource-derived class. If you added a new layer source type, fill out all code stubs.")
         return super(LayerSource, self).save(*args, **kwargs)
 
     def get_object(self):
-        # preset an un-initilized object
-        if None == self.name:
-            self.name=""
-        if None == self.apiurl:
-            self.apiurl=""
-        if None == self.sourcetype:
-            self.sourcetype=LayerSource.TYPE_LOCAL
-
         if self.sourcetype == LayerSource.TYPE_LOCAL:
             self.__class__ = LocalLayerSource
         elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
-- 
1.9.1


