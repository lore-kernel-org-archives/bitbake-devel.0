Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f175.google.com (mail-wj0-f175.google.com
	[209.85.210.175])
	by mail.openembedded.org (Postfix) with ESMTP id B50EC6013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:15 +0000 (UTC)
Received: by mail-wj0-f175.google.com with SMTP id v7so19391114wjy.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wgfFUVtJ+hyw5KhzNUsjGwnIyCYYR17T4Fx/sXUJzxY=;
	b=b0E7royyTQPZt3DLwjWLaUfpSFod9FTF7ZQ3o2UiRwrWweo36NiBvyoplIdbox17Un
	r0CPp5vrR4YdfwHHEYy6+o+TCv6YiRoI4oSE+GY/RYq6lRQ+zhV85ZfT2u12S6+jg8Qc
	iQz8f/w1E4rbW/Bs4yMrs9PITjCctrdtiPiN/OKhiIY0YHF7gszGZokS1kMjniSAx9vh
	ncOkD6g93UW25fC2WDTyBb712yelPRJ11NY8hVD8CTXAyKJG+DE/yO6v8rlHH8MsecPH
	+BirGwklcUvqoTWo2Mib4bKe89H09qQHiYY3nf1hfmeOzrFgWrxVCF4DOMbNN8Yr1Flc
	iRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wgfFUVtJ+hyw5KhzNUsjGwnIyCYYR17T4Fx/sXUJzxY=;
	b=HUTfQ+SzTga8diZM3jwum5wUyIJgNQq9RySk64bd1bcRDbXQdE0JK3cmWkWNmqXP8Y
	EgXSOuh8PG08QZwQ1pFzLho54pw8KIeoMh8No3V2ynFlM2z9CLJioePxS3nwyx69rl+6
	o6s2g5L6F7sd8VSKlbJ7/DusPGlbhNmUq2zCd+OfvRy3fNZOzR7REkKh9ThKQ5ObXYk4
	ezss3E5TnZOYFQMkpXkCV+01C6xcc1yfVozwDB1lxktaik3LYjD4LLnvSsWoY+f2K3Cd
	+Akem07JNZ5o/z7Ar7zzGe2jm0VRMmcmllJnztmD9/rUvg6ORUddrGYbcNvs7TugD+0y
	O1GA==
X-Gm-Message-State: AKaTC02Lb/yWYtHz0l8NcoSmeqhlVBiAGUuqc31+6/M6wC/ZZQP6kB5HYAot3juDpYQcY5tN
X-Received: by 10.194.114.10 with SMTP id jc10mr39181901wjb.157.1481302396699; 
	Fri, 09 Dec 2016 08:53:16 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:16 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:55 +0000
Message-Id: <1481302375-7985-15-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 14/14] toaster: views Remove old code that converts template context to JSON
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:16 -0000

Remove the template context to JSON decorator function as this is
deprecated by having a proper REST API.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 94b630a..75c5911 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -120,32 +120,6 @@ def objtojson(obj):
         raise TypeError("Unserializable object %s (%s) of type %s" % ( obj, dir(obj), type(obj)))
 
 
-def _template_renderer(template):
-    def func_wrapper(view):
-        def returned_wrapper(request, *args, **kwargs):
-            try:
-                context = view(request, *args, **kwargs)
-            except RedirectException as e:
-                return e.get_redirect_response()
-
-            if request.GET.get('format', None) == 'json':
-                # objects is a special keyword - it's a Page, but we need the actual objects here
-                # in XHR, the objects come in the "rows" property
-                if "objects" in context:
-                    context["rows"] = context["objects"].object_list
-                    del context["objects"]
-
-                # we're about to return; to keep up with the XHR API, we set the error to OK
-                context["error"] = "ok"
-
-                return HttpResponse(jsonfilter(context, default=objtojson ),
-                            content_type = "application/json; charset=utf-8")
-            else:
-                return render(request, template, context)
-        return returned_wrapper
-    return func_wrapper
-
-
 def _lv_to_dict(prj, x = None):
     if x is None:
         def wrapper(x):
@@ -1528,8 +1502,6 @@ if True:
         }
         return render(request, template, context)
 
-    # TODO merge with api pseudo api here is used for deps modal
-    @_template_renderer('layerdetails.html')
     def layerdetails(request, pid, layerid):
         project = Project.objects.get(pk=pid)
         layer_version = Layer_Version.objects.get(pk=layerid)
@@ -1557,7 +1529,7 @@ if True:
             'projectlayers': list(project_layers)
         }
 
-        return context
+        return render(request, 'layerdetails.html', context)
 
 
     def get_project_configvars_context():
@@ -1577,7 +1549,6 @@ if True:
 
         return(vars_managed,sorted(vars_fstypes),vars_blacklist)
 
-    @_template_renderer("projectconf.html")
     def projectconf(request, pid):
 
         try:
@@ -1648,7 +1619,7 @@ if True:
         except (ProjectVariable.DoesNotExist, BuildEnvironment.DoesNotExist):
             pass
 
-        return context
+        return render(request, "projectconf.html", context)
 
     def _file_names_for_artifact(build, artifact_type, artifact_id):
         """
-- 
2.7.4


