Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
	[209.85.166.44])
	by mail.openembedded.org (Postfix) with ESMTP id 673626C5F7;
	Tue,  4 Dec 2018 03:46:23 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id f14so6935805iol.4;
	Mon, 03 Dec 2018 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pXzEUMqRMIk4vvSEnFGbpwLdHTeiSa9y3jpcWuKm+jQ=;
	b=HUAKhLAQa9jABEs6YYExkaDXE8Vh1tYp0N5gwOhcW+S1B2CT4qwT7HJ9KlyAlUvkST
	jO5VRu05u80/rgQ4LSYVfTifBluAFkZJqJnOs+Vl7hC2UmzC0kT9K/kGVMTvU3hqhA24
	nWz869KXeEHz+4KLavYfNdYoMZN8ryMOGuIdGtuSEWXQWNRsLQAPcH2ksaOEG0vVBBUF
	aGNwWGAlkjEPjfDVUraJSeX5HDWPqkRGOqcd0hjzjg/fviwgS+JMyAfXKrBOKw7z5WDg
	YVOO4Va793yp1MdFmL955hH6hmmu1EzT6wNP7gkwnbqmmD9rEJ0j320bxmF0JlD0BC2Y
	ZXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pXzEUMqRMIk4vvSEnFGbpwLdHTeiSa9y3jpcWuKm+jQ=;
	b=HttQkQkm/SXiSxivjvhnakVyzGUQ3sXbNUWg6+t1nUQRIFOHbhstx8WFzb1ujf86lw
	YuvDBic6yTB+DdnABwPY+nvKHqho2K8QZkE36qNN+I9Qq0QXQjqTom9uOAMbSE6FYraY
	hDxlSlw9b3/g5IA03HV/TbRZBBVVIcdwV3K8hzh7baQFl/HlXUNiu36v/e72Qs2s+Bpu
	3KR2EOcskmFO6fIreg46OyzR75dXUnB075EYQM+9jyuUwKqudoJ0NynuStO5XlidN/yo
	/OGKpYHV/ZWaEIpi5ZK8rLLrgWSCoCVqIS3qN9SzC0DR5uOYNF8a+ImwYgNpG3V1cavs
	k2/A==
X-Gm-Message-State: AA+aEWb33BjpehkeDGr+jaBqCKwf3OnBe6e4ytlj11tg2XTvRGZqofD2
	eoi+Zdr8gPqeol7BMmvnNnUIlUu3cYQ=
X-Google-Smtp-Source: AFSGD/Ufbz2Bh5ah3k0O95SX83VegvslM5L7zDIu+RazJYgPQrdG29nT56s/g+/8b2QP0tbdsv0oIQ==
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr17462885ior.31.1543895184095; 
	Mon, 03 Dec 2018 19:46:24 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:23 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:31 -0600
Message-Id: <20181204034245.25461-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 03/17] bitbake: persist_data: Add key constraints
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:23 -0000
Content-Transfer-Encoding: 8bit

Constructs the "key" column in the persistent database as a non-NULL
primary key. This significantly speeds up lookup operations in large
databases.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 1a6319f9498..2bc3e766a93 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -94,7 +94,7 @@ class SQLTable(collections.MutableMapping):
         self.table = table
         self.connection = connect(self.cachefile)
 
-        self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT, value TEXT);" % table)
+        self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT PRIMARY KEY NOT NULL, value TEXT);" % table)
 
     @_Decorators.retry
     @_Decorators.transaction
-- 
2.19.1


