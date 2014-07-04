Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f177.google.com (mail-we0-f177.google.com
	[74.125.82.177])
	by mail.openembedded.org (Postfix) with ESMTP id 9C0236FEE3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:30 +0000 (UTC)
Received: by mail-we0-f177.google.com with SMTP id u56so1625923wes.36
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=T7EqbjOBA8BZBWkfRpHjwGL07uAOVWNUguNUh3T+4xM=;
	b=DWujfx8aHPW0XIy2wqCUl4JiBqHZglmiC2UqyvfSBIuvmzD2asac87Gf8F5hpEvYMT
	or8Hy4WmACV4SN+j+cd+tGDM5heaiUeb9SJeQkI5TN1e6K7ck/XTqbEmIrd/bM9gQKWr
	qrOh+kufcoGN6dN/BCsPbQYqbT/0FKV1KWxwz+c0wKNTmzem8xfUTlYwQ+X9gc+SbK/7
	a7hCmcrXe+GFzrhRHyDpiAtqDvj20dP5Su3SpLiOjN/R3CVgPmb0tm6Y4lMOe7nataFo
	lZgVqBdLByQIk1swEZMW7zTLULNv4iSva/6SFeV6PeUNRytQx2qZKvw5bGhbk1z2kCuL
	83Vw==
X-Gm-Message-State: ALoCoQkNe5ZcLs0JPIsiVTSfg+4SVb0SdxpuueZpu8A7R49rmT+5EUl5i+i8oIzowJltMLHSQhmq
X-Received: by 10.180.37.42 with SMTP id v10mr17460180wij.43.1404477871228;
	Fri, 04 Jul 2014 05:44:31 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gh16sm78938610wic.3.2014.07.04.05.44.28 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:29 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2905E56190C; Fri,  4 Jul 2014 13:44:27 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:24 +0100
Message-Id: <5f33d1a240faa49bd8259a48eb15ef57a6b4ce55.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 7/9] toaster: whitespace fix
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch is just a whitespace (end-of-line) fix.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templatetags/projecttags.py | 18 +++++++++---------
 lib/toaster/toastergui/views.py                    | 14 +++++++-------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index be75b21..b953aa1 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -142,7 +142,7 @@ def variable_parent_name(value):
     """
     value=re.sub('_\$.*', '', value)
     return re.sub('_[a-z].*', '', value)
-  
+
 @register.filter
 def filter_setin_files(file_list,matchstr):
     """ filter/search the 'set in' file lists. Note
@@ -150,7 +150,7 @@ def filter_setin_files(file_list,matchstr):
         the <p> marks, but this is safe as the data
         is file paths
     """
-   
+
     # no filters, show last file (if any)
     if matchstr == ":":
         if file_list:
@@ -162,24 +162,24 @@ def filter_setin_files(file_list,matchstr):
     htmlstr=""
     # match only filters
     if search == '':
-        for i in range(len(file_list)):   
+        for i in range(len(file_list)):
             if re.search(filter, file_list[i].file_name):
                 if htmlstr.find(file_list[i].file_name + "<p>") < 0:
                     htmlstr += file_list[i].file_name + "<p>"
         return htmlstr
-       
+
     # match only search string, plus always last file
     if filter == "":
-        for i in range(len(file_list)-1):   
+        for i in range(len(file_list)-1):
             if re.search(search,file_list[i].file_name):
                 if htmlstr.find(file_list[i].file_name + "<p>") < 0:
                     htmlstr += file_list[i].file_name + "<p>"
         if htmlstr.find(file_list[len(file_list)-1].file_name) < 0:
             htmlstr += file_list[len(file_list)-1].file_name
         return htmlstr
-       
+
     # match filter or search string
-    for i in range(len(file_list)):   
+    for i in range(len(file_list)):
         if re.search(filter, file_list[i].file_name) or re.search(search,file_list[i].file_name):
             if htmlstr.find(file_list[i].file_name + "<p>") < 0:
                 htmlstr += file_list[i].file_name + "<p>"
@@ -218,7 +218,7 @@ def filtered_packageversion(version, revision):
         else ""
     """
     return "" if (not version or version == "") else version if (not revision or revision == "") else version + "-" + revision
-        
+
 @register.filter
 def filter_sizeovertotal(package_object, total_size):
     """ Return the % size of the package over the total size argument
@@ -227,7 +227,7 @@ def filter_sizeovertotal(package_object, total_size):
     size = package_object.installed_size
     if size == None or size == '':
         size = package_object.size
-  
+
     return '{:.1%}'.format(float(size)/float(total_size))
 
 from django.utils.safestring import mark_safe
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 89c02d4..a57f001 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -429,7 +429,7 @@ def builddashboard( request, build_id ):
                 ndx = 0;
             f = i.file_name[ ndx + 1: ]
             imageFiles.append({ 'path': f, 'size' : i.file_size })
-        if ( t.is_image and 
+        if ( t.is_image and
              (( len( imageFiles ) <= 0 ) or ( len( t.license_manifest_path ) <= 0 ))):
             targetHasNoImages = True
         elem[ 'imageFiles' ] = imageFiles
@@ -516,8 +516,8 @@ def task( request, build_id, task_id ):
     }
     if request.GET.get( 'show_matches', "" ):
         context[ 'showing_matches' ] = True
-        context[ 'matching_tasks' ] = Task.objects.filter( 
-            sstate_checksum=task.sstate_checksum ).filter( 
+        context[ 'matching_tasks' ] = Task.objects.filter(
+            sstate_checksum=task.sstate_checksum ).filter(
             build__completed_on__lt=task.build.completed_on).exclude(
             order__isnull=True).exclude(outcome=Task.OUTCOME_NA).order_by('-build__completed_on')
 
@@ -551,14 +551,14 @@ def target_common( request, build_id, target_id, variant ):
     mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'name:+'};
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
-        return _redirect_parameters( 
-                    variant, request.GET, mandatory_parameters, 
+        return _redirect_parameters(
+                    variant, request.GET, mandatory_parameters,
                     build_id = build_id, target_id = target_id )
     ( filter_string, search_term, ordering_string ) = _search_tuple( request, Package )
 
     # FUTURE:  get rid of nested sub-queries replacing with ManyToMany field
     queryset = Package.objects.filter(
-                    size__gte = 0, 
+                    size__gte = 0,
                     id__in = Target_Installed_Package.objects.filter(
                         target_id=target_id ).values( 'package_id' ))
     packages_sum =  queryset.aggregate( Sum( 'installed_size' ))
@@ -682,7 +682,7 @@ his package',
         'clclass'    : 'layer_directory',
         'hidden'     : 1,
         }
-    context = { 
+    context = {
         'objectname': variant,
         'build'                : Build.objects.filter( pk = build_id )[ 0 ],
         'target'               : Target.objects.filter( pk = target_id )[ 0 ],
-- 
1.9.1


