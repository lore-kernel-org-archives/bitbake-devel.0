Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f181.google.com (mail-wj0-f181.google.com
	[209.85.210.181])
	by mail.openembedded.org (Postfix) with ESMTP id 8C1186011A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:25 +0000 (UTC)
Received: by mail-wj0-f181.google.com with SMTP id qp4so30950138wjc.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TWo/dliefdrjAnNBgg5iz8TQ9r0J155aqmNor6kOjis=;
	b=bsSJc3NyQOI7zYIKgPXwR0HXn78st1Nyr14G2zl6uew+cbSTuGq3BxIkxFHGsWALr2
	ff/wdZsriqgCy8ybM6APVxlziElkHupS/x3ZUH1SLnNee17Ochoqw9UbEcC42+JgMmYM
	gxEaxttyMw5N6FVFj862GR2F7kVd0aFTthrNYxvVpbIP84uJHZJ/abHaLLDSNpIwsNQk
	By/OVdkRLKo9zEPymtEo0JzI00VLKFq4UsaPdIF7WX6lEx0H+XLzVohr5oE+meh3QAVr
	Amx1eP4c/07oNXUP+iyZ/KplwGAt8LQXl91GPEH2wlKgqsDP6dS1IV5zNiowIwyVcbbR
	YQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TWo/dliefdrjAnNBgg5iz8TQ9r0J155aqmNor6kOjis=;
	b=XJLPCdZA4fXH1QgwAOMJnL5zuaQ2Gn32KFic4tT7XiHlA4ZJ2iC0wFb43T8iwce5dA
	RH+gYYz5EZ0TfcR8P2OiiX2gv1F2A3Tf8J9wsGVvRbExGj48D0nVogB2Zw3x/8zIkP2M
	la4WinWovjBEhzc8JDE6+an7ejXDVYE8CIWQA12U6I01g5F1k+l82qlBeevLGi7QJr8E
	6ajd10iRCrxhY/AY4SRhAhNb/Qo+2H87GpYdWEvuoux+u9ImYYOGjXqA4cJNvuDqCDGq
	c3p6BynQqES/e/VXM+o0wwZ3WYj732dabiIn30mwDVZbvq0+vNQlPD/46Mgp/tvOZX/X
	BoPQ==
X-Gm-Message-State: AKaTC00+qQAj5n8zc9UnP53xvX7JRfDR28QLQsiTQTKziwwIV3RSxwZ9gx+uiCNBL8+sCzj2
X-Received: by 10.194.18.196 with SMTP id y4mr1837532wjd.73.1479986426201;
	Thu, 24 Nov 2016 03:20:26 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:25 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:56 +0000
Message-Id: <1479986406-4657-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 05/15] toaster: orm gen_layerdeps Protect against circular Layer dependencies
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:26 -0000

From: "Reyna, David" <david.reyna@windriver.com>

Limit the recursion (to say 20 levels) when processing layer dependencies
so that circular dependecies do not cause infinite decent and an
out-of-memory failure. The duplicate found layers are already immediately
filtered in the code.

[YOCTO #10630]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4f8510c..b24e9c5 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1478,17 +1478,22 @@ class Layer_Version(models.Model):
 
     def get_alldeps(self, project_id):
         """Get full list of unique layer dependencies."""
-        def gen_layerdeps(lver, project):
+        def gen_layerdeps(lver, project, depth):
+            if depth == 0:
+                return
             for ldep in lver.dependencies.all():
                 yield ldep.depends_on
                 # get next level of deps recursively calling gen_layerdeps
-                for subdep in gen_layerdeps(ldep.depends_on, project):
+                for subdep in gen_layerdeps(ldep.depends_on, project, depth-1):
                     yield subdep
 
         project = Project.objects.get(pk=project_id)
         result = []
-        projectlvers = [player.layercommit for player in project.projectlayer_set.all()]
-        for dep in gen_layerdeps(self, project):
+        projectlvers = [player.layercommit for player in
+                        project.projectlayer_set.all()]
+        # protect against infinite layer dependency loops
+        maxdepth = 20
+        for dep in gen_layerdeps(self, project, maxdepth):
             # filter out duplicates and layers already belonging to the project
             if dep not in result + projectlvers:
                 result.append(dep)
-- 
2.7.4


