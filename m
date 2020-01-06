Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
	[209.85.210.172])
	by mail.openembedded.org (Postfix) with ESMTP id 1EC347FD94
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:00 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id q10so27176259pfs.6
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Vyo4msbjtScoNFMhi70j40sFrkLNLYqVfPl4iRz/apw=;
	b=ux4h2OXgm+W/YIzn07xfac6IilOmXAcyidi52fGZPh33v4CWKDqiVEmASTfaDhDzt3
	ezNTvyar8K0vNLadb2lV/9A2EFj8cPDWxUp36anckrMTMU8fJH7Yj1ou+UobPMmtZqVK
	zh6QNcbb2GYCNYbh2BFrSeNjSykGmqN3cUN8q/IhTSheX327+IC4eaQO6UD2f0YhXWTh
	1dP0vNtZjTW0UrV4ypZF7G5VLkgcJpBeJoLK6Le+bEYddRWgHkNJnWdLE7t8WS6ZY2sD
	6VqwxOPQAH6cTzdhCbNdcaAmRDj1FZ4rgIgnvkc4h1Upf5lf97R75xzTDYMmMZwP/SmG
	Ei/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Vyo4msbjtScoNFMhi70j40sFrkLNLYqVfPl4iRz/apw=;
	b=Gw087oe5FRbNBFii+L4vYf1XCWIrhNkP1GQ2eisVv5sn8/WpPIOamJwyxTxtKvsrbP
	b/X9PwfPvvGcG6AmPFQs/4/2kURsbTz56OJ56A1sRchYsqBHE6xBs3ZC2YSY0pKCcFrE
	Dk8/OlJCRdDJVto2ONbV3CU9Le8xEsNMlDXaEJXKg8kSFpRRLwLZRMzRwi2IM8V43QUD
	wNvvusOK+gElh1NYvOHQgRW7r4VxKZ4/MRnhR62no9VNwkIeZUprX2rJLYNxmNxNJ2hK
	qnjT/ph033BhK2GtcdgJEdK58WuQHS3AFkJ/ilIKuojJD29KnQGpsQXTYLQyZ9j+aiHz
	JUPQ==
X-Gm-Message-State: APjAAAVGZKPGpizJk/EcSldYhglfmQWzAhXnWNpCYQtd8T6916cGZgQZ
	9yOZpqCTgolmGOa7etJpTkFFLpaV
X-Google-Smtp-Source: APXvYqxY44eqW9Vig/6LJvFkqawzhC1Fpka9rFt4jtISWRxjDwiu7umjgz8YvnfqcJgxIb7dZ7Q6cA==
X-Received: by 2002:a62:aa03:: with SMTP id e3mr102006311pff.61.1578328021064; 
	Mon, 06 Jan 2020 08:27:01 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.00
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:00 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:32 -0800
Message-Id: <480939538f5887a70d11c2f7cf74446100e25fab.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 11/25] runqueue: Fix task mismatch failures from incorrect logic
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:00 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The "no dependencies" task case was not being correctly considered in this
code and seemed to be the cause of occasionaly task hash mismatch errors
that were being seen as the dependencies were never accounted for properly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 608b9f821539de813bfbd9e65950dbc56a274bc2)
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a45b27ce..b3648ddb 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2286,7 +2286,7 @@ class RunQueueExecute:
             current = next.copy()
             next = set()
             for tid in current:
-                if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 procdep = []
                 for dep in self.rqdata.runtaskentries[tid].depends:
-- 
2.17.1


