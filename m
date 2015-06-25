Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id D5AC075A1F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:35:02 +0000 (UTC)
Received: by wgck11 with SMTP id k11so58823468wgc.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CkJO2fY3S5e7hp/hF5b8eCqh/FtSzNMVavvCJd7rBRE=;
	b=N1KAh1vzXlA3jkcjDvN+fA+YdveDSBeuA61DjZdPHPkRyd0486eS8HUosnfEGg7mL6
	ypu5qbYJxrMLsItRP3g62qrmfsrRkalfzNEuETobNRra4HU2m1o1IfVRAIl45FzQ6FDf
	GrQMkiw+fbY9LmLe7N4aw7CX5oei7h4+WneC33a4JWkpsj+65KnJHBgrkmIFyiucJkM+
	38UErZ/75tHtD1QR2wcXElyXABOOt42c6/Axn3C6/tYtgCt03CFm0Ze0L/XabZ9E7BjZ
	N/4/Q1JyssPb83vg0QTMBFpJwQO/fUiUG1o8iaKRdn05S+TE+7m+ecS4I/lhv3uFZIqQ
	JXeg==
X-Gm-Message-State: ALoCoQkvVEU8r+PXrbPM9uf+FvhQ4dZSKT1X8wOUsWP8TlfZGIUZBZyVEYKGMoKGXq4fwUqog5V1
X-Received: by 10.181.29.100 with SMTP id jv4mr4431436wid.4.1435228503771;
	Thu, 25 Jun 2015 03:35:03 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v3sm6935283wiz.14.2015.06.25.03.35.02
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:35:03 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E126E5629B2; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:55 +0100
Message-Id: <e0d59c32a7cff76d732a90cc6d507c7a9b68cb84.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 18/23] toaster: toastertable Pass up the kwargs for setup_filter
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
X-List-Received-Date: Thu, 25 Jun 2015 10:35:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

This allows us to setup_filter in tables using args such as the current
project.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/widgets.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index e257c70..5f6b47b 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -72,7 +72,7 @@ class ToasterTable(TemplateView):
 
             cmd = request.GET.get('cmd', None)
             if cmd and 'filterinfo' in cmd:
-                data = self.get_filter_info(request)
+                data = self.get_filter_info(request, **kwargs)
             else:
                 # If no cmd is specified we give you the table data
                 data = self.get_data(request, **kwargs)
@@ -81,10 +81,10 @@ class ToasterTable(TemplateView):
 
         return super(ToasterTable, self).get(request, *args, **kwargs)
 
-    def get_filter_info(self, request):
+    def get_filter_info(self, request, **kwargs):
         data = None
 
-        self.setup_filters()
+        self.setup_filters(**kwargs)
 
         search = request.GET.get("search", None)
         if search:
@@ -194,8 +194,8 @@ class ToasterTable(TemplateView):
 
         return template.render(context)
 
-    def apply_filter(self, filters):
-        self.setup_filters()
+    def apply_filter(self, filters, **kwargs):
+        self.setup_filters(**kwargs)
 
         try:
             filter_name, filter_action = filters.split(':')
@@ -264,7 +264,7 @@ class ToasterTable(TemplateView):
         if search:
             self.apply_search(search)
         if filters:
-            self.apply_filter(filters)
+            self.apply_filter(filters, **kwargs)
         if orderby:
             self.apply_orderby(orderby)
 
-- 
1.9.1


