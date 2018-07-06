Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id CEBA778AA4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jul 2018 15:42:06 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id v71-v6so7177858itb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jul 2018 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lyrJDCfmsL2plfoAO8W98qWSaDQMhIzP8p+pBMx6DwQ=;
	b=bGUL+ujZQtf6fhPXc+fV1/IZz02etbGuAsiUSwsUyvaZtSozxvXtQqvyzcKJRzLOvQ
	JRCnk8+mIAPra094v4LpPksab5DtLICds1sxSSh6P2aJfjUX4Yad43/IB8Gs71UhD71w
	/bxCKqICa/9iUILgMhKLXmtkQc5LjtgMkLr71F+wmHI71RD3YGv+lfLPY7rjx08DQKbm
	2EEnnjcKYrMvSJPGCgM02bMB6mmy8EIOVRL07QBT6ZFw1AjpOqJDn/2cH0rXC1VFQgfc
	KSGxYWlXRQzbRfzXQHoWdo1rU8u1zBsT3E3w4eoNly/tW+TWYT0ClZHvAl/QpPhMPLra
	NDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lyrJDCfmsL2plfoAO8W98qWSaDQMhIzP8p+pBMx6DwQ=;
	b=PEzbim8sCjyugwyMAkpiAAQE2o7vQLJYB8Em0FxHsLv+o9ZJneh21+iVRHRh3AGHd/
	9irhpY3kDeKjlgjFpJHFIstACtE5ZQrY2z0HjeAoc6laBCrSYJ10rpBqfL7b5FfuLR9r
	N0YX9E57C29LtnHS4NrpcThYnm6V86fM/2ftkkCfT7Z2WTiGdqavmICRDmf5Pk2qrAGU
	HMAKG0ASRZB9vyCSzU2RJ+1tHffbRI3iiqGTro4tZ+ieDpT0G5LHXUuwk/qn3FW84JpH
	5mIep8Hk3nNBoGqEtj2cBCrIuSonFZYY7RL2k2xSbWpI9h2MBfYFKutEyYgSmyaKSDsd
	xysQ==
X-Gm-Message-State: APt69E3l/fRkyk3WQxSLOZML1UAdFBWob0rIzRSn7tF5Q8nbpi/bg1HD
	DxkauYO3I6CchGy1wb35u4/fq5cB
X-Google-Smtp-Source: AAOMgpcMCqZObgTCOpgPLk67DYtsHBE88rKkt6Z4C/wXlC8aJUv2Ix6YBNClAbyGV5rTHkonTUgiOQ==
X-Received: by 2002:a02:8c75:: with SMTP id
	j50-v6mr9022284jal.76.1530891727751; 
	Fri, 06 Jul 2018 08:42:07 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r80-v6sm1734053ita.20.2018.07.06.08.42.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 06 Jul 2018 08:42:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jul 2018 10:41:58 -0500
Message-Id: <20180706154200.28769-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706154200.28769-1-JPEWhacker@gmail.com>
References: <20180706154200.28769-1-JPEWhacker@gmail.com>
Subject: [PATCH 2/4] siggen: Delete trailing whitespace
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
X-List-Received-Date: Fri, 06 Jul 2018 15:42:06 -0000

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 5ef82d7be0e..ab228e4148e 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -347,7 +347,7 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
 
     def stampcleanmask(self, stampbase, fn, taskname, extrainfo):
         return self.stampfile(stampbase, fn, taskname, extrainfo, clean=True)
-        
+
     def invalidate_task(self, task, d, fn):
         bb.note("Tainting hash to force rebuild of task %s, %s" % (fn, task))
         bb.build.write_taint(task, d, fn)
@@ -636,7 +636,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                         if collapsed:
                             output.extend(recout)
                         else:
-                            # If a dependent hash changed, might as well print the line above and then defer to the changes in 
+                            # If a dependent hash changed, might as well print the line above and then defer to the changes in
                             # that hash since in all likelyhood, they're the same changes this task also saw.
                             output = [output[-1]] + recout
 
-- 
2.17.1


