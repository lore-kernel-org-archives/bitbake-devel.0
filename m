Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 324836EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:04 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so2461893wes.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Lb4N9yAtAerEDwSFxisRxRtUl2zUTUj7GLmZwBMdHDs=;
	b=ff9uLHM6MI/ejKWgJ4aqzSHpvTmviyaCnJROEycbMQsdrgcezp8jREqydooSeLtvwS
	yjsSKiRAyiOigrBON5w2NNByFMVOBG98gVMzWh+5guBHL//BM3LEJ9jlaNLPo7vYjOOr
	7YMUEiWeDS40UYKEuf0fBXa1iaJH6Tgq6IITF2aIjR4lPt8YX+jxf34D1q19m8pkq3ZL
	QvCMRyEDWd3FCIp6ATapAF12IdwJYX7+zwSathhY9QRHCPkG1iiy/qBoGGSnXjnmrLF+
	2pVxIDtPrtoCeQJroGBf2Uj1EFjvSXSQaYHgtfWnaciN0+FG6tGIurDZxxtfTmtIRNpr
	lk/g==
X-Gm-Message-State: ALoCoQlltnijBatZzMbIRFlAE5CTxIVFfg5WKRryEIM+oQdCxi5zB8H2tM6xO9Hye9IigH7JAU6J
X-Received: by 10.180.8.130 with SMTP id r2mr7395170wia.14.1394819945595;
	Fri, 14 Mar 2014 10:59:05 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id f7sm15568338wjb.7.2014.03.14.10.59.03
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:04 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 11AD1561101; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:47 +0000
Message-Id: <c0820f93e0387d2b6ead9e2fa7205d49001d27e6.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 06/19] toaster: Replace hyphens with underscores in package name
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:07 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Package details pages were using hyphens to separate package
name from package version. Changing them to underscores.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/package_detail_base.html             | 4 ++--
 lib/toaster/toastergui/templates/package_included_dependencies.html   | 4 ++--
 lib/toaster/toastergui/templates/package_included_detail.html         | 4 ++--
 .../toastergui/templates/package_included_reverse_dependencies.html   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index a7aaab6..79f135c 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -2,7 +2,7 @@
 {% load projecttags %}
 
 {% block localbreadcrumb %}
-{% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
+{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
     {% if target %}
         <li><a href="{% url "target" build.id target.id %}">{{target.target}}</a></li>
     {% else %}
@@ -13,7 +13,7 @@
 {% endblock localbreadcrumb %}
 
 {% block pagedetailinfomain %}
-{% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
+{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
 
     <div class="row span11">
         <div class="page-header">
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index 00d42e7..71043ec 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -2,13 +2,13 @@
 {% load projecttags %}
 
 {% block title %}
-    {% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
+    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
         <h1>{{fullPackageSpec}} <small>({{target.target}})</small></h1>
     {% endwith %}
 {% endblock title %}
 
 {% block tabcontent %}
-    {% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
     {% include "package_included_tabs.html" with active_tab="dependencies" %}
     <div class="tab-content">
        <div class="tab-pane active" id="dependencies">
diff --git a/lib/toaster/toastergui/templates/package_included_detail.html b/lib/toaster/toastergui/templates/package_included_detail.html
index af56b21..df25885 100644
--- a/lib/toaster/toastergui/templates/package_included_detail.html
+++ b/lib/toaster/toastergui/templates/package_included_detail.html
@@ -2,13 +2,13 @@
 {% load projecttags %}
 
 {% block title %}
-{% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
+{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
         <h1>{{fullPackageSpec}} <small>({{target.target}})</small></h1>
 {% endwith %}
 {% endblock title %}
 
 {% block tabcontent %}
-{% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
     {% include "package_included_tabs.html" with active_tab="detail" %}
     <div class="tab-content">
         <div class="tab-pane active" id="files">
diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 8ae0af3..d0edeb5 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -2,13 +2,13 @@
 {% load projecttags %}
 
 {% block title %}
-    {% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec  %}
+    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec  %}
         <h1>{{fullPackageSpec}} <small>({{target.target}})</small></h1>
     {% endwith %}
 {% endblock title %}
 
 {% block tabcontent %}
-    {% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
     {% include "package_included_tabs.html" with active_tab="reverse" %}
     <div class="tab-content">
         <div class="tab-pane active" id="brought-in-by">
-- 
1.8.3.2


