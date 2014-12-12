Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id CD62B7250C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:26 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id bs8so2235337wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=0JCjFMuxpgNJ9jWVjWVgc8uoB3zK+7RchvaaGeHrwC0=;
	b=THw6iZmOf3THEqvpIwNpViVQAfKLjLQPAuTMaLz4rplQL8yGergHNtpwXrMHih+Dq5
	UOncQHfkI+sHU+XAFoeqJHjEPoOGIA2jRVCpe0aaiAbbgiQh4zAU8qJ2J1ByFptccU8+
	ch4jb9lVQATaA2AdRwRuYBYdI/XhRYF3RTxg3U5DJGgpKPFzqA/RXOjwWx0Xm0iCXsMh
	2vh18SbxdJZqGwoxoUN1X7Fk/HxC66jwYruI5LGAvxfaUYZZGCfBiLTmoZxs5vJcEFb5
	wMBGZ3IHR7tsB7G8cLmjqDXZxI8hfzbluVLatmqjZb1Cn9/zedtDHrnV36MXIMlV5knB
	WJzQ==
X-Gm-Message-State: ALoCoQmiPEiI8qGZQLG1rAnVteOfIV0UClEHZTJgfoB3N9C7G2zDaOVHPy6mLIykc+AyPHrZ1odZ
X-Received: by 10.194.2.164 with SMTP id 4mr25451195wjv.55.1418384727230;
	Fri, 12 Dec 2014 03:45:27 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id h13sm1645291wiw.4.2014.12.12.03.45.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4A9A056625D; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:14 +0000
Message-Id: <07e5c7c82519604501feb7d892db330c610978e9.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 15/18] toaster: projectapp Add links to the imported layers notify
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:29 -0000

From: Michael Wood <michael.g.wood@intel.com>

Adds links to layer details for each of the layers that has been added
to the project.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js |  3 +--
 lib/toaster/toastergui/static/js/projectapp.js  | 29 ++++++++++++++++++-------
 lib/toaster/toastergui/templates/project.html   |  3 ++-
 lib/toaster/toastergui/views.py                 |  4 ++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 34dbcd9..5748efd 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -152,9 +152,8 @@ function importLayerPageInit (ctx) {
               show_error_message(data, layerData);
               console.log(data.error);
             } else {
-              layerData.layersAdded = data.layers_added;
               /* Success layer import now go to the project page */
-              $.cookie('layer-imported-alert', JSON.stringify(layerData), { path: '/'});
+              $.cookie('layer-imported-alert', JSON.stringify(data), { path: '/'});
               window.location.replace(ctx.projectPageUrl+'#/layerimported');
             }
           },
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 94c24f4..741038d 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -578,18 +578,31 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
           if (!imported)
             return;
 
-          if (imported.layersAdded.length == 0) {
-            text = "You have imported <strong>"+imported.name+
-              "</strong> and added it to your project.";
+          if (imported.deps_added.length == 0) {
+            text = "You have imported <strong><a href=\""+$scope.urls.layer+
+              imported.imported_layer.id+"\">"+imported.imported_layer.name+
+              "</a></strong> and added it to your project.";
           } else {
-            text = "You have imported <strong>"+imported.name+
-              "</strong> and added <strong>"+imported.layersAdded.length+
-              "</strong> layers to your project. <strong>"+
-              imported.layersAdded.join(", ")+"</strong>";
+            var links = "<a href=\""+$scope.urls.layer+
+              imported.imported_layer.id+"\">"+imported.imported_layer.name+
+              "</a>, ";
+
+            imported.deps_added.map (function(item, index){
+              links +="<a href=\""+$scope.urls.layer+item.id+"\" >"+item.name+
+                "</a>";
+              /*If we're at the last element we don't want the trailing comma */
+              if (imported.deps_added[index+1] != undefined)
+                links += ", ";
+            });
+
+            /* Length + 1 here to do deps + the imported layer */
+            text = "You have imported <strong><a href=\""+$scope.urls.layer+
+              imported.imported_layer.id+"\">"+imported.imported_layer.name+
+              "</a></strong> and added <strong>"+(imported.deps_added.length+1)+
+              "</strong> layers to your project. <strong>"+links+"</strong>";
           }
 
             $scope.displayAlert($scope.zone2alerts, text, "alert-info");
-
             // This doesn't work
             $cookieStore.remove("layer-imported-alert");
             //use jquery plugin instead
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 113e382..2979db7 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -382,7 +382,8 @@ angular.element(document).ready(function() {
   scope.urls.xhr_datatypeahead = "{% url 'xhr_datatypeahead' %}";
   scope.urls.layers = "{% url 'layers' %}";
   scope.urls.targets = "{% url 'targets' %}";
-  scope.urls.importlayer = "{% url 'importlayer'%}"
+  scope.urls.importlayer = "{% url 'importlayer'%}";
+  scope.urls.layer = "{% url 'layerdetails' %}";
   scope.project = {{prj|json}};
   scope.builds = {{builds|json}};
   scope.layers = {{layers|json}};
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index dd43080..679c1e9 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2322,7 +2322,7 @@ if toastermain.settings.MANAGED:
                             continue
 
                         if prj_layer_created:
-                            layers_added.append(Layer.objects.get(id=layer_dep_obj.layer_id).name)
+                            layers_added.append({'id': layer_dep_obj.id, 'name': Layer.objects.get(id=layer_dep_obj.layer_id).name})
 
 
                 # If an old layer version exists in our project then remove it
@@ -2342,7 +2342,7 @@ if toastermain.settings.MANAGED:
                 return HttpResponse(jsonfilter({"error": "Uncaught error: Could not create layer version"}), content_type = "application/json")
 
 
-        return HttpResponse(jsonfilter({"error": "ok", "layers_added": layers_added}), content_type = "application/json")
+        return HttpResponse(jsonfilter({"error": "ok", "imported_layer" : { "name" : layer.name, "id": layer_version.id },  "deps_added": layers_added }), content_type = "application/json")
 
 
 
-- 
1.9.1


