Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5C042755F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 11:08:52 +0000 (UTC)
Received: by wicfx3 with SMTP id fx3so108901773wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Oct 2015 04:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Fg7ZEtKLux+qoU64OVA5wsDmEkwfXE501FXSqjUCyAI=;
	b=YYNRoAOJ03El70a048WNQuohP8UqjguJwCY36l2gMewvz9W/fJiRpbTwadJoKNm7N4
	qI9Q/7kpWuV9K8s+HzDnlKAHsQUhJYDuc0i8obZsWBXhdpPl2jCuDw2wC4rN5uMdJRKL
	h/coLt5ZUw6bfILR5/GWmvkcYxMrggdC7Qu3SXB7ssb7OOQPCohaMVT9sfHsaNEiRN0d
	NScLhJEEh5+ZTVXW9SNu4fodMIoQ9Km3Sbx8oAEfCiEz4T3x0T7Z3z96QmXxSgXj6ToX
	3nwSNmvv13A2SW2+F8SeQoUT4zvvU0stuh6xAgOKDn7oRA6fXBw1ScpHrbILvh9WKbcz
	ELLw==
X-Gm-Message-State: ALoCoQnGvQcB5TdyVan0O79yaOlil5FEXZIRAgRyOP8tA5Q4/SjshbTgC57vCPvikmNy3IWRHoTl
X-Received: by 10.180.188.33 with SMTP id fx1mr11247673wic.31.1444043332423;
	Mon, 05 Oct 2015 04:08:52 -0700 (PDT)
Received: from localhost.localdomain ([2.218.205.118])
	by smtp.gmail.com with ESMTPSA id
	jf3sm14040527wic.8.2015.10.05.04.08.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Oct 2015 04:08:51 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 12:08:32 +0100
Message-Id: <1444043312-7618-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1444043312-7618-1-git-send-email-michael.g.wood@intel.com>
References: <1444043312-7618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/2] toaster: Don't HTTP cache ToasterTable responses
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
X-List-Received-Date: Mon, 05 Oct 2015 11:08:56 -0000

From: Elliot Smith <elliot.smith@intel.com>

Django allows generated pages to be cached by default by the
browser. This can result in stale data displaying for some pages.

Instead, disable HTTP caching of ToasterTable responses, so that
each time a ToasterTable view is displayed, its data is
refreshed. This carries a performance penalty, but ensures that
ToasterTable views (e.g. compatible layers) are correctly
refreshed if the user navigates their history with forward/back.

[YOCTO #7660]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/widgets.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index e58dd7c..6bb3889 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -20,6 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.views.generic import View, TemplateView
+from django.views.decorators.cache import cache_control
 from django.shortcuts import HttpResponse
 from django.http import HttpResponseBadRequest
 from django.core import serializers
@@ -64,6 +65,11 @@ class ToasterTable(TemplateView):
                         orderable=True,
                         field_name="id")
 
+        # prevent HTTP caching of table data
+    @cache_control(must_revalidate=True, max_age=0, no_store=True, no_cache=True)
+    def dispatch(self, *args, **kwargs):
+        return super(ToasterTable, self).dispatch(*args, **kwargs)
+
     def get_context_data(self, **kwargs):
         context = super(ToasterTable, self).get_context_data(**kwargs)
         context['title'] = self.title
-- 
2.1.4


