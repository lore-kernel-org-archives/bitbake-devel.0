Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 9D848731A7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 00:05:18 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id kp3so2015916pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Feb 2016 16:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=CBPG5OAnhbTLZUcwcqntXpIYEuKlTtNNieQOtgX/AJw=;
	b=eS4+bZrr6pOZZD5QGzuoDArFn/5+zCcqI8j6KhhOzwzSRd4olXiAgmQ+hst8fDrMC1
	bFyx4e3LtZa5MUideiEWU4BdBmuU7sbptj0uIzCLL/nH/qWX+tfTWmLv+Dc/ixfuRyfJ
	tUOUYfg3xOpAtqDFvGlpLc7Fy2kHqxGaAbS0Vj7s9tr32amha6kzVxz34Wu8oz6Xo1vC
	MMfMFo7WkFpL5TI6gCP4yC169nVkfuZSeYxitwGrbB2YmADQU78hE4jzAc0or93MkNRC
	hdNTF4dYBb7t8BBItNqVVaVh1sw57iQ4fJhAi48zB4wS1taqnU3G5f/rOQQJpec2s9bR
	NvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=CBPG5OAnhbTLZUcwcqntXpIYEuKlTtNNieQOtgX/AJw=;
	b=HVkYb5K0UCnw+uA/GoBiRRrlxoM1eQ5Cjph0bjTxQeRs9UV7Vq6qVROdyYUB/oYu8A
	HRMIgPD/vj2hCq4mUS+E4cb4Js+fPv1td0J8IK0ct4ImL9j4CWZHYgDkMdLWEnsHaD9G
	D+y8iRmc+pWtjGvvHNbhzoY+woxPjie9XFVUTu+S9jOGuMSPKPblkBbbfIXNvyoQ88Py
	/mdhwVvR9tFRZTVSsQtCt/62HM5VA/1+7bVWKqtd1Ts4/tqqKRFDpP2ZSMSid00X/b41
	YUOyEwZLwVL1RDA8ttiynvgGF1xhlGpsPORZ2TuU8Um1g+Vj0cV4R6BiFqpeVr+ShfyU
	Bybg==
X-Gm-Message-State: AG10YORc6vsKhFREw2PwJLcDFj0EEtUE9GNj1Go5JRR9WAzjIV9kAuFFxNiOZGr1Yf3lAhC4
X-Received: by 10.66.229.104 with SMTP id sp8mr54408758pac.53.1455062719102;
	Tue, 09 Feb 2016 16:05:19 -0800 (PST)
Received: from dorado.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id 82sm345777pfn.89.2016.02.09.16.05.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 09 Feb 2016 16:05:18 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Feb 2016 00:05:06 +0000
Message-Id: <1455062707-14501-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH 1/2] toaster: templates make build data breadcrumb consistent
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
X-List-Received-Date: Wed, 10 Feb 2016 00:05:18 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The pages in the build data section of Toaster showed different
breadcrumbs: in some pages the machine was displayed, but not in others.
For builds with more than one target, some pages showed the first
alphabetical target (the correct behaviour), others didn't.

This patch removes the inconsistencies, showing exactly the same
breacrumb across all pages in the section.

The patch also removes the extra space between the '+' and the number of
targets when the builds have more than one target.

Remove an unneeded debug message

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/basebuilddetailpage.html | 2 +-
 lib/toaster/toastergui/templates/basebuildpage.html       | 3 +--
 lib/toaster/toastergui/templates/builddashboard.html      | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuilddetailpage.html b/lib/toaster/toastergui/templates/basebuilddetailpage.html
index 22ca50c..ffe7aa4 100644
--- a/lib/toaster/toastergui/templates/basebuilddetailpage.html
+++ b/lib/toaster/toastergui/templates/basebuilddetailpage.html
@@ -8,7 +8,7 @@
         <ul class="breadcrumb" id="breadcrumb">
             <li class="muted">{{build.project.name}}:</li>
             <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
-            <li><a href="{%url 'builddashboard' build.pk%}">{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
+            <li><a href="{%url 'builddashboard' build.pk%}">{{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
         <script>
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index d441df8..a9048d3 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -13,7 +13,7 @@
             <li>
             {% block parentbreadcrumb %}
             <a href="{%url 'builddashboard' build.pk%}">
-                {{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} ({{build.completed_on|date:"d/m/y H:i"}})
+              {{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
             </a>
             {% endblock %}
             </li>
@@ -24,7 +24,6 @@
             $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
             $('#breadcrumb > li:last > span, #breadcrumb > li:first > span').remove();
-	    console.log("done");
         });
         </script>
     </div>
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 323bbbb..7857aba 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -6,10 +6,9 @@
 {% block parentbreadcrumb %}
 {% if build.get_sorted_target_list.count > 0 %}
   {{build.get_sorted_target_list.0.target}}
-  &nbsp;
 {% endif %}
 
-{%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
+{%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
 {% endblock %}
 
 {% block buildinfomain %}
-- 
2.5.0


