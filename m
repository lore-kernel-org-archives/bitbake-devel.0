Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 676CC73D5B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:42 +0000 (UTC)
Received: by wgsk9 with SMTP id k9so83341860wgs.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vV0114Kg/oG+zk1ivs2krJUjSPEjid/qvfVZbxpRc+4=;
	b=PmVo8pmTSzzysTbmcS8QuM+Mkg0hsu15Bi/cqnDEOXtViTJgpBck94xvA8WXzezMsK
	mUo80e2V+dgO0q9r0F8snVN3g2xiSANEW9/+ZnFdFmmw6nnGHj3LnzB19vXOQBxOT5No
	mlqcbdDkGhxSK0dW+bq1tNWSEsMjHBtB/nTQJYl7hJivIPdR60aZ5PsWffhuhSY5onn/
	etnilPB1CkFn+42QbcDKabk9w+pBsjHM1Gn+kI1sjgH0cWBbtNN6Aqw04DQtfe48Ybbu
	yvLUvJOzHcZ8X+9UMi4gRTEZuJowKQ0t2DCf7yEs0HMj6dAfAWw+9HbKhZ85aOqUh9DN
	8/Tg==
X-Gm-Message-State: ALoCoQl/Y3tHjnYH9W4RxufYoBVO3J86P1uYeLtbLqAGPvgaGnAIIxlhHCVb5EVFFU2RZNSFfIh6
X-Received: by 10.180.86.137 with SMTP id p9mr8343015wiz.47.1429195663117;
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fl14sm10718195wjc.11.2015.04.16.07.47.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C2A10560ABA; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:37 +0100
Message-Id: <fd1f6fda7a7629f4660235313dc99adb3c190952.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 4/8] toaster: add layer source in admin throws an error
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:42 -0000

From: David Reyna <David.Reyna@windriver.com>

Preset uninitialized object members to bootstrap new layer source creation.

[YOCTO #7437]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 625eb1e..4a6ca8f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -640,17 +640,25 @@ class LayerSource(models.Model):
         raise Exception("Abstract, update() must be implemented by all LayerSource-derived classes (object is %s)" % str(vars(self)))
 
     def save(self, *args, **kwargs):
-        if isinstance(self, LocalLayerSource):
-            self.sourcetype = LayerSource.TYPE_LOCAL
-        elif isinstance(self, LayerIndexLayerSource):
-            self.sourcetype = LayerSource.TYPE_LAYERINDEX
-        elif isinstance(self, ImportedLayerSource):
-            self.sourcetype = LayerSource.TYPE_IMPORTED
+        if self.sourcetype == LayerSource.TYPE_LOCAL:
+            self.__class__ = LocalLayerSource
+        elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
+            self.__class__ = LayerIndexLayerSource
+        elif self.sourcetype == LayerSource.TYPE_IMPORTED:
+            self.__class__ = ImportedLayerSource
         elif self.sourcetype == None:
             raise Exception("Unknown LayerSource-derived class. If you added a new layer source type, fill out all code stubs.")
         return super(LayerSource, self).save(*args, **kwargs)
 
     def get_object(self):
+        # preset an un-initilized object
+        if None == self.name:
+            self.name=""
+        if None == self.apiurl:
+            self.apiurl=""
+        if None == self.sourcetype:
+            self.sourcetype=LayerSource.TYPE_LOCAL
+
         if self.sourcetype == LayerSource.TYPE_LOCAL:
             self.__class__ = LocalLayerSource
         elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
-- 
1.9.1


