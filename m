Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id C77F87316A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:11 +0000 (UTC)
Received: by pfbg73 with SMTP id g73so41647553pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=htxrL4YcNmSuOG+bavoDwRpn9wNPfXgR77SzV9KZlbQ=;
	b=slWzg+1Du56NGlgHkpY/cnqjE/dnhHCGEQKzcP87IQu0C7jVr/OF3h3An4oeyJ4qeY
	zG1Jt2nYY7eWEBseVCS9k82G91I0vW2a5XOSuT6YftflYjDcFRXmgzseZWEB2TcnaP3Y
	5zdXONHWsZfeU5Ye6YrsehTFb5HQvweXZWYkxB6cO2ZTH8UU4cCEitgn50wixuhALWy/
	fEInF3qrgBuPcCqQGEhcjrrvRDP1i2O+9/g4oRRHGK3eLc31Ud1qoG188Ix69e4BSb8C
	7TzsmzIiRsWJRKBtpiVTLmFhSPUhxwo8KD0Vgx9o3ljEhfiu0C7tPj9sgXIhOXMlkqn5
	ldRw==
X-Received: by 10.98.8.3 with SMTP id c3mr3554900pfd.89.1449719592693;
	Wed, 09 Dec 2015 19:53:12 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:12 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:40 -0800
Message-Id: <0650aca645b5f681442bc3d91d3d0294d323d210.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 15/18] toaster: work around 'database is locked' error
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:12 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

When sqlite can not cope with a stream of 'insert' queries it throws
'database is locked' exception.

Wrapping model.save in transaction.atomic context and repeating the call
should solve this issue.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3c51c6f..0d598ac 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -29,10 +29,28 @@ from django.core import validators
 from django.conf import settings
 import django.db.models.signals
 
-
 import logging
 logger = logging.getLogger("toaster")
 
+if 'sqlite' in settings.DATABASES['default']['ENGINE']:
+    from django.db import transaction, OperationalError
+    from time import sleep
+
+    _base_save = models.Model.save
+    def save(self, *args, **kwargs):
+        while True:
+            try:
+                with transaction.atomic():
+                    return _base_save(self, *args, **kwargs)
+            except OperationalError as err:
+                if 'database is locked' in str(err):
+                    logger.warning("%s, model: %s, args: %s, kwargs: %s",
+                                   err, self.__class__, args, kwargs)
+                    sleep(0.5)
+                    continue
+                raise
+
+    models.Model.save = save
 
 class GitURLValidator(validators.URLValidator):
     import re
-- 
1.9.1


