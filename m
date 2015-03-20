Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 22ADF728C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:40 +0000 (UTC)
Received: by pabxg6 with SMTP id xg6so92233773pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=edCvcpxwaedbm/6NZIaQCdsp8c7adWcXnv9JF6QxrKc=;
	b=leUDS8qt/XhndZhqyluKSlibY2+qFL7mPEmmsjJk+7ZbIasaa3Q2fwbKJCMyYH38la
	pTKzPM5b1bRoNDk3fZbsIua65nCS7HmmJ2GAF9jRQJMZWCqE1oGgRaJQFVpjUCkao3a4
	q1voyoMAaJQR5BWHwyoqhTnd06gApY5bYep4CYamHlU+mqq0g73D2z9mMOobtgRQ+kp/
	us+W0EprvLemrjH1Grd22km2EsgiAVLLmdr1f6b+a6x7dG0aKhAdAd+AvrnPB+TA2C6Y
	VdLeThdzjQysuQ3yZyocURkVaDjQpo+Y/KQwHttRFYAAmVloJ/222JNOZNFNxu3MuYqk
	4sjw==
X-Gm-Message-State: ALoCoQmFJx2nOoKWV3G79DyqQSGubaoJrkFaudM25Y0UbAPbJG+vO0Qlp7PqC+F3vohfiwdqW++s
X-Received: by 10.66.118.198 with SMTP id ko6mr188495093pab.16.1426847142375; 
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ca17sm7324189pdb.95.2015.03.20.03.25.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B832356448F; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:27 +0000
Message-Id: <6fa0417a35de856d56418e9ac3f4b44f3a61b00d.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 10/14] toaster: Incorrect breadcrumb behaviour in the project page
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:41 -0000

From: David Reyna <David.Reyna@windriver.com>

The last item in the breadcrumb for the project page should not be a link.

[YOCTO #7157]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/baseprojectpage.html | 6 ++++++
 lib/toaster/toastergui/views.py                       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index e140925..0807f4c 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -11,10 +11,16 @@
             <li><a href="{% url 'all-builds' %}">All builds</a></li>
             {% block parentbreadcrumb %}
         {% if project %}
+          {% if project_html %}
+            <li>
+                {{project.name}}
+            </li>
+          {% else %}
             <li>
                 <a href="{%url 'project' project.id %}"><span id="project_name">{{project.name}}</span>
                 </a>
             </li>
+          {% endif %}
         {% endif %}
             {% endblock %}
             {% block localbreadcrumb %}{% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e87c9f2..661023e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2142,6 +2142,7 @@ if toastermain.settings.MANAGED:
             "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
             "freqtargets": freqtargets,
             "releases": map(lambda x: {"id": x.pk, "name": x.name, "description":x.description}, Release.objects.all()),
+            "project_html": 1,
         }
         try:
             context["machine"] = {"name": prj.projectvariable_set.get(name="MACHINE").value}
-- 
1.9.1


