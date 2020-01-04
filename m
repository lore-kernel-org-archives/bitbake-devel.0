Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 53C1E7F9A3
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:16 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id a33so24185302pgm.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=wDhez4FOQrjDQe/uissBn+DwjmpfDNLJAdRh1VG2LLw=;
	b=Ed/62z1nefxBIbkq36HL1eZ27c7qSf95ETNTAyrVKijaKhUvMhxBcpHwFZLZAZbubL
	8pctw2mQfnIy4e9IND6ZUsw44/SXITLTdKDtJA4YU9RtRy9xKPCG6yXOAfw4GlxmSqSY
	fmQOxtDSWVWIUiAhXzBRk8SJU4Dc9rmRA69IjK3Ic8G5dNb5Nwj9xNfSh2k/zR6Tcg77
	ozHiVVIzFn+6U8QFUfXclgMSjl+233DycpM7mH6821GzUt+3OIHDfW2XPwpjScG550CK
	DkPBx30z0+MWsg1KhCTk2fqMuyIwLbvR42Q4uIvZ7YbiIGlLwoTiA3UfB6VXujGCqob3
	O6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=wDhez4FOQrjDQe/uissBn+DwjmpfDNLJAdRh1VG2LLw=;
	b=LXCKsHCxO0A9JNBuqcRrW5k1AsFw1ty54414rt0g4AA5w9+KletkC1TlYpGwPpJAZI
	53MMs2BOD/DQifLghsyX9kcGORI2w9T+YTtKkmNvniLb+S0J+d6dPMM5vTe5YxHmz11N
	4+GhIo8CAOQ/KNvEMzefDzOnvXNoYnQ057EyFpcJvguXtq1qGCE4tlVdlAmJYSTtI0OI
	dGlm+zwdZmjxyAw5K9ktilaJkPm9afhW2j36UQ6ZkCG0z+wkdoobriQ9yE4dOCqy0/pb
	zgoYd4bqeopWvYPKOaFl5oMTNJNJeVUWlH0TQiKwoB4MVWkMtZSEeYQAQpU4NKfndJEJ
	SbJg==
X-Gm-Message-State: APjAAAXI8KIyZvig4tc+8cepWdfyaYntvmfRIQh5GIYYo8s3ew1H/v3Q
	HBjjK1ZTTaP9ASOhxsuWsYqLaPkBHvI=
X-Google-Smtp-Source: APXvYqwXeygwj3ruypLiINYGYkcE/lrGVxoTobVz0IdKC5pBm9TzvRjrGLpfAJi6+/CIXTKd83Db9w==
X-Received: by 2002:a65:6842:: with SMTP id q2mr102224792pgt.345.1578104597511;
	Fri, 03 Jan 2020 18:23:17 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:17 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:48 -0800
Message-Id: <6f0b82627edc82601f80f0f096bf96db43afefa8.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 03/25] runqueue: Add extra debugging when locked sigs mismatches occur
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:17 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3aad9978be2a40d4c535a5ae092f374ba2a5f627)
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a869ba52..246a9cdb 100644
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
2.17.1


