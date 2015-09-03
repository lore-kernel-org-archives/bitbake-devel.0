Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id B9F5F7702E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:24:31 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so22111101pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=+jIzjMaQQqJ+GSlvk4HvGm/WusTacWlY11hZnI0RGdg=;
	b=qhN2rNczOyYM2oN79L2T9QCtO3jSJlh6TRSohlRRZJlgByT5q/Wi4B11f1nuWgFBuj
	PXuHesCkVY4WjE59dQkruOnelYohWLyWS67J4Mu5dF6cn61BQhBYu13k63NmnIFEknJi
	BmC8z24htXmZg+10Yk+mrTyWhJ6n6OWikmjeq6XLZZWKQWTGsO1XI9dVoWnd5xe7VZaW
	lbyzy4cwxjPpSoQnzfjzkTzMQtmj/9EwQi/xffoER9sNhxl1VpFNObeaXroblDf85Yj5
	YvJ3hNelUzGJ9mJibha1LCOesPAZQU+HDlshj/IieAmoCv6w+rFiDThssbd92HYfT/7V
	mT4g==
X-Received: by 10.68.175.3 with SMTP id bw3mr60440473pbc.106.1441239871967;
	Wed, 02 Sep 2015 17:24:31 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw3sm22972308pbc.30.2015.09.02.17.24.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:24:31 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:25:10 -0700
Message-Id: <f263f0f3d638f6d9fe1e9904c5c34572338dd402.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
References: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441239229.git.avery.brian@gmail.com>
References: <cover.1441239229.git.avery.brian@gmail.com>
Subject: [PATCH 4/6] toaster: Exclude default project unless it has builds
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
X-List-Received-Date: Thu, 03 Sep 2015 00:24:32 -0000

From: Elliot Smith <elliot.smith@intel.com>

Don't include the default "command line builds" project in
the projects view unless it has builds associated with it.

[YOCTO #7932]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6c73eb4..4e8f69e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2804,6 +2804,14 @@ if True:
 
         queryset_all = Project.objects.all()
 
+        # annotate each project with its number of builds
+        queryset_all = queryset_all.annotate(num_builds=Count('build'))
+
+        # exclude the command line builds project if it has no builds
+        q_default_with_builds = Q(is_default=True) & Q(num_builds__gt=0)
+        queryset_all = queryset_all.filter(Q(is_default=False) |
+                                           q_default_with_builds)
+
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Project)
-- 
1.9.1


