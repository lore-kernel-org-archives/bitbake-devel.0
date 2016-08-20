Return-Path: <net147@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66])
	by mail.openembedded.org (Postfix) with ESMTP id DDF7676E3F
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 20 Aug 2016 08:58:38 +0000 (UTC)
Received: by mail-pa0-f66.google.com with SMTP id hh10so4682036pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 20 Aug 2016 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=hv4Fo4cw/odtzDMKE2O6iR7c+aNoSENppgRaEdLB3Nk=;
	b=OzAc5bljMIxWQ/5Lpq4myA7qX/WLR+7fHTerGluNViCTwiz/p21GfJdOkkSivlbzcn
	EKFnKjB8h/BqN0W0cMf5wQHlTz8jqR0n81RjUGDOwRY29s4N7eq5KmPpJF/FtGjLBhlI
	dbn2UAbKP6G+j6K6BfKvlTfoN5JN+F9ihOrWEw76LTUyRZhQYHLiMhlyCzml+gAqY0ag
	ofWoxiLyfdW/LJ10hanzTREuc5/dQtTXMtMj9Jnbu6GriSOzYaUQGewXXpkUd54eS5jC
	vGUhrNgI0gq+DliMbGaqko2An9gmjIyUr4frh013G1YpJSuxtmkTJQEdQ1+Ksdjraj3O
	Md8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=hv4Fo4cw/odtzDMKE2O6iR7c+aNoSENppgRaEdLB3Nk=;
	b=QjzvFO9AIaw+T3tvQuu/9a1BzJ01eFUiTiEDs3w6Laic7HZE8CBlSxO2kIEzQvyDGr
	oDW1OVYBuGio+F6cha89N3upntp9pBwPZQwJAf+8s56xtBTtBtcksxmfCiMjzdBgCC54
	UTi5htypLZJc/FTVGK0hNy7t5KO5KnFAGlDDaRztgAkdZlCzZ+1W2e6P4j0pqPjDf/y/
	LS+l4aIt2kYqqXIuIMlv2+o3mJf5O5L6DUknXvtvIhfJPyLy72ZkgwRwKe+CE/brTJ37
	oiVH3rjmv2TahzJDgV1Z74CVPY9sb1k7jO8W0nkZ1dA6NL2N8F9HhqqJCJypEH+QahQl
	jx6w==
X-Gm-Message-State: AEkooustmkOK8KRjBkrKUQlZFnS+E6WHoF2FuC66HvaigqZQyIXZbGYAhILO9eeeC5UiVg==
X-Received: by 10.66.227.101 with SMTP id rz5mr21717000pac.81.1471683519712;
	Sat, 20 Aug 2016 01:58:39 -0700 (PDT)
Received: from 60-242-179-244.static.tpgi.com.au
	(60-242-179-244.static.tpgi.com.au. [60.242.179.244])
	by smtp.gmail.com with ESMTPSA id
	dz13sm17135265pac.44.2016.08.20.01.58.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Aug 2016 01:58:39 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 20 Aug 2016 18:58:13 +1000
Message-Id: <20160820085813.15502-1-net147@gmail.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH] siggen: Fix file variable typo in compare_sigfiles
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
X-List-Received-Date: Sat, 20 Aug 2016 08:58:42 -0000

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0862cff..3a7dac4 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -367,7 +367,7 @@ def compare_sigfiles(a, b, recursecb = None):
     output = []
 
     with open(a, 'rb') as f:
-        p1 = pickle.Unpickler(ff)
+        p1 = pickle.Unpickler(f)
         a_data = p1.load()
     with open(b, 'rb') as f:
         p2 = pickle.Unpickler(f)
-- 
2.9.3


