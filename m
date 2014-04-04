Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id EEC856B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:58 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id z2so1360344wiv.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=4TZMHyX0x7UTh1fKNFBKT4dUVMnA7Mzms9ZzqHGilc8=;
	b=juWrzDWVC7F13qIoZBPO5rtoBZ7UU8JZjcUoQB6/OwbFXegIgXQ4KrnqbZbFtgdVFh
	Ky5Zk2xJP2OWn5lxtCH/UrSgefZAmJVqkZIxAMG/vn2fAF6uQiKwBxrvG0hRcoklsaTd
	PLp+LXT0CmwYv5/sRN60RVYO5KSrZ98FyIOk/w7q/eMf29K0jgVJnKUl2SrD6GiNl+bS
	hYb6IjJUlhOdqATFaVAiI0B1yGFgkkEm2h4mXxyozB6x8P8jH71fbgfoV9B24QZEXbIh
	siQnM1DUw5JSvGuEbyfcGfUmX9wgzuuyOwAUwDkpTzmPJmP4jgp5v3Qn8D8N9Fox02PV
	tdzg==
X-Gm-Message-State: ALoCoQnBshHZGXxEluoPSMolvRCoNW2nB2J8aFeIZYyFZ4+MaHCN8hPz+ryQkyjg8ERD5ndVhx8w
X-Received: by 10.180.76.142 with SMTP id k14mr4855388wiw.21.1396620659288;
	Fri, 04 Apr 2014 07:10:59 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	wr4sm11327524wjc.21.2014.04.04.07.10.56 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 89C105606FE; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:45 +0100
Message-Id: <346a278afd708a905c9b084055e692569acd65e8.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 06/14] toaster: Remove html validation errors in tasks.html
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:59 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Remove the duplicated class attribute and the name
attribute.

Also, make sure that the row blue highlight works
without the name attribute when you land on the
tasks table after clicking the order link in a
task details page.

The commit also fixes a typo in default.css.

[YOCTO #6033]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css |  2 +-
 lib/toaster/toastergui/static/js/main.js      |  2 +-
 lib/toaster/toastergui/templates/tasks.html   | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 0b53718..b4345da 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -103,7 +103,7 @@ select { width: auto; }
 .well > .lead, .alert .lead { margin-bottom: 0px; }
 .no-results { margin: 10px 0; }
 .task-name { margin-left: 7px; }
-.icon-hand-right {color: #ccccc; }
+.icon-hand-right {color: #CCCCCC; }
 .help-inline { margin: 5px; }
 .hero-unit { margin: 20px 0 30px; }
 .hero-unit > .close { font-size:40px; }
diff --git a/lib/toaster/toastergui/static/js/main.js b/lib/toaster/toastergui/static/js/main.js
index 7f897d2..eef6b46 100644
--- a/lib/toaster/toastergui/static/js/main.js
+++ b/lib/toaster/toastergui/static/js/main.js
@@ -107,5 +107,5 @@ $(document).ready(function() {
     if (location.href.search('#warnings') > -1) {
         $('#collapse-warnings').addClass('in');
     }
-
+        
 });
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index d68a31a..77d38b0 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -75,7 +75,7 @@
   {% include "basetable_top.html" %}
 
     {% for task in objects %}
-        <tr {{ task|task_color }} class="flash" id="{{task.order}}" name="{{task.order}}">
+        <tr {{ task|task_color }} id="{{task.order}}">
             <td class="order">
                 <a href="{%url "task" build.pk task.pk%}">{{task.order}}</a>
             </td>
@@ -117,4 +117,17 @@
   {% endif %} {# objects.paginator.count #}
 {% endif %} {# empty #}
 </div>
+
+<script type="text/javascript">
+
+    $(document).ready(function() {
+        // enable blue hightlight animation for the order link
+        if (location.href.search('#') > -1) {
+            var task_order = location.href.split('#')[1];
+            $("#" + task_order).addClass("highlight"); 
+        }
+    });
+    
+</script>
+
 {% endblock %}
-- 
1.9.1


