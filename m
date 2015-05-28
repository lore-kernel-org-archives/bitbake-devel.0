Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id D1C0475692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:16:26 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so125113475wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=doe6bslh0tubb9sLRCKbywQwkkJG5JuPztjlAM8vhh0=;
	b=fAyRS+QmWZ+cDF4PxYjwmK+nYl95YFjkVl6p4A0svNE/e5bDLoT86jhoLrsJjP/H07
	5F0zu8xuJPWLV4OQngXICMYzCsSzds4EZqb0bOOWqSyOI+WseBsp5lBHaopEMMu87Zcn
	Q6/TUFsNhksm2HHhSr+gq8+J2FzaKwOU5/3ag/70oOX8ZUv9gIqlLwYqX41xtCOZ7miW
	CDZTuj6p4S+kEL7Q/kvPfe9qFuGPtpHfdmTIdNZk32B5Hbf0bzjfaJllAMK0pSb3aNMQ
	fJK9ocQ3Oi1nQo4kdk0j4uqcEwc5ZkhGL85qNHDJiUJUKex74Djv0NcCbc27Isi3LRaQ
	XV4Q==
X-Gm-Message-State: ALoCoQnpBMP4z0UsrZDu09R0Ui8iQDef1OFASuqFzwvh0NAxFEmzdrHkUN8Vyq52uwvs1mdx8SdR
X-Received: by 10.195.11.168 with SMTP id ej8mr5795204wjd.150.1432822587500;
	Thu, 28 May 2015 07:16:27 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n6sm3186402wic.16.2015.05.28.07.16.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:16:26 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C89E0561271; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:05 +0100
Message-Id: <b3746b18fc111907fafa5015d92a48a0b967f45d.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 11/22] toaster-gui: Show task name for the builds in /builds
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
X-List-Received-Date: Thu, 28 May 2015 14:16:27 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Task name was only shown for the latest builds in project view.
Now it should be shown also in builds view.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/brtargets.html      | 20 ++++++++++++++++++++
 .../toastergui/templates/managed_mrb_section.html    | 12 +++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/brtargets.html

diff --git a/lib/toaster/toastergui/templates/brtargets.html b/lib/toaster/toastergui/templates/brtargets.html
new file mode 100644
index 0000000..4ebd058
--- /dev/null
+++ b/lib/toaster/toastergui/templates/brtargets.html
@@ -0,0 +1,20 @@
+<span data-toggle="tooltip"
+    {% if buildrequest.brtarget_set.all.count > 1 %}
+        title="Targets:
+        {% for target in buildrequest.brtarget_set.all %}
+            {% if target.task %}
+                {{target.target}}:{{target.task}}
+            {% else %}
+                {{target.target}}
+            {% endif %}
+        {%endfor%}"
+    {%endif%}>
+    {% if buildrequest.brtarget_set.all.0.task %}
+        {{buildrequest.brtarget_set.all.0.target}}:{{buildrequest.brtarget_set.all.0.task}}
+    {% else %}
+         {{buildrequest.brtarget_set.all.0.target}}
+    {% endif %}
+    {% if buildrequest.brtarget_set.all.count > 1 %}
+        (+ {{buildrequest.brtarget_set.all.count|add:"-1"}})
+    {% endif %}
+</span>
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index a6d4ac6..abcc0bb 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -26,8 +26,7 @@
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
     {% endif %}
-                <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
-                </span>
+    {% include "brtargets.html" %}
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 </a>
     {% endif %}
@@ -84,7 +83,7 @@
           {% if buildrequest.state == buildrequest.REQ_FAILED %}
             <div class="span3 lead">
                 <a href="{%url 'buildrequestdetails' buildrequest.project.id buildrequest.pk%}" class="error">
-                  <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                  {% include "brtargets.html" %}
                 </a>
             </div>
             <div class="span2 lead">
@@ -113,8 +112,7 @@
          {% elif buildrequest.state == buildrequest.REQ_QUEUED %}
 
             <div class="lead span5">
-
-                <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                {% include "brtargets.html" %}
             </div>
             <div class="span4 lead">Build queued
               <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
@@ -124,7 +122,7 @@
          {% elif buildrequest.state == buildrequest.REQ_CREATED %}
 
             <div class="lead span3">
-                <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                {% include "brtargets.html" %}
             </div>
             <div class="span6" >
               <span class="lead">Creating build</span>
@@ -133,7 +131,7 @@
          {% elif buildrequest.state == buildrequest.REQ_INPROGRESS %}
 
                 <div class="lead span5">
-                  <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                  {% include "brtargets.html" %}
                 </div>
                 <div class="span4 lead">
                   Checking out layers
-- 
1.9.1


