Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id A37F078E72;
	Thu,  9 Aug 2018 22:10:46 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id i18-v6so6056005ioj.13;
	Thu, 09 Aug 2018 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qrqkkTihxJjR98mC95Lh2yKzOBQxmglquVe7JgrE7S4=;
	b=tD15+OGFuSon6ORcBXQ14AtLI09RKFPn1veijUJurRF2raYyL11SlKZ1hgJNmYskbT
	qAaNz7rmO+eHU1yLOLl0XkIcIB/LWXVNxgKtlY/qwT+EGntmiXa76EC/eKga3Ut7XTds
	V1DNeZ0Bs0KXc/M4xzkeZ/fE3dqc/jgGyynlbZPxoPLzRfZLP2cayOwjAMwggzwEEa2x
	Z2j9k0fNwP9GQ7XusdPK72SHMQMItZBrnEddf308BW4V+JEa0ZRQnqT+G9di7REjpIKm
	KSgAdM5hVpYIFZCT4+LNsiTQ7KuSR/+wK5rmjzNIyl7Gh52f6KBEiQKtsJxylIALTnkX
	OHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qrqkkTihxJjR98mC95Lh2yKzOBQxmglquVe7JgrE7S4=;
	b=D7EL//1O3c87L92M9QMYZqSYEr9WlW6gMWOSBm8FCXx65CF7/dpJcLrF2SQ4cqJYjv
	uCaNS/mtSi02RG5ANNcfuGTQbMoGfBC0dIaD7cQscghsBWAnu0itfxYRN7urM1y3ldxH
	DBp0SqBUZKLVbq8DpKTYhlraMFrIkHf8y8w0rzYxHtr7CJmmJUNaMdol53XhxN3emJuU
	jDE3Gk3ph+BKHzbSYnhPorOX7ll4E/MgkzAjBjjz94A4nx2Pl94BTcN8ueHyKdkoZbNh
	i8gf5HyGeWGognL46ZK7xJwbg3X4vmoJl63krYTsbWUEN/7qzmc7DGgYhI8QIClszzWx
	vt+w==
X-Gm-Message-State: AOUpUlHZp1pk+FuTq5QC+DTTQpYCMmRIBV78kItXUn+2hx/x065TLM71
	eRPN3MI8liaqRttU4isPcz6qb2MV
X-Google-Smtp-Source: AA+uWPzGNr+Hic0UpoOltXsOgrlpQ1y4ECTbF1wfNYK2UNBKgwShhjYIwMoCiwZG753WdmWKP97MNQ==
X-Received: by 2002:a6b:3954:: with SMTP id
	g81-v6mr3162843ioa.225.1533852647532; 
	Thu, 09 Aug 2018 15:10:47 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:46 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:28 -0500
Message-Id: <20180809220840.26697-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 04/16] bitbake: persist_data: Enable Write Ahead Log
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:47 -0000

Enabling the write ahead log improves database reliability, speeds up
writes (since they mostly happen sequentially), and speeds up readers
(since they are no longer blocked by most write operations). The
persistent database is very read heavy, so the auto-checkpoint size is
reduced from the default (usually 1000) to 100 so that reads remain
fast.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 2bc3e766a93..9a4e7dd5941 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -278,7 +278,12 @@ class PersistData(object):
 
 def connect(database):
     connection = sqlite3.connect(database, timeout=5)
-    connection.execute("pragma synchronous = off;")
+    connection.execute("pragma synchronous = normal;")
+    # Enable WAL and keep the autocheckpoint length small (the default is
+    # usually 1000). Persistent caches are usually read-mostly, so keeping
+    # this short will keep readers running quickly
+    connection.execute("pragma journal_mode = WAL;")
+    connection.execute("pragma wal_autocheckpoint = 100;")
     connection.text_factory = str
     return connection
 
-- 
2.17.1


