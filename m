Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 73C5165CBC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 17:08:16 +0000 (UTC)
Received: by wmdw130 with SMTP id w130so80115623wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding;
	bh=piRMSP9u2dF0Q4d16QDFDfOXOD6rZv3SAj7KnhkEIKE=;
	b=c8eByXo24Kw1q5MCDNUHOxKtKnSzeb30QkkXlQi28Rk+5zvXX1gFUXeWsS9WMfhWdQ
	6/rjTaPyJDXCS5M05YTx9QGM0dNqFEPnzZKEbxV2S8Hvu77G/IVMoA4JrQwSy6Z/LfIx
	KbDt2uvIP2jxygrl59LXs4huwaimjmW/5rNAzpJkprbzI8OSkj/p+VcSUY8XJqxKcstY
	cRlcG2x39B5przDLWN8E3MF29/hNSF9rZLc6yl2NoBpBvzsA+cmqSfdemifccGfeGwzk
	xgkH3SU5naEIthQ3CaVm1qYlHueJ9SQ0tzvEZJUU10RsCDHDrsb7O4hqYpOi81SQUCS6
	2+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-type:content-transfer-encoding;
	bh=piRMSP9u2dF0Q4d16QDFDfOXOD6rZv3SAj7KnhkEIKE=;
	b=gcMk7t8kG68MmKWweOGsgtER/eubpmdJrFMdPXX1DzovEXJuAwtPE5R1esHhepR1KG
	bbGZ2MWwiuf3uHwjwsbuI9bipbaR8a6QlUhu6qPt6RcM/qiknQVQ4Mqp5eqyw+kNBP+w
	sm/3RVG78M8xXait/J0osOC6cBhfBA8H4t9lSBjATLqj747WsCibJzdldhCx+P59DMxI
	yvQkfu7fJDCuBxF63EYiQtkPGR6qfoL383WmQ7lbd5h9NxjaYdOUjbzAd9V+gFTvNwQw
	kZ3Yk298sbMlWrImGbLngA9PsDX0v55NQH/8NvjdCyJi367KJUZ8mM0+WRciAOcLuhDH
	dCWQ==
X-Gm-Message-State: ALoCoQnc2ofzTQUl74Ir6E7ot2Z6qDMtKDspP1fh75+TzTPoqnMXMszcddH8W3eS9oN2/39D0qDV
X-Received: by 10.194.134.199 with SMTP id pm7mr5183883wjb.46.1447175296098;
	Tue, 10 Nov 2015 09:08:16 -0800 (PST)
Received: from dorado.Home ([90.199.203.61])
	by smtp.gmail.com with ESMTPSA id w4sm4465345wje.49.2015.11.10.09.08.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 10 Nov 2015 09:08:15 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Nov 2015 17:08:02 +0000
Message-Id: <1447175283-24245-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Subject: [PATCH 1/2] toaster: project pages Link to image recipes table in notifications
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
X-List-Received-Date: Tue, 10 Nov 2015 17:08:16 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Belen Barros Pena <belen.barros.pena@intel.com>

The project created notifications and the 'Choosea recipe to build' link in
the project page are linking to the software recipes table. Changes them to
link to the image recipes table instead, which is bound to be more useful.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/project.html       | 2 +-
 lib/toaster/toastergui/templates/projecttopbar.html | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 4e83981..cc4745b 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -68,7 +68,7 @@
 
       <div class="alert alert-info" style="display:none" id="no-most-built">
         <span class="lead">You haven't built any recipes yet</span>
-        <p style="margin-top: 10px;"><a href="{% url 'projectsoftwarerecipes' project.id %}">Choose a recipe to build</a></p>
+        <p style="margin-top: 10px;"><a href="{% url 'projectimagerecipes' project.id %}">Choose a recipe to build</a></p>
       </div>
 
       <ul class="unstyled configuration-list" id="freq-build-list">
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index ee86b54..7a6bfef 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -1,6 +1,6 @@
 <div class="alert alert-success lead" id="project-created-notification" style="margin-top:15px; display:none">
   <button type="button" class="close" data-dismiss="alert">×</button>
-  Your project <strong>{{project.name}}</strong> has been created. You can now <a href="{% url 'projectmachines' project.id %}">select your target machine</a> and <a href="{% url 'projectsoftwarerecipes' project.id %}">choose image recipes</a> to build.
+  Your project <strong>{{project.name}}</strong> has been created. You can now <a href="{% url 'projectmachines' project.id %}">select your target machine</a> and <a href="{% url 'projectimagerecipes' project.id %}">choose image recipes</a> to build.
 </div>
 
 <!-- project name -->
-- 
2.5.0


