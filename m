Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B4C0218A
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:29:10 +0000 (UTC)
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web10.52717.1737988150248951988
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 06:29:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SleFsTy4;
 spf=pass (domain: gmail.com, ip: 209.85.166.196, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso10116255ab.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 06:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988149; x=1738592949; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY0hUfztbJOdUnYWzzkrp8Gia/c0LVtFRjuMdv+qgQE=;
        b=SleFsTy48fxFii5TVnO7s7VN9X4qVYbJom6hFJLojFZhhWy2Hscb67M6irU5vZqWwh
         75Bb1XqSyKV4z/YQqthewzqDd2xwMMjE5oYwpjcYCAEWgH5FD3VKCmd9z/eBo4JcVJmC
         emXa0WZT3Ev1IRM6rg3nsgkWpp33a8JHlgu9BGm1hgTKG4aNF3R6k/Va0pdlyjX9RV63
         LLfHBlN8tNwmseSlYM8+TJKehfC9PcaqrVFIXkKEH9iqK1ePIJJwnmNyP6JLHeTAhvMc
         v8z2li7yaxvIizmWgIKvJgpCwo44+E5lHYLtz/EJWFGcF00Zd/A8G1JHVsZppkx1jz1+
         rmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988149; x=1738592949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY0hUfztbJOdUnYWzzkrp8Gia/c0LVtFRjuMdv+qgQE=;
        b=cF1Jbjd/QxQG2U0LBCRx1PgN1qikxqXOQt0MSlnBzl7qM3V9h2Egp3f6drunYmNAQg
         JMsrsh/R8uOhn5u36ulIxHMqREWCtqELZeTgSq5miokxhzIbxvycrL+tvdMUi1nY793E
         FL8ChAYpzQMUOJS0O4f6s7sP6rysCzW+xPJnfKEgDB4s+cBwnIkKaZWzjjICxBOVZr/5
         NsqNnx8kZGZ2EEIvO32zNO/qHoIsSBm2GubPdBaQD2H4uWCdRHll/zdJp3YkeVOu9Q0q
         1+aAup92Ocwa/SVIiBjUF1XYaG1Qk+d1dmJY17qV7rCFLdWiiIsnIk/4YORfKRVoJr/A
         aU5Q==
X-Gm-Message-State: AOJu0YyuvVwJNCEz5oj9YxTDdVvyxzPRc+JvwYx5FSyweQ4JGsZVRNvT
	QHnFgibeanAcuByYtRSPbErUjsOAQsf4lAem+RoAANiL/WUHyz4LHMwTiNeTWP8=
X-Gm-Gg: ASbGncvirqKTpMjUy3EtkI2vEN1n89JKQjrnaqI1qhuvs1xDn3vXFgBed3mSEQIbK0W
	iSuInSUbsdA360PRxkbTZb4o48nSdf1d7DYlpBWThO79U3R9wSlch1BOnkaE0A1PMVckcBDttSp
	c5zZ+Gb+XqVZwOaVg07E38cOB20YwzayBoST5PQaAx29igZ9SY834G7iXfuAqXAYbIIGa5V5noE
	dIyixcRrTti2H9dfFwU5sSWhFzn2dZ8nZZf8jfWtDRgLVccJOtQnIigX9JZZPPNguSO2vnpX51e
	9l/Z9EfDCgqWAQ5KjcH9Zb8IBKe1gS2hiqPPREppT4ZUBzgZ7Sw99f96Iv+T3CPp72JO7HxsA/+
	Q9Q==
X-Google-Smtp-Source: AGHT+IFW3sJW2HhCyfxF0bC9QfyBOErESs+YkPbYzF2sh/+Qh46fh3W+2hKXOVfaB9l3NbKz0+R/6Q==
X-Received: by 2002:a05:6e02:1f85:b0:3cf:b08e:7e91 with SMTP id e9e14a558f8ab-3cfb08e7f5bmr184182345ab.13.1737988149124;
        Mon, 27 Jan 2025 06:29:09 -0800 (PST)
Received: from 95d5ae3229ef.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc744be43sm26228645ab.33.2025.01.27.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:29:08 -0800 (PST)
From: eric.meyers15310@gmail.com
X-Google-Original-From: eric.meyers@arthrex.com
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>
Subject: [PATCH 3/3] tests/fetch: Switch to working npm registry for registry_alternate test
Date: Mon, 27 Jan 2025 14:29:18 +0000
Message-Id: <20250127142918.163-4-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250127142918.163-1-eric.meyers@arthrex.com>
References: <20250127142918.163-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 14:29:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17099

From: Eric Meyers <eric.meyers@arthrex.com>

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d64717011..42caad655 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2772,7 +2772,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        urls = ['npm://skimdb.npmjs.com;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.yarnpkg.com;package=@savoirfairelinux/node-server-example;version=1.0.0']
         fetcher = bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)

