Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 325B37F898
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:27 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id b137so24180173pga.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=paei4CsarOQgVjzqiWvlqV27K2XKAO4q3wav2K/ryz8=;
	b=lSaWl7OJdy35Yk5oGvCeRYj7jdMgBDCFEh9VMi4ZQ1jv21n3auZY/1GEeQF/RZqgtT
	hsGJZzjZ9x+7Fr5u2gRI+Kbi9Ps3HxQ1HKc4fGSf/k37OzXAZLjvTavWAEYSGWW4cl4B
	3gSJtiYXW76L6mP2N7hWn5EF/54+gRtoxU1YtTXEC7hXKx9uaYPdPHnxVYvwEq2SUaLX
	SvCJiY3+DdC5Bp6XwOKH5wwJH5WgBMUjuPbqBoKpOIr/8GGrhahlXbzIWVtuWiTFUG8H
	BpiZBnW0bYk4EuyN6JMNIe2rcdy9o6oqUf3Ut1IgMOcaT2B4DZyKymMFTKmYZYBMZ86A
	wDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=paei4CsarOQgVjzqiWvlqV27K2XKAO4q3wav2K/ryz8=;
	b=FgzsbCAYjy8k9UTBhky4K8dkjFcg6/1XgZBPoy27S4P3HjALErM0wDz7i8eSEfy1xO
	pi9sD5wSCJwvMbam6fqxWO2uPtVLb1xY2gu7pkmyWzwEdsfCTn5XPu35q8cihzFCU9y5
	819f8q7YRmBoyJZ7Xxc3oGBZ0t6HZ+SU49hxprCBxmXw3KL4enwwUk/8xT3n6JIsfsO7
	sWUCznyPd12u9Vw/w1neK2E2uwUGU6mvpsik8d3xrF8ghS9wu30YzEv0mNp4myH+dlt4
	1VEdtjQOaFgEQEYaBLoFgooSgSst/hU+KMijqvP5YWDfldLst76AiV7e/MGG0/LBKdnr
	kg8g==
X-Gm-Message-State: APjAAAVZmCwAZ/SPu/jj8CT7JRlLl+3mZ0NTsQsjOBy9dVVBP6tUXx0m
	wXRmGASnOezOkMjANmHEb4yFif0thm0=
X-Google-Smtp-Source: APXvYqwyVcBA4rPkLx5UvCB5UloVQ3NmpcxVjfXHP+dLAh69zgqn0chTUtjY4U0+nsnqnBExmLkXUQ==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr97915716pgp.6.1578104608082; 
	Fri, 03 Jan 2020 18:23:28 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.27
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:27 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:00 -0800
Message-Id: <14babbf0a32637db640e0494b0331397dcb0f715.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 15/25] runqueue: Optimise out pointless loop iteration
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:27 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 105d1f0748edde7753a4063e6fdc758ffc8a8a9e)
---
 lib/bb/runqueue.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6da612b7..73775d97 100644
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
2.17.1


