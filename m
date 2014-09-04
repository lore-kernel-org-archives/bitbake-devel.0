Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 2DA9C7149A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:19 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id hi2so1443652wib.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=y9IIEbcA4tHSE13KdtXY9ZCfLDp0g/sPn0rqbVNScs8=;
	b=lLs1yWQdoXKhyM8IH71YeKe4NRiy1NrVAHNLTLh9CnI8Fq9egkUC3dNB3wNfFtDxyD
	40gEIDBUrrvY3VkmaXXNBm/tuEyrGZsFF5ZRJfc/unvBuRY4+ZOFF7sYDxmpnL6shRSJ
	O4cVmQMCT6AI5SFLOpTRddBrMDXAsNfn65h9zlo3ftD58Z9v6PovQYn9hwaQLc5CnwKk
	vkSd6PfoS967wyI1fppPYh1UMxpQ2VB7QftEYosaE7SlLC814qvwYgZVOBoZzH4QuiGy
	ymsjnMnCirxP6tnMj6zVtBaU50dgenZudnGc7eoXyPuL1soO7rzUEm661PI1QBIaYOK7
	H7Tg==
X-Gm-Message-State: ALoCoQnpr57+R06wO0f86aQySJpVY2XnXZVGNfK8z3bkCpmrSoRIy6Uy2CuEI0MZ4U+R569Cp3W5
X-Received: by 10.194.59.201 with SMTP id b9mr7706090wjr.43.1409849120205;
	Thu, 04 Sep 2014 09:45:20 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	k10sm19967389wjb.28.2014.09.04.09.45.18 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:19 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2EDAD5616CF; Thu,  4 Sep 2014 17:45:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:45:12 +0100
Message-Id: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1409848901.git.alexandru.damian@intel.com>
References: <cover.1409848901.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/6] toaster: rename bldviewer projecttags custom tagset
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We rename the projecttags in bldviewer.templatetags to
simple_projecttags in order to avoid conflict with the
similarly named tagset in toastergui.

The conflict leads to an intermittent bug where proper
tags are not read correctly since Django uses only the
module name as global tag library identificator.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldviewer/templates/simple_build.html                       | 2 +-
 lib/toaster/bldviewer/templates/simple_layer.html                       | 2 +-
 lib/toaster/bldviewer/templates/simple_recipe.html                      | 2 +-
 .../bldviewer/templatetags/{projecttags.py => simple_projecttags.py}    | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename lib/toaster/bldviewer/templatetags/{projecttags.py => simple_projecttags.py} (100%)

diff --git a/lib/toaster/bldviewer/templates/simple_build.html b/lib/toaster/bldviewer/templates/simple_build.html
index a6983f5..230e7c2 100644
--- a/lib/toaster/bldviewer/templates/simple_build.html
+++ b/lib/toaster/bldviewer/templates/simple_build.html
@@ -6,7 +6,7 @@
 
 {% block pagetable %}
 
-    {% load projecttags %}
+    {% load simple_projecttags %}
         <tr>
             <th>Outcome</th>
             <th>Started On</th>
diff --git a/lib/toaster/bldviewer/templates/simple_layer.html b/lib/toaster/bldviewer/templates/simple_layer.html
index ae7172d..25e7bf8 100644
--- a/lib/toaster/bldviewer/templates/simple_layer.html
+++ b/lib/toaster/bldviewer/templates/simple_layer.html
@@ -5,7 +5,7 @@
 {% endblock %}
 
 {% block pagetable %}
-    {% load projecttags %}
+    {% load simple_projecttags %}
 
         <tr>
             <th>Name</th>
diff --git a/lib/toaster/bldviewer/templates/simple_recipe.html b/lib/toaster/bldviewer/templates/simple_recipe.html
index 77b9de2..3bff3b9a 100644
--- a/lib/toaster/bldviewer/templates/simple_recipe.html
+++ b/lib/toaster/bldviewer/templates/simple_recipe.html
@@ -8,7 +8,7 @@
 {% endblock %}
 
 {% block pagetable %}
-    {% load projecttags %}
+    {% load simple_projecttags %}
 
         <tr>
         </tr>
diff --git a/lib/toaster/bldviewer/templatetags/projecttags.py b/lib/toaster/bldviewer/templatetags/simple_projecttags.py
similarity index 100%
rename from lib/toaster/bldviewer/templatetags/projecttags.py
rename to lib/toaster/bldviewer/templatetags/simple_projecttags.py
-- 
1.9.1


