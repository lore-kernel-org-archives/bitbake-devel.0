Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
	[209.85.210.180])
	by mail.openembedded.org (Postfix) with ESMTP id 9EB0E7F8A1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:57 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id n9so693203pff.13
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=45t5yQCLHUttItpGCMMjqg8BYxLbXjP1r1e4ki+MuvY=;
	b=X97rRK5P/GWnHySLLmBjizX7MNC0tKljTfVyuEGHS3xWWDNUKGi7gSArJJ8uJWDutq
	I3INbejxUM6I2JX2xG6/wbIW+e/ZdERNnTyo4tQorlYAAS5+oUdjjjUpCkVV1gDFbcow
	/YTZkrbLld1OtNaGn/WE7oTjjEXTrQq675Y+Sd1mrCd4yIdmNQFo17uC5KNy8l1waxkf
	AXD+aSDCJuyBFSJ/OFxUVkCmmjQCjyRLOPRr1XMJJwiy8ARp2Pg+/4gEfB6a3aj70B8c
	3uaKAPM+EHP3n1hcY/MSQRzAM19m2WdZGKzYZIMtHoWP7HLaAq3XkgxXVk7yQMx/Dj/L
	M4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=45t5yQCLHUttItpGCMMjqg8BYxLbXjP1r1e4ki+MuvY=;
	b=LVneyfv0sUnjvalcMfip1licnjR30EiWRBnROdqGGOjir3d1Fjc0YFOrVwtm9475S/
	Gc5DQRdWO8zLBjhdIxihHwNo2YxSct3bhxUFFUWOOwr3wKA+qgw6FG7GRR/i+bJo4Xgj
	kWxXRWFFTEHNSRXJdvjqc3BSDHQ89n5ywYQe/oE86WQVw63HkukzGpbk1sQyb7pNBUW/
	yazW0IwBQFEs1HZkJNmyaf3zUtiKFl55h2FZjZkBFAZ/vbEL9T0XTcxcqj4gQb5Q4WVQ
	oaXOqedAlfys/lso3PN5WbSfruh9VZGwhab8ZsJJa96NTuRgQk/8QqlQu5kFHhSZ0cdp
	FKGg==
X-Gm-Message-State: APjAAAV1b658cCaf5DJvf6qHVVESyw+oKo8cYaYSj2Js5rnbmr+wPHul
	NmkuE8cfDdkNvqUgdxbsbxv3H9astL0=
X-Google-Smtp-Source: APXvYqzhzfmmYkk2WHWH7gTf4tWeoF3mZxbXX0r2sZx/dZk49XoyThvGm1RwASH6kOZP5RGyf08Hcg==
X-Received: by 2002:a62:6381:: with SMTP id x123mr30142687pfb.75.1577076658723;
	Sun, 22 Dec 2019 20:50:58 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:58 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:39 -0800
Message-Id: <14babbf0a32637db640e0494b0331397dcb0f715.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 15/18] runqueue: Optimise out pointless loop iteration
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:57 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 105d1f0748edde7753a4063e6fdc758ffc8a8a9e)
---
 lib/bb/runqueue.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6da612b..73775d9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1182,11 +1182,8 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        procdep = []
-        for dep in self.runtaskentries[tid].depends:
-            procdep.append(dep)
-        bb.parse.siggen.prep_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
+        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
     def dump_data(self):
@@ -2294,11 +2291,8 @@ class RunQueueExecute:
             for tid in current:
                 if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
-                procdep = []
-                for dep in self.rqdata.runtaskentries[tid].depends:
-                    procdep.append(dep)
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
+                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches[mc_from_tid(tid)])
                 origuni = self.rqdata.runtaskentries[tid].unihash
                 newuni = bb.parse.siggen.get_unihash(tid)
                 # FIXME, need to check it can come from sstate at all for determinism?
-- 
2.7.4


