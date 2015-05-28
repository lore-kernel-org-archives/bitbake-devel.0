Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 64F7575701
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:14:39 +0000 (UTC)
Received: by wifw1 with SMTP id w1so64023533wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=B3CiBBXEk1JsSbPIvV/UbXhE6xeHfZN+bovfEUeqnpQ=;
	b=NxiKvw6DFG+ROf/Ph+SPJaJe30Kz8FBuFKmCPCU8exAL7p0zA5S+gGrhljn4sYDq1H
	ZZMJUgW0uXZT8rObp6V8dUKwrqgVIc+F3uHklF0Kx/M2vVizy9x03K/gyEQjbMFGiu1t
	Bnzk11CbjTEMrfOxnd9klEMe9h439/L9BiEIFZ9fbaxKb+ynHcuYE2Tybc/jI34x0ouz
	VpyC0yWC9H5pmRX9lExBzmeeun8beQC17VPqw5DnN7s5elrtQjUFg3ShrXBOqUAW6Bag
	BywRzQV6Q69ETUaXyHk2C7JU2lXVMBp4/l8d7HnBBXKV/IRYLnPjrDuMrPcZZI3gUQCA
	AXfw==
X-Gm-Message-State: ALoCoQmUtiTR/+3+A0b8V4dDVzcIhQknT9rfcoxL1yuWUGfo2TrtVh2dBfX88BmpzUnEILui6u72
X-Received: by 10.194.122.105 with SMTP id lr9mr5758595wjb.153.1432822480034; 
	Thu, 28 May 2015 07:14:40 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dg8sm3572353wjc.9.2015.05.28.07.14.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:14:39 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B545A5611E3; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:13:56 +0100
Message-Id: <f758b57753b85ae76daeecdca687df700dcb2a9d.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 02/22] toaster: enable server-side sessions for all usages
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
X-List-Received-Date: Thu, 28 May 2015 14:14:41 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In an effort to fix client-side session storage using
cookies, we enable server-side session support for all pages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                         |  6 +++++-
 lib/toaster/toastergui/views.py     |  6 ++++--
 lib/toaster/toastermain/settings.py | 17 ++++++-----------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 18eba8e..93abcfa 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -53,7 +53,11 @@ function webserverStartAll()
     fi
 
     retval=0
-    python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
+    if [ "$TOASTER_MANAGED" '==' '1' ]; then
+        python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
+    else
+        python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
+    fi
     python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
     if [ $retval -eq 1 ]; then
         echo "Failed db sync, stopping system start" 1>&2
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9217d8a..c16fc22 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -266,8 +266,10 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string,
 # if the value is given explicitly as a GET parameter it will be the first selected,
 # otherwise the cookie value will be used.
 def _get_parameters_values(request, default_count, default_order):
-    pagesize = request.GET.get('count', request.COOKIES.get('count', default_count))
-    orderby = request.GET.get('orderby', request.COOKIES.get('orderby', default_order))
+    from django.core.urlresolvers import resolve
+    current_url = resolve(request.path_info).url_name
+    pagesize = request.GET.get('count', request.session.get('%s_count' % current_url, default_count))
+    orderby = request.GET.get('orderby', request.session.get('%s_orderby' % current_url, default_order))
     return (pagesize, orderby)
 
 
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 80f26e0..225138b 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -258,8 +258,13 @@ TEMPLATE_CONTEXT_PROCESSORS = ('django.contrib.auth.context_processors.auth',
  )
 
 INSTALLED_APPS = (
-    #'django.contrib.sites',
+    'django.contrib.auth',
+    'django.contrib.contenttypes',
+    'django.contrib.messages',
+    'django.contrib.sessions',
+    'django.contrib.admin',
     'django.contrib.staticfiles',
+
     # Uncomment the next line to enable admin documentation:
     # 'django.contrib.admindocs',
     'django.contrib.humanize',
@@ -307,16 +312,6 @@ if os.environ.get('TOASTER_DEVEL', None) is not None:
 
 SOUTH_TESTS_MIGRATE = False
 
-# if we run in managed mode, we need user support
-if MANAGED:
-    INSTALLED_APPS = ('django.contrib.auth',
-    'django.contrib.contenttypes',
-    'django.contrib.messages',
-    'django.contrib.sessions',
-    # Uncomment the next line to enable the admin:
-    'django.contrib.admin',
-        ) + INSTALLED_APPS
-
 
 # We automatically detect and install applications here if
 # they have a 'models.py' or 'views.py' file
-- 
1.9.1


