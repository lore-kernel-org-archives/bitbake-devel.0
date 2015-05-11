Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 8AA8C73FD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 11:00:35 +0000 (UTC)
Received: by widdi4 with SMTP id di4so91675181wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 04:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RXJKg1OXsiXEnA5yCA20jQhlGhrYR4GUc8KnW+83wb8=;
	b=GGwH/zaKhUk02JXEtwC8CR8C95QErlwsa+IolmIDzmTerb5NmypMx4jO3YDWEbgtjY
	t7oLExBHldHyh86xNe5WRikNZShYH7OlAUhLcL2u+DhN7GijmSeNir0nEpj/KvZ6wD/l
	YIi3ZADdAKHw7otgw/vPeafUlMHv7z/YfVfjKtS0r5YzPJWCA9LGRDzlZOpFcobBz7la
	vuyQtxv1U/DYuiwU4O0S85wXhdt0tQxsiFFItPkKmk/HbJoXre9RxVOFmD13p1wZ9IHk
	KYIwSH5GWQ9R6hsoVH1Gu/+bjDDgHVaE4VgfT/f5h/N9cH3mvPaqym/wTjEhSjOeREdw
	tQuA==
X-Gm-Message-State: ALoCoQnqK3teR2XL7eegAHqxzv6Q21LWTt4Rt+ERW9jVl5WiN8BoZZti6OAY2DBI6Vc1DMexdYlw
X-Received: by 10.180.74.208 with SMTP id w16mr18429474wiv.31.1431342035103;
	Mon, 11 May 2015 04:00:35 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u6sm22269253wjy.13.2015.05.11.04.00.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 04:00:34 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F40DB56062D; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:41 +0100
Message-Id: <771f331793a8e5acf60df62693caac9bfed463d1.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 10/11] toastergui: fix whitespace after URL
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
X-List-Received-Date: Mon, 11 May 2015 11:00:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes whitespace after URLs in the tasks page,
fixing warnings from the linkchecker.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/tasks.html | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 5c1c476..32c0552 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -86,13 +86,13 @@
                 <a href="{% url "recipe" build.pk task.recipe.pk %}">{{task.recipe.version}}</a>
             </td>
             <td class="task_name">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.task_name}}</a> {% if task.get_description %}<i class="icon-question-sign get-help hover-help" title="{{task.get_description}}"></i> {% endif %}
+                <a href="{%url "task" build.pk task.pk%}">{{task.task_name}}</a> {% if task.get_description %}<i class="icon-question-sign get-help hover-help" title="{{task.get_description}}"></i> {% endif %}
             </td>
             <td class="executed">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.get_executed_display}}</a>
+                <a href="{%url "task" build.pk task.pk%}">{{task.get_executed_display}}</a>
             </td>
             <td class="outcome">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.get_outcome_display}} </a>
+                <a href="{%url "task" build.pk task.pk%}">{{task.get_outcome_display}} </a>
                 {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
                     <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
                         <i class="icon-download-alt" title="Download task log file"></i>
@@ -101,7 +101,7 @@
                 <i class="icon-question-sign get-help hover-help" title="{{task.get_outcome_help}}"></i>
             </td>
             <td class="cache_attempt">
-                <a href="{%url "task" build.pk task.pk%} ">{{task.get_sstate_result_display|format_none_and_zero}}</a>
+                <a href="{%url "task" build.pk task.pk%}">{{task.get_sstate_result_display|format_none_and_zero}}</a>
             </td>
             <td class="time_taken">
                 {{task.elapsed_time|format_none_and_zero|floatformat:2}}
-- 
1.9.1


