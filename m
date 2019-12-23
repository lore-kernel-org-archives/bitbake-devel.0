Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
	[209.85.215.178])
	by mail.openembedded.org (Postfix) with ESMTP id 814937F85F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:54 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id q127so8196993pga.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=RytAfh4OB8TNhsCnQfBes0raGLKRnADcwn2xic9giOA=;
	b=RaxaSx75Pjc60IxwWd3pxVN2loj2QjmArf2Bm7Rzi7PN8IwBaU9cUJIAwB7sTMs9mc
	6gA4no34ZR/swR3C/7LiygFp/70gCAcI+MgObLbpI2yfqDVU9ORC+p+pc2yaa7qcdqp7
	1BKw2us/YhnwjT92aSDflBPQv7/OaHbV2aygnkB3u4LYg2+nyJvLcQSn27CYk0qhmiZ5
	SvSDM5QDPnOvrZ2JoDJhTriHjVvqB1pd61eddfDUqg9rZeFK9YnpGqj5TUx/NUlspBNn
	PQ2HDDUwU4iGwbdC23VseypBfaGrk5ZUEd+AH0fI11ozOqtKeLBtncaN1U/9pBONonww
	FDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=RytAfh4OB8TNhsCnQfBes0raGLKRnADcwn2xic9giOA=;
	b=ZRa1N2r8SeTpRyoImKaX3htepGggbppx1efe4AXfvqhqK9m+jrPYCkUq0M3RayWqer
	TkabfExQfoVnB1lUqg+yjL18sMmo83n3BMN5Xu9JJ+/NwNs9iCUETzNDVhWITD1EvIGN
	uwj1ELcFa3WHv7rZsO2kTNwNBtulaVUsV1wp3+gP0IP6P3GzXOwEf2DsmFWwxspLkKtq
	c+y5DDw+bsTCX7iGex4gWtSll0ix34OHLtwXJj2iv8wgjZZOzzrlofH1esNixkxVXd+4
	lczKGPV9AX9AYuENlm15g+WBRgn9K/rtBGX0kO1rqt0SRiUL19+Kfq7DFoGWpJuQtguz
	y6cg==
X-Gm-Message-State: APjAAAW/wmJPkrHMpJWnH64kdqtz41hu5mOXBG4wSyx28pOHeoq/jVZV
	euG34XDmivUZaDt7z4C1QZZFgEgdZE8=
X-Google-Smtp-Source: APXvYqzIYoWeZpX68fYjnHAdV08x0qlpUfF7y3r3+JEaWQQugk+qJv8IQiX6lUGS/f7/NnFDP7FPcA==
X-Received: by 2002:aa7:971d:: with SMTP id a29mr28959191pfg.29.1577076655617; 
	Sun, 22 Dec 2019 20:50:55 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:55 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:35 -0800
Message-Id: <480939538f5887a70d11c2f7cf74446100e25fab.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 11/18] runqueue: Fix task mismatch failures from incorrect logic
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:54 -0000

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
index a45b27c..b3648dd 100644
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
2.7.4


