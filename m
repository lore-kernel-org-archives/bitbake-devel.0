Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id B212D606A8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 23:02:00 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id e201so155916446wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2lHGBzyQ/HjxENtwgiKlhnCuuueGoTHMHfRSOhQGnhA=;
	b=UODYZxTZbvEeLHdHV7eHUE9xM9vJ5PtrC756nVVaOL3sVvyViwCeHmrS/9ptlU+620
	IOQgqcY/0/zxKk3r3FRVySD+eWw1Lz+igE3/ngHJXGcaET77fkRAUF6x/D9KxvjWB7KQ
	IIWMP700xhe1/aljNPv6n14SVpsSp8PP0YmzgrcNOH8KZiD89n/5UWNUV9G5SaoKKCwq
	uxD2EN/BQCP1tSUKHUkpmbWojce63QFY4pButtssRFEgCPSdJlalCjN1kYIQzLSc0GgJ
	PBU56Lhwsy7M8b0zdHpWFfWbipxlnj+NhGLIfavOxn0a2JSnCrJk55d2MGR/HBtc7g9B
	ZHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2lHGBzyQ/HjxENtwgiKlhnCuuueGoTHMHfRSOhQGnhA=;
	b=bhf53UqovofelgIDNCcXy7MELmDYKC0t503ivQtw8H1OA4LRVyIknhm9tqG4KlYcG+
	d8uRAFbUCh/yGKKQ1fp+cYVWtlgaI12SjMl/urFe4oRrWOkiXkMub91+20tm+f/Hh5ee
	ITqjNfGfB8rhqRF9C9enjjtAu29hItcoLz7Tj+VkQSOod3ouETNzwvSpAjZ+nOEiO5X+
	vd2zBV9HMYHBA8C8AP++5dByf2FBYSgWGzoGnHVfGMSWBC4zBmc5PuaA/pYfA86tK0oL
	4SaZpODP5stJ5MUU85RtHS4gFHLgX4ys4Y9buW8NtqT1x4BD4LKjKU4v429naB/UD074
	xX/w==
X-Gm-Message-State: AOPr4FXAqERXBWVUVxePs4fp8OX8DZnWlmcQVi8XGBcvbgZJht2B3aENZq/ngtWr3Jr82FGT
X-Received: by 10.28.1.143 with SMTP id 137mr12716417wmb.17.1462834921014;
	Mon, 09 May 2016 16:02:01 -0700 (PDT)
Received: from orion.home (host109-151-244-175.range109-151.btcentralplus.com.
	[109.151.244.175]) by smtp.gmail.com with ESMTPSA id
	b22sm27111436wmb.9.2016.05.09.16.02.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 09 May 2016 16:02:00 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 00:01:49 +0100
Message-Id: <1462834912-23449-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
References: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/5] toaster: ui handles duplicate project name in new project page
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
X-List-Received-Date: Mon, 09 May 2016 23:02:00 -0000

From: Sujith H <sujith.h@gmail.com>

When already existing project name is typed by user,
the ui pops up message regarding the existance of the
project name.

[YOCTO #7005]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/newproject.html | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index e83b2be..8913057 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -19,9 +19,12 @@
         <div class="span6">
         <form method="POST">{% csrf_token %}
 
-            <fieldset>
+            <fieldset id="validate-project-name">
               <label>Project name <span class="muted">(required)</span></label>
-              <input type="text" class="input-xlarge" required id="new-project-name" name="projectname">
+              <div>
+                <input type="text" class="input-xlarge" required id="new-project-name" name="projectname">
+                <p class="help-block error" style="display: none;" id="hint-error-project-name">A project with this name exists. Project names must be unique.</p>
+              </div>
             </fieldset>
 <!--
             <fieldset>
@@ -113,6 +116,11 @@
                 $('#description-' + new_release).fadeIn();
             });
 
+            libtoaster.makeProjectNameValidation($("#new-project-name"),
+                 $("#hint-error-project-name"), $("#validate-project-name"),
+                 $(".btn-primary"));
+
+
 /*			// Hide the project release when you select an analysis project
 			function projectType() {
 				if ($("input[type='radio']:checked").val() == 'build') {
-- 
2.7.4


