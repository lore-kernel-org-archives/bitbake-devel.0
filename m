Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 5DBDD767D5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 14:38:06 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so221252764wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 07:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9kGA1oJM7NP29P5JNiPSioBGedYNot/pQcpz/q/fH5g=;
	b=eQxOW0z3VQEkGN4pLzTOKwd1lbK9XMVzSo+ceD8psEZzVTJYTqFnjIqM8hyLk3y9Bn
	933gBv+SiGV+bVJvOOC53EGzgGo/nJ0V2qJTNVrY5gLIxz5N5pTgwyMjF2WIEczaySoP
	GBCflxQs4fTqkJkW+qJBENANsaxcLBp/OLF6DXHuj7By9wc+0X/jn9AyKhIvJFlrJoVO
	TxTddOJ7o14L9lIG0Qez0wX4alx+Yd+DVsROxPnj4WR0wxWZc2V0FTGsBuRdO7hbfYfA
	psOLKThWgJxqJKNd1rtj9plwVAbC2Tyszvj6B95qRxbtNzC5SZkuAyZLGdW+abm3lM57
	HXhg==
X-Gm-Message-State: ALoCoQkr3hqW1qtq+qsGy8jtwAyup9c2LT+nb1QfHrzf/1AFMt/PP+stM0Of68Xv688E7cCGOt5V
X-Received: by 10.180.160.210 with SMTP id xm18mr46131177wib.93.1439390286609; 
	Wed, 12 Aug 2015 07:38:06 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	g13sm8266965wjs.21.2015.08.12.07.38.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 12 Aug 2015 07:38:05 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Aug 2015 15:37:55 +0100
Message-Id: <1439390275-10396-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH] toastergui: Added IDs to elements used in testing
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
X-List-Received-Date: Wed, 12 Aug 2015 14:38:09 -0000

From: Mihail Stanciu <stanciux.mihail@intel.com>

Added static IDs to elements commonly used in the testing process so
that future UI modifications would not break tests as easily.

[YOCTO #7380]

Signed-off-by: Mihail Stanciu <stanciux.mihail@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 4 ++--
 lib/toaster/toastergui/templates/newproject.html    | 2 +-
 lib/toaster/toastergui/templates/projecttopbar.html | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index d4bac36..33ede66 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -165,12 +165,12 @@
             <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{%if request.GET.search %}{{request.GET.search}}{% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
             <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
             <input type="hidden" name="page" value="1">
-            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn" id="search-button" type="submit" value="Search">Search</button>
         </form>
         <div class="pull-right">
 {% if tablecols %}
             <div class="btn-group">
-                <button class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
+                <button id="edit-columns-button" class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
                     <span class="caret"></span>
                 </button>
 <!--
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 745b79b..997390b 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -59,7 +59,7 @@
         {% endif %}
 
             <div class="form-actions">
-              <input type="submit" class="btn btn-primary btn-large" value="Create project"/>
+              <input type="submit" id="create-project-button" class="btn btn-primary btn-large" value="Create project"/>
               <span class="help-inline" style="vertical-align:middle;">To create a project, you need to enter a project name</span>
             </div>
         </form>
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 220ca72..7412e4c 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -47,8 +47,8 @@
         </i>
         <div class="input-append">
           <form class="form-inline" style="margin-bottom: 0">
-            <input type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
-              <button class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build
+            <input id="build-input" type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
+              <button id="build-button" class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build
               </button>
             </form>
           </div>
-- 
2.1.4


