Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
	[209.85.215.170])
	by mail.openembedded.org (Postfix) with ESMTP id A54317FAB7
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:23 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id k25so24174334pgt.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Vyo4msbjtScoNFMhi70j40sFrkLNLYqVfPl4iRz/apw=;
	b=bnghKcFuqC0ppl9b+deFO8H+JX1hKElcTFWZVebpeHsuTIZYjv5Sw558DxmPccusFV
	Le12+N2ivCIxxwT5IsFfrCItV3YS71UqHPrtv+uF3DqbDDFYQt9juQqXWnxFF06ACzHe
	6M4gdqZ2HtxCPCX80Tdn6LBYd2hbtIZy/T0QNzmSZ77GcyIYx3azKhkGNO4tp5ZoWLGS
	j++GEw2gMXje2CAPV0Vvr9eHVk6QqYdr0JFMoXCbne0OJ5bxtN7fnkjRNOyQKw+yCt3R
	MP7cKdVoH/ii3X2f7bziDUhBfAMOzh7SJEX9sA0/7OVQX4EJGOD5bEm6AhnfDAjcuEYD
	hVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Vyo4msbjtScoNFMhi70j40sFrkLNLYqVfPl4iRz/apw=;
	b=JxILuqLXeIBjHqI2sFJ80BqGefY6ephVNhJbe7OYP7kOKXPh3sS7vHOUa4j0PailKH
	DZLiGEHYoST/7W7TxLTrv0mic7vHVZRLhrOdMA0/zVodSMcUP0yGhfdv4dEICq14aF+V
	IqVlLIt8guOvAiGUoAiuGV5V+PC9opnqAYqL25ntsp35y86iV2KQy4WkJVBfy0MRsbkt
	JKaZjUnvHy2Z5bDuhxrhP7wrep3c3vjNvIJ5BfrQcQMd44L3+CTJFEo70Fs/4uQmcryE
	SnxIM4Fr3U6EIRrkg0v3rTVTu+98bL7fE+SiPvE2Mo7mUDFxp5uqeh7y8z3Tm9SIfZ8l
	gUvQ==
X-Gm-Message-State: APjAAAWeicSz4TVj3698JIDyPH9IeYDrmPvenlN7a4fDKlr/opE83Ma0
	FZYwbNH2w1FAquxrh1+g+yAH003+eEw=
X-Google-Smtp-Source: APXvYqxZaF5kUVg948nZD437wrG3HuuSAvND05hyKo0qW82cGAmCULfj2VvUKMebM87ywhzImyBfUQ==
X-Received: by 2002:a63:e4f:: with SMTP id 15mr95533535pgo.398.1578104604573; 
	Fri, 03 Jan 2020 18:23:24 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:24 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:56 -0800
Message-Id: <480939538f5887a70d11c2f7cf74446100e25fab.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 11/25] runqueue: Fix task mismatch failures from incorrect logic
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:23 -0000

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


