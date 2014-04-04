Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 3BB986B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:59 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id cc10so1347002wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=JelV8XW0XzRJhj7EDVI9iKfVSlXLpArXAgANio0fDPI=;
	b=LA4vrxAcRw9UYlr6zDv0C5ptswikznnD3elGH+Xq6S4Aq72zDr4p8vgtHbms5FlZzL
	IgXZARDftq7vRxPrkwVp61TrtYga/vyvpetSh4YAKHOemfx9kvUZRNPPgyqK3AhzC578
	CmHTwbdxHZwk3on0z5MWcpk78U6j4ahpxZkvXWOGkQL7RpAsCXfflnvYAMGaJdWnWJRo
	sjmG+apgLi1zuJbk6rIT+6+JTcP5sVILmYXVkp2K4QB0Uopp3bsEFHyKVlHleO0rRmDw
	d81gOQaRCHUZ+TFZGzuKs/PdQYX71NKDrRix6ruA/VVOY/2/6Ab8BqohS/035u0OP20C
	8Plg==
X-Gm-Message-State: ALoCoQnb1/bBlDtoY1Xy7VZYwtauxXjwHX7gxmKq57RfwZEBuPtNryI9Jebctmp3+ZWVDB5HSGfd
X-Received: by 10.180.90.50 with SMTP id bt18mr4417540wib.49.1396620660463;
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h19sm4902416wiw.17.2014.04.04.07.10.56
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8F61956082C; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:48 +0100
Message-Id: <04ad8ad2067fd283c8040bfa52a71b1b823fac8f.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 09/14] toaster: Fix "Recent builds" links
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:02 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

* Link the number of errors to the #errors section in the
build dashboard

* Link the number of warnigns to the #warnings section in
the build dashboard

* Link the build time to the build time page

* Move some javascript that applies only to builddashboard.html
to that template from main.js

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/build.html          | 6 +++---
 lib/toaster/toastergui/templates/builddashboard.html | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index afa390f..faabd22 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -48,16 +48,16 @@
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
     {% if  build.errors_no %}
-                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
     {% endif %}
             </div>
             <div class="span2 lead">
     {% if  build.warnings_no %}
-                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}" class="warning">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>
+                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}#warnings" class="warning">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>
     {% endif %}
             </div>
             <div class="lead pull-right">
-                Build time: <a href="build-time.html">{{ build.timespent|sectohms }}</a>
+                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
             </div>
     {%endif%}{%if build.outcome == build.IN_PROGRESS %}
             <div class="span4">
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 6cce788..cc92af5 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -186,4 +186,13 @@
 </div>
 {% endif %}
 
+<script type="text/javascript">
+    $(document).ready(function() {
+        //show warnings section when requested from the previous page
+        if (location.href.search('#warnings') > -1) {
+            $('#collapse-warnings').addClass('in');
+        }
+    });
+</script>
+
 {% endblock %}
-- 
1.9.1


