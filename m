Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id E06AC72C9C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:21:59 +0000 (UTC)
Received: by mail-wg0-f53.google.com with SMTP id a1so4136015wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ME+dCmvSloHbnTJ5rRKBrZGonedwFc5FvJbzcKj0XDU=;
	b=afFubA8ojsfpAljAlelb1uqt+buu9A7nUhsvSIxChvineNnWHyE02ip8AQ2O/aj4hI
	6uP4OXZhbO31FaoxLEsd/cwvZRdXy8blaWaeEAaXQNem2Kao0YKD7k/FjFs0bFq0V0AS
	nP3WHIH7ZMQH3xlKr5ksOM7S4aGAeERCB+lj3bSezRBN6GNuyAIiR281S+ymZ+3icJ/X
	iMi891Ull17O7b6azSN9I5zIKZG4MjJuJIXfWEwUXwJfIaJj6XbgOo6p6jA7lgbzkA33
	lIEl3VNgbdJuasSCxlh3G4PyuBaDBXDjdUJaUslTGdyqW5d/ynwla/Ro6UIaShrLIN1G
	rNfw==
X-Gm-Message-State: ALoCoQld40jZ573BUfHci/zZaU+e/zxks9bM7QAoJ7DYeVY/TQYvZ3Ynxzvn5ziDpmLUhUgMKX1m
X-Received: by 10.180.210.167 with SMTP id mv7mr58459393wic.78.1421864519931; 
	Wed, 21 Jan 2015 10:21:59 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id be2sm767438wjb.38.2015.01.21.10.21.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:21:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E93E45640DA; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:36 +0000
Message-Id: <027daf3a01682880d1cda3fef98070f38f483818.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 06/12] toastergui: fix all-targets redirect
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Fixes the all targets redirect to /api/1.0/targets.

[YOCTO #7147]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 2 +-
 lib/toaster/toastergui/urls.py                | 2 +-
 lib/toaster/toastergui/views.py               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 67b2672..815c24c 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -98,7 +98,7 @@ vim: expandtab tabstop=2
       </div>
       <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more targets you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a target name, like so: <code>core-image-minimal:do_build</code>"></i>
       <p>
-        <a href="{% url 'targets' %}">
+        <a href="{% url 'all-targets' %}">
           View all targets
         </a>
         {% if completedbuilds.count %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index c74c7a6..8c3b5a8 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -77,7 +77,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^layers/$', 'layers', name='layers'),
         url(r'^layer/(?P<layerid>\d+)/$', 'layerdetails', name='layerdetails'),
         url(r'^layer/$', 'layerdetails', name='layerdetails'),
-        url(r'^targets/$', 'targets', name='targets'),
+        url(r'^targets/$', 'targets', name='all-targets'),
         url(r'^machines/$', 'machines', name='machines'),
 
         url(r'^projects/$', 'projects', name='all-projects'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7a11bbd..6b4b5d9 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2625,7 +2625,7 @@ if toastermain.settings.MANAGED:
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'targets', request.GET, mandatory_parameters)
+            return _redirect_parameters( 'all-targets', request.GET, mandatory_parameters)
         (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
 
         prj = Project.objects.get(pk = request.session['project_id'])
-- 
1.9.1


