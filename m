Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 15D777068F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 10:27:28 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id y10so7755839wgg.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Nov 2014 02:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/MtpqUjyU4WFtJXkFwuTtuY+9xhMJo5CXoM4RZtYNqk=;
	b=EZRtUouV6XXJ/kgz8gmRRFXaIt/Hk/owB9vnJm7dj+/rFeCzVbtkKk6r1qSIjk+kfp
	YwRPNP9sJgXB9hMUQhJsaAmhYwh6PFnSz7pAh1oSnULrQix9XgA4+luRCuf9kFCxS8D7
	gQK8caa0F3jVbq3HaE/Np0jS8c905ygipcaqR8AqJoh15XiFohrjaLP9OQTeBlRCdFph
	ELTbQHwCXpUWdWqIQeeKGSQcI7KGCk9muMPsGnYqf4ysUAIVOnxOi67WwvMPk4iulsyN
	v9MlITfqdBzCTauokuqY/ztal0G0ps4gBR4yZ7Od0aU+5Y67vyoVDxM0x2N564psZXAp
	KqsA==
X-Gm-Message-State: ALoCoQm8ApBVJOrp2dBrX7364TisI2AmskEjD9nSR6K1shh7SW/BhSWJLjprWYz765zvScJ0LhLC
X-Received: by 10.194.203.201 with SMTP id ks9mr1926331wjc.105.1415010448574; 
	Mon, 03 Nov 2014 02:27:28 -0800 (PST)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hu3sm21679734wjb.17.2014.11.03.02.27.26 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Nov 2014 02:27:26 -0800 (PST)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 17AE5560576; Fri, 31 Oct 2014 19:17:05 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Oct 2014 19:17:02 +0000
Message-Id: <8d2a3e4b92c67cce1f9f54de7386aae0a604de44.1414779051.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <82772b844dfa509e533adc339264151c47f013d6.1414779051.git.alexandru.damian@intel.com>
References: <82772b844dfa509e533adc339264151c47f013d6.1414779051.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1414779051.git.alexandru.damian@intel.com>
References: <cover.1414779051.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/2] toastergui: fix invalid build url usage
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
X-List-Received-Date: Mon, 03 Nov 2014 10:27:30 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We need to pass the URL for the build action as javascript
parameter, since the project ID is different for each build,
instead of using the project id of the most-recently-used project.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 5ba0b08..3d17ac6 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -44,7 +44,7 @@
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
           {% if build.project %}
-              <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick="scheduleBuild({{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})">Run again</a>
+              <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick="scheduleBuild({%url 'xhr_projectbuild' build.project.id as myurl %}{{myurl|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})">Run again</a>
           {% endif %}
             </div>
     {%endif%}
@@ -64,10 +64,10 @@
 
 <script>
 
-function _makeXHRBuildCall(data, onsuccess, onfail) {
+function _makeXHRBuildCall(url, data, onsuccess, onfail) {
     $.ajax( {
         type: "POST",
-        url: "{% url 'xhr_projectbuild' project.id %}",
+        url: url,
         data: data,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
@@ -86,9 +86,9 @@ function _makeXHRBuildCall(data, onsuccess, onfail) {
 }
 
 
-function scheduleBuild(projectName, buildlist) {
+function scheduleBuild(url, projectName, buildlist) {
   console.log("scheduleBuild");
-//  _makeXHRBuildCall({targets: buildlist.join(" ")}, function (_data) {
+//  _makeXHRBuildCall(url , {targets: buildlist.join(" ")}, function (_data) {
 
   $('#latest-builds').prepend('<div class="alert alert-info" style="padding-top:0px">' + '<span class="label label-info" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;">'+projectName+'</span><div class="row-fluid">' +
   '<div class="span4 lead">' + buildlist.join(" ") +
-- 
1.9.1


