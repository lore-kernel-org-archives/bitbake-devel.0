Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id CD4C77FD44
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:51 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id p9so22037969plk.9
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=wDhez4FOQrjDQe/uissBn+DwjmpfDNLJAdRh1VG2LLw=;
	b=c9oDMJ0zoqNpOGkqGLhaEtllcVny/c7HmfXt8l52KavuWwrRrTAwed+A6+b2OJssHf
	XEWcjfi+xPq4C0rPgvOvUGvJWgsSSuNoX8xyGeCbizH6BP7h6Xg8rw9DjFC43HTTBGVP
	SCgXMcsVcpxxsDpXDV3seqCmtoWJyT+L6Y4AlPQ2MquDGpNNIUSzYzBcREG05GLVzqlt
	WBkNb82ZZzFlg3aGw5lhD2+3cGX52AYc1DS1l0BTc6V4kwYBGWhT1971yhK8C4m+QE71
	4xsLnBjiwZ/3AETxmrW8V30kN+/pSMGLeHDrV//VQVXwumVZTzoOVk/D2NejdFNx4C5R
	iEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=wDhez4FOQrjDQe/uissBn+DwjmpfDNLJAdRh1VG2LLw=;
	b=ccnMDWogm8EqT6mhpx5W/rZg5s37YB4+l740qaiOh8PCviwDS6g0NDRsGhbjLHGDzc
	Z0a+t+tHDUO20EL71cA/S55t6+yAgiOEMWV+Qk67qv0j+dwfxJdtvUQqsYBw2/oK4Hfk
	uSmbd6OMZK/5v5VmBi0zoOJ8RY933ZuPF3er+V4m7t+tsZzRgAhvOVOBA+qPsIb4ohf/
	ri1rceeG1OoL25UcwnL94/Exqc3uPtoz5qwnIchR2PCgonjql2lq6flN/pLutPxiWSMR
	86yyQYBqPl77AqVMzQa8EA1qMiNOEe5Z7U49zr1WH5o+p/ebdQbH+n5jlkC16naWRCPj
	hC3Q==
X-Gm-Message-State: APjAAAW47VhVI+qTd6g6gym8j1SP0O78DGEtvVr/Iq/IpVn8FvK7y4ni
	fUhdR5EsRUqZg3H0od9StYrh2Mno
X-Google-Smtp-Source: APXvYqxr39yTnjD3QDUImiduAWv0gkA/Cc6tPrRariI2YIwDs3WgDaaMxojpVzHmr6nhEaf3pgxtxQ==
X-Received: by 2002:a17:902:b206:: with SMTP id
	t6mr53862163plr.211.1578328012692; 
	Mon, 06 Jan 2020 08:26:52 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.51
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:52 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:24 -0800
Message-Id: <6f0b82627edc82601f80f0f096bf96db43afefa8.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 03/25] runqueue: Add extra debugging when locked sigs mismatches occur
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:51 -0000

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


