Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
	[209.85.216.42])
	by mail.openembedded.org (Postfix) with ESMTP id 51F747FCF1
	for <bitbake-devel@openembedded.org>;
	Wed, 22 Jan 2020 05:25:09 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id bg7so2857863pjb.5
	for <bitbake-devel@openembedded.org>;
	Tue, 21 Jan 2020 21:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=7y2zBWwKC6qnS72kXGbDa3QCDiRfdiQ33YGrxTjhjTM=;
	b=DNWX/D7q6b5yXFq5yX3JE1SeG0IYXQGGOBIudz8DK2GBXhkLkUBhZfxauFG+BztPk8
	wJ6cgtVwdM1rwtbJy4iwk7ktohb9EZuexHLUSkftqFU1HM6MjvNAaEmW3tIZeopPRF+y
	n0sDI2+E8Pxk1vqwrusy0Xx5J6HqrHfdyaPMa312bdWIdouPM4qpFw4JhLrZhWZFIj5p
	o5ZJnhLWceltsIG1BJVrXalfoJIpE92taD8WxnMYK92XW3l0UAbNtXHzUXG7LGV3n2ma
	BSKtTv4jv+TUK+kbCPQXTKQRyCQF/nDCAPvusfUMj57aA3pNYLsgi6lgEY7DrOh01LiU
	2i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=7y2zBWwKC6qnS72kXGbDa3QCDiRfdiQ33YGrxTjhjTM=;
	b=KrtDKi0mN6k7xgBWqdyupa/Bms9tR+jMl+NKJNds9UkF8XZa2Z1W7aZ+ULE15ja151
	YR3I0XC43lubQB73GCh5Sv6RjFaCbCY+9mwr/M0OQnCz0zcg6j0v+AnWceA1+83a+sig
	tKOrVsvbyi5z+yfDP7REuBa2pGFY+i+0EXCS+HVCqHMMmX5BnbYCSUZXBfJIdRLBeM4n
	gcPjVcrycMzHhzHBpbHqh7YV4ZebRFXOlnc9GPJcdAUU7+D5Hi2RJZugMY1gAazbjE22
	1WCDDe4nSFo3pVoFEmXMyQMidYeV0gPWD+KaucaIn3C3WmkVnwTsgfGXgXGPacZC1EvT
	8hZA==
X-Gm-Message-State: APjAAAW56V0+iWSOHFlMEYmtIqjAGK6SVrGMFdfSCSs9FaPGPHAo0nhP
	Q6RYhxe9EsARfCT3Mha2hJtpcijF
X-Google-Smtp-Source: APXvYqy8PDmMipCaYrgTGp0dkSRVOW1wH+D7Mu9Uc+umx2krdRS+MiKty5dvJpHxgoMWNRaKm4TEdQ==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3mr2954124plz.0.1579670710269;
	Tue, 21 Jan 2020 21:25:10 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:682c:76b9:6d8a:bbd2])
	by smtp.gmail.com with ESMTPSA id o7sm1228628pjs.28.2020.01.21.21.25.09
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 21 Jan 2020 21:25:09 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Tue, 21 Jan 2020 21:25:02 -0800
Message-Id: <1a026d4aca47ed1b0b74a8a818635e7520e8f9c8.1579670574.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579670574.git.akuster808@gmail.com>
References: <cover.1579670574.git.akuster808@gmail.com>
Subject: [1.44 4/4] runqueue: Use a set for the setscene tasks list
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
X-List-Received-Date: Wed, 22 Jan 2020 05:25:09 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This should give performance improvements to functions using this list of
tasks (sets are used for most of the other code for this reason, not sure
why this wasn't a set in the first place).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f5daef68703481a3c243dfecc7de404e6ebfdbb6)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6e3a91b8..d7186e85 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1124,14 +1124,14 @@ class RunQueueData:
         self.init_progress_reporter.next_stage()
 
         # Iterate over the task list looking for tasks with a 'setscene' function
-        self.runq_setscene_tids = []
+        self.runq_setscene_tids = set()
         if not self.cooker.configuration.nosetscene:
             for tid in self.runtaskentries:
                 (mc, fn, taskname, _) = split_tid_mcfn(tid)
                 setscenetid = tid + "_setscene"
                 if setscenetid not in taskData[mc].taskentries:
                     continue
-                self.runq_setscene_tids.append(tid)
+                self.runq_setscene_tids.add(tid)
 
         self.init_progress_reporter.next_stage()
 
-- 
2.17.1


