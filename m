Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id ACA8F6F79F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:56 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id hn9so1100704wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Jo16kjI0gDAIV/kEX13uKLE+kqc4CYtdifu9E7CecVM=;
	b=mvhAPdTsZhGwOs2LESXx1LLllrj4KP6FU3uW/BIosqx0J7FSCqe+55eXQBx58fs69S
	8bBaaUCyxpWltnyoA6+qlRYXbsqsphk/4fxxvabwibFmRCVos/3gK55AQwNJzUxb2PLO
	yWZMnmue5swBPt6vP1q++M0VadL7wJxF9KTOvL1Gm1iXXRApyDSBVRiPaazTyooEjSgV
	h62837vSEsk+cMxq0pZr63tbgVKGR0JwueUPk/Gmy+Hy/JYt4vm8CSfMklP5+h6CUBp1
	MOMkny7TqmtM6BqChscUMEYwaPWIuuUUDWP7CQisQVvGpdhc89U2w1/cwNj/RmpKDnIA
	3ePA==
X-Gm-Message-State: ALoCoQmcUhDh/X/W63Ebz1EPdg7gUrrAFeh9SXB+MMDMchc5NKYQI7mBwl0Bl2Jemh4X/S8oB7n/
X-Received: by 10.180.97.37 with SMTP id dx5mr3585827wib.53.1394552997664;
	Tue, 11 Mar 2014 08:49:57 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t5sm62453845wjw.15.2014.03.11.08.49.54
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:56 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 39BBF5616DC; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:50 +0000
Message-Id: <874b627b96809c274023b5fa330dfbdd14676d19.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 6/8] toaster: add empty outcome support to task page
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:58 -0000

From: David Reyna <David.Reyna@windriver.com>

Add the new "empty" outcome value to the task detail page,
with help text, help notice, plus sorting for empty in the
tasks page.

[YOCTO #5917]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py                  | 1 +
 lib/toaster/toastergui/templates/task.html | 4 ++++
 lib/toaster/toastergui/views.py            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0646813..93506d7 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -146,6 +146,7 @@ class Task(models.Model):
         (OUTCOME_CACHED, 'This task restored output from the sstate-cache directory or mirrors'),
         (OUTCOME_PREBUILT, 'This task did not run because its outcome was reused from a previous build'),
         (OUTCOME_FAILED, 'This task did not complete'),
+        (OUTCOME_EMPTY, 'This task has no executable content'),
         (OUTCOME_NA, ''),
     )
 
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index a8bcb52..5d79d44 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -121,6 +121,10 @@
 		</code>
             </dd>
         </dl>
+    {%elif task.outcome == task.OUTCOME_EMPTY%}
+        <div class="alert alert-info details">
+            This task is empty because it has the <code>noexec</code> flag set to <code>1</code>, or the task function is empty
+        </div>
     {% endif %}
 {% endif %}
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ccf9585..6273d4c 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -558,7 +558,7 @@ def tasks_common(request, build_id, variant):
                                ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED),
                                ('Prebuilt Tasks', 'outcome:%d'%Task.OUTCOME_PREBUILT),
                                ('Covered Tasks', 'outcome:%d'%Task.OUTCOME_COVERED),
-                               ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_NA),
+                               ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_EMPTY),
                                ]
                    }
 
-- 
1.8.3.2


