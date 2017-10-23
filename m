Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
	[209.85.215.67])
	by mail.openembedded.org (Postfix) with ESMTP id 7B0607198A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Oct 2017 06:13:13 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id 75so18791408lfx.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Oct 2017 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=ULquoSWLd81vbINWi46tULf0aQOZh85X8eAv65fhrXA=;
	b=WnUhUEYLfXmcqXXbGN0ve2P5RnIIcRzZ+xubBUTT+UM4A6wBVcAU0fpiuOkY1kF+kg
	4GM9YYsTE8JfaiCF9LuMYKZBqAgag77TyU5yFwuGDmSPNA4b+dp/45WXUzons2ZQM2sJ
	z4osQI/1eJZL+z4cjgQu06TXuf3NGx8kFWH50qsCKFQ50bhS5DpQSkUbtzVaNl2eubyR
	4St4akQmB0x5S0o11f8WA6jkGjoYro4I4jPQ9afNQgKGUHZS/u8DSQ+ppWi5k4InKyrP
	aZo5joapsBiNyqiFbaqtcEp3drnIa1Nu29W9Cj4fcUkVIfHiBQ8uCC+zdBpzvo43E1v4
	HAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ULquoSWLd81vbINWi46tULf0aQOZh85X8eAv65fhrXA=;
	b=DscBNB9ClhkQnv6We0DdiAJDWA9eHm5hClOMh01y6V48qqZO/tgonlz+9+cgtnS7cy
	H8Zg1HX3gbHpaM8yjq6O6uX05dGjikejG2FVhoD4yAYWsXwma5RJwKzYJ18Gx6r+PFZQ
	6DhMNrYPF72xmgNZGyxkP4xxkGySge6KquHBtZ0T48lk7cJ2lhuQcVCn8Rdko0iZlzIf
	Vk6RZXQs3vYRQImtgQoENmJYfGLymVHfYI4ll9BljnLrh+Nox9UlcxsRgBt1PBgqTdl/
	UFn6eHZbSBRjuxY1Fjlgr5s/sgMFSlxam0dODJgtQseuKlJeUHwvXKb5k7vnSvI7rldb
	PXVg==
X-Gm-Message-State: AMCzsaWpnlLpmtythgiD5mAy9SbPd+PlgG6fjVxtZWL9NdzraVFIs2PM
	3V/LOyCtHjoEPKMu31WWIlD/Lg==
X-Google-Smtp-Source: ABhQp+Qg23LRGdROedpRIsez0Wv3WbxjriZYIGbVCvtXthDUd37OT3lZF6pp7iLEmsoo2+wukTRgMg==
X-Received: by 10.25.99.216 with SMTP id v85mr3976640lfi.257.1508739193771;
	Sun, 22 Oct 2017 23:13:13 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com
	(ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
	by smtp.gmail.com with ESMTPSA id
	v29sm1698421ljv.27.2017.10.22.23.13.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Oct 2017 23:13:12 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Oct 2017 09:13:00 +0300
Message-Id: <1508739180-12447-1-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] fetch2: Fix missing logger import in repo fetcher
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
X-List-Received-Date: Mon, 23 Oct 2017 06:13:13 -0000

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

After cleaning deprecated API usage repo fetcher is missing
logger as it was indirectly imported via deprecated bb.data.
Fix this by importing logger directly.

Fixes: 9752fd1c10b8 ("fetch2: don't use deprecated bb.data APIs")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 lib/bb/fetch2/repo.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 1be91cc698e3..c22d9b5578eb 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -27,6 +27,7 @@ import os
 import bb
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import logger
 
 class Repo(FetchMethod):
     """Class to fetch a module or modules from repo (git) repositories"""
-- 
2.7.4


