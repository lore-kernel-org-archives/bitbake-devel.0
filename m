Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id 7127673179
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:13 +0000 (UTC)
Received: by pfbg73 with SMTP id g73so41647947pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=DtPLw1Qj2GT4aWlO/GS2P6kEF9AJV4gk04ZpmcNYfFs=;
	b=hRvyE2VZRrd7vXuK/sIWLJsB5qOOTjwXJf6OVBDV/Eu1iyV7etspExUh9qpJL6Xn9Z
	xNSX2jEHSLC1MhUDB1GHIiLUtrAHviu0MdLr0dfXpoaoDSPJv2Iq5xMxavpQCHaFriTX
	3dVa7GgZ+8ghOSqRLKQMi7ujXnd6tic7ZdXHh+M1Jqf6vwfEhpmx5OqAI2htjLr8u+kv
	UuJ3bKfCHYvSEGBdTcLQ6HosuPqGyZqbKyli6TTSJDZDyV5VfKgYqEVZkuEd28xqzpVw
	qKZnODG24+QVqUiwnfUVJ/Q7Wp7r06rJ6CS8yL45L7nzqcbZwHkODvkhSdph7K5uDCOR
	ML9g==
X-Received: by 10.98.7.91 with SMTP id b88mr3596216pfd.48.1449719594523;
	Wed, 09 Dec 2015 19:53:14 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:13 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:42 -0800
Message-Id: <63a165305e678df3b6f73cac989c128b27ac60f3.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 17/18] toaster: monkey patch Queryset
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed 'database is locked' issue by monkey patching django QuerySet
methods.

The actual patching places were found by bisecting Django codebase.

This commit should be removed after Django is fixed if it's fixed
at all.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0d598ac..6e87c54 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -52,6 +52,36 @@ if 'sqlite' in settings.DATABASES['default']['ENGINE']:
 
     models.Model.save = save
 
+    # HACK: Monkey patch Django to fix 'database is locked' issue
+
+    from django.db.models.query import QuerySet
+    _base_insert = QuerySet._insert
+    def _insert(self,  *args, **kwargs):
+        with transaction.atomic(using=self.db, savepoint=False):
+            return _base_insert(self, *args, **kwargs)
+    QuerySet._insert = _insert
+
+    from django.utils import six
+    def _create_object_from_params(self, lookup, params):
+        """
+        Tries to create an object using passed params.
+        Used by get_or_create and update_or_create
+        """
+        try:
+            obj = self.create(**params)
+            return obj, True
+        except IntegrityError:
+            exc_info = sys.exc_info()
+            try:
+                return self.get(**lookup), False
+            except self.model.DoesNotExist:
+                pass
+            six.reraise(*exc_info)
+
+    QuerySet._create_object_from_params = _create_object_from_params
+
+    # end of HACK
+
 class GitURLValidator(validators.URLValidator):
     import re
     regex = re.compile(
-- 
1.9.1


