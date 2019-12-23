Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
	[209.85.214.172])
	by mail.openembedded.org (Postfix) with ESMTP id 6A1497F873
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:51 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id bd4so6700212plb.8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=wHfUod3r5VQucU0Z+mK5DUTFmNVlGd+GOtkG8Fk3usg=;
	b=JzF6TiLxQ7WZvFb1mcXjGuApyzduSHBxDnDxLo1AzjMa+uuhiqKgxb9uDquHgEtILh
	Q6kCrf2g/6P+lxKxxemYYb61P8OiGiVRJ58HIPQQDV8bVtTNDEgQDuv1AGk4h5AGUw/w
	gA7++UitezWjb3SUjjz2nSUx0XkoB2Zq039on5f0QxaMDZPXb0Cr6xAdqaXRHqatQ6Ed
	BsD1Nus69SD8EePo6LCctR521sedUgV9TZmW+pg/B8IRKQHiW8Q8Sg4SDwChyYGjDI7X
	/J2z+K8otFF5TxhDKcgkgUlB/cJ1lBunIlqkDxrTNCcPcb5T9YUKSEZy5CsJc7xzwSn5
	Juhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=wHfUod3r5VQucU0Z+mK5DUTFmNVlGd+GOtkG8Fk3usg=;
	b=Hx5vkcZJpbnHPXjrM/o/NALtg/b+flfcCYmR8NGW6rCF1myGFT6Buw46fcwNZiBm3W
	8A0y5IhIDpf/x4gV2sAibeiuwuczaaL+XpW8VnC1Bqf2boPuJOKopHxsjRKS1tYaftai
	bev+26M8x9mwxPinuwbAHR9p1zl8Sej5W8VX4iAUO01BmtWtN4McwROZS3SvjT9njvq6
	xlt6rK272mjIBupu2DVe54EqeaPaME5Wm/8QQsUl52CRWxqsQ6VEOdlWoCQ5R0tPBk3K
	KGhsViUjCW8Vo8AoPLVglnUrzdZ5lIwFWV/Rnb8MFNM1IgG4O/aHf//SElEDy775cKHD
	yo2Q==
X-Gm-Message-State: APjAAAWmkOK3iiRxtMS+dkvVMiwn7I4NTBlGWWBdiMglSXZrvjX7rVXz
	+c2J8qb8t/I0+XUd6TVlJfKRC/xd7bs=
X-Google-Smtp-Source: APXvYqyZ/hxpUz3Ajr5UszjQ442Mmbm9zfwTolTrHjq1PQSv14p+qXrVfac1NEiebyYnkWeTd0BTHw==
X-Received: by 2002:a17:90b:3d0:: with SMTP id
	go16mr32365268pjb.75.1577076651659; 
	Sun, 22 Dec 2019 20:50:51 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:51 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:30 -0800
Message-Id: <0aee83e4e31dff7f4354e4eb4cbd35dd592e9f06.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 06/18] siggen: Ensure new unihash propagates through the system
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:51 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Its possible the new unihash may not exist in sstate. Currently the code
would create an sstate object with the old hash however this updates it to
create the object with the new unihash.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit abcaa1398031fa5338a43859c661e6d4a9ce863d)
---
 lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index de85326..dbf5102 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -513,6 +513,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                     self.set_unihash(tid, new_unihash)
+                    d.setVar('BB_UNIHASH', new_unihash)
                 else:
                     bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
             except hashserv.client.HashConnectionError as e:
-- 
2.7.4


