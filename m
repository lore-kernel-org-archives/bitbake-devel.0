Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 909C777139
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:21 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id 191so64805354wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=ugGyP38ztljJ1oL/a+eUhzVCKUnRTUNH1N2+l7cnzuE=;
	b=kNpuRzrOUz1QjW+QG7eERi0QYQ1UXr+sLyOrCINqIdex8juOkAspftDKeGhPTQWRaU
	Rzk+tTLnneFogHKK5tmVb5wwrTPuMwvg+157QuzGe8bIZ36OTZz4zd4/la16z8kjvBzn
	s/olyf4srURCpCp4AP4ywNTggie7wNp9jUJebwWya0m9Eq5BYBrmu0AkcfeqcYM4/QBk
	4TgkUe4BO66ksEcajC8A/EBRtNzy7nGxNMGllb/zil8eF91tViS/4vkK/LdaU9tCJuND
	dqasr76Mp11Yoi+hP8GHLgL/qmaO105fpHxwlV429sypk6V1lCpQdxWocJEUF8JnkZdx
	20YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ugGyP38ztljJ1oL/a+eUhzVCKUnRTUNH1N2+l7cnzuE=;
	b=ez5CxroBOVl89tV+M7edQmCeG8C8AAycaKIfO/eX4weOqah1JNoY0wMoedxYBtQ8Rj
	EFSPmbgcmyct32xpce98Vz2WSJNktncFv4SgLJUkNdzil8VflhxuLheyU0WgQal2bZFi
	cwbJ8qTrcr3PJ5bzhnJz0PWYEuFO8gWwnv6ZLaQg5R2F5eDUXP8ypEzcYGxAjmwfO/RJ
	Hw0yL/qi/LpXzuhzFhRVT4hr9HnTs2nDu0FNx3RTeY3hn5g2IN2jXQ4AYA4smm95LGhS
	DbAIa/NJqN1T7hdzkxvoMCqeWKOaknT54kRzW7c8lzzsFXETizBzpe7Uhhtg7T2/kGy9
	hozA==
X-Gm-Message-State: AD7BkJLlWlgVdVqemZmN6LB0wizJkwMwp9iNBm/RDG4ca6iqyPUIsTq9HniYAfSphoVoOml3
X-Received: by 10.194.134.227 with SMTP id pn3mr22762399wjb.129.1459961241667; 
	Wed, 06 Apr 2016 09:47:21 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.20
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:21 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:24 +0100
Message-Id: <0dee60c5757f4e5248c0e5d246952488b1872979.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 14/38] toaster: stop bitbake server after the build
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:22 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Bitbake server is used only during the build. There is no need
in keeping server running after the build.

Running bitbake -m in the subshell after the build should stop
the server.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index ed46636..6d7f433 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -317,11 +317,13 @@ class LocalhostBEController(BuildEnvironmentController):
                 task = ':%s' % task
             bbtargets += '%s%s ' % (target.target, task)
 
-        # run build with local bitbake
+        # run build with local bitbake. stop the server after the build.
         log = os.path.join(builddir, 'toaster_ui.log')
-        self._shellcmd('TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
-                       '../bitbake/bin/bitbake %s -u toasterui '
-                       '>>%s 2>&1 &' % (brbe, bbtargets, log), builddir)
+        self._shellcmd(['(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
+                        '../bitbake/bin/bitbake %s -u toasterui >>%s 2>&1;'
+                        'BITBAKE_UI="" BBSERVER=0.0.0.0:-1 %s -m)&' \
+                        % (brbe, bbtargets, log, bitbake)], builddir,
+                        nowait=True)
 
         logger.debug('localhostbecontroller: Build launched, exiting. '
                      'Follow build logs at %s' % log)
-- 
2.1.4


