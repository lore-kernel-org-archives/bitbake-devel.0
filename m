Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
	[209.85.210.171])
	by mail.openembedded.org (Postfix) with ESMTP id 76A2A7FDE7
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:10 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id z16so27196373pfk.0
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=IvhnibPf7wk7NMAZFV7DWk1mZ2+rPRNABc7gaTRrVq8=;
	b=Bn8QKpUX0G6zLdp/P7S/wOy4ts0riwytCQcXg4r8lQ4xTOZNPXhok8iixwdtWSEhpL
	j0NRO8gN5fNsjqXrWRVtl6uutMsEytBGaxPZCm8ODNjohyGD8hhpogbNJzF8bmlLfKb6
	tzhEOhycP9VZMFFXiOiBZcudMNU8e5kP8PKSe/IOlqFGqA8OZ1AOZ8GxPfSWNIydIowW
	6kSsGy0JJOB1lROyIUfeIfRwgzUP8pr2MLvslbFAwVU0VBQ/PjBF2Mmtgh+41X5dDPna
	iMgNwOGB5A8HRK9e/P87+hjNQ8L0/Q6z17EBqybG5E5OmOq8cbZKU3EG70eQ8Svv3rp7
	OhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=IvhnibPf7wk7NMAZFV7DWk1mZ2+rPRNABc7gaTRrVq8=;
	b=mhMRcKQy5WJJC1M6nbXJsmLKIOaxLZY6F2C2mR9DItaQ6vCJRuMRfl4oa1Cj9FY+QG
	ftFqM7ZqQBgi867KLK3EVJx7nyp0fn9R9iL6BfH1p83DqDQOnXRF9L9xVfrRQU2qPnn+
	LgxofSAG7r7gSsFmeb5eK2qpwtZ7mJi4kZTOzIYBz2kTFChrDuMrurA3By/i2oXcZ6/a
	xThX/Yf5OGM5ykvtTo9KeRW2A4DPNV3oEEzhlyirEdR+d4LNeCB2fZnULVp58XV3oEgQ
	omw5yJ4JDxCpkBgMIJ9JVqcNlJt7rINSkDZQmZW4EpucwNkRnVlqcK8D+JECjvc+uEUI
	v8eg==
X-Gm-Message-State: APjAAAUmy+sQ/0/Zo3GS1XQZnKISv59MqAqIPUqEjtnpcaVBYud58G5x
	bF7jwiI4fY6ARI0H9+T5N0RJ9yXD
X-Google-Smtp-Source: APXvYqzVAKASBbCDAMgroTDQ2oN2ry+i8mt0rLTgdnVru4rx6If6aKdty4gEJA32/nh1cCEL9XMWrA==
X-Received: by 2002:a63:31d1:: with SMTP id
	x200mr104848276pgx.405.1578328031158; 
	Mon, 06 Jan 2020 08:27:11 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.10
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:10 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:42 -0800
Message-Id: <10058fe590c56ee3b4d2136b6e247c2d29ae47e6.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 21/25] runqueue: Fix equiv hash handling build failures
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:10 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Regardless of whether we remapped the hash on the server or not, we need
to have bitbake work as if we did as we need to match how the stamp files
look.

This change resolves build failures where tasks were rerunning when they
shouldn't.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 40928f6991436cf687821015324483b205abfcb1)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 729439ef..f8279980 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2302,8 +2302,9 @@ class RunQueueExecute:
                     remapped = True
                 elif tid in self.scenequeue_covered or tid in self.sq_live:
                     # Already ran this setscene task or it running. Report the new taskhash
-                    remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
+                    bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
                     logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+                    remapped = True
 
                 if not remapped:
                     #logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
-- 
2.17.1


