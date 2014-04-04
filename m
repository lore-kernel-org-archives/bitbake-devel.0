Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id BC03A6E760
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:11:01 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id bs8so1338665wib.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=XeBV2XeCvFnsgXcKXWO0VfhEUqkIkPzoek3qAJUgXd0=;
	b=YRgdbaET08wWAusPoqpcZck8yKjsW4DH0PmNlQMKyoFUUfmy09DOId2v+p4Uc/TS7M
	I7bbygWIq6btxAIMVn/JyE/t+PHX4RekJQgahd//lnbR+hSUuwgirkrTF/UcFosTyPCh
	fmSZEfE8eFhLRxIEO5iP3t2azVv01IrFgNd29RnlZ7ElFk2oITafxt3vJUf96veSUn9X
	nz+CfoDfD39mMTO3isBavlc5T/HaUN5uPx6jJHNoosWoqISxB5AiF1kfAyf0oC2JeYZ9
	bhl74hDOt5O3TC3iJfwKsGbpxhjaJIze7adM+OeWVGNssA4+ZKELCuuJx4cYs6H5dYh1
	mptQ==
X-Gm-Message-State: ALoCoQnACeqpxodVdoscM1o1vHtIDk0n0TABb2smH0TWwQ1pQe5JlO4NtCMRi+/q7K3J0wk4sPBM
X-Received: by 10.194.71.164 with SMTP id w4mr20683218wju.0.1396620662421;
	Fri, 04 Apr 2014 07:11:02 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fs16sm4898864wic.18.2014.04.04.07.10.57 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9743B560F7F; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:52 +0100
Message-Id: <a6ded338cf91a4fae2b5f5413cc7cd509dfcbd5a.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: Farrell Wymore <farrell.wymore@windriver.com>
Subject: [PATCH 13/14] toaster: correct package count
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:03 -0000

From: Farrell Wymore <farrell.wymore@windriver.com>

The package count was incorrect because it was counting anonymous
packages. the full path of the image files was shortened to just
the filename.

[YOCTO 6087]
[YOCTO 6091]

Signed-off-by: Farrell Wymore <farrell.wymore@windriver.com>
---
 .../toastergui/templates/builddashboard.html       |  2 +-
 lib/toaster/toastergui/views.py                    | 73 ++++++++++++++--------
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 891d860..fa4b194 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -155,7 +155,7 @@
         <h4><a href="{% url 'recipes' build.pk %}">Recipes</a> & <a href="{% url 'packages' build.pk %}">Packages</a></h4>
             <dl>
         <dt>Recipes built</dt><dd><a href="{% url 'recipes' build.pk %}">{{recipecount}}</a></dd>
-        <dt>Packages built</dt><dd><a href="{% url 'packages' build.pk %}">{{build.package_set.all.count}}</a></dd>
+        <dt>Packages built</dt><dd><a href="{% url 'packages' build.pk %}">{{packagecount}}</a></dd>
             </dl>
     </div>
 </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e346ac4..2da81c1 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -381,42 +381,60 @@ def builds(request):
 # Each build may contain multiple targets and each target
 # may generate multiple image files. display them all.
 #
-def builddashboard(request, build_id):
+def builddashboard( request, build_id ):
     template = "builddashboard.html"
-    if Build.objects.filter(pk=build_id).count() == 0 :
-        return redirect(builds)
-    build = Build.objects.filter(pk = build_id)[0];
+    if Build.objects.filter( pk=build_id ).count( ) == 0 :
+        return redirect( builds )
+    build = Build.objects.filter( pk = build_id )[ 0 ];
     layerVersionId = Layer_Version.objects.filter( build = build_id );
     recipeCount = Recipe.objects.filter( layer_version__id__in = layerVersionId ).count( );
     tgts = Target.objects.filter( build_id = build_id ).order_by( 'target' );
 
+    ##
     # set up custom target list with computed package and image data
-    targets = [ ];
-    ntargets = 0;
-    hasImages = False;
+    #
+
+    targets = [ ]
+    ntargets = 0
+    hasImages = False
     for t in tgts:
-        elem = { };
-        elem[ 'target' ] = t;
+        elem = { }
+        elem[ 'target' ] = t
         if ( t.is_image ):
-            hasImages = True;
-        npkg = 0;
-        pkgsz = 0;
-        pid= 0;
-        tp = Target_Installed_Package.objects.filter( target_id = t.id );
-        package = None;
+            hasImages = True
+        npkg = 0
+        pkgsz = 0
+        pid= 0
+        tp = Target_Installed_Package.objects.filter( target_id = t.id )
+        package = None
         for p in tp:
-            pid = p.package_id;
+            pid = p.package_id
             package = Package.objects.get( pk = p.package_id )
-            pkgsz = pkgsz + package.size;
-            npkg = npkg + 1;
-        elem[ 'npkg' ] = npkg;
-        elem[ 'pkgsz' ] = pkgsz;
-        ti = Target_Image_File.objects.filter( target_id = t.id );
-        imageFiles = [ ];
+            pkgsz = pkgsz + package.size
+            if ( package.installed_name ):
+                npkg = npkg + 1
+        elem[ 'npkg' ] = npkg
+        elem[ 'pkgsz' ] = pkgsz
+        ti = Target_Image_File.objects.filter( target_id = t.id )
+        imageFiles = [ ]
         for i in ti:
-            imageFiles.append({ 'path': i.file_name, 'size' : i.file_size });
-        elem[ 'imageFiles' ] = imageFiles;
-        targets.append( elem );
+            ndx = i.file_name.rfind( '/' )
+            if ( ndx < 0 ):
+                ndx = 0;
+            f = i.file_name[ ndx + 1: ]
+            imageFiles.append({ 'path': f, 'size' : i.file_size })
+        elem[ 'imageFiles' ] = imageFiles
+        targets.append( elem )
+
+    ##
+    # how many packages in this build - ignore anonymous ones
+    #
+
+    packageCount = 0
+    packages = Package.objects.filter( build_id = build_id )
+    for p in packages:
+        if ( p.installed_name ):
+            packageCount = packageCount + 1
 
     context = {
             'build'           : build,
@@ -424,9 +442,10 @@ def builddashboard(request, build_id):
             'ntargets'        : ntargets,
             'targets'         : targets,
             'recipecount'     : recipeCount,
-            'logmessages'     : LogMessage.objects.filter(build=build_id),
+            'packagecount'    : packageCount,
+            'logmessages'     : LogMessage.objects.filter( build = build_id ),
     }
-    return render(request, template, context)
+    return render( request, template, context )
 
 
 def task(request, build_id, task_id):
-- 
1.9.1


