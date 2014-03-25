Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
	[74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id 92B766F4EC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 18:02:36 +0000 (UTC)
Received: by mail-we0-f181.google.com with SMTP id q58so557885wes.40
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 11:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=N5WmOr6N8b/UkwtG+q2w9v6gUrP07ra+hLNvvLjWAT4=;
	b=WK8U3mdp2Km0gtioKL4yNgIGTF9CIDoqTyzDFnptAMfPjq7MyBPOjAjVFMvlHV5NnU
	qK6oRmmBTie0QREWIjTCjyOm5B3vh2//Aw3nShlvILYRP3TSi9uugduadkeXGq6qrSJu
	s+FnMV8D7FyNdt4flOF0se7DMEKnK5jStCSnF6Ja2GONFx0isk+cBkYLinNzvjHingrP
	DdZ9IKdrSY1Kmt0WlJkH9iG8doUOnc/lz42OOXth2AXr0mfWcOFCDUOVtS97u05CSrQe
	qsAEsLqthqfgincTcIHGYgEosvzJHtfazgS5ak5+Z05mUXNlM0+cCgwObCCBL3t//yIp
	OCWA==
X-Gm-Message-State: ALoCoQnW9smzI4odFDjX+W/vR4fAfb842g3ludqjVFk5hVuExtzNQ773T98ildi7z3G1u+sDIrVN
X-Received: by 10.180.12.14 with SMTP id u14mr25791426wib.0.1395770556577;
	Tue, 25 Mar 2014 11:02:36 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fs4sm52669942wib.11.2014.03.25.11.02.34 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 25 Mar 2014 11:02:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8FA2B56051F; Tue, 25 Mar 2014 17:51:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 17:51:09 +0000
Message-Id: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1395769683.git.alexandru.damian@intel.com>
References: <cover.1395769683.git.alexandru.damian@intel.com>
Subject: [PATCH 1/5] toaster: Change placeholder attribute in variables table
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
X-List-Received-Date: Tue, 25 Mar 2014 18:02:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Set placeholder attribute for the search input field in
the variables table to "Search BitBake variables" as per
the design specification.

[YOCTO #5998]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e523c31..a9023a3 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1047,7 +1047,7 @@ def configvars(request, build_id):
 
     context = {
                 'objectname': 'configvars',
-                'object_search_display':'variables',
+                'object_search_display':'BitBake variables',
                 'filter_search_display':'variables',
                 'file_filter': file_filter,
                 'build': Build.objects.filter(pk=build_id)[0],
-- 
1.8.3.2


