Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 9318B770D6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 18:03:32 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so111878833pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Oct 2015 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PNiZJY1z+64zLowY43Kpf6shkcFIrFljVVK3rrkito4=;
	b=Tyx0FxuvxzJUk42fhd3LTI08Mq7MF7309ai+nieGcH6+8eC46UJ7xlsst+Whmduft6
	rd7XmoBKjEgFyAB1EJna1BNNnyyznaU5wegWnu2PN6Tip5C08SleNm0z6W093K23hJCW
	0Mo7t4Qu/JZqBI3bEIIJxYpIqu+SrCQ9C7TbriR8yHyE0sNw69fMc2hwbrg2hAyzR1gj
	6uDBBW99f9e91FXR3esZb6PFwqPBZniQhjWY3HDotd/RJsHZvdHLuDph2m2RqSPNkUwi
	nC41vL5ZD9Xfg5VzV8i2bbtTuqKHB4up/7OHJBL1vLAWYs9PBcL9/C4YmbCrK5nkkycz
	lgFQ==
X-Received: by 10.66.184.42 with SMTP id er10mr21980925pac.117.1443809012493; 
	Fri, 02 Oct 2015 11:03:32 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw10sm13142211pbc.25.2015.10.02.11.03.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 02 Oct 2015 11:03:31 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 11:05:12 -0700
Message-Id: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1443809021.git.avery.brian@gmail.com>
References: <cover.1443809021.git.avery.brian@gmail.com>
Subject: [PATCH 1/5] toaster: implement API to get full list of deps
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
X-List-Received-Date: Fri, 02 Oct 2015 18:03:34 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Implemented Layer_Version.get_alldeps API to recursively get
full list of dependencies for the layer. Dependencies that are
already in the project are filtered out from the result.
Result list of Layer_Version objects is sorted by layer name
for UI to look consistent.

This API is going to be used to show amount and list of
dependencies for the layer in the list of compatible layers
for the project.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index ad12dd4..431bd8b 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1178,6 +1178,25 @@ class Layer_Version(models.Model):
     def get_detailspage_url(self, project_id):
         return reverse('layerdetails', args=(project_id, self.pk))
 
+    def get_alldeps(self, project_id):
+        """Get full list of unique layer dependencies."""
+        def gen_layerdeps(lver, project):
+            for ldep in lver.dependencies.all():
+                yield ldep.depends_on
+                # get next level of deps recursively calling gen_layerdeps
+                for subdep in gen_layerdeps(ldep.depends_on, project):
+                    yield subdep
+
+        project = Project.objects.get(pk=project_id)
+        result = []
+        projectlvers = [player.layercommit for player in project.projectlayer_set.all()]
+        for dep in gen_layerdeps(self, project):
+            # filter out duplicates and layers already belonging to the project
+            if dep not in result + projectlvers:
+                result.append(dep)
+
+        return sorted(result, key=lambda x: x.layer.name)
+
     def __unicode__(self):
         return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
 
-- 
1.9.1


