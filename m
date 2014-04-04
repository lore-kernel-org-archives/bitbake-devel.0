Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id A39936B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:11:00 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id z2so1360421wiv.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vDYD1CJoOC5Qj6iuArCUCdiNMAYdwMcOLKUjMrjI5to=;
	b=MbGul46PwCB0bFWpszXgpXupMjJ3/ZtYKE0R3Ri8WUnkbG9oCkMoWM6ufU0x84sV1T
	vUtplYiYF8H4T0sLVUnVP8LP/H1ZUJtQKbu7qF2Ndoiho03VYBl+ZvERIEuk9Ynw06WI
	ClhazyN5tNzLKAGwCWHWJOJIQkEBntRjjND4q9yDQTezpKZtHN3DF2QPBegGpKR8qHLP
	JC8TIYpaLxdsn0e7p6JY07mKW7DYhtbEQWpjpf2pgmph5TCIXGu+vF78+teOYEa14uB/
	ky99RC+3+opxiNCl6GeFEsZcbaqd2RAPMZzcMEmnHSiTbEBhrDjrEWEKRGfWvsz9Hitu
	TKAA==
X-Gm-Message-State: ALoCoQk6tzghpwszbNHrglJeN9V36buxHXOYzO9Sq/mlYcCFg0VgVh1TSpr9JJZn1A93fWA4ZfM6
X-Received: by 10.180.85.134 with SMTP id h6mr4967491wiz.44.1396620661266;
	Fri, 04 Apr 2014 07:11:01 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ll1sm12630160wjc.6.2014.04.04.07.10.57
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 91D45560927; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:49 +0100
Message-Id: <f5eebce2d71a1ed42aa2f128935a2f09aa2b4b24.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 10/14] toaster: Fix the empty packages alert
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:01 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

* Remove a tag in all capitals
* Remove an unnecessary div
* Fix a typo

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/bpackage.html | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 22609e2..c6ec634 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -17,16 +17,14 @@
 
 <!-- Empty - no data in database -->
 <div class="page-header">
-  <div class="page-header">
     <h1>
-    Packages
+        Packages
     </h1>
-    </div>
-  <div class="alert alert-info lead">
-    <STRONG>No packages were built.</STRONG> How did this happen? Well, BitBake reuses as much stuff as possible.
-    If all of the packages needed were already built and available in your build infrastructure, Bitbake
+</div>
+<div class="alert alert-info lead">
+    <strong>No packages were built.</strong> How did this happen? Well, BitBake reuses as much stuff as possible.
+    If all of the packages needed were already built and available in your build infrastructure, BitBake
     will not rebuild any of them. This might be slightly confusing, but it does make everything faster.
-  </div>
 </div>
 
 {% else %}
-- 
1.9.1


