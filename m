Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by mail.openembedded.org (Postfix) with ESMTP id 24DB2735C7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:07 +0000 (UTC)
Received: by wesx3 with SMTP id x3so3068956wes.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=g7cMSqTitxdQ++JNyxsqFXGZ9vEnFu28B4kyHKPfRxA=;
	b=hOEVl6AFPUu/DQUKeAgykrAVNeM9Fb9dwpv4GFb9Ya/m9lIpWQ0R+jm0MvoL0e+OK6
	cHMS75cF7WukJCWR0AzIbjrz9mawKAzSxuWG/7E/qdZ6TPyp1gUvpHi8YUf/ep7q2vad
	jTIBLMGP3m13pddcNeDA/vfp/JhEQCQuZ1tzfUs+WKOJn0QWslfyMI9rFD+QHLSgOz3u
	7PaIL8kB5eubUoDsVuGq0Eq5EVpJdgAhmJMUAyWZVDG8qfPm+bRzUnWG+CHqUSFWahhg
	w8qGjatexd4nnUuioJwMzBOIMo64WtQos/3UW2LQSF8buYw8Lo0Ak4LRcmqKOxQ9IRv6
	yOCg==
X-Gm-Message-State: ALoCoQlBfg9rGYRO0kTiu4RlNp2HioTk6mrNg+Ga1lt48UJS/lM0Usu8DdvT9orXv7YkcHkEABYG
X-Received: by 10.180.109.193 with SMTP id hu1mr5849106wib.25.1424286668699;
	Wed, 18 Feb 2015 11:11:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	pp10sm33936418wjc.31.2015.02.18.11.11.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 49ECB561F59; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:11:00 +0000
Message-Id: <6618a0a71cc9ea5426238549094ab9e05ae61649.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 06/10] toaster: landing page when no build module
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:09 -0000

From: David Reyna <David.Reyna@windriver.com>

Add landing page for managed build pages when build module not installed.

Some wording and whitespace changed.

[YOCTO #6483]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/landing_not_managed.html  | 32 +++++++++++++++++
 lib/toaster/toastergui/views.py                    | 42 +++++++++++-----------
 2 files changed, 53 insertions(+), 21 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/landing_not_managed.html

diff --git a/lib/toaster/toastergui/templates/landing_not_managed.html b/lib/toaster/toastergui/templates/landing_not_managed.html
new file mode 100644
index 0000000..fe56655
--- /dev/null
+++ b/lib/toaster/toastergui/templates/landing_not_managed.html
@@ -0,0 +1,32 @@
+{% extends "base.html" %}
+
+{% load static %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block pagecontent %}
+
+  <div class="container-fluid">
+   <div class="row-fluid">
+    <!-- Empty - no build module -->
+    <div class="page-header top-air">
+     <h1>
+       This page only works with the Toaster 'Build' mode
+     </h1>
+    </div>
+    <div class="alert alert-info">
+     <p class="lead">
+     The 'Build' mode allows you to configure and run your Yocto Project builds from Toaster
+     <ul>
+       <li class="lead"><a href="https://wiki.yoctoproject.org/wiki/Toaster#Modes">
+       Read about the 'Build' mode
+       </a></li>
+       <li class="lead"><a href="/">
+       View your builds
+       </a></li>
+     </ul>
+     </p>
+    </div>
+   </div>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a2e9206..70241dc 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -3290,64 +3290,64 @@ else:
 
 
     def newproject(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def project(request, pid):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_projectbuild(request, pid):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_build(request, pid):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_projectinfo(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_projectedit(request, pid):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_datatypeahead(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_configvaredit(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def importlayer(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def layers(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def layerdetails(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def targets(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def targetdetails(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def machines(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def projectconf(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def projectbuilds(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def build_artifact(request, build_id, artifact_type, artifact_id):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def projects(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_importlayer(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def xhr_updatelayer(request):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
 
     def buildrequestdetails(request, pid, brid):
-        raise Exception("page not available in interactive mode")
+        return render(request, 'landing_not_managed.html')
-- 
1.9.1


