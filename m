Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id ABFE578699
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 22:31:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id vAKMVPKu011117
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 14:31:25 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 20 Nov 2017 14:31:25 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Nov 2017 14:23:34 -0800
Message-ID: <9c0035ce99cb1f2ffb5894518b6038b9bf0f2758.1511216528.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1511216528.git.David.Reyna@windriver.com>
References: <cover.1511216528.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/6] toaster: update Toaster for Django 1.11
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
X-List-Received-Date: Mon, 20 Nov 2017 22:31:24 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster needs to accomodate API changes in Django 1.11.

[YOCTO #12192]
---
 lib/toaster/bldcollector/urls.py    | 2 +-
 lib/toaster/toastergui/urls.py      | 2 +-
 lib/toaster/toastergui/views.py     | 2 +-
 lib/toaster/toastermain/settings.py | 2 +-
 lib/toaster/toastermain/urls.py     | 2 +-
 toaster-requirements.txt            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index 076afdb..888175d 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -17,7 +17,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 
-from django.conf.urls import patterns, include, url
+from django.conf.urls import include, url
 
 import bldcollector.views
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 3ad5566..e07b0ef 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -16,7 +16,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from django.conf.urls import patterns, include, url
+from django.conf.urls import include, url
 from django.views.generic import RedirectView, TemplateView
 
 from django.http import HttpResponseBadRequest
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 334bb4a..209b07d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -277,7 +277,7 @@ def _validate_input(field_input, model):
             return None, invalid + str(field_input_list)
 
         # Check we are looking for a valid field
-        valid_fields = model._meta.get_all_field_names()
+        valid_fields = [f.name for f in model._meta.get_fields()]
         for field in field_input_list[0].split(AND_VALUE_SEPARATOR):
             if True in [field.startswith(x) for x in valid_fields]:
                 break
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 54ab31f..13541d3 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -186,7 +186,7 @@ TEMPLATES = [
                 'django.template.context_processors.tz',
                 'django.contrib.messages.context_processors.messages',
                 # Custom
-                'django.core.context_processors.request',
+                'django.template.context_processors.request',
                 'toastergui.views.managedcontextprocessor',
 
             ],
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 6750bdf..e2fb0ae 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -19,7 +19,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from django.conf.urls import patterns, include, url
+from django.conf.urls import include, url
 from django.views.generic import RedirectView, TemplateView
 from django.views.decorators.cache import never_cache
 import bldcollector.views
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 3f47650..c0ec368 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django>1.8,<1.9.9
+Django>1.8,<1.11.9
 beautifulsoup4>=4.4.0
 pytz
-- 
1.9.1


