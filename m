Return-Path: <michael.g.wood@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id C31A7734B8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jul 2015 10:58:00 +0000 (UTC)
Received: by wgav7 with SMTP id v7so87496849wga.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jul 2015 03:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Z2g6vBSwkg9q+TgFyHPRHakkpVQmZtaOzvclniwqQzM=;
	b=KkKaqORlezWh3fdrUU9OAl8bEnPAB/tOKJOjr4riTFODAFvpBQZSRsnRw3pZdgVU3e
	cjiSlLFuuwXWoV82AsJ3wNNkZ7wh4MZpF/ffS3rvX5SauhXhnh1ccV3lGOT1uxE4643Y
	SO4ajoo2FMrxqlLHUdaLddBUFcGK6tHEMr/LiUweONkSsWy0UF76es43ySk/x4sAim3L
	ziJKm7BcCdZhraw6iRHa7dD1CVDQV84UE3XjXUsyjFv0LV3evE34T98D2FlZa4o96YHM
	5vFm+KM2usTE0LObG36eU5hCPP8TCzrBztsg+nzgMlPNEz7XHcb5G78MngaZZXT6irG1
	NAgA==
X-Gm-Message-State: ALoCoQmawsz4qXbv87FNn4aC42DU0mraJQOEF/zJbWZ+qOIxjqXJ2vlnMQHaf4a2yLyrALhJCim/
X-Received: by 10.180.78.73 with SMTP id z9mr30252922wiw.64.1437476280266;
	Tue, 21 Jul 2015 03:58:00 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	r6sm16228577wiy.13.2015.07.21.03.57.59
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Jul 2015 03:57:59 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jul 2015 11:57:36 +0100
Message-Id: <1437476256-5615-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: toastergui: make our tables Chrome-happy
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
X-List-Received-Date: Tue, 21 Jul 2015 10:58:03 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make sure that Toaster tables adapt nicely to the
viewport width in Chrome without squashing the
buttons in the right column (when they are there).

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 115abc4..9acf1e1 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -145,7 +145,7 @@ select { width: auto; }
 .hero-unit img { background-color: #eee; margin-top: 15px; }
 
 /* make tables Chrome-happy (me, not so much) */
-#otable { table-layout: fixed; word-wrap: break-word; }
+table { table-layout: fixed; word-wrap: break-word; }
 
 /* styles for the new build button */
 .new-build .btn-primary { padding: 4px 30px; }
-- 
2.1.4


