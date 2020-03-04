Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com
	[209.85.166.173])
	by mail.openembedded.org (Postfix) with ESMTP id BF2A460575
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Mar 2020 20:02:29 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id g126so2936467ilh.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Mar 2020 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OkziaePXn1ZNuirYXFCENVGhejXcPnLVTKOf5kpPmrs=;
	b=LfELrAO8ZZSiyAGZVmd52uLHhdCWvaOzGNt5JemCZ53Rf3RClycDDc4GNmU+hPJncm
	Y7vo9zzVc0AoEmWxpacSoAE6k6uKOfCH7kZ3SwuXqw2RP5YRGDO8OZbb1hsuQo+ISN3k
	41qSobleMfeqZeBIk3IK4Tz0L2CgR3TKAD00LUZH2qyDooEmGABaq2UNFW8vjVoXODnn
	xwtXz3g6k2SwAV4Mo2i+jteXdwnM4de4+Tz0gN+fzvqYJVO36AW0KRyxCPoggtAES+sH
	aRBkJ8RTlbGyaSFuPjxjgDBts6SUgT8Tw7cZ6Gw9K4h1JyPOd80KJoCQytdsBS5lMVj9
	SafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OkziaePXn1ZNuirYXFCENVGhejXcPnLVTKOf5kpPmrs=;
	b=Q73sWK9GFSPonbl8xNQZ+YIh74cX8iTc0XZljJeMnvZr+R0alEBNhA/XosR2MSlNVo
	14Ykr/QTe7ky2KDoX6fEKcsHiCu7e4WPUrL45C9y645slVGpJrRCecgpUUgPV4ehOS9+
	tV1MBsJc9G/gxqcvNRSkdLm36Q0596J/c/5twk2wX7F3+GC49bIyEH6q9t0FodjCXZox
	oFTBpVc76Mt99jNhXJtqgLk1fJK8/Cuizj/fqSO9is0CV7p72HOkIe4+1OcMHG6oZU4n
	Atl2iSoTkic3L/7eaQV/ymGkSR6mOHhoHGMd1xv8DoQsXzN8l7nwZmRkp13V9QbgcHTB
	puIw==
X-Gm-Message-State: ANhLgQ3ZeVRbuOr120OyU+LwfDcIIdWRXVI4O9uBtS9jX6JwVsucd/q9
	r6nzQmrXB7F2mFqXfeMi8BHFitFfzCI=
X-Google-Smtp-Source: ADFU+vv/nLUY+wkD0G1iA5/uBBN8wJaqZIH1W5GskjOMz6rkc4BwlplU3Joi5OLPJ+HdiIpdsh73GQ==
X-Received: by 2002:a05:6e02:e93:: with SMTP id
	t19mr4643558ilj.286.1583352150489; 
	Wed, 04 Mar 2020 12:02:30 -0800 (PST)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j4sm7310626ilf.21.2020.03.04.12.02.29
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Mar 2020 12:02:29 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Mar 2020 14:02:23 -0600
Message-Id: <20200304200226.23771-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304200226.23771-1-JPEWhacker@gmail.com>
References: <20200304200226.23771-1-JPEWhacker@gmail.com>
Subject: [PATCH 1/4] bitbake: command: Add mc parameter to findProviders command
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
X-List-Received-Date: Wed, 04 Mar 2020 20:02:29 -0000

Adds a multiconfig selection parameter to the findProviders command.
This allows a client to find the providers for a specific multiconfig
instead of the base configuration.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/command.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index c8e1352865..b38c151b3d 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -414,7 +414,11 @@ class CommandsSync:
     getAllAppends.readonly = True
 
     def findProviders(self, command, params):
-        return command.cooker.findProviders()
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.findProviders(mc)
     findProviders.readonly = True
 
     def findBestProvider(self, command, params):
-- 
2.17.1


