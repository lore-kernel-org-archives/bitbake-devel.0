Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 6AC9F73943
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:54 +0000 (UTC)
Received: by wgha1 with SMTP id a1so15469838wgh.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=mdRNXKACm4XsEk8C1JXmb0vOfVB9phxSPA35lqrOsfA=;
	b=ZT0cCmscEaDvd07WhbL5rI4REAdgbtFeTOk04Od7OCACyJqwhCnSDFuI6pc3euRcjj
	4G6LW3zvj3hdW154CkkwafH0/i1JbqIN6AJ0Tn91FDZOabyTAkluGwc72gQJOFEwkqva
	9q4TCbWqg+Mehc6Zo3Suxl71nw4r/LY90zcfw8kFAHao2eyQ8CoOKuDsgnZVIbgB8SO5
	y4RwsN/jOSSt5cRRlpg8iCDi9Z6+SfH+k0Uh0N9fALhfJGy9dxasLHSmZix7nPWuHRxR
	CajgShPejGgd4dgRWM1Qx9+acR5InOWzcuZw6PWLFkyWZ/gitxu3FrBgDSc4pjZg8y3Y
	Iazw==
X-Gm-Message-State: ALoCoQk+ERxSBlHu5yJcZpvYYNSAIK2aBQJMWaTfNYFxphTiwZerMHI/M+M2NPG3yCsWnY7JV55p
X-Received: by 10.194.176.162 with SMTP id cj2mr21895853wjc.93.1426157216009; 
	Thu, 12 Mar 2015 03:46:56 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nd15sm10115379wic.8.2015.03.12.03.46.53
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:55 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 78D765627BB; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:49 +0000
Message-Id: <239b0f5b9d044dab5f21a0d0b5285be3990ea568.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 16/17] toaster: projectconf fix typo of package name
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:55 -0000

From: Michael Wood <michael.g.wood@intel.com>

The package should be deb rather than dev.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index c994f31..ffdf760 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -89,7 +89,7 @@
                         <i class="icon-question-sign get-help" title="The package format used to generate the root file system. Options are <code>dev</code>, <code>ipk</code> and <code>rpm</code>"></i>
                     </label>
                     <select id="package_classes-select">
-                        <option>package_dev</option>
+                        <option>package_deb</option>
                         <option>package_ipk</option>
                         <option>package_rpm</option>
                     </select>
@@ -98,7 +98,7 @@
                         <i class="icon-question-sign get-help" title="Extra package formats to build"></i>
                     </label>
                     <label class="checkbox" id="package_class_1">
-                        <input type="checkbox" id="package_class_1_input"> package_dev
+                        <input type="checkbox" id="package_class_1_input"> package_deb
                     </label>
                     <label class="checkbox" id="package_class_2">
                         <input type="checkbox" id="package_class_2_input"> package_ipk
@@ -325,16 +325,16 @@
         // Preset or reset the Package Class checkbox labels
         function updatePackageClassCheckboxes() {
             $('#package_class_1, #package_class_2').hide();
-            if ($('select').val() == 'package_dev') {
+            if ($('select').val() == 'package_deb') {
                 $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_ipk');
                 $('#package_class_2').html('<input type="checkbox" id="package_class_2_input"> package_rpm');
             }
             if ($('select').val() == 'package_ipk') {
-                $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_dev');
+                $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_deb');
                 $('#package_class_2').html('<input type="checkbox" id="package_class_2_input"> package_rpm');
             }
             if ($('select').val() == 'package_rpm') {
-                $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_dev');
+                $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_deb');
                 $('#package_class_2').html('<input type="checkbox" id="package_class_2_input"> package_ipk');
             }
             $('#package_class_1, #package_class_2').fadeIn(1500);
@@ -687,7 +687,7 @@
 
                 // initialize the pulldown and checkboxes
                 var value = document.getElementById("package_classes").innerHTML;
-                if (0 == value.indexOf("package_dev")) {
+                if (0 == value.indexOf("package_deb")) {
                     $('select').selectedIndex = 0;
                     updatePackageClassCheckboxes();
                     if (0 < value.indexOf("package_ipk")) {document.getElementById("package_class_1_input").checked = true};
@@ -696,13 +696,13 @@
                 if (0 == value.indexOf("package_ipk")) {
                     $('select').selectedIndex = 1;
                     updatePackageClassCheckboxes();
-                    if (0 < value.indexOf("package_dev")) {document.getElementById("package_class_1_input").checked = true;};
+                    if (0 < value.indexOf("package_deb")) {document.getElementById("package_class_1_input").checked = true;};
                     if (0 < value.indexOf("package_rpm")) {document.getElementById("package_class_2_input").checked = true;};
                 }
                 if (0 == value.indexOf("package_rpm")) {
                     $('select').selectedIndex = 2;
                     updatePackageClassCheckboxes();
-                    if (0 < value.indexOf("package_dev")) {document.getElementById("#package_class_1_input").checked = true;};
+                    if (0 < value.indexOf("package_deb")) {document.getElementById("#package_class_1_input").checked = true;};
                     if (0 < value.indexOf("package_ipk")) {document.getElementById("#package_class_2_input").checked = true;};
                 }
             });
@@ -723,16 +723,16 @@
 
                 pc1_checked = document.getElementById("package_class_1_input").checked;
                 pc2_checked = document.getElementById("package_class_2_input").checked;
-                if (val == "package_dev") {
+                if (val == "package_deb") {
                     if (pc1_checked) val = val + " package_ipk";
                     if (pc2_checked) val = val + " package_rpm";
                 }
                 if (val == "package_ipk") {
-                    if (pc1_checked) val = val + " package_dev";
+                    if (pc1_checked) val = val + " package_deb";
                     if (pc2_checked) val = val + " package_rpm";
                 }
                 if (val == "package_rpm") {
-                    if (pc1_checked) val = val + " package_dev";
+                    if (pc1_checked) val = val + " package_deb";
                     if (pc2_checked) val = val + " package_ipk";
                 }
 
-- 
1.9.1


