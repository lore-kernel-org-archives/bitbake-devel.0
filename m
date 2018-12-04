Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com
	[209.85.166.172])
	by mail.openembedded.org (Postfix) with ESMTP id 39DFE6C52A;
	Tue,  4 Dec 2018 03:46:24 +0000 (UTC)
Received: by mail-it1-f172.google.com with SMTP id i145so13148062ita.4;
	Mon, 03 Dec 2018 19:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=a8IdkJdw+Yv1iiTgxJUPUoWV4cKKgz2o0Dk9szBmuD8=;
	b=CtHqeQqz0Mo+YyuHF6s0gafE8Qn2MdSXVhy+BsXq4pIO6GwXOfaXS2tpcf5Ytnfey1
	jL5ihGnqbGGAohopqoUDlOjmcKuitQxDPMZrT4GGxCm5z+m5ggrIcoXqYm3lPQxD8yEh
	j19JmxEX15elJ6P5MdkIXoEZYoFEEwDDpFWydi6sfKCniC+rXPI536IVQUDy6ktwUOJu
	P4aZxTlGwV2E6h0nLpZJWW+bg5CL985Xe1LQe+4oN5v2hws01tK3UQaK5o+j3zuADN+4
	TZHwnpJtsUEJAcFz3cQ5LTcWm06gwYIH4+OCrRknxqznXDavE5eBWNbxOKr9zpVXhk6G
	Ysvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=a8IdkJdw+Yv1iiTgxJUPUoWV4cKKgz2o0Dk9szBmuD8=;
	b=pPqFKrHUeSmKsL/FweeA6jI45v3i0YhT1mTd/ADXOp7JZD1Sxlojjr2o+jFFpcQ6NH
	ZkbAgMOi8RKKMFRM8GZA7so9Kj0KteyG4CoLxAnmP4MaHhh8+MPp10LCzlDqG9Ux3jSy
	2sQkGu99jgiQgoc5HPSYNXS4sJrcbxK4JSFtBBQaY8v9icoxgT30PXPOX1vIBtWbnSoj
	n3VbeNYeUIMephlwoNog++yoMI+Fc7CyufnisQDLWxDU4VEKKiIqJ5WSKsFbqryXjMHd
	OJbNzkJsyilfiQUdnVXs8nSddCqu4XAW2IKMzQh5YxncvlcJBUKan+lu2Fwz+w9AWeOC
	3aIg==
X-Gm-Message-State: AA+aEWZMRF9neCOa5lSGBYpKpD7in380+hgjAETNnJuC3tqGB8HvsBNG
	De8FRPjblySK/hZlbNO0hpIRRCux2LI=
X-Google-Smtp-Source: AFSGD/WSV2haqSIXkyF0g7s6/IeyJFDs/xjtxXZ94sF65DJ/EZQyw7wu2wjxdA/40iJp4VyDQlEdRQ==
X-Received: by 2002:a24:5d11:: with SMTP id w17mr10079716ita.169.1543895185018;
	Mon, 03 Dec 2018 19:46:25 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:24 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:32 -0600
Message-Id: <20181204034245.25461-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 04/17] bitbake: persist_data: Enable Write Ahead Log
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:24 -0000
Content-Transfer-Encoding: 8bit

Enabling the write ahead log improves database reliability, speeds up
writes (since they mostly happen sequentially), and speeds up readers
(since they are no longer blocked by most write operations). The
persistent database is very read heavy, so the auto-checkpoint size is
reduced from the default (usually 1000) to 100 so that reads remain
fast.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 2bc3e766a93..14927920908 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -279,6 +279,11 @@ class PersistData(object):
 def connect(database):
     connection = sqlite3.connect(database, timeout=5)
     connection.execute("pragma synchronous = off;")
+    # Enable WAL and keep the autocheckpoint length small (the default is
+    # usually 1000). Persistent caches are usually read-mostly, so keeping
+    # this short will keep readers running quickly
+    connection.execute("pragma journal_mode = WAL;")
+    connection.execute("pragma wal_autocheckpoint = 100;")
     connection.text_factory = str
     return connection
 
-- 
2.19.1


