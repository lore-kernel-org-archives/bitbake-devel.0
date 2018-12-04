Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id 02A326C52A;
	Tue,  4 Dec 2018 03:46:25 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id x6so12391718ioa.9;
	Mon, 03 Dec 2018 19:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NjAYVsZnEsPakTihdlqBdI78yT0X7kxLuN/xUDI5o9c=;
	b=IrWVvEQaCdM4MZM/WZJFXMK+w428AfePZ2RhWloFb+dsgkNdznkLk4kWwu0YmRCRS2
	wkqjOBTkgyK9zDcenhT+MJFkb5Bkn/sClEntQxRxu30MKUynidyDlEUGqsWH2jlyiyJU
	045+twzBPDIquAwSl6pCEun1di91V7qOaKRIX9vJXKKSD104QJlsRXlsQDhcvytRrfVO
	js417/HD9UcGQB0TRLgblFLIGcMBcOvEXth9+fN7MLuItEsfB/5D07MAMBrJEwHRF5zs
	gLffn6HX/cza7ug97F9TJ4Znc+QCDZv1Y3hnl0Qt4mlKyShJch7oG947hjjaSA1NiQQB
	x4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NjAYVsZnEsPakTihdlqBdI78yT0X7kxLuN/xUDI5o9c=;
	b=UXARlYjOT/yyd02IPQ6fjQisAfQTvJzV2lV9tD+62Qq+f2M8F9I0OiQ/JTRQpz1KZ6
	O/KwyKtzpC6qdtEVWKzlW67mOD7rnxz2zkp0iCveMmTdtfrR0sDTxlemQ36zzsN2CcWz
	lM0EXMhaMSZOgtiIX5Fp4x2bTUYhBUxrOx1T8d+mEhkZKf+mgzvfAImYzF6hQ2jxwhhn
	pIehscstf9Pk+s0g1H1FQi4qTsNED9blL+A/O2YTj1iGwRwy8HSqLlA67PjL+ICfnA9o
	K3Om80tEwch5VkVs0pASloVCA3VoRXKuRkxh+GzNvH6BfF6OWkhgnwLKZ/1Og/8AsEAR
	adWg==
X-Gm-Message-State: AA+aEWaEFPnWVxSuq9ltwb6a3zxexXoM9SBbQfFd9gUUoUbLDYMbh1qi
	ocNDGaGp65It97q+vQ+sR/9RkrjsbTc=
X-Google-Smtp-Source: AFSGD/WZ36DPe20aWEq/SGVapF2xl1lW3bCPw4pRYDIwyDTpJLF+lKVIFtsJ6HZCCQ2uJ4y5Q9EAsQ==
X-Received: by 2002:a6b:d803:: with SMTP id y3mr16760337iob.247.1543895185919; 
	Mon, 03 Dec 2018 19:46:25 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:25 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:33 -0600
Message-Id: <20181204034245.25461-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 05/17] bitbake: persist_data: Disable enable_shared_cache
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:25 -0000
Content-Transfer-Encoding: 8bit

Turns off the shared cache. It isn't a significant factor in performance
(now that WAL is enabled), and is a really bad idea to have enabled in
processes that fork() (as bitbake it prone to do).

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 14927920908..41fcf2a41c4 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -37,12 +37,6 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 
 
 logger = logging.getLogger("BitBake.PersistData")
-if hasattr(sqlite3, 'enable_shared_cache'):
-    try:
-        sqlite3.enable_shared_cache(True)
-    except sqlite3.OperationalError:
-        pass
-
 
 @total_ordering
 class SQLTable(collections.MutableMapping):
-- 
2.19.1


