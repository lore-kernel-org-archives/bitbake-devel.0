Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 3E18E76903
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:02 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97504077pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=DqPd+9uIgficrU7Kyl0mXsHrhsWE0ivnVLFT+tR5pDg=;
	b=SaKdrPFxRb71AMMj4/AyxjVjoR9GQbiEsTJF4kTtJLGh7lidpiFm0glRaLR2MEs3ee
	kSqcQYshh7ivzD066iu9g2LcobNnYvAeBgT7BVZbVZodLKAqTTk4UXhWI02hF5LDmY43
	+xSbtqXE+DQPGlwZdGiLMa2Mh4IAnVH6swJk1G8WplRbbk/d86vzOP6sQ2zR9WpCcR5F
	qlNUSkArvjDJjAobXRG+vjXm7wu2he8D4ywhe8cPPgOTQ02RcY8eJUJ7eUxnhfguoQyv
	aasiVn1EOcG9ubZ02GLvg7+TsP5O3+26ANPtfuNinXBY3Q7h61KFZCEZAhJ8usCKYC60
	biyg==
X-Received: by 10.67.15.100 with SMTP id fn4mr30891765pad.120.1443501843524;
	Mon, 28 Sep 2015 21:44:03 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:02 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:20 -0700
Message-Id: <8feb4622961622194ce8f3b3f6c1c44c52eff84a.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 10/22] toaster: implement decorator for REST responses
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:03 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Implemented xhr_response decorator to decorate responses
from REST methods into Django HttpResponse objects.

This decorator should reduce amount of repeated code in
REST methods and make them more readable.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2e3b822..95df60e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -45,6 +45,7 @@ from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 import json
 from os.path import dirname
+from functools import wraps
 import itertools
 
 import magic
@@ -2314,6 +2315,18 @@ if True:
 
         return context
 
+    def xhr_response(fun):
+        """
+        Decorator for REST methods.
+        calls jsonfilter on the returned dictionary and returns result
+        as HttpResponse object of content_type application/json
+        """
+        @wraps(fun)
+        def wrapper(*args, **kwds):
+            return HttpResponse(jsonfilter(fun(*args, **kwds)),
+                                content_type="application/json")
+        return wrapper
+
     def jsunittests(request):
       """ Provides a page for the js unit tests """
       bbv = BitbakeVersion.objects.filter(branch="master").first()
-- 
1.9.1


