Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id 388647F847
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:48 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id g6so6709975plt.2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=j4KGs5DCOEg8GzBlizCGe0Fuv2WG0/v6hJSevcpcgWQ=;
	b=JVJbSQH4H/jbBJhM0AGHbcgVbC9U15yeR/Zh1FAVeuZHYAAS6VzUUmMOqmwzgMeQDU
	MKQl4ocPB33cb3BcrMS9rjLK2zyCkpxd1+Uh38wdOegmk91KJmm79L+1m4Vq+U698sne
	/Hz25Qb9AOhfcVl1kxXZNKMFBvvzAbooLV5QW3yAs5qWC/tEXmjIZavdBk3YcY/ucqAv
	uZ2yEMoor/3QyePAgR/2Bp4ktcJ2ZLIzhukTaclRh87im/ay8W66XFKYnniuwq1VJqiV
	bnK4+NSjk2Rtuahkk3DEFHzP9jDq05psrvZinxr1u+vN93zvLpccxhQ2pYYPjW5QGyn5
	aHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=j4KGs5DCOEg8GzBlizCGe0Fuv2WG0/v6hJSevcpcgWQ=;
	b=hbAO2zFrt+oETwRqwKewuX6gvAhmRiyCnMB+kop3C1KEWhLPbTidzyFEUxenKWx1Tp
	zdWuYTHL1B/zeB8WWUvnH1R9oSMfdBAW8GVTKNmZnlbwgYc7Rx7PMDLDqcJ3YCmhZWCZ
	8wT8RMGWskEqzQWUquuuv38DuftFVAOUJvqnS98qAwlBQjvdeO9eHNB0nwCNhjaMkHO3
	loExV8nAnNGLJQ+JWLJj+oA2WkJJ8yAQAkfv1qE6Uydd53FOLOWK3P2rlJFHtC65D4sz
	ZKKYB36i9pinDYrPRtbSqvtc78gdLmBOw0lUMliZqZd/uIEdlkM5+jURKEa/HB+fTV3K
	tncg==
X-Gm-Message-State: APjAAAWM5hEbv6ThFS4q54DhW5ZcjdYAz4tlT9cFVNbNy+9pHLvaJwpm
	aNuKBKyaY+PwXHovdSXSMgOi+FGraiw=
X-Google-Smtp-Source: APXvYqzFU7cNTCaAiUBEZQZ3uKmNQWG/4VamjwNXWLWK+5hBbAZMFI0oJXaCz1jx6fWkXHZAPOFCCw==
X-Received: by 2002:a17:902:6a8a:: with SMTP id
	n10mr29148270plk.9.1577076649261; 
	Sun, 22 Dec 2019 20:50:49 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.48
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:48 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:27 -0800
Message-Id: <6f0b82627edc82601f80f0f096bf96db43afefa8.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 03/18] runqueue: Add extra debugging when locked sigs mismatches occur
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:48 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3aad9978be2a40d4c535a5ae092f374ba2a5f627)
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a869ba5..246a9cd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2524,6 +2524,8 @@ class RunQueueExecute:
                 msg = 'Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname)
             else:
                 msg = 'Task %s.%s attempted to execute unexpectedly' % (pn, taskname)
+            for t in self.scenequeue_notcovered:
+                msg = msg + "\nTask %s, unihash %s, taskhash %s" % (t, self.rqdata.runtaskentries[t].unihash, self.rqdata.runtaskentries[t].hash)
             logger.error(msg + '\nThis is usually due to missing setscene tasks. Those missing in this build were: %s' % pprint.pformat(self.scenequeue_notcovered))
             return True
         return False
-- 
2.7.4


