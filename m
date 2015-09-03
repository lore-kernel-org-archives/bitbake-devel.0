Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 7A3507702E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:24:29 +0000 (UTC)
Received: by padhy1 with SMTP id hy1so27258934pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=cTxSdT3CcCTwiyhCRL04dFQ6N7C22LLjdIJ4TtPh4SA=;
	b=DEyBSesM1riF73Z70yVrUv88zwJz9RfjJknE3zYHHfj4cQaYtW43YVkQaM1+UrZ2t1
	9NJNRPYzcBFmJCCIbzd2qkAwg5EsSAwDzIc7rdav+3v3h+kFyJfTRVjfBKqlGMffM76R
	icV/bqX7cjTKCZR3iSspeg/gszISQkArOQt3NJKz0KoNu4SBakXC7Jf6PZvzLbeYyyHC
	Jky9vB00+twrNiWx/s6x4MStjN7haWZHEF+ChXK3LVkrkBFpBjIRSfDmCLjXiunAhmYe
	QGsfoiHn2kpcHFkhJ59TxVumi5t4BluFRUcZ3nPZ15z6DvI04FdxgATG3JawAHvQ6y10
	E+hg==
X-Received: by 10.68.239.202 with SMTP id vu10mr59180822pbc.135.1441239870389; 
	Wed, 02 Sep 2015 17:24:30 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw3sm22972308pbc.30.2015.09.02.17.24.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:24:29 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:25:09 -0700
Message-Id: <294ac916ead6bbc07016722e7421985d23fc8800.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
References: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441239229.git.avery.brian@gmail.com>
References: <cover.1441239229.git.avery.brian@gmail.com>
Subject: [PATCH 3/6] toaster: Only redirect to projects page if user has added projects
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
X-List-Received-Date: Thu, 03 Sep 2015 00:24:30 -0000

From: Elliot Smith <elliot.smith@intel.com>

The landing page currently redirects the user if there are any
projects in the db. Because we now always have at least one
(the default one added by a migration), we always get the redirect.

Change this so that when the user hits the landing page,
we only redirect them to the projects page if there is at least
one user-added project and there are no builds.

[YOCTO #7932]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index c583d96..6c73eb4 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -54,7 +54,11 @@ logger = logging.getLogger("toaster")
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
-    if Build.objects.count() == 0 and Project.objects.count() > 0:
+    # we only redirect to projects page if there is a user-generated project
+    user_projects = Project.objects.filter(is_default = False)
+    has_user_project = user_projects.count() > 0
+
+    if Build.objects.count() == 0 and has_user_project:
         return redirect(reverse('all-projects'), permanent = False)
 
     if Build.objects.all().count() > 0:
-- 
1.9.1


