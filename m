Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id AE2F9755F4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:19:37 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so6608996pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Oct 2015 20:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=aGc+Sna9AXT9AxahbN0oCI5pmdp9qH9+tDZ4lPKJFlg=;
	b=Mee5bnfdpyMFogZkV01jmLtxa9ggk3TXjccliI6uoulxyCgGr1VQBKPfaEHrQ6GFlA
	2OrN6cX3ZE2+GD3XAWnGOw1dlTTzWrxJXhZVd9xCC0td9T90cFPMQJQBRdsWtvHNjHJ3
	rko3KdibZaPObnHfoa0KMg94KJWohNRjVWvRDKEz+MlyNfNgg7Z2+655/Ko0v9m0FRjt
	LgI826cKxc+Ki/2+ZKGc9PBzeMBCZ9g1mNQG/ntDys3KPl4PgrY1Vt2cRHumxh10B+rd
	cEE2wZdU21X38XptPG+S3iEcA3VM3c3owG2O/E/E4HJ378q7IKVc8qUPAp2a2RdldGxn
	Abwg==
X-Received: by 10.68.164.98 with SMTP id yp2mr8260540pbb.125.1444187977758;
	Tue, 06 Oct 2015 20:19:37 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qy5sm36230685pbb.16.2015.10.06.20.19.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Oct 2015 20:19:37 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 20:21:25 -0700
Message-Id: <34399e5950509ffe978d9e6a31e91193d1bdcf0a.1444187945.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1444187945.git.avery.brian@gmail.com>
References: <cover.1444187945.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toaster: orm Machines filter don't pass self in as parameter
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
X-List-Received-Date: Wed, 07 Oct 2015 03:19:38 -0000

From: Michael Wood <michael.g.wood@intel.com>

Fix typo don't pass self in as a parameter, this evaluated to true
giving the wrong results meaning the machines typeahead did not return
valid results.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 670ec78..375985e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -229,7 +229,7 @@ class Project(models.Model):
         """ Returns QuerySet of all Machines which are provided by the
         Layers currently added to the Project """
         queryset = Machine.objects.filter(
-            layer_version__in=self.get_project_layer_versions(self))
+            layer_version__in=self.get_project_layer_versions())
 
         return queryset
 
-- 
1.9.1


