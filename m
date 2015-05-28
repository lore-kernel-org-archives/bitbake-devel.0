Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id BE7AA73236
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:18:35 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37871121wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=MGZCx1/U2G40heyLG63/JLuLO0nV5IjBwVVstf/paqk=;
	b=jfnVuRKrUo17LCG78Q2SnUg4NhFkqUjIqLxX29YooRlYRdZGGFpE7FEJ8ugHyFxgps
	8sduGa4ufjVLyfUdNcGacGIGaA4IbGxN6Wm5R9PgIrQ47rd45utZb7FYBmMFS2G2EV6F
	4GiH+lRnGHwQ2xLPQB/1CV/G1q0Bwgr+aJQpxfKix5JssLBJFuLN9aUgrobF5D8iEuyM
	OFHJc59eB3EHJ5Z57qjzOeWHJ4317IcRyBzXklJ+lWjT3Iwf8HFWDDSC96FXA7dKn941
	0QvcpGdLPbvp2+gXB8OQmumS+/phKpeyv2tB+FmlPHeVxEMTJIFYk/thmukpHm29bMEi
	iRzw==
X-Gm-Message-State: ALoCoQkpbXqS7b0Ky5LwU60+bVMRudQZTLaaQpiQN2gJ7+bkVs7CR7J/VxVf3SbWYhD9gCz/0Qs9
X-Received: by 10.194.143.75 with SMTP id sc11mr5656813wjb.62.1432822716860;
	Thu, 28 May 2015 07:18:36 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id d14sm3564676wjn.30.2015.05.28.07.18.35
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:18:35 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D8E04561316; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:16 +0100
Message-Id: <5fb2efe0e825323bff0db2c0de3a62ab828cd468.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 22/22] toaster: more HTML5 fixes
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
X-List-Received-Date: Thu, 28 May 2015 14:18:36 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

More HTML5 fixes highlighted by tests on new data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html | 2 +-
 lib/toaster/toastergui/templates/configvars.html     | 2 +-
 lib/toaster/toastergui/templates/recipe.html         | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index d5fe92a..ad497e6 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -209,6 +209,7 @@
                     <a class="error" href="{% url "task" build.id exectask.0.id %}">
                         {{exectask.0.recipe.name}}
                         <span class="task-name">{{exectask.0.task_name}}</span>
+                    </a>
 
                       {% if MANAGED and build.project %}
                         <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
@@ -216,7 +217,6 @@
                         </a>
                       {% endif %}
 
-                    </a>
                 {% elif exectask.count > 1%}
                     <a class="error" href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>
                 {% endif %}
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index 42c42a5..cbe3c68 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -56,7 +56,7 @@
         <td class="file"><a data-toggle="modal" href="#variable-{{variable.pk}}">
             {% if variable.vhistory.all %}
                 {% for path in variable.vhistory.all|filter_setin_files:file_filter %}
-                    {{path|cut_path_prefix:dirstostrip}}<p>
+                    {{path|cut_path_prefix:dirstostrip}}<br/>
                 {% endfor %}
             {% endif %}
         </a></td>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index 2da41c3..dd8753d 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -87,6 +87,7 @@
             {% else %}
             <table class="table table-bordered table-hover">
                 <thead>
+		  <tr>
                     <th>
                         <i class="icon-question-sign get-help" title="The running sequence of each task in the build"></i>
                         Order
@@ -107,6 +108,7 @@
                         <i class="icon-question-sign get-help" title="This column tells you if a task tried to restore output from the <code>sstate-cache</code> directory or mirrors, and reports the result: Succeeded, Failed or File not in cache"></i>
                         Cache attempt
                     </th>
+		  </tr>
                 </thead>
                 <tbody>
 
-- 
1.9.1


