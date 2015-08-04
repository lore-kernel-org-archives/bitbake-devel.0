Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id AD000763CE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:47:10 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 04 Aug 2015 12:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="536004668"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2015 12:46:50 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 660186A4083;
	Tue,  4 Aug 2015 12:46:03 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:32 +0300
Message-Id: <ee301b98eb6fb31497e41276a95ffa49aa5daa48.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 04/12] bitbake: toastergui: widgets Add a typeahead widget
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
X-List-Received-Date: Tue, 04 Aug 2015 19:47:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

The typeahead behaviour is significantly different from searching in a
table so we need a separate widget to do this.

[YOCTO #7152]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/widgets.py | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 0885402..2adf574 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -354,3 +354,55 @@ class ToasterTemplateView(TemplateView):
                             content_type = "application/json; charset=utf-8")
 
         return super(ToasterTemplateView, self).get(*args, **kwargs)
+
+class ToasterTypeAhead(View):
+    """ A typeahead mechanism to support the front end typeahead widgets """
+    MAX_RESULTS = 6
+
+    class MissingFieldsException(Exception):
+        pass
+
+    def __init__(self, *args, **kwargs):
+        super(ToasterTypeAhead, self).__init__()
+
+    def get(self, request, *args, **kwargs):
+        def response(data):
+            return HttpResponse(json.dumps(data,
+                                           indent=2,
+                                           cls=DjangoJSONEncoder),
+                                content_type="application/json")
+
+        error = "ok"
+
+        search_term = request.GET.get("search", None)
+        if search_term == None:
+            # We got no search value so return empty reponse
+            return response({'error' : error , 'results': []})
+
+        try:
+            prj = Project.objects.get(pk=kwargs['pid'])
+        except KeyError:
+            prj = None
+
+        results = self.apply_search(search_term, prj, request)[:ToasterTypeAhead.MAX_RESULTS]
+
+        if len(results) > 0:
+            try:
+                self.validate_fields(results[0])
+            except MissingFieldsException as e:
+                error = e
+
+        data = { 'results' : results,
+                'error' : error,
+               }
+
+        return response(data)
+
+    def validate_fields(self, result):
+        if 'name' in result == False or 'detail' in result == False:
+            raise MissingFieldsException("name and detail are required fields")
+
+    def apply_search(self, search_term, prj):
+        """ Override this function to implement search. Return an array of
+        dictionaries with a minium of a name and detail field"""
+        pass
-- 
2.1.4


