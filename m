Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 6198071D3D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:09 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id g23so32317808wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qgWvPGhO91MaBfc3A7O4dsuf/Lht+PwxrSmodhSHNaQ=;
	b=LWklQYKcgqcpEs4MAARdKCOF/uet4430mk2HU6oDkpdB5DGZJHifTyWMMWKsHLf+np
	6HaDrv09r+O7l62x9c7DVJ9MsLgC3vinO1ADMLDR+qaHvUUMArqzpiowLjXT+PF4afvR
	MfQc8d8JM21IL2BEJqrayfoB3ov4DE8n0FFZeIEIxEFJgct8wKBM7EqbHRw6fEd71T3J
	5qE3iqaIOJ35E/88zhJHvKkNE7cqsd6MRs/TY9MJ6IhnRjTgAlsGHefd/E1yitCtRJ8c
	oYjPN+3zzGX1lIV+yOptBS0hknAIGAN9gNWh2AX+ok4ghF0zaR36ggr4Ooo14cLpytVf
	J+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qgWvPGhO91MaBfc3A7O4dsuf/Lht+PwxrSmodhSHNaQ=;
	b=iVohsaXBdvY3SwGOLD7MZE3x0GC+EziA4aCWgK2bw1wwfM5OPdeg/ZpDEMrJLTrnwh
	Axx/bO7fR8Kd1ukQetn0DBiHTnevGJNaNJmV2m4AKtEWFvWTwMeGQPDSMd8jXDIEn0ZR
	qsbbMm51WDVde2pOYvg7cgFnQsAnF0DpypZIvvR2hiIAeJxCfpo/Z0Imsl63LsYOPh//
	SIok2R3mtq1snI9KOv7uNcFb6tHlZHRFgY8m8tktvxacBuq/HjvXXZbnbwGILmGA1iQd
	dZ1Ys7yU3zjZdx0Y/lKvw1RKucZDsN8V/DxL3wtjJ7MqLzRVjyFwQoOJ79mBih2Pvmyp
	6ahQ==
X-Gm-Message-State: AKaTC02omkUuf3jYLDQhPGGIrFzlxRbPFStM1tOMjDzCmMNM2/4ooFJF8EsmV0X97MqIsQGK
X-Received: by 10.28.234.85 with SMTP id i82mr7288210wmh.6.1481302390808;
	Fri, 09 Dec 2016 08:53:10 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:10 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:49 +0000
Message-Id: <1481302375-7985-9-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 08/14] toaster: typeaheads Add a git revisions suggestions
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:10 -0000

When we're importing a layer it's useful to suggest available git revisions of the
layers. This uses git ls-remote to fetch the revisions and then filter on this.
Caching is added for this typeahead to avoid having to fetch this
information multiple times in a single session.

[YOCTO #8429]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/typeaheads.py | 29 +++++++++++++++++++++++++++++
 lib/toaster/toastergui/urls.py       |  5 +++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 2c6c145..5316000 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -16,9 +16,12 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import subprocess
+
 from toastergui.widgets import ToasterTypeAhead
 from orm.models import Project
 from django.core.urlresolvers import reverse
+from django.core.cache import cache
 
 class LayersTypeAhead(ToasterTypeAhead):
     """ Typeahead for layers available and not added in the current project's
@@ -147,3 +150,29 @@ class ProjectsTypeAhead(ToasterTypeAhead):
             results.append(needed_fields)
 
         return results
+
+
+class GitRevisionTypeAhead(ToasterTypeAhead):
+    def apply_search(self, search_term, prj, request):
+        results = []
+        git_url = request.GET.get('git_url')
+        ls_remote = cache.get(git_url)
+
+        if ls_remote is None:
+            ls_remote = subprocess.check_output(['git', 'ls-remote', git_url],
+                                                universal_newlines=True)
+            ls_remote = ls_remote.splitlines()
+            # Avoid fetching the list of git refs on each new input
+            cache.set(git_url, ls_remote, 120)
+
+        for rev in ls_remote:
+            git_rev = str(rev).split("/")[-1:][0]
+            # "HEAD" has a special meaning in Toaster...  YOCTO #9924
+            if "HEAD" in git_rev:
+                continue
+
+            if git_rev.startswith(search_term):
+                results.append({'name': git_rev,
+                                'detail': '[ %s ]' % str(rev)})
+
+        return results
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 29f0d96..d92f190 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -182,8 +182,9 @@ urlpatterns = patterns('toastergui.views',
             typeaheads.RecipesTypeAhead.as_view(), name='xhr_recipestypeahead'),
         url(r'^xhr_typeahead/projects$',
             typeaheads.ProjectsTypeAhead.as_view(), name='xhr_projectstypeahead'),
-
-
+        url(r'^xhr_typeahead/gitrev$',
+            typeaheads.GitRevisionTypeAhead.as_view(),
+            name='xhr_gitrevtypeahead'),
 
         url(r'^xhr_testreleasechange/(?P<pid>\d+)$', 'xhr_testreleasechange',
             name='xhr_testreleasechange'),
-- 
2.7.4


