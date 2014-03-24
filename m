Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id B2ADB6FB0B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:34 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id hi5so2703677wib.17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UUGJ9JRk9W9m8LaO/7Mbkk/GDAqRXUsh8jqBasM4Fdg=;
	b=XEqKYXL+My+6T1KjIjpBA0UFCGDdYnIypC79/v2ltM8LSG1ZkLBU5WjDVmASFyF2mp
	+h4shhJk72lbYPlWxQgMXDSs7wS0sBG7cfV9XgIC4vAZ7/eAKr2a5TugdehtS0Yg+qur
	HZfDw8LXtf3cFR22QeCLbgMrlkmX52ZxFm+IzkhKye3owmlcUpv4XSnAAFCwwsoakkqV
	7L568Ds5Fs5rAhtLzecvMF8YE/hPXjidakT5EgaFS3p26YHK/mXSpzoiOVlI0qXRF5Fp
	ndlne7zYVXHK9l8VP4UibPbneW6krqF1I04mq0nFHe9XmCYdMGFPFGCuhXGBG9lUV2f9
	7kjw==
X-Gm-Message-State: ALoCoQl1R+xGcD2iKKE6gsLD/UJWXIsUEmGxQCml8lBqGu5A41GhBDrPKwUu8VF7ljl1+g3kCRAy
X-Received: by 10.180.25.46 with SMTP id z14mr16681007wif.49.1395686254931;
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id bi8sm41436420wib.3.2014.03.24.11.37.32
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id BA0A6561337; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:17 +0000
Message-Id: <7793de593121da9761e4584331b68bf684112300.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Subject: [PATCH 07/18] toaster: Add help text to filters
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:37 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The 'Set in file' and 'Description' filters in the configuration page,
and the 'Outcome' and 'Cache attempt' filters in the tasks page should
include a help tooltip with some explanation about what they do.
This change adds the tooltips.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 .../toastergui/templates/filtersnippet.html        |  1 +
 lib/toaster/toastergui/views.py                    | 32 +++++++++++-----------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/templates/filtersnippet.html b/lib/toaster/toastergui/templates/filtersnippet.html
index a72eeaa..90ffd3d 100644
--- a/lib/toaster/toastergui/templates/filtersnippet.html
+++ b/lib/toaster/toastergui/templates/filtersnippet.html
@@ -23,6 +23,7 @@
                     <label class="radio muted">
                         <input type="radio" name="filter" disabled {%if request.GET.filter == option.1 %}checked{%endif%}  value="{{option.1}}"> {{option.0}} ({{option.2}})
                 {% endif %}
+                {% if option.3 %}<i class="icon-question-sign get-help" data-placement="right" title="{{option.3}}"></i>{% endif %}
                 </label>
             {% endfor %}
         </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 3f6b93e..2156d68 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -782,12 +782,12 @@ def tasks_common(request, build_id, variant):
                    'class' : 'outcome',
                    'label': 'Show:',
                    'options' : [
-                               ('Succeeded Tasks', 'outcome:%d'%Task.OUTCOME_SUCCESS, queryset_with_search.filter(outcome=Task.OUTCOME_SUCCESS).count() ),
-                               ('Failed Tasks', 'outcome:%d'%Task.OUTCOME_FAILED, queryset_with_search.filter(outcome=Task.OUTCOME_FAILED).count()),
-                               ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED, queryset_with_search.filter(outcome=Task.OUTCOME_CACHED).count()),
-                               ('Prebuilt Tasks', 'outcome:%d'%Task.OUTCOME_PREBUILT, queryset_with_search.filter(outcome=Task.OUTCOME_PREBUILT).count()),
-                               ('Covered Tasks', 'outcome:%d'%Task.OUTCOME_COVERED, queryset_with_search.filter(outcome=Task.OUTCOME_COVERED).count()),
-                               ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_EMPTY, queryset_with_search.filter(outcome=Task.OUTCOME_NA).count()),
+                               ('Succeeded Tasks', 'outcome:%d'%Task.OUTCOME_SUCCESS, queryset_with_search.filter(outcome=Task.OUTCOME_SUCCESS).count(), 'Succeeded tasks are those that ran and completed during the build' ),
+                               ('Failed Tasks', 'outcome:%d'%Task.OUTCOME_FAILED, queryset_with_search.filter(outcome=Task.OUTCOME_FAILED).count(), 'Failed tasks are those that ran but did not complete during the build'),
+                               ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED, queryset_with_search.filter(outcome=Task.OUTCOME_CACHED).count(), 'Cached tasks restored output from the <code>sstate-cache</code> directory or mirrors'),
+                               ('Prebuilt Tasks', 'outcome:%d'%Task.OUTCOME_PREBUILT, queryset_with_search.filter(outcome=Task.OUTCOME_PREBUILT).count(),'Prebuilt tasks didn\'t need to run because their output was reused from a previous build'),
+                               ('Covered Tasks', 'outcome:%d'%Task.OUTCOME_COVERED, queryset_with_search.filter(outcome=Task.OUTCOME_COVERED).count(), 'Covered tasks didn\'t need to run because their output is provided by another task in this build'),
+                               ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_EMPTY, queryset_with_search.filter(outcome=Task.OUTCOME_NA).count(), 'Empty tasks have no executable content'),
                                ]
                    }
 
@@ -809,10 +809,10 @@ def tasks_common(request, build_id, variant):
                    'class' : 'cache_attempt',
                    'label': 'Show:',
                    'options' : [
-                               ('Tasks with cache attempts', 'sstate_result:%d'%Task.SSTATE_NA, queryset_with_search.filter(sstate_result=Task.SSTATE_NA).count()),
-                               ("Tasks with 'File not in cache' attempts", 'sstate_result:%d'%Task.SSTATE_MISS,  queryset_with_search.filter(sstate_result=Task.SSTATE_MISS).count()),
-                               ("Tasks with 'Failed' cache attempts", 'sstate_result:%d'%Task.SSTATE_FAILED,  queryset_with_search.filter(sstate_result=Task.SSTATE_FAILED).count()),
-                               ("Tasks with 'Succeeded' cache attempts", 'sstate_result:%d'%Task.SSTATE_RESTORED,  queryset_with_search.filter(sstate_result=Task.SSTATE_RESTORED).count()),
+                               ('Tasks with cache attempts', 'sstate_result:%d'%Task.SSTATE_NA, queryset_with_search.filter(sstate_result=Task.SSTATE_NA).count(), 'Show all tasks that tried to restore ouput from the <code>sstate-cache</code> directory or mirrors'),
+                               ("Tasks with 'File not in cache' attempts", 'sstate_result:%d'%Task.SSTATE_MISS,  queryset_with_search.filter(sstate_result=Task.SSTATE_MISS).count(), 'Show tasks that tried to restore output, but did not find it in the <code>sstate-cache</code> directory or mirrors'),
+                               ("Tasks with 'Failed' cache attempts", 'sstate_result:%d'%Task.SSTATE_FAILED,  queryset_with_search.filter(sstate_result=Task.SSTATE_FAILED).count(), 'Show tasks that found the required output in the <code>sstate-cache</code> directory or mirrors, but could not restore it'),
+                               ("Tasks with 'Succeeded' cache attempts", 'sstate_result:%d'%Task.SSTATE_RESTORED,  queryset_with_search.filter(sstate_result=Task.SSTATE_RESTORED).count(), 'Show tasks that successfully restored the required output from the <code>sstate-cache</code> directory or mirrors'),
                                ]
                    }
 
@@ -1072,11 +1072,11 @@ def configvars(request, build_id):
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
                     'options' : [
-                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf', queryset_with_search.filter(vhistory__file_name__contains='conf/local.conf').count()),
-                               ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/',queryset_with_search.filter(vhistory__file_name__contains='conf/machine').count()),
-                               ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/',queryset_with_search.filter(vhistory__file_name__contains='conf/distro').count()),
-                               ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf',queryset_with_search.filter(vhistory__file_name__contains='conf/layer.conf').count()),
-                               ('bitbake.conf variables', 'vhistory__file_name__contains:/bitbake.conf',queryset_with_search.filter(vhistory__file_name__contains='/bitbake.conf').count()),
+                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf', queryset_with_search.filter(vhistory__file_name__contains='conf/local.conf').count(), 'Select this filter to see variables set by the <code>local.conf</code> and <code>bblayers.conf</code> configuration files inside the <code>/build/conf/</code> directory'),
+                               ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/',queryset_with_search.filter(vhistory__file_name__contains='conf/machine').count(), 'Select this filter to see variables set by the configuration file(s) inside your layers <code>/conf/machine/</code> directory'),
+                               ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/',queryset_with_search.filter(vhistory__file_name__contains='conf/distro').count(), 'Select this filter to see variables set by the configuration file(s) inside your layers <code>/conf/distro/</code> directory'),
+                               ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf',queryset_with_search.filter(vhistory__file_name__contains='conf/layer.conf').count(), 'Select this filter to see variables set by the <code>layer.conf</code> configuration file inside your layers'),
+                               ('bitbake.conf variables', 'vhistory__file_name__contains:/bitbake.conf',queryset_with_search.filter(vhistory__file_name__contains='/bitbake.conf').count(), 'Select this filter to see variables set by the <code>bitbake.conf</code> configuration file'),
                                ]
                              },
                 },
@@ -1088,7 +1088,7 @@ def configvars(request, build_id):
                     'class' : 'description',
                     'label': 'Show:',
                     'options' : [
-                               ('Variables with description', 'description__regex:.+', queryset_with_search.filter(description__regex='.+').count()),
+                               ('Variables with description', 'description__regex:.+', queryset_with_search.filter(description__regex='.+').count(), 'We provide descriptions for the most common BiBake variables, so this filter effectively shows you a curated list of variables put together by the Yocto Project maintainers. The curated list lives in <code>/meta/conf/documentation.conf</code> inside your <code>poky</code> directory'),
                                ]
                             },
                 },
-- 
1.8.3.2


