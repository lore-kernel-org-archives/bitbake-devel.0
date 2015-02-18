Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id D8BE6735C9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:08 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id r20so4425500wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+2mHFmk21O5i0PIkRof+R4soyaR/w608q19l59ozHLo=;
	b=NHM11MSbm+bmuOjp1oBUueayFMdS8+9IqRiBxjidxOZbzTJ0OyZovUaJR2xf0i5Fod
	P7eoGEi48COcObKZWpsCnQUyNoS44PK+qsZ5+VBfKsAcvIG78hpocvoQUo91qd/2QBxy
	uDGI7cOuBbB+lRysGdQS0i6mT9MAVvr8zclJWsXkDID/hyLqOuXJen1edeOfY1sSP524
	VTwhMW3Dcmf5YNqBTtunn0jJW/5fLBHccR1X9lOwIdz8MbwsotOAbiczFC0WBr06SvT/
	qyzTW+yaLo/RffEc5NJrxO/5o1gFrgXedkPWbrkMUtaSKTzxkU5pDg6wUF1zuKT3PX7b
	8B2w==
X-Gm-Message-State: ALoCoQnvKrCxjqQ2nUivfbbNqJPB9xyQG1fDhlmyFPUgnkzNOUTVESELEvM7isZASihsqX8E9csL
X-Received: by 10.195.13.168 with SMTP id ez8mr1775944wjd.30.1424286669559;
	Wed, 18 Feb 2015 11:11:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	dx11sm31031378wjb.23.2015.02.18.11.11.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4ECE3561FAD; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:11:03 +0000
Message-Id: <1eaf60d0fe34f5f43386c6f0e91f0b26c7a62845.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 09/10] toasterui: remove layer directory in managed mode
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

From: Belen Barros Pena <belen.barros.pena@intel.com>

Removes the layer directory information from the packages
built page when in managed mode.

[YOCTO #7221]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/bpackage.html |  4 +++-
 lib/toaster/toastergui/views.py                | 14 ++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 2d4948b..80229f9 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -88,7 +88,9 @@
                 </a>
             </td>
             <!-- Layer directory -->
-            <td class="recipe__layer_version__layer__local_path">{{package.recipe.layer_version.layer.local_path}}</td>
+            {% if not MANAGED or not build.project %}
+                <td class="recipe__layer_version__layer__local_path">{{package.recipe.layer_version.layer.local_path}}</td>
+            {% endif %}
         {%else%}
             <td class="recipe__name"></td>
             <td class="recipe__version"></td>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 70241dc..bf148e2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1282,9 +1282,11 @@ def bpackage(request, build_id):
 
     packages = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
+    build = Build.objects.get( pk = build_id )
+
     context = {
         'objectname': 'packages built',
-        'build': Build.objects.get(pk=build_id),
+        'build': build,
         'objects' : packages,
         'default_orderby' : 'name:+',
         'tablecols':[
@@ -1349,16 +1351,20 @@ def bpackage(request, build_id):
                 'qhelp':'The Git commit of the layer providing the recipe that builds the package',
                 'clclass': 'recipe__layer_version__layer__commit', 'hidden': 1,
             },
-            {
+            ]
+        }
+
+    if not toastermain.settings.MANAGED or build.project is None:
+
+        tc_layerDir = {
                 'name':'Layer directory',
                 'qhelp':'Path to the layer providing the recipe that builds the package',
                 'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__local_path"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__local_path"),
                 'orderkey' : 'recipe__layer_version__layer__local_path',
                 'clclass': 'recipe__layer_version__layer__local_path', 'hidden': 1,
-            },
-            ]
         }
+        context['tablecols'].append(tc_layerDir)
 
     response = render(request, template, context)
     _save_parameters_cookies(response, pagesize, orderby, request)
-- 
1.9.1


