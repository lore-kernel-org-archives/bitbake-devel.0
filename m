Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
	[209.85.214.44])
	by mail.openembedded.org (Postfix) with ESMTP id 89BA078E86;
	Thu,  9 Aug 2018 22:10:47 +0000 (UTC)
Received: by mail-it0-f44.google.com with SMTP id g141-v6so140093ita.4;
	Thu, 09 Aug 2018 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/5u3x7Xdeze8UwVuh02z2JWv8awv+iu+8JjDM36R/gI=;
	b=iT+IVJ2elaYfrAIdHm6lDWvY0NBMW432dDrKBYMmLF04PzCLKnHhPZpyTrzJXsCuTy
	jfAfpxiPNFsJ608PUXFrhtULEPoFISPBClJuAyFt9Tbi5XxsLmQ8Ug8oT3NdLQY4niDT
	Zph2IfND686y2RUHIxZmeK32hLWaROYS0T7jWRr4EALtiwnByVxc8CPZky3VqRiQ62GT
	GZ4pifLPfuCVYk1WH4Y3fmpKqZHkTcf6+vQB3qB7CajM1IJZ3kSMvfbI3Bo4z1RT29rW
	RFpwqiZK6liENZLK9vMSjNdKav0c6Inuolk5dBOxkRo+3fq5t2w/THEPV1876xieAgC5
	INQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/5u3x7Xdeze8UwVuh02z2JWv8awv+iu+8JjDM36R/gI=;
	b=Cs8XvBYsSxGSRIUYBFIA8N7B5eN4wABAw6ISms8g9E0yVbmdrhobyJ7bXeTzi2yymO
	9ofJ1uDFmBEz3WN3M1xSS1e7nLB6601zmaU91t5OcDXzt/0tPZ3Q6wFr1aIut9WA6MjN
	HDTiEh9KBVAbu5/k/51xb4kZsjKG/oNzojsoSLFls4tufFkL+cYxBcfOGS2hZuCaTm6u
	R74yopCLR/2UOlUr6j7BQ9qaSWGczuGbeVjJyLo0p87ea+OqZ62c6jgBpxM0hSJdHNk+
	9JzrAl75oB3+V3ieNKTjY0F6DLtqC83H/Y1eypOI1Ja2gPpT+KivnAQ5blzyptZOceDX
	h89w==
X-Gm-Message-State: AOUpUlHYs2rmoNzqC+piSRntgeVnJd6QbTaspjop6BXXfl+7LNUWXv4P
	OQ7j6L95maYQLFKMkqBM7fcRzPaN
X-Google-Smtp-Source: AA+uWPy7/VcqXDBulKkgikV1h5ay7ezSgSjVXYpYkG0HOgtAJ6xRJ96Eke/TFP/CaDxiWljA8fstWQ==
X-Received: by 2002:a02:4d57:: with SMTP id
	l84-v6mr3610528jab.56.1533852648403; 
	Thu, 09 Aug 2018 15:10:48 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:29 -0500
Message-Id: <20180809220840.26697-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 05/16] bitbake: persist_data: Disable enable_shared_cache
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

Turns off the shared cache. It isn't a significant factor in performance
(now that WAL is enabled), and is a really bad idea to have enabled in
processes that fork() (as bitbake it prone to do).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 9a4e7dd5941..f0d3ce665d9 100644
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
2.17.1


