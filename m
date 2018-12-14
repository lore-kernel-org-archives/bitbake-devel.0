Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 967DB6B06A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 14:02:22 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id s12so5107005wrt.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=GG5p0L1OxoSSVvdQHeDYT+sGg0EBqOLkJ4BziKRUVj0=;
	b=ceWEgmfF4s6/h8kld/JxQVFlTbCwAnN6SHKrdrnrTNEvOm+mXW7mzRVJWX+oC6Hy46
	SPmEzEJuqtMtYEI4JYNjhcfoXS1O6gTQd8IUCzhyjAwdGthfeZaICEJuQIMpXaMmLRsv
	LUTkR7tV7fp1sRL5zNr8KngVxpH/zrN/Dg214=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GG5p0L1OxoSSVvdQHeDYT+sGg0EBqOLkJ4BziKRUVj0=;
	b=rWtl+T54Fgp4g1XDbpglyW0Ov1axnr5XOJVu9wPAyyPXWsW7+NzPXJlOCCNTgA+Gr4
	dAzofnA69/lzbK9hNbcBh9OfgFmJn5D5BVQAyqVHDK+Kfeq4x0JbTdl4h6iTw9PVFYOD
	ZFMYCTO/ot1zQMTRE83GI+YEbcSDLTntayrtPo0SEG0z2MrkxKvPpsLyRvTjUo/PKmfN
	mbeY5gDG5HyP1MTMHK0/s2rkj43UJ7pQmQT9BIw2wDcF4ORViyxbERJaL4XMj0/vq+jD
	1rKh/s3c4b7CpbtkDUW1jq7OmLaw71qMBkYJzwhbZPQZIRmkeJoQZSykKiTUdKjTWw74
	4EkQ==
X-Gm-Message-State: AA+aEWZ57dcmSX1mGl62Jhn6C4TgFpCR5YRiFgj0FSeaAJEV8hJOt1Rp
	Wwh84zwND9dqYr44e4/J65EDU9MPsYhQwQ==
X-Google-Smtp-Source: AFSGD/U6an8JDtnfowd8cFOYph2DrYEz/+IDdA80qJyH2C9IrD/nmg5YaWX3a2ZniquPdGrdPjoR1Q==
X-Received: by 2002:adf:9542:: with SMTP id 60mr2657889wrs.60.1544796142607;
	Fri, 14 Dec 2018 06:02:22 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y13sm5859489wrw.85.2018.12.14.06.02.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Dec 2018 06:02:21 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Dec 2018 14:02:18 +0000
Message-Id: <20181214140219.1553-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/3] data_smart: Allow numeric characters in overrides
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
X-List-Received-Date: Fri, 14 Dec 2018 14:02:22 -0000
Content-Transfer-Encoding: 8bit

We're seeing problems due to the way x86-64 is handled (or not handled)
as an override. Relax the containts on overrides from being lowercase
to being lowercase or numeric. This fixes problem where MACHINE=qemux86
would work but MACHINE=qemux86-64 would fail the same tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 297a2f45b4..c342adaa0a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -43,6 +43,7 @@ __setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>_append|_prepend|_remo
 __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 __whitespace_split__ = re.compile(r'(\s)')
+__override_regexp__ = re.compile(r'[a-z0-9]+')
 
 def infer_caller_details(loginfo, parent = False, varval = True):
     """Save the caller the trouble of specifying everything."""
@@ -597,7 +598,7 @@ class DataSmart(MutableMapping):
         # aka pay the cookie monster
         override = var[var.rfind('_')+1:]
         shortvar = var[:var.rfind('_')]
-        while override and override.islower():
+        while override and __override_regexp__.match(override):
             if shortvar not in self.overridedata:
                 self.overridedata[shortvar] = []
             if [var, override] not in self.overridedata[shortvar]:
-- 
2.19.1


