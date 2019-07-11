Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id C2A197EF50
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:12:24 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id n9so6980047wru.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SiIM9iVV1c6Yh1A+2P/BAkC5ME/5JZ8jB/mAu8QbmMQ=;
	b=hueOd31glUApO77XjvC+1a/ZVqE8Kr+bIL3cRD3HD4a8vwjRnBUgx63eOSNCDn0VvR
	gi5w4r9/o5NpJOlewNxDmatS7tq/5lz9hTukNg7zu4RsqOrM4ottN0zB+vtB/qtwZey6
	BvbPkqycMJ13SQpXgiFlKEp7XadHyYfRJVAUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SiIM9iVV1c6Yh1A+2P/BAkC5ME/5JZ8jB/mAu8QbmMQ=;
	b=Qlw4tGcARSCGZiVni3iCJWPuesxEtMY0n40JsxtffY6bBFaoD/0se7PI2SPU8GHean
	c8NFiKCTWivFjTXIG9pGlt4+l3aCeoBCoZITS3tzURWH+Tovs6CD1eL9gexBGhAGOZHo
	OcldSb5z7z+6Er41sUFW+kK5iDSs97SzD5QptYMwyvbiwOlTW91oraBtz3vN/3FFJ51B
	nr2Kl5IIDJcCt+wb7q+oei7miTFuf5ogkqbHCZKy22hjFitRUEf7ZV5VCgu1cn1WGDFW
	jLBT9C58XOwVl6matAB9EU3hkOa/QTTeoDmheNvIvcS9A1A3Ehdf2ra9+rfZ5cDi/6ot
	qi6Q==
X-Gm-Message-State: APjAAAUOuPh3XFpQEqigPD5SQ1NXIvsojq9t6WOkFcSBVSrsdm8kp+VG
	H1Pn6V8DObkaj89RlC/t9mO4pwe5CRg=
X-Google-Smtp-Source: APXvYqxrzvauAcm0RrmJSoAEAIu5MCyFEm644qPynz5b8h1zZF2XvhE707jQ5j+w/FTIAnsxBnPSew==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr6233102wrn.215.1562861545137; 
	Thu, 11 Jul 2019 09:12:25 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c7sm4841279wro.70.2019.07.11.09.12.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:12:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 17:12:19 +0100
Message-Id: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/5] runqueue: Simplify some convoluted logic
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
X-List-Received-Date: Thu, 11 Jul 2019 16:12:25 -0000
Content-Transfer-Encoding: 8bit

This was left from when task IDs complicated the code, simplify.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index db0d852c54..48b668abc1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1908,12 +1908,7 @@ class RunQueueExecute:
                     if nexttask in self.sqdata.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
-                        fn = fn_from_tid(nexttask)
-                        foundtarget = False
-
-                        if nexttask in self.rqdata.target_tids:
-                            foundtarget = True
-                        if not foundtarget:
+                        if nexttask not in self.rqdata.target_tids:
                             logger.debug(2, "Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
-- 
2.20.1


