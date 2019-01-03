Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id BB6806D4C6
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jan 2019 16:36:14 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id b5so43388023iti.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 03 Jan 2019 08:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=iN68EWHA3toEVb8LONT9wVwjqhl3eDq877eoZybxN+U=;
	b=pcZEajDPqbWHqcAwInWH9CJ2exTNNSHbQ9cBBBbTDDOFPrfShRGUmf3KeLB4w2pmNI
	/gYnp0Ut6df/rz+Fu3MrsMuNqpljzc0EAZFt6fkWFwyc+3kse6Fb5M9ZlKNFdMaqf2jr
	9Z7zcPfqQUJNJsmYiXMB1Gfcu7sbIvWSkiu4rTwAhmZ/6e05GbqZGfIQUI4FjDmzs7c3
	Q9cHDfjpNDnpcUPMPpLr+KtMuRWTtfLK5pdaffKhCFSnen1l8dBnptCckEhzeH9KtSk/
	J0FJ7Oq3y71SzBgn/x3glbYfhxadqB4wn9gzd3cN3H+cfYKQYPqUnkcoX/ICy++zoD00
	L1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=iN68EWHA3toEVb8LONT9wVwjqhl3eDq877eoZybxN+U=;
	b=Zf5C+zlyJ4SmjjNTTdUFslGMCBYyJGaejk8moI/NdMBHdWg0165XuvTWRT/yxEM1YG
	Q4OUJt+OstxKd1Y2aAJnHKOUmxEwZqRIFNJuAsFJfV0ZEz8ZDnvfsFY6BNn1sx7iYVIO
	WwM5mqOhGN7WJVibCAco4btayQgI+Wyhb5nG9g5hCdRpEcKYnqxjx3a0XpKcoW8dvYDS
	LNLRoouWbJ6Howt5nPUS0S7K1Gmq8Es5Z4ZB5UHCXtWjKIiaY1xiP5YIDorubyooRFt8
	JVvOdv15txkZz681EalS9nGoBlmWByDC5a47m2gaxzJj2QHE9o1K4tGAqa/dWRluGXHp
	y3cg==
X-Gm-Message-State: AA+aEWZPAGf7TTgs1vhW1fB9yILVzBlzhn8R7TWhIiERM3jM4ktZcPDh
	pKZ/AFhc49gWrew1cvJvZcgMy9T0
X-Google-Smtp-Source: AFSGD/X0JCCnBQT31NFWYITt7PcC08OKPxcGSTcMWMBGTIsLV0haEnBu37h3gmN1Ktwe54fZyL3Q9w==
X-Received: by 2002:a02:a003:: with SMTP id a3mr33956997jah.8.1546533375519;
	Thu, 03 Jan 2019 08:36:15 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	m45sm22765868iti.10.2019.01.03.08.36.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Jan 2019 08:36:14 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Jan 2019 10:36:11 -0600
Message-Id: <20190103163611.7736-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: persist_data: Fix Locking Protocol Error
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
X-List-Received-Date: Thu, 03 Jan 2019 16:36:15 -0000
Content-Transfer-Encoding: 8bit

Under heavy load with process delays, sqlite can issues a "locking
protocol" error (SQLITE_PROTOCOL). Unfortunately, it is impossible to
distinguish between actual locking protocol errors and this race
condition, so they best that can be done is to retry the operation when
the error is detected.

[YOCTO #13108]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 4468facd18f..0d44100f103 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -59,7 +59,7 @@ class SQLTable(collections.MutableMapping):
                         try:
                             return f(self, *args, **kwargs)
                         except sqlite3.OperationalError as exc:
-                            if 'is locked' in str(exc) and count < 500:
+                            if count < 500 and ('is locked' in str(exc) or 'locking protocol' in str(exc)):
                                 count = count + 1
                                 if reconnect:
                                     self.reconnect()
-- 
2.20.1


