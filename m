Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f178.google.com (mail-wj0-f178.google.com
	[209.85.210.178])
	by mail.openembedded.org (Postfix) with ESMTP id 1627571D3D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:14 +0000 (UTC)
Received: by mail-wj0-f178.google.com with SMTP id xy5so19451538wjc.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Qq0STKTFP4bEBopoJSup0uc5ip1u33Qo2+QIAo7wKoQ=;
	b=FMDMGeOT5gAeaQuLv7fNnOjAxy5+Uaho35L1N5nxthn28+P9ZT3WgweH128IG0yKRR
	59bMVQ5puYQzu6ilSkI8GSjBm6UCs0nuBamet9mPNwdO2EIUKYh0apanlD7pCjMl9rHU
	0cZopI0kXxjDvaNySTKfW1pVlT8Je5NnTDlBNUoGKxXX8ndz9f4G7NxSdGtAgBwqyJkQ
	lekk6ooUjgt/8A1/ivsL4KyAN3XwXtXMRFiIXQAslU2rpvJ7clKys6xslQH/qBAx9YTn
	BB8H7uLJJwf6N8m6/jWM1UD2LxSujxPmm63Uxx3eRvxKPjdt8+RQQr/K8H4uiyx4xDv7
	x46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Qq0STKTFP4bEBopoJSup0uc5ip1u33Qo2+QIAo7wKoQ=;
	b=Sq6i7rLAxaYlNq2jsTIPdZf3Eo9oDKQ+ciniHzlGaPaDy/C9x1KaAa7GiHmgFkc9ZX
	Lhp5sa78YVdyEtRwWqW6ZLD68k8yRBVXULXhtEEL3cQy5M9+3qyEd8sa4nTRs7wr1eTH
	fnDpaSr9AEIqKMJBoJR9BEOajqSSoGDM+xqGw9/pMRNKST0/Tz6Div9crXx7ZZvst59W
	AdnG+FuwznZML7Yo7NltC6B8FYtFNh9hlEPHuj0veluy6tN/2i7wa/QSCmFQhJsNmskD
	2F1eLgN+RVzejrDOAlvP8oj693XUWLa1X051/hXMoXhEaPa2M5pSXLzWgU4NdQWQmR/A
	fwPw==
X-Gm-Message-State: AKaTC00Q8bDCaZ1Jk/Q3V5LCB70aK7uhMmE+xTgtq+vr7rcAVe5V36RQAaODfJXkMmNuzCxO
X-Received: by 10.194.0.167 with SMTP id 7mr66468504wjf.80.1481302395707;
	Fri, 09 Dec 2016 08:53:15 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:15 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:54 +0000
Message-Id: <1481302375-7985-14-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 13/14] toaster: js test Update js tests to use correct url for layer REST
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:15 -0000

Update js tests so that we use the new Layer REST API.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/tests/test.js | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/tests/test.js b/lib/toaster/toastergui/static/js/tests/test.js
index f3bf8d7..4a4c83f 100644
--- a/lib/toaster/toastergui/static/js/tests/test.js
+++ b/lib/toaster/toastergui/static/js/tests/test.js
@@ -5,6 +5,7 @@
 QUnit.test("Layer alert notification", function(assert) {
   var layer = {
     "layerdetailurl":"/toastergui/project/1/layer/22",
+    "xhrLayerUrl":"/toastergui/xhr_layer/1/9",
     "vcs_url":"git://example.com/example.git",
     "detail":"[ git://example.com/example.git | master ]",
     "vcs_reference":"master",
@@ -15,6 +16,7 @@ QUnit.test("Layer alert notification", function(assert) {
   var layerDepsList = [
     {
     "layerdetailurl":"/toastergui/project/1/layer/9",
+    "xhrLayerUrl":"/toastergui/xhr_layer/1/9",
     "vcs_url":"git://example.com/example.git",
     "detail":"[ git://example.com/example.git | master ]",
     "vcs_reference":"master",
@@ -23,6 +25,7 @@ QUnit.test("Layer alert notification", function(assert) {
     },
     {
     "layerdetailurl":"/toastergui/project/1/layer/9",
+    "xhrLayerUrl":"/toastergui/xhr_layer/1/9",
     "vcs_url":"git://example.com/example.git",
     "detail":"[ git://example.com/example.git | master ]",
     "vcs_reference":"master",
@@ -66,7 +69,8 @@ QUnit.test("Show notification", function(assert){
 var layer = {
   "id": 1,
   "name":  "meta-testing",
-  "layerdetailurl": "/toastergui/project/1/layer/1"
+  "layerdetailurl": "/toastergui/project/1/layer/1",
+  "xhrLayerUrl": "/toastergui/xhr_layer/1/1"
 };
 
 QUnit.test("Add layer", function(assert){
-- 
2.7.4


