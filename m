Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 3CB45759C7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 15:07:28 +0000 (UTC)
Received: by wibxm9 with SMTP id xm9so170699258wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Aug 2015 08:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=5Ugj+YpX9fRDZLFjVe9ShDGEfmcQQgt9qlhQfRn/Bl4=;
	b=erS/FXDfW9qsqP1GZaCgdDA7aALNOTcqBGlhELvqiQ8fMEn9Pd6N0zMoexhWOxFVdU
	fyRsdnaDIlyMoVoHSRINq+VhJIRkEoaMZzAbB7+5qzH4KOapcn5ltqSpjCFfYQ/BgvN+
	/1F6VLmQlZ74E53+E+foUPJHcrbUK6eWne+4MQew+svO+6fNuUjCVAnIo5ekTp4GzGdq
	9+bLrYEJ4Sg8WCAt86NRK2kr2XLbtUgFMEf4E5QK5yye3DzLoEQwq1chQn1gp6FM4VWd
	rYEXrGBo9fL8Y4erGuQAPkyFR0YaqWKYz1DMiLwYw9mIRoiyZTCSMWw0lDo41xQfBvmy
	oS7Q==
X-Gm-Message-State: ALoCoQn5S8KzEzK/+MD5rqt3crSVK7Qmmxu9NXzQv2niPdj75nIbkwvVlhBdVMnSetd/K+y70cRf
X-Received: by 10.181.13.169 with SMTP id ez9mr8400411wid.92.1438700848460;
	Tue, 04 Aug 2015 08:07:28 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gm20sm2314260wjc.17.2015.08.04.08.07.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Aug 2015 08:07:27 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 16:07:06 +0100
Message-Id: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 1/6] bitbake: toastergui: spacing and top nav style change
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
X-List-Received-Date: Tue, 04 Aug 2015 15:07:30 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Remove the margin for the .section class and the
.row-fluid class in the page header div to
reduce the vertical white space a little
bit in the project pages.

Also, change the style of the Toaster manual
link to make it look like the main navigation.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css       |  1 -
 lib/toaster/toastergui/templates/base.html          | 16 +++++++++++-----
 lib/toaster/toastergui/templates/projecttopbar.html |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 638c6dd..dbe2307 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -10,7 +10,6 @@
 
 /* Style the breadcrumb */
 .breadcrumb { display: inline-block; background-color: transparent; }
-.section { margin: 20px 0; }
 
 /* Styles for the help information */
 .get-help { color: #CCCCCC; }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index c16fd65..65367e2 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -102,11 +102,17 @@
                 <i class="icon-folder-open"></i>
                 All projects
               </a>
-            </li>                                                                         </ul>
-          <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
-            <i class="icon-book"></i>
-            Toaster manual
-          </a>
+            </li>
+          </ul>
+          <ul class="nav pull-right">
+            <li>
+              <a target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
+                <i class="icon-book"></i>
+                Manual
+              </a>
+            </li>
+          </ul>
+          <span class="pull-right divider-vertical"></span>
           <div class="btn-group pull-right">
             <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
           </div>
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 79f6d1e..220ca72 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -4,7 +4,7 @@
 </div>
 
 <!-- project name -->
-<div class="row-fluid page-header">
+<div class="page-header">
   <h1><span id="project-name">{{project.name}}</span>
     <i class="icon-pencil" data-original-title="" id="project-change-form-toggle" title=""></i>
   </h1>
-- 
2.1.4


