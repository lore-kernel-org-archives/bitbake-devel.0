Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id D82B86EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:14 +0000 (UTC)
Received: by mail-we0-f176.google.com with SMTP id x48so5116626wes.35
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=oqClWRaSUjx1RGjSTL1k1NPJ0lGxrVZooniCb8/fCqY=;
	b=IHLvWK1Q9e2FpkzR9dp4OvjSyCyOEadvKYLlp/yxR886E5K7kIbHS2Fg+qXXFjBfkN
	rkTG629xQrYQvHI40QvXrXqvnN9vh2coV31vH9XMxEyokqhT00auN55Q5cD9xOlX/yUh
	lIe6FCImRy9BMha3wRq+V8c8B3ogYqzsjnskmS1BL2JJOoy+7ShEIRFTyX7M0mXzGFt2
	psfSYlEoEg135VV2QjXk+yx+38M8urG6GTl6/Oys1FTfbXNmvxGPcIX9TGASNrc7CGqo
	k9YvVqh7WedRvXJiTqeeSGki2Jab8pdBxX5UthIk+1W7TA7NnaXlzYJkO0ZTz7Qn4mg4
	Wxxw==
X-Gm-Message-State: ALoCoQnVv3T+uyBNfRYRFinqZ/5U01fPkKqEey9bFH6asNLolQIq8/zqOgvEYu/s5n0ykz5mTmUC
X-Received: by 10.194.58.180 with SMTP id s20mr7248881wjq.54.1396284434996;
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n3sm27672353wix.10.2014.03.31.09.47.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0BB22560356; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:03 +0100
Message-Id: <4db519c5b37cfdce37e4b2afaef75109295ff800.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: Ravi Chintakunta <ravi.chintakunta@timesys.com>
Subject: [PATCH 03/14] toaster: Display task description
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:17 -0000

From: Ravi Chintakunta <ravi.chintakunta@timesys.com>

Display task description as content of help bubble for a task.

[YOCTO #5748]

Signed-off-by: Ravi Chintakunta <ravi.chintakunta@timesys.com>
---
 lib/toaster/orm/models.py                    | 7 +++++++
 lib/toaster/toastergui/templates/recipe.html | 2 +-
 lib/toaster/toastergui/templates/tasks.html  | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4975433..9c15ebf 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -174,6 +174,13 @@ class Task(models.Model):
             return "Executed"
         return "Not Executed"
 
+    def get_description(self):
+        variable = Variable.objects.filter(variable_name=self.task_name, build = self.build)
+        try:
+            return variable[0].description
+        except IndexError:
+            return ''
+
     build = models.ForeignKey(Build, related_name='task_build')
     order = models.IntegerField(null=True)
     task_executed = models.BooleanField(default=False) # True means Executed, False means Not/Executed
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index e367077..b8898d2 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -112,7 +112,7 @@
                     <td><a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.order}}</a></td>
                     <td>
                         <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.task_name}}</a>
-                        <i class="icon-question-sign get-help hover-help" title="This task fetches the source code"></i>
+                        {% if task.get_description %}<i class="icon-question-sign get-help hover-help" title="" data-original-title="{{task.get_description}}"></i> {% endif %}
                     </td>
 
                     <td><a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_executed_display}}</a></td>
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index ca7e187..d68a31a 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -86,7 +86,7 @@
                 <a href="{% url "recipe" build.pk task.recipe.pk %}">{{task.recipe.version}}</a>
             </td>
             <td class="task_name">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.task_name}}</a>
+                <a href="{%url "task" build.pk task.pk%} ">{{task.task_name}}</a> {% if task.get_description %}<i class="icon-question-sign get-help hover-help" title="" data-original-title="{{task.get_description}}"></i> {% endif %}
             </td>
             <td class="executed">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_executed_display}}</a>
-- 
1.9.1


