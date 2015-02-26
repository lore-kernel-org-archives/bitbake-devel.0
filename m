Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by mail.openembedded.org (Postfix) with ESMTP id 97C5673784
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:23 +0000 (UTC)
Received: by wesw55 with SMTP id w55so15044266wes.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=7f9RItPcVpyVJlgFdp34C3uOzqiVSjo684fZ83+DG7A=;
	b=SJgvnUh1BkLYiD9emx0Tc/IXCeghI0ZCmmwS30YgNXF5b5CzJq1TxMZV9T3dRcIzH1
	jzAD6fS+K9lDVj0xfklW2Gof1exLCbuc/cWz6QtcKcHLdOKXNTo07gZvD1G61lTnZ2nK
	Ax0GexDwb6hTb6bQN+iUx+xr7wjAEu7UBfSNNMNdodcrW3NGqT5fWSZYeB7XtZyIc1H0
	XWhq/Y9Dm/iOh2JsXr7vptMLDUEqDZ7v+gOX7GbSQaD7Oedf2NXeywjPftuvEBO8qwwd
	XlieiiLy+R2e7SsvUv6fbj8a/jIPtsX6cw/8aBCX5ECS91xHaSRePZD/Vq9D7nGHzX/A
	sVRA==
X-Gm-Message-State: ALoCoQnIhE+DrkKAUstl0nbic5q7CjMXERdlY9uAeNvbCwZVUooRQVGUJj2P3mQs0el/CdDqmRor
X-Received: by 10.194.5.168 with SMTP id t8mr21354835wjt.150.1424986944045;
	Thu, 26 Feb 2015 13:42:24 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id j5sm55878wie.3.2015.02.26.13.42.21
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:23 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C519456172F; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:59 +0000
Message-Id: <b637123221a58f3084e144bbfbab0b8db6c3b6e4.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Subject: [PATCH 6/8] toastergui: add csrf tokens for AJAX calls
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds CSRF tokens in pages using AJAX calls in
order to force Django to generate the CSRF cookie used to
authenticate the call.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/layers.html              | 1 +
 lib/toaster/toastergui/templates/managed_mrb_section.html | 1 +
 lib/toaster/toastergui/templates/projectconf.html         | 1 +
 lib/toaster/toastergui/templates/targets.html             | 1 +
 4 files changed, 4 insertions(+)

diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 5cfda5b..864e156 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -117,6 +117,7 @@
 
 var tooltipUpdateText;
 
+/* ensure csrf cookie exists {% csrf_token %} */
 function _makeXHREditCall(data, onsuccess, onfail) {
     $.ajax( {
         type: "POST",
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index 08bb05d..d6e32f8 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -156,6 +156,7 @@
 
 <script>
 
+/* ensure csrf cookie exists {% csrf_token %} */
 function _makeXHRBuildCall(url, data, onsuccess, onfail) {
     $.ajax( {
         type: "POST",
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 9cacce4..dde8a11 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -429,6 +429,7 @@
             // re-assert the event handlers
         }
 
+	/* ensure cookie exists {% csrf_token %} */
         function postEditAjaxRequest(reqdata) {
             var ajax = $.ajax({
                     type:"POST",
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 234159a..690c6a5 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -120,6 +120,7 @@
 
 var tooltipUpdateText;
 
+/* ensure csrf cookie exists {% csrf_token %} */
 function _makeXHREditCall(data, onsuccess, onfail) {
     $.ajax( {
         type: "POST",
-- 
1.9.1


