Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 4FF3077187
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:43 +0000 (UTC)
Received: by pabrc13 with SMTP id rc13so149569283pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=l1NMYqKb99SvFh5IApDNLXGp0oY6JIys+SLPLhSwddc=;
	b=sUD1vL3NLmDEy39hihXqWSLgPTQvjmZ3OYvmzttq5YYK8uO7/krQqb360VCV5a0P/A
	hQ4kUm+Wi0ApYlBFOzyumVGs2cMxbSEHvSL1U+r55LrL2FA3XnZBx0790SERjLnRo209
	hmH9zGFdbQcgczYYOdOAmkT96BNLA/nvb7hJYrmaidTzbGSHNEMs7XKhtQFcTes/tgku
	WOEQCrmn/XnRwdlzjX5+Wx05buFjnJk7eRWeBD+/K87uFQBEmLZ0sy65/h2WDwOzmAcB
	VlYN2fU/tW84xhxr5xJ9cCZ4Z55eISIJzSrTH0cRyMRUJwXHUvWbeKbrdH0kvvBQQJ/W
	cF2A==
X-Received: by 10.66.155.231 with SMTP id vz7mr23739713pab.58.1445103824393;
	Sat, 17 Oct 2015 10:43:44 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	bn1sm27888794pad.17.2015.10.17.10.43.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:43 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:49 -0700
Message-Id: <00a636cf84b1f680f622380b016699d09cd46f71.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
References: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
In-Reply-To: <cover.1445103849.git.avery.brian@gmail.com>
References: <cover.1445103849.git.avery.brian@gmail.com>
Subject: [PATCH 2/6] toaster: Show mode-appropriate landing page
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:45 -0000

From: Elliot Smith <elliot.smith@intel.com>

The same landing page is shown for both analysis and
build modes. This means that users in analysis mode can see
options which are not available or broken in that mode.

Modify the landing page template to show a simple "run a build"
message if the user is in analysis mode and has no builds yet.

Also clean up the landing page HTML, because the indentation was
a mess and the HTML was invalid.

[YOCTO #8514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/landing.html | 103 +++++++++++++++-----------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 45e9532..65d8c3c 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -6,53 +6,66 @@
 
 {% block pagecontent %}
 
-  <div class="container-fluid">
-   <div class="row-fluid">
-    <!-- Empty - no data in database -->
-    <div class="hero-unit span12 well-transparent">
-     <div class="row-fluid">
-      <div class="span6">
-       <h1>
-        This is Toaster
-       </h1>
-       <p>A web interface to <a href="http://www.openembedded.org">OpenEmbedded</a> and <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
-
-
-		{% if lvs_nos %}
-		    <p class="hero-actions">
-			    <a class="btn btn-primary btn-large" href="{% url 'newproject' %}">
-				    To start building, create your first Toaster project
-			    </a>
-		    </p>
-		{% else %}
-		    <div class="alert alert-info lead air">
-			    Toaster has no layer information. Without layer information, you cannot run builds. To generate layer information you can:
-			    <ul>
-			        <li>
-			            <a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#layer-source">Configure a layer source</a>
-			        </li>
-			        <li>
-			            <a href="{% url 'newproject' %}">Create a project</a>, then import layers
-			        </li>
-			    </ul>
-		    </div>
-	        {% endif %}
-
-        <ul class="unstyled">
-            <li>
-                <a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">Read the Toaster manual</a>
-            </li>
-            <li>
-                <a href="https://wiki.yoctoproject.org/wiki/Contribute_to_Toaster">Contribute to Toaster</a>
-            </li>
-        </ul>
+  {% if BUILD_MODE %}
+    <!-- build mode -->
+    <div class="container-fluid">
+      <div class="row-fluid">
+        <div class="hero-unit span12 well-transparent">
+          <div class="row-fluid">
 
+            <div class="span6">
+              <h1>This is Toaster</h1>
+
+              <p>A web interface to <a href="http://www.openembedded.org">OpenEmbedded</a> and <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
+
+		          {% if lvs_nos %}
+		            <p class="hero-actions">
+		              <a class="btn btn-primary btn-large" href="{% url 'newproject' %}">
+			              To start building, create your first Toaster project
+		              </a>
+		            </p>
+		          {% else %}
+                <div class="alert alert-info lead air">
+                  Toaster has no layer information. Without layer information, you cannot run builds. To generate layer information you can:
+                  <ul>
+                    <li>
+                      <a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#layer-source">Configure a layer source</a>
+                    </li>
+                    <li>
+			                <a href="{% url 'newproject' %}">Create a project</a>, then import layers
+                    </li>
+                  </ul>
+                </div>
+              {% endif %}
+
+              <ul class="unstyled">
+                <li>
+                  <a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
+                    Read the Toaster manual
+                  </a>
+                </li>
+
+                <li>
+                  <a href="https://wiki.yoctoproject.org/wiki/Contribute_to_Toaster">
+                    Contribute to Toaster
+                  </a>
+                </li>
+              </ul>
+            </div>
+
+            <div class="span6">
+              <img alt="Yocto Project" class="thumbnail" src="{% static 'img/toaster_bw.png' %}"/>
+            </div>
+
+          </div>
+        </div>
       </div>
-      <div class="span6">
-          <img alt="Yocto Project" class="thumbnail" src="{% static 'img/toaster_bw.png' %}"/>
-      </div>
-     </div>
     </div>
-   </div>
+  {% else %}
+    <!-- analysis mode -->
+    <div class="alert alert-info lead top-air">
+      Toaster has not recorded any builds yet. Run a build from the command line to see it here.
+    </div>
+  {% endif %}
 
 {% endblock %}
-- 
1.9.1


