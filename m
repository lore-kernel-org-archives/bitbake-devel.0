Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0A3E67737C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48K007485; Wed, 1 Jun 2016 13:37:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2_6Jo01s7t_3; Wed,  1 Jun 2016 13:37:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxfJ007458
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000oY-Dz; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:35 +0100
Message-Id: <1464784607-2985-16-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 16/28] toaster: use items and range instead of old APIs
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:08 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used items() and range() APIs instead of iteritems() and
xrange() as latter don't exist in python 3

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/contrib/tts/config.py     | 2 +-
 lib/toaster/orm/models.py             | 2 +-
 lib/toaster/toastergui/tablefilter.py | 2 +-
 lib/toaster/toastergui/views.py       | 2 +-
 lib/toaster/toastergui/widgets.py     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/contrib/tts/config.py b/lib/toaster/contrib/tts/config.py
index 40d45f3..87b427c 100644
--- a/lib/toaster/contrib/tts/config.py
+++ b/lib/toaster/contrib/tts/config.py
@@ -74,7 +74,7 @@ BACKLOGFILE = os.path.join(os.path.dirname(__file__), "backlog.txt")
 # task states
 def enum(*sequential, **named):
     enums = dict(zip(sequential, range(len(sequential))), **named)
-    reverse = dict((value, key) for key, value in enums.iteritems())
+    reverse = dict((value, key) for key, value in enums.items())
     enums['reverse_mapping'] = reverse
     return type('Enum', (), enums)
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 58dc753..ee01a46 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -103,7 +103,7 @@ class GitURLValidator(validators.URLValidator):
 
 def GitURLField(**kwargs):
     r = models.URLField(**kwargs)
-    for i in xrange(len(r.validators)):
+    for i in range(len(r.validators)):
         if isinstance(r.validators[i], validators.URLValidator):
             r.validators[i] = GitURLValidator()
     return r
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index 9d15bcf..65454e1 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -286,7 +286,7 @@ class TableFilterMap(object):
     def to_json(self, queryset):
         data = {}
 
-        for filter_name, table_filter in self.__filters.iteritems():
+        for filter_name, table_filter in self.__filters.items():
             data[filter_name] = table_filter.to_json()
 
         return data
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 22d1a0c..b256db7 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2279,7 +2279,7 @@ if True:
         # Strip trailing/leading whitespace from all values
         # put into a new dict because POST one is immutable
         post_data = dict()
-        for key,val in request.POST.iteritems():
+        for key,val in request.POST.items():
           post_data[key] = val.strip()
 
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 0f972d9..19850fb 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -278,12 +278,12 @@ class ToasterTable(TemplateView):
         # Make a unique cache name
         cache_name = self.__class__.__name__
 
-        for key, val in request.GET.iteritems():
+        for key, val in request.GET.items():
             if key == 'nocache':
                 continue
             cache_name = cache_name + str(key) + str(val)
 
-        for key, val in kwargs.iteritems():
+        for key, val in kwargs.items():
             cache_name = cache_name + str(key) + str(val)
 
         # No special chars allowed in the cache name apart from dash
-- 
2.5.0


