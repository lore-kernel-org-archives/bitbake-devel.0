Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 0C1666B7CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:35 +0000 (UTC)
Received: by mail-pa0-f52.google.com with SMTP id eu11so2849998pac.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pql2vR5JnTwmislLMHKX1eQvMaOassiE2FCR3wfbK8w=;
	b=Z5zoRk0HGzsFWAy3ZU5H/t3kmoypchEpoOfc6jI2/L1XaWJ+Mhu1VGKWMZD/pIQKt5
	0Wltw+pzxPiBwOVELQL2CQK4JlM3GOTkBC/yfU9tZxEhVtU39/JUeq8npzq8R5M6ku9h
	j+eWV2b2yLgV+MZsF3a+QAKADr/2bHbgel7tLSWuV//eIxfumAULkjKBCA7ls5uaGupI
	DRrUb2uPCWxompynWyGfJID4IXh4cCRn1UnJTXG8ks6Sq7bFg3VzUcN5sNHtP5MgSZl+
	cEm3M84c0tisljy/nIYgBOgkV9f2xvoS3w57mNDom4k6D1yeXzDFLWFEh7i+ZtvUlVxJ
	w9rg==
X-Gm-Message-State: ALoCoQk0vMSErJmrRmi/H5SJVL5xRG4DMUTNFFuNzvTBF0vlO8leqdsbLMjQJSNiw+36+0KAoYri
X-Received: by 10.66.169.209 with SMTP id ag17mr7043955pac.62.1416500855757;
	Thu, 20 Nov 2014 08:27:35 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id kk7sm2499778pab.31.2014.11.20.08.27.34
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 80A335641C4; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:21 +0000
Message-Id: <af42ea5f006c5cf55a7c57a42904f412639d261f.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/11] toaster: libtoaster: Add getProjectInfo utility function
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:37 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add a utility function to return a specified project's info/config
This re-uses the existing server code path for the project edit
except that it allows any project id to be used as a parameter

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 22 ++++++++++++++++++++++
 lib/toaster/toastergui/urls.py                 |  1 +
 lib/toaster/toastergui/views.py                |  5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index b899b8d..4983ef6 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -88,10 +88,32 @@ var libtoaster = (function (){
     } });
   };
 
+  /* Get a project's configuration info */
+  function _getProjectInfo(url, projectId, onsuccess, onfail){
+    $.ajax({
+        type: "POST",
+        url: url,
+        data: { project_id : projectId },
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+          if (_data.error != "ok") {
+            console.log(_data.error);
+          } else {
+            if (onsuccess != undefined) onsuccess(_data);
+          }
+        },
+        error: function (_data) {
+          console.log(_data);
+          if (onfail) onfail(data);
+        }
+    });
+  };
+
   return {
     reload_params : reload_params,
     startABuild : _startABuild,
     makeTypeahead : _makeTypeahead,
+    getProjectInfo: _getProjectInfo,
   }
 })();
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index f43bb64..bae7103 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -85,6 +85,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^project/(?P<pid>\d+)/builds$', 'projectbuilds', name='projectbuilds'),
 
         url(r'^xhr_projectbuild/(?P<pid>\d+)/$', 'xhr_projectbuild', name='xhr_projectbuild'),
+        url(r'^xhr_projectinfo/$', 'xhr_projectinfo', name='xhr_projectinfo'),
         url(r'^xhr_projectedit/(?P<pid>\d+)/$', 'xhr_projectedit', name='xhr_projectedit'),
 
         url(r'^xhr_datatypeahead/$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 1b4bb9f..9f214bb 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2057,8 +2057,11 @@ if toastermain.settings.MANAGED:
         except Exception as e:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
+    def xhr_projectinfo(request):
+        if request.POST.has_key("project_id") == False:
+            raise BadParameterException("invalid project id")
 
-
+        return xhr_projectedit(request, request.POST['project_id'])
 
     def xhr_projectedit(request, pid):
         try:
-- 
1.9.1


