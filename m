Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 00CF576F9D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:00 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194493169pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=XlP0dZEHcu8nqMyJGV+2sXQjBvqwdEzsJq6QLzseTd8=;
	b=knfvGMcneFtt30kCV7LTdjQgwl7NBLvwpG+V/mlzdDr+Lihi24/xr5Rd5VzOREj6Do
	ZAA7loNhpnoGUfQbMxLpez5kKAnpCWbu2nfD3KVUw7oRYDwSXOV3QI8Tk6SPr0bXq7Ht
	ha2bZ+keyiP6vygFieS0tGKir8uVX3imjF4VOnRPrjwGZVARFI1pzkyI2UKVsvPjV//r
	loiUC8SqX1qCjGcY0bzPOs8QmWOcc8DOSjJuu6WDMvhKJFhzDx760cgxdskTqC3VLgLn
	+vMu/wJDLDtY49dpO20TcPNLB52DbBj4dgeeYO8jjQii/5DLAYWmdbTu0IYxIwumBsR2
	xVxg==
X-Received: by 10.69.2.227 with SMTP id br3mr31217320pbd.9.1443501840984;
	Mon, 28 Sep 2015 21:44:00 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:00 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:17 -0700
Message-Id: <b6822f181cde1e022b49116b1b86e194b615000e.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 07/22] toaster: ToasterTable remove unused class definition
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:01 -0000

From: Michael Wood <michael.g.wood@intel.com>

Remove ToasterTemplateView as this isn't used by anything.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/widgets.py | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index d7d5efd..e58dd7c 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -349,33 +349,6 @@ class ToasterTable(TemplateView):
         return data
 
 
-class ToasterTemplateView(TemplateView):
-    # renders a instance in a template, or returns the context as json
-    # the class-equivalent of the _template_renderer decorator for views
-
-    def __init__(self, *args, **kwargs):
-        super(ToasterTemplateView, self).__init__(*args, **kwargs)
-        self.context_entries = []
-
-    def get(self, *args, **kwargs):
-        if self.request.GET.get('format', None) == 'json':
-            from django.core.urlresolvers import reverse
-            from django.shortcuts import HttpResponse
-            from views import objtojson
-            from toastergui.templatetags.projecttags import json as jsonfilter
-
-            context = self.get_context_data(**kwargs)
-
-            for x in context.keys():
-                if x not in self.context_entries:
-                    del context[x]
-
-            context["error"] = "ok"
-
-            return HttpResponse(jsonfilter(context,  default=objtojson ),
-                            content_type = "application/json; charset=utf-8")
-
-        return super(ToasterTemplateView, self).get(*args, **kwargs)
 
 class ToasterTypeAhead(View):
     """ A typeahead mechanism to support the front end typeahead widgets """
-- 
1.9.1


