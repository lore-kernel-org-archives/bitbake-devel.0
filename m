Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id A6259758A4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:41 +0000 (UTC)
Received: by wiga1 with SMTP id a1so50806395wig.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=s/+WprUDAp9bE4vILPrAsPgoTMVmAVOfMXSBhlGue1U=;
	b=QrMBC2yNXDKDg7wFl/gYpAIclRd8aZSzWZRItcqPCxwZ+b8tVDTUDt/lrdy6TXWRB5
	y06JyX/aNyPtru1N33Et6Mmx6UUKO2oDaq/4R7bL39DetoZqZNLY19CYCu0a8HRt/fQP
	VjlK7hqLYZU3ckHXTboW1cSnTgH3byIBNkpqEFfV0pPg9lImlYQCGNchx4JJaU0a5h2L
	B8GCyS5g63ZX/a2TXvuKgtHDBV45ysX4WGh/khKTH4rbuyOOncmWSniAgVE2g88BYN+h
	ShdxygisZ7iZ/H2t/vebASdnBw8MNSr+ubv0lZfWrHafO6ln/6EmMFrfn1QEkrhTpl5I
	93zw==
X-Gm-Message-State: ALoCoQmDaBXHmLikwjVs7iM19/7eHmay0LU1omQ+epq7Ebxt9WoZ9YYunoU7wjRRSPdE5JAcmYVg
X-Received: by 10.194.71.105 with SMTP id t9mr6704852wju.128.1433947182547;
	Wed, 10 Jun 2015 07:39:42 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id b7sm14888516wjx.47.2015.06.10.07.39.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 192185611DD; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:58 +0100
Message-Id: <fb5eb1d7759222573565936a964d602c148df139.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 10/19] toaster: eliminate duplicate querysets
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:42 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The Layer_Version.get_equivalents_wpriority performs the same
function as Project.compatible_layerversions, but in memory and
with worse performance.

Replace the code in get_equivalents_wpriority with a call to
the project compatible_layerversions, which also returns a queryset
instead of a list (can be used to further enhance queries)

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 198c6f5..8e73ee1 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -20,7 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.db import models
-from django.db.models import F, Q
+from django.db.models import F, Q, Avg
 from django.utils import timezone
 
 
@@ -180,7 +180,7 @@ class Project(models.Model):
             queryset = queryset.filter(layer__name = layer_name)
 
         # order by layer version priority
-        queryset = queryset.filter(layer_source__releaselayersourcepriority__release = release).order_by("-layer_source__releaselayersourcepriority__priority")
+        queryset = queryset.filter(Q(layer_source=None) | Q(layer_source__releaselayersourcepriority__release = release)).select_related('layer_source', 'layer', 'up_branch').annotate(prio=Avg("layer_source__releaselayersourcepriority__priority")).order_by("-prio")
 
         return queryset
 
@@ -1062,42 +1062,7 @@ class Layer_Version(models.Model):
         return self._handle_url_path(self.layer.vcs_web_tree_base_url, '')
 
     def get_equivalents_wpriority(self, project):
-        """ Returns an ordered layerversion list that satisfies a LayerVersionDependency using the layer name and the current Project Releases' LayerSource priority """
-
-        # layers created for this project, or coming from a build inthe project
-        query = Q(project = project) | Q(build__project = project)
-        if self.up_branch is not None:
-            # the same up_branch name
-            query |= Q(up_branch__name=self.up_branch.name)
-        else:
-            # or we have a layer in the project that's similar to mine (See the layer.name constraint below)
-            query |= Q(projectlayer__project=project)
-
-        candidate_layer_versions = list(Layer_Version.objects.filter(layer__name = self.layer.name).filter(query).select_related('layer_source', 'layer', 'up_branch').order_by("-id"))
-
-        # optimization - if we have only one, we don't need no stinking sort
-        if len(candidate_layer_versions) == 1:
-            return candidate_layer_versions
-
-#        raise Exception(candidate_layer_versions)
-
-        release_priorities = {}
-
-        for ls_id, prio in map(lambda x: (x.layer_source_id, x.priority), project.release.releaselayersourcepriority_set.all().order_by("-priority")):
-            release_priorities[ls_id] = prio
-
-        def _get_ls_priority(ls):
-            # if there is no layer source, we have minus infinite priority, as we don't want this layer selected
-            if ls == None:
-                return -10000
-            try:
-                return release_priorities[ls.id]
-            except IndexError:
-                raise Exception("Unknown %d %s" % (ls.id, release_priorities))
-
-        return sorted( candidate_layer_versions ,
-                key = lambda x: _get_ls_priority(x.layer_source),
-                reverse = True)
+        return project.compatible_layerversions(layer_name = self.layer.name)
 
     def get_vcs_reference(self):
         if self.commit is not None and len(self.commit) > 0:
-- 
1.9.1


