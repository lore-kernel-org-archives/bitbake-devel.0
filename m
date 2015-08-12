Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 909037677C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 10:33:49 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so107663648wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 03:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=dsA8/8/0JvPFVoCa80hCRI0p9dot2Q0ghmJvhOF1y9M=;
	b=Yu7zeEAw4c5qf+BrcWAF+7O9cl9sGinJCROv174A5Yupn3eIJCnqVAu5CkB4XyG95z
	PB6D3wE5VR4nzdOlZMj3rsxiOcZfph2DKF84ZzxUs+q1yksGcOUZPfRlB2pkjCn0kZ/K
	SKFMxG+EUr90+kTf0VzqNQwqVhOxIO5oDNZ9N/xQBj4VjbjztaN1S/UYw4Q5noDMpEFl
	pNfLWV9JC1kYcTxJgDu0uHLdjAvJrh7yGBqff8nTz0zr1oR92OBF3GhgVJIk4G2Ya2Lj
	0RLRValFxUr6k/XnQdTHvlgk15aN/qm7BQijRC3+jBgmqGRHQhDfjaioyBWiv6ZGRpIV
	OSZA==
X-Gm-Message-State: ALoCoQnix3RQgHxnjmUYucD7VFJSG0s7hroNBz8pW4QFbGxS4OW1ip7Aew0br4PEWr6nhXAJq+5H
X-Received: by 10.180.86.137 with SMTP id p9mr24843719wiz.38.1439375629933;
	Wed, 12 Aug 2015 03:33:49 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id wx9sm7262934wjb.6.2015.08.12.03.33.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 12 Aug 2015 03:33:49 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Aug 2015 11:33:43 +0100
Message-Id: <d6d2f3d5d4d6fefe9eb76db215ae0f2123b976d8.1439375393.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <a77a9b3c3d6a971349ce6068fb7f91115e70bdcf.1439375393.git.michael.g.wood@intel.com>
References: <cover.1439375393.git.michael.g.wood@intel.com>
	<a77a9b3c3d6a971349ce6068fb7f91115e70bdcf.1439375393.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439375393.git.michael.g.wood@intel.com>
References: <cover.1439375393.git.michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 2/2] bitbake: toaster: fix invalid fields in the package details page
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
X-List-Received-Date: Wed, 12 Aug 2015 10:33:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch safeguards referencing invalid fields in the
project details template, and fixes errors thrown in the
page.

[YOCTO #7992]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 .../toastergui/templates/package_included_reverse_dependencies.html   | 2 +-
 lib/toaster/toastergui/templates/tablesort.html                       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 4ba472f..5cc8b47 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -23,7 +23,7 @@
             {% include "tablesort.html" %}
                 <tbody>
 					{% for reverse_dep in objects %}
-                        <tr {{reverse_dep.size|format_vpackage_rowclass}} >
+                        <tr {% if reverse_dep.size %}{{reverse_dep.size|format_vpackage_rowclass}}{%endif%} >
                         {% if reverse_dep.size != -1 %}
                             <td>
                                 <a href="{% url 'package_included_detail' build.id target.id reverse_dep.package_id %}">
diff --git a/lib/toaster/toastergui/templates/tablesort.html b/lib/toaster/toastergui/templates/tablesort.html
index bf311b6..3624742 100644
--- a/lib/toaster/toastergui/templates/tablesort.html
+++ b/lib/toaster/toastergui/templates/tablesort.html
@@ -5,7 +5,7 @@
     <thead>
         <tr>
             {% for tc in tablecols %}
-            <th class="{{tc.dclass}} {{tc.clclass}}">
+            <th class="{%if tc.dclass%}{{tc.dclass}}{%endif%} {%if tc.clclass%}{{tc.clclass}}{%endif%}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
                 {{tc.name}}
             </th>
@@ -18,7 +18,7 @@
         <!-- Table header row; generated from "tablecols" entry in the context dict -->
         <tr>
             {% for tc in tablecols %}
-            <th class="{{tc.dclass}} {{tc.clclass}}">
+            <th class="{%if tc.dclass%}{{tc.dclass}}{%endif%} {%if tc.clclass%}{{tc.clclass}}{%endif%}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
                 {%if tc.orderfield%}
                     <a {%if tc.ordericon%} class="sorted" {%endif%}
-- 
2.1.4


