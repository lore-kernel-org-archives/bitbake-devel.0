Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by mail.openembedded.org (Postfix) with ESMTP id A536A7F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:28 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id q8so24287397pfh.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=uqsU4iahV6ya7AsZvE73RbOcH+y0VC0dy9bHnjPg1qg=;
	b=RNDFwDnAVolMBkWUw25xdgzBxgANG11+TfrgPYRADZZlpOMi3/J6J+UsQqeVKYllVo
	7cPmD73OszO2upuxyCQ2SNJpibK6/NXuv0UuWoUmKwYlE9HeQMiyY1D9ua2Fau1gzfrX
	dK7v3f8ihEUL4BNoLH21vLAP7fvs1fgNfe9IjMADLI9vpHhRIBEYI1BzXLhDAhM13tBB
	pMeeJn4cU5U4olzmGpFL2Rp50ORGkIrkwWq6tELWnrOUVadkswq8t3WklOlAeB/XJjfJ
	vHNEiu2jYqSoA2Q0LXVpvVEalLTtjU9jxXrX6nGxxTLZcrhkw5zwGroub9dUa5yWcV5g
	Vxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=uqsU4iahV6ya7AsZvE73RbOcH+y0VC0dy9bHnjPg1qg=;
	b=IYA0K9QSZ6FVsKqgMUydIOSsJ/vLzxN29pABMknKjyvoFigXPSs5ypuMgmpHuG4Wbz
	MVIYIIULDWcIkXEds9am1Z5UCVq0k9lFguJPjRIdhss5HqEn6Ojxt+ZS9XMwIuNtlVZ7
	KCjVIO32+br2991brJIwLU/Y/5YFjC5Abg1M80MJPpsOHxSw/CesdYquCscfW2lOUBzE
	98Ino6DiUqfKPDvpUPbWvKZlZssluIaZC9KOyFbtY5cRxLjmSlP1heO+NEi9PyVmSUG0
	ik2LCc2G/zavQML60j/Zi0h3gD8u3OxPylysVRFjN1bsFRw0N/gygH4peJhZfyzS2yCS
	7AGA==
X-Gm-Message-State: APjAAAWpYlX9TuZmGW9rCuqV05owV9l3adbzrQ9J4jkSi2j5zNHo8czR
	nOArZEIGo31ybuWLq+KjEeSNs0qckHU=
X-Google-Smtp-Source: APXvYqxCc/jdwX0a4WB4QN1bzdRNwwEl7/jFVZPg1bxHkjkkKCtEtSVApv+Dy9H6hqlWg4PdHfd0eg==
X-Received: by 2002:a63:70e:: with SMTP id 14mr97402741pgh.266.1578104609649; 
	Fri, 03 Jan 2020 18:23:29 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:29 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:02 -0800
Message-Id: <53a3cba93401c902d1d214cafe0bc036e1b101e5.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 17/25] runqueue: Only call into the migrations function if migrations active
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:29 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This doesn't save much time but does make the profile counts for the
function more accurate which is in itself useful.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d446fa89d206fbc6d098215163c968ea5a8cf4a9)
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b90ac875..729439ef 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1959,7 +1959,8 @@ class RunQueueExecute:
         """
 
         self.rq.read_workers()
-        self.process_possible_migrations()
+        if self.updated_taskhash_queue or self.pending_migrations:
+            self.process_possible_migrations()
 
         if not hasattr(self, "sorted_setscene_tids"):
             # Don't want to sort this set every execution
-- 
2.17.1


