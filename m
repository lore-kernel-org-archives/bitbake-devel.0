Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id A9D8D77030
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:56 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97501366pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=cbfz9BUT9h+Epwi+sow54qELzi5/l0aAqShE1zb9fXg=;
	b=G/Jv2fOZra//+D9afKX6nnq3Ib2H/xXecVxKkM55U/M6xZ6NtFB4E9pOGf9tbjcP1p
	r7zmOU9Vo4XUVmH8PIc4IWsfw+yijd6kuEahvpBfefgy7E+ZEix40Uv3dXcY4euM7cDR
	9UueX6ZMa/x51EgDelG0rPHEwJV5PhjKtnJ0q2t/pqZ8/mWHDvYw7gqY5MdswJCvpXSC
	ZEUr7Z+36giZ3AzzotAjLDP61CU48z/vKqbVwZavjMRvt+/IVWUEqKSZM2MVeN3xxbP1
	mzasa4pQ0KMUI8GwF+eOJ19SxcMOoPoXjkM9gOjbi24yzjYJxf7ObcxdCfGaIwVlXRzG
	FMMw==
X-Received: by 10.66.144.135 with SMTP id sm7mr31310237pab.106.1443501836796; 
	Mon, 28 Sep 2015 21:43:56 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.43.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:56 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:12 -0700
Message-Id: <6c53eddfa3b37c1ad7e899ae50f1ebb62b31c969.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 02/22] toaster: tables Move the title and name into the widget
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
X-List-Received-Date: Tue, 29 Sep 2015 04:43:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

For historical reasons this was being set in the urls definition. We
can set this in the actual definition of the table and defaults in the
widget.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tables.py  |  2 ++
 lib/toaster/toastergui/urls.py    | 22 +++++++++++++---------
 lib/toaster/toastergui/widgets.py |  9 ++++++++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 92e3b5c..70e4b6d 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -50,6 +50,7 @@ class LayersTable(ToasterTable):
     def __init__(self, *args, **kwargs):
         super(LayersTable, self).__init__(*args, **kwargs)
         self.default_orderby = "layer__name"
+        self.title = "Compatible layers"
 
     def get_context_data(self, **kwargs):
         context = super(LayersTable, self).get_context_data(**kwargs)
@@ -208,6 +209,7 @@ class MachinesTable(ToasterTable, ProjectFiltersMixin):
     def __init__(self, *args, **kwargs):
         super(MachinesTable, self).__init__(*args, **kwargs)
         self.empty_state = "No machines maybe you need to do a build?"
+        self.title = "Compatible machines"
         self.default_orderby = "name"
 
     def get_context_data(self, **kwargs):
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 46e5761..55f325d 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -87,15 +87,21 @@ urlpatterns = patterns('toastergui.views',
         # the table pages that have been converted to ToasterTable widget
         url(r'^project/(?P<pid>\d+)/machines/$',
             tables.MachinesTable.as_view(template_name="generic-toastertable-page.html"),
-            { 'table_name': tables.MachinesTable.__name__.lower(),
-              'title' : 'Compatible machines' },
             name="projectmachines"),
 
-        url(r'^project/(?P<pid>\d+)/recipes/$',
-            tables.RecipesTable.as_view(template_name="generic-toastertable-page.html"),
-            { 'table_name': tables.RecipesTable.__name__.lower(),
-              'title' : 'Compatible recipes' },
-            name="projecttargets"),
+        url(r'^project/(?P<pid>\d+)/softwarerecipes/$',
+            tables.SoftwareRecipesTable.as_view(template_name="generic-toastertable-page.html"),
+            name="projectsoftwarerecipes"),
+
+        url(r'^project/(?P<pid>\d+)/images/$',
+            tables.ImageRecipesTable.as_view(template_name="generic-toastertable-page.html"), name="projectimagerecipes"),
+
+        url(r'^project/(?P<pid>\d+)/customimages/$',
+            tables.CustomImagesTable.as_view(template_name="generic-toastertable-page.html"), name="projectcustomimages"),
+
+        url(r'^project/(?P<pid>\d+)/newcustomimage/$',
+            tables.NewCustomImagesTable.as_view(template_name="newcustomimage.html"),
+            name="newcustomimage"),
 
         url(r'^project/(?P<pid>\d+)/availablerecipes/$',
             tables.ProjectLayersRecipesTable.as_view(template_name="generic-toastertable-page.html"),
@@ -105,8 +111,6 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^project/(?P<pid>\d+)/layers/$',
             tables.LayersTable.as_view(template_name="generic-toastertable-page.html"),
-            { 'table_name': tables.LayersTable.__name__.lower(),
-              'title' : 'Compatible layers' },
             name="projectlayers"),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index eb2914d..eb49692 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -45,7 +45,7 @@ class ToasterTable(TemplateView):
         super(ToasterTable, self).__init__()
         if 'template_name' in kwargs:
             self.template_name = kwargs['template_name']
-        self.title = None
+        self.title = "Table"
         self.queryset = None
         self.columns = []
         self.filters = {}
@@ -61,6 +61,13 @@ class ToasterTable(TemplateView):
                         orderable=True,
                         field_name="id")
 
+    def get_context_data(self, **kwargs):
+        context = super(ToasterTable, self).get_context_data(**kwargs)
+        context['title'] = self.title
+        context['table_name'] =  type(self).__name__.lower()
+
+        return context
+
 
     def get(self, request, *args, **kwargs):
         if request.GET.get('format', None) == 'json':
-- 
1.9.1


