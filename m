Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 47F8F73013
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 18:41:10 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id r137so19485311pfr.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=YUy0gOi7IkgKuTnw7DFJvnM9pgnHs/fihFo2YELVfZs=;
	b=CRGUgs0gstSgoqwIR58ov0vyoJT29olo7Td+nvF9kab56YPXeVB1+mQkw6rnZUF8hD
	lEsPVbpfRYGtedNWIsZM4f1tLZwCE0JejPctgfJpR2JnWETvTNh9awuqb0/5rpz6PCCQ
	laBeT8txcHWzGeKa7J7MZXpO2pRBRsxXQOJ39WyfcDw6jvqImIZh1sIlmq72RrAu1czn
	WrmCAf/5Y6iVRQ2ABS5cYDu5COtMPzOm7I+cfOpWx5hdgaQzcaHoZOsnHNSD9sLFWtsy
	/upQ0NVtqij/wCneFD+7iNg8BLrBpKs90UloRo1uiVlOXXejjNSqvxwqP8PelR3jz7Z5
	IL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=YUy0gOi7IkgKuTnw7DFJvnM9pgnHs/fihFo2YELVfZs=;
	b=qFlsNwtJjctmU+/GAbyCw3Wco7E6QYznaG8wqef8Kk5kapg3+qHcIltwFOnlmPeNnL
	RiddpDvi0ybDl8Lhfi3g0zXfGrHfySffNDI0KwF8c3oeFODrjQl2cRyjH/5TiLBdvVbk
	46hOodce3ElVvGOAgaM+5J4N9VrhBhpaMjNWp2tjhu7+1+C3TgEQY6xW4t9fQILuRdiw
	vRv9M9lwrY7Wtm0glFhoqYVGStNKrNmxnqzgHk9OcYoC1+KUU/OgwZ00D+CaLyBvJxGV
	tyMLlw9a0lwQW2yK3fMB9UfDRFYyV3XuZ40LzYb5exQXM0zww1TnmWmEVPQzahEu9qPW
	V8Jg==
X-Gm-Message-State: AFeK/H1WZbGWp6bRZsdVeURJ0yxk0M9ihmt7S50EO5vgXCPsuTFIMrZoiULK9wk0XdKwNg==
X-Received: by 10.99.138.68 with SMTP id y65mr4154196pgd.73.1490121672475;
	Tue, 21 Mar 2017 11:41:12 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z19sm25324304pfd.81.2017.03.21.11.41.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Mar 2017 11:41:11 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 11:41:01 -0700
Message-Id: <7ef969d3a2b98f00ccc22645445f5e9f255336f6.1490121529.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1490121529.git.chris_larson@mentor.com>
References: <cover.1490121529.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/4] fetch/git: use enumerate for ud.names
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
X-List-Received-Date: Tue, 21 Mar 2017 18:41:11 -0000

From: Christopher Larson <chris_larson@mentor.com>

list.index() isn't a particularly efficient operation, so keep track of our
position via enumerate() instead, which is more pythonic as well.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0779e80..bbd302e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -173,8 +173,8 @@ class Git(FetchMethod):
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
         ud.branches = {}
-        for name in ud.names:
-            branch = branches[ud.names.index(name)]
+        for pos, name in enumerate(ud.names):
+            branch = branches[pos]
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
-- 
2.8.0


