Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id D4783606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:05 +0000 (UTC)
Received: by pfu207 with SMTP id 207so40747316pfu.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=rZYwx9/SLdX+zA9H7Vb3b+0KvgssePf+MMGO5qYYf/c=;
	b=NE38NNqi9/HkppVrjFGWsFT83kg2QhaoAQ5OxSMb8wdN4VSmrWkhIsvdNYPKbdf6x9
	oTG5Aiy+RaEuRGF3UflZ4b1J1lwLrnDy1EpKfSr9jhyA55NypHuH31tQ8PsnPUCgfpCv
	NHJdcppkiZ6ZM3HXohQj79qIO3ZSLvIEAi3qwMkiVyPQN4TajOSvgT79u+TotC1kdaHN
	045VYKLMJ8N/ZD9E7f8JsZlWL7HZaNX/6TbbAyRg6M45CxVZB5Rxqd7PutxpIn0FrMZp
	YjAcb0IiWp8WsLNveETHtiqeo+/nq2SAkIiT0GZAGuPb/QP6hwiEO+ejdyPdqRDhzZ66
	3yuA==
X-Received: by 10.98.74.221 with SMTP id c90mr3495735pfj.127.1449719586454;
	Wed, 09 Dec 2015 19:53:06 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:05 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:33 -0800
Message-Id: <739346667ef01f308c99b198bac0ef056d296818.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 08/18] toaster: Prevent deprecation warnings for RedirectView
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:06 -0000

From: Elliot Smith <elliot.smith@intel.com>

The API for RedirectView is due to change in Django 1.9, which
means that Toaster generates deprecation warnings.

Set the "permanent" flag when constructing RedirectView instances
to prevent this warning.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcollector/urls.py | 1 -
 lib/toaster/toastergui/urls.py   | 2 +-
 lib/toaster/toastermain/urls.py  | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index 144387b..64722f2 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -18,7 +18,6 @@
 
 
 from django.conf.urls import patterns, include, url
-from django.views.generic import RedirectView
 
 urlpatterns = patterns('bldcollector.views',
         # landing point for pushing a bitbake_eventlog.json file to this toaster instace
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index a1adbb7..2bf2d99 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -168,5 +168,5 @@ urlpatterns = patterns('toastergui.views',
             name='xhr_customrecipe'),
 
           # default redirection
-        url(r'^$', RedirectView.as_view( url= 'landing')),
+        url(r'^$', RedirectView.as_view(url='landing', permanent=True)),
 )
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 5ce5a92..534679d 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -45,7 +45,7 @@ urlpatterns = patterns('',
     url(r'^orm/eventfile$', 'bldcollector.views.eventfile'),
 
     # if no application is selected, we have the magic toastergui app here
-    url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/'))),
+    url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/', permanent=True))),
 )
 
 import toastermain.settings
-- 
1.9.1


