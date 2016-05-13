Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 9F6576FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 16:03:09 +0000 (UTC)
Received: by mail-pf0-f172.google.com with SMTP id 206so44072385pfu.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=3DxeVic6qavCGMk3xtz27OK2I5RvMAhmFDLChO/Z4dQ=;
	b=EbQlB/EwuJq9Gb/TDWS+HX2ArJdVIjP/7JmNBOaz9euuaK9axy7SV3ZfxZi4HXV0dL
	5xBsznmVThdRvckK+ylNkukXDURsIZV3NPox/KjSrAtIC4O3a6W+8cQygRiyHqK7qdnC
	Dw9/DLKYxC9Rnj2TNaJbdqza+AgGOs3usZKzfwLQvSx13H2j1/x7/kAtqc7sDSq9XDDe
	5CCs+2cxeKS5xT6pKehBmU40KRu4FMxSa0dE0aIrXe1h8RL2CUL2Ci0BqTLzS+Plnnrq
	/QB53tbSpneHLP7zqog7Dk0F4TEO9jg2CvKKWxEKuI2zGkcSj/5siIADdzmwdmLMMYAd
	+e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3DxeVic6qavCGMk3xtz27OK2I5RvMAhmFDLChO/Z4dQ=;
	b=XK5dhX3x6uaGnd+OT3RqM1vGvFUxJoPGHUGAsJYX6ePL49Awblw8oGoBGixQuVAwGo
	MXOZmeY8No4Ap3KABYAUxFQlKXahw1PIwCTUXzf89A+LuFBVj1GrC6PhqDEm0sUcW0As
	FL1lJmw5Z5MLG+63SBG1FzQ4LME9Ime0pCY1df8LN7nln6f3UoFKssO6xxOZYf4qjcbm
	ZJAHDY6UwpcuZGqR27mFJ60Pp9LRYI7E61ZblonuOKX34MQvX/68uHzvDKNE0eDwFEuI
	bceEAIUpGu53/nrwXD58HIRntbApqcV7I60gqOsT2vrSyzfQR3LfdxiBqL3EU2/918LJ
	hIpg==
X-Gm-Message-State: AOPr4FUu3n0jAcWeU21dE1oOmIFlnsrk+bdcyiG6Wv6kPFqNhvDGJ42QE/bX8sTXTyhpCJds
X-Received: by 10.98.93.131 with SMTP id n3mr24325231pfj.141.1463155389942;
	Fri, 13 May 2016 09:03:09 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.43])
	by smtp.gmail.com with ESMTPSA id g5sm28528559pac.1.2016.05.13.09.03.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 May 2016 09:03:09 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 May 2016 17:02:58 +0100
Message-Id: <1463155378-31402-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] toaster: fix progress bar in MySQL environment
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
X-List-Received-Date: Fri, 13 May 2016 16:03:09 -0000

From: Elliot Smith <elliot.smith@intel.com>

When using MySQL, the project builds info delivered by MySQL
differs from that delivered by SQLite: the former returns text
values from the enumeration for Build outcomes, while the latter
returns the integer value. This causes the progress bar JS to
break, as it is expecting outcome strings.

Modify the recent_build() method to include an outcomeText property
for each Build object, then use this in the conditionals in the
progress bar JS.

[YOCTO #9498]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py                      | 1 +
 lib/toaster/toastergui/static/js/mrbsection.js | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 2669606..88967a2 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -416,6 +416,7 @@ class Build(models.Model):
         # to show build progress in mrb_section.html
         for build in recent_builds:
             build.percentDone = build.completeper()
+            build.outcomeText = build.get_outcome_text()
 
         return recent_builds
 
diff --git a/lib/toaster/toastergui/static/js/mrbsection.js b/lib/toaster/toastergui/static/js/mrbsection.js
index 09117e1..9a76ee6 100644
--- a/lib/toaster/toastergui/static/js/mrbsection.js
+++ b/lib/toaster/toastergui/static/js/mrbsection.js
@@ -57,12 +57,12 @@ function mrbSectionInit(ctx){
           for (var i in prjInfo.builds){
             var build = prjInfo.builds[i];
 
-            if (build.outcome === "In Progress" ||
+            if (build.outcomeText === "In Progress" ||
                $(".progress .bar").length > 0){
               /* Update the build progress */
               var percentDone;
 
-              if (build.outcome !== "In Progress"){
+              if (build.outcomeText !== "In Progress"){
                 /* We have to ignore the value when it's Succeeded because it
                 *   goes back to 0
                 */
-- 
2.7.4


