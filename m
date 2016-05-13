Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 21FB6731B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 16:12:13 +0000 (UTC)
Received: by mail-pa0-f54.google.com with SMTP id iv1so42122665pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 May 2016 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=3GsMLYzq0UraIZ6p2MNtawg8Seoth+dOuZo19mr3zJ0=;
	b=ASJjQJB1OLI2/j3oi7/zskM+KkQabH628yWW5gpZaBvjscnMmy82epFu/eB5+o5ZvR
	3DaIjjTVidvj02mC8mE0bGXAVCiKwG0ng8JoSRFV7GCq9QXBGxgh3KxEsFd0M10B8gMK
	b4zO0WIs8ttMiQCedBLGCCt7h9DoAVwmo65ZCq6Bj4Tm32ARinNWfiQF234xT08pbrsK
	ydf0mQ9rx167pyyHQO2mTyLMQBw8t+CbJ0cPYlghBIGK6LR8+8L0V8u68nKeGNcx4yk2
	XdjJPtE2oqJD2rrw8j1eBo76GYMY9BQT2pcQsWJlfP4dWolsuD74nJVVg5ovsv90ealY
	dKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3GsMLYzq0UraIZ6p2MNtawg8Seoth+dOuZo19mr3zJ0=;
	b=aMFXMY5MJvKabjFxdD/Zu5qHVv951LLZ+1cuxk//cwNqx3zlcaAaRX1ZxP4iC3rDVx
	wyl/+VlITxxzyNyFIHgy6tcFPIpCWHZrWsshmVuW1bxEX1czUKXmJc0rlxfNEYw3yJnC
	jN6Y9eRy9lF6oIOlmxdUZ5hJztE/nrJEX+h0ExjoBBbW7j11Gp0PbrVPbRaaPiDSaXzo
	0HzlAyoz6D2JPMb056GnlV6DVTmS08O/BbPGXB66Iaj8OB7e0s8BlZtWEaHI99KT8yWS
	kwKkYgKlX1ym2P6mro6BEGFjR3ryELOAJxPt2dslpQsznCe4rEU1ZavOO17/93N0t9oO
	Utzw==
X-Gm-Message-State: AOPr4FXJbRcahFdXHgKy30W6NibrH94V8mXWM1IBAEAG66VLcjdgOg7V30BqiIVasXOHwucM
X-Received: by 10.66.66.234 with SMTP id i10mr24594523pat.114.1463155934573;
	Fri, 13 May 2016 09:12:14 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.43])
	by smtp.gmail.com with ESMTPSA id
	u63sm28530175pfu.18.2016.05.13.09.12.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 May 2016 09:12:14 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 May 2016 17:12:09 +0100
Message-Id: <1463155929-31660-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH][1.30] toaster: fix progress bar in MySQL environment
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
X-List-Received-Date: Fri, 13 May 2016 16:12:14 -0000

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
index 0b83b99..dbdd060 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -415,6 +415,7 @@ class Build(models.Model):
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


