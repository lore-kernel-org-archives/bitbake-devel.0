Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 5BCEF65D4A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:45 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so2453011wes.29
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=i9qpPCp9CuVBvwDlaCcE+oOcoEWWv/3nyRDGg4kIkrc=;
	b=MG00mz1qfFwHO1G6HwEOsCff7z82j5bJ4J/60/x+ek9PDmcaOXOGlxXhTadnCiQ+Hu
	vDn1cEZjj94SANoJOLeAR+Bjf6GOYrj6j97Ti7hb6zpdNnC50zVMZOJZhxsahOfeVvPC
	3BxTGoutPJq5fS7OhKi7ZSi15OsXfysfK/+FtY20QH5Wq7JbLnvsn/digFPZjvEFWyPQ
	Zv4nBpABj1B0aQ2SA7V+hhjeqgIxVBzmdWVErih9waHY7Lv5XyuM9Es5caurfp5wP4sb
	3LR1z78GpsvS3erH8jWhBQJEdGWtcJxSfI72vspcpi1UXSadcHy7OiNqw/3Q7x5hZIJK
	TSYg==
X-Gm-Message-State: ALoCoQm0x44bz3tL4yx3VaYg/GrN+6T2uUJ0HGIGZFmzemjVpLoJKMjn1Us95N46ALA/bGH6oO9L
X-Received: by 10.194.92.177 with SMTP id cn17mr9752292wjb.18.1397049466721;
	Wed, 09 Apr 2014 06:17:46 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id co9sm1659007wjb.22.2014.04.09.06.17.43
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:44 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 80AAF560373; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:40 +0100
Message-Id: <50625fd85f0165642d26b75bf1b7263221ec96f2.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 9/9] toaster: add URI search path list
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:46 -0000

From: David Reyna <David.Reyna@windriver.com>

Display the URI paths from SSTATE_DIR and SSTATE_MIRRORS
in the Task page.

[YOCTO #5996]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/task.html |  2 +-
 lib/toaster/toastergui/views.py            | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 66a6695..4555999 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -172,7 +172,7 @@
                 <i class="icon-question-sign get-help" title="The locations searched for the above file (i.e. your <code>sstate-cache</code> directory and any mirrors you have set up)"></i>
                 URI(s) searched
             </dt>
-            <dd><code>{{task.work_directory}}</code></dd>
+            <dd><ul>{% for uri in uri_list %}<li><code>{{uri}}</code></li>{% endfor %}</ul></dd>
         </dl>
     {% endif %}
     {% if task.sstate_result == task.SSTATE_MISS %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 36eb0bf..e4ada14 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -481,6 +481,17 @@ def task( request, build_id, task_id ):
     if task.outcome == task.OUTCOME_FAILED:
         pass
 
+    uri_list= [ ]
+    variables = Variable.objects.filter(build=build_id)
+    v=variables.filter(variable_name='SSTATE_DIR')
+    if v.count > 0:
+        uri_list.append(v[0].variable_value)
+    v=variables.filter(variable_name='SSTATE_MIRRORS')
+    if (v.count > 0):
+        for mirror in v[0].variable_value.split('\\n'):
+            s=re.sub('.* ','',mirror.strip(' \t\n\r'))
+            if len(s): uri_list.append(s)
+
     context = {
             'build'           : Build.objects.filter( pk = build_id )[ 0 ],
             'object'          : task,
@@ -491,6 +502,7 @@ def task( request, build_id, task_id ):
             'log_head'        : log_head,
             'log_body'        : log_body,
             'showing_matches' : False,
+			'uri_list'        : uri_list,
     }
     if request.GET.get( 'show_matches', "" ):
         context[ 'showing_matches' ] = True
-- 
1.9.1


