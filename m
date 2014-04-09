Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id 0C08565E21
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:46 +0000 (UTC)
Received: by mail-we0-f176.google.com with SMTP id x48so2421923wes.21
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=NYOivwcv1LuJzJ7XRHFF21qC9xQQ6PaOW/g1mS4FqYg=;
	b=K8JNWEnF9662c14TndnER2vYrXwBnLVw/nMgGhc8W15zK7qErnaSCuhjPXpJax5fWt
	/9Jmsde1Q+npUoKxtz37+1h+r3zeBHmIvlDDNOXuM3vo2CvKG5ua9nxq19NJXjRfGZuC
	R4F/hBO1n1NLKRG6WPDT0SGQFVokhxc1V7VmuvbiDe2P06ubMMjsGf9n4WdSFvz6+7by
	68o1KPBLg9G0fB3Vba+74DcvMF/ut/WhTfdM5hZvSto413yrgDVaLCWAbTmUN/DU/Aqs
	ZowSHGuSpodmQ5hDoKmjUnom0k5i6EIl1Eaiy2qUnnPQgNdIUNTHyFw4nOCzZzyZap9b
	ZCdQ==
X-Gm-Message-State: ALoCoQnPo8TW9n7P/5n4EtExwY6QCv1AZBMa8LAyK0Zr7QOyRGX9nI/IExvy791ZcbW6lGgXFLf0
X-Received: by 10.194.89.168 with SMTP id bp8mr2481027wjb.73.1397049466014;
	Wed, 09 Apr 2014 06:17:46 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id c7sm1661631wjf.19.2014.04.09.06.17.43
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:44 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7AE865602DB; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:37 +0100
Message-Id: <281c891d480d2763726c6f264b4e32b933d7c2cc.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 6/9] toaster: regex alternation filter caused django error
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:47 -0000

From: David Reyna <David.Reyna@windriver.com>

The combination of a regex filter specification that uses alternate,
plus a search string, plus multiple search_allowed_fields, leads to
a Django fatal error. Replace this regex filter for variables in
local files with a simpler 'contains' against the project's directory
plus a '/conf/' string.

Alex rebased this on top of fix for #6048.

[YOCTO #5962]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templatetags/projecttags.py |  6 +++---
 lib/toaster/toastergui/views.py                    | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index aa1ebf8..e863457 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -163,7 +163,7 @@ def filter_setin_files(file_list,matchstr):
     # match only filters
     if search == '':
         for i in range(len(file_list)):   
-            if file_list[i].file_name.find(filter) >= 0:
+            if re.search(filter, file_list[i].file_name):
                 if htmlstr.find(file_list[i].file_name + "<p>") < 0:
                     htmlstr += file_list[i].file_name + "<p>"
         return htmlstr
@@ -171,7 +171,7 @@ def filter_setin_files(file_list,matchstr):
     # match only search string, plus always last file
     if filter == "":
         for i in range(len(file_list)-1):   
-            if file_list[i].file_name.find(search) >= 0:
+            if re.search(search,file_list[i].file_name):
                 if htmlstr.find(file_list[i].file_name + "<p>") < 0:
                     htmlstr += file_list[i].file_name + "<p>"
         if htmlstr.find(file_list[len(file_list)-1].file_name) < 0:
@@ -180,7 +180,7 @@ def filter_setin_files(file_list,matchstr):
        
     # match filter or search string
     for i in range(len(file_list)):   
-        if (file_list[i].file_name.find(filter) >= 0) or (file_list[i].file_name.find(search) >= 0):
+        if re.search(filter, file_list[i].file_name) or re.search(search,file_list[i].file_name):
             if htmlstr.find(file_list[i].file_name + "<p>") < 0:
                 htmlstr += file_list[i].file_name + "<p>"
     return htmlstr
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4ed9940..78726a8 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1154,17 +1154,17 @@ def configvars(request, build_id):
 
     variables = _build_page_range(Paginator(queryset, request.GET.get('count', 50)), request.GET.get('page', 1))
 
+    # show all matching files (not just the last one)
     file_filter= search_term + ":"
-    if filter_string.find('conf/local.conf') > 0:
-        file_filter += 'conf/local.conf'
-    if filter_string.find('conf/bblayers.conf') > 0:
-        file_filter += 'conf/bblayers.conf'
+    if filter_string.find('/conf/') > 0:
+        file_filter += 'conf/(local|bblayers).conf'
     if filter_string.find('conf/machine/') > 0:
         file_filter += 'conf/machine/'
     if filter_string.find('conf/distro/') > 0:
         file_filter += 'conf/distro/'
     if filter_string.find('/bitbake.conf') > 0:
         file_filter += '/bitbake.conf'
+    build_dir=re.sub("/tmp/log/.*","",Build.objects.filter(pk=build_id)[0].cooker_log_path)
 
     context = {
                 'objectname': 'configvars',
@@ -1193,7 +1193,7 @@ def configvars(request, build_id):
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
                     'options' : [
-                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf', queryset_with_search.filter(vhistory__file_name__regex='conf/(local|bblayers).conf').count(), 'Select this filter to see variables set by the <code>local.conf</code> and <code>bblayers.conf</code> configuration files inside the <code>/build/conf/</code> directory'),
+                               ('Local configuration variables', 'vhistory__file_name__contains:'+build_dir+'/conf/',queryset_with_search.filter(vhistory__file_name__contains=build_dir+'/conf/').count(), 'Select this filter to see variables set by the <code>local.conf</code> and <code>bblayers.conf</code> configuration files inside the <code>/build/conf/</code> directory'),
                                ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/',queryset_with_search.filter(vhistory__file_name__contains='conf/machine').count(), 'Select this filter to see variables set by the configuration file(s) inside your layers <code>/conf/machine/</code> directory'),
                                ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/',queryset_with_search.filter(vhistory__file_name__contains='conf/distro').count(), 'Select this filter to see variables set by the configuration file(s) inside your layers <code>/conf/distro/</code> directory'),
                                ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf',queryset_with_search.filter(vhistory__file_name__contains='conf/layer.conf').count(), 'Select this filter to see variables set by the <code>layer.conf</code> configuration file inside your layers'),
-- 
1.9.1


