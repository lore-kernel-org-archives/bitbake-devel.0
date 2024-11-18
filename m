Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE1D49207
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 16:26:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.46125.1731947185460930183
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 08:26:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=evcuugzT;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431688d5127so36148335e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947184; x=1732551984; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKQ7TEFxdmLZIfm7dYxy7iOCt3zrTkqc/jTwHHn0iKg=;
        b=evcuugzTQvaaZK8PD5OV4r/d0KX+hhei6Sqp6uG0cQRuNyTOjXjpOW99dCHvOmd9rq
         NTtclPlIfQakWHrafb/R4APhcEkQetk0FLDd+d6oXx33AyLxZSDIfNZlFNWJeETH3FzK
         bDl80bSSb/RE0c8fX9yMTxU01ApLsFvBrrKePSuPCqFtLowlQUyIq0FY3Azlf25aYLts
         SZqK0afXa7UuFozFUSlJBR1wv5puEq4qkpegXu7ngDWKirlR/Xzhbi4mhCHy1TnuDqbh
         OlG4u19GWxVLI/KkcnpqYntI1ATAArNXjjX/pItYC39Xb3x+HnHrzyN5JJ1a+fWpc+SB
         pcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947184; x=1732551984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKQ7TEFxdmLZIfm7dYxy7iOCt3zrTkqc/jTwHHn0iKg=;
        b=k7QNyK+jCfrmvOhDSkieabhOrVTYGZiTGMy9NGAvwgPfeyaoIi/9au4vMe1A3ultjW
         LsTts9oIrEGG+lTqeWS3aWRuycqC7oo2ddiXzjOFWECklb6jhZjiTIm9HD/QdGe7+KTj
         xGxFVCrvCbIcQzDpHKVQSr6OAP68AhYs4X1oAB780zz7WvqnbkkbwZ0C3nbDGevsvczK
         KGXbVNrRNKIqZohDy9OmYwOvxalgKfdZ2hpJcOGlknWoPwKGGdfmoWGMIHLkfMmxJd9R
         K1Cki1AZ55EGeoiZFKTXOW57tW7l+FCls14QOWV2Ruu0knpPegs+jRLCItmS6PDvkdVZ
         ydYQ==
X-Gm-Message-State: AOJu0YzUuX1TKJ+au/F0j1aeWBQocS2JhpmMuIO+cY2Of5Fm1HoBg7Or
	nLzkPvyNpG4p/lCU8G4B497D0ejZUwN6s/tV8+PmoCdimsZxV530z28QHA==
X-Google-Smtp-Source: AGHT+IE6qRFWhGClKMEXdN5FsE7ONrMBsaMvf7dkTaFZXCQyepGEin93DQAESPirZyHfxOjHCTTCTg==
X-Received: by 2002:a05:600c:4e8b:b0:431:4f29:4a98 with SMTP id 5b1f17b1804b1-432df77c605mr104060635e9.20.1731947183682;
        Mon, 18 Nov 2024 08:26:23 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48c731dsm109341455e9.2.2024.11.18.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:26:23 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v3 1/4] bitbake-layers: ensure tinfoil.shutdown() gets executed when tinfoil.prepare() fails
Date: Mon, 18 Nov 2024 17:26:07 +0100
Message-Id: <20241118162610.1423384-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 16:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16807

From: Alexander Kanavin <alex@linutronix.de>

https://git.yoctoproject.org/poky/commit/bitbake/bin/bitbake-layers?id=f6de2b033d32c0f92f19f5a4a8c4c8874a00a8f7
erroneously moved tinfoil.prepare() out of try..finally block, where
'finally' contains a tinfoil.shutdown() call.

Without the shutdown, if there is an error in tinfoil.prepare() (such as parsing errors),
the tool locks up, as seen here:
https://valkyrie.yoctoproject.org/#/builders/71/builds/431

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-layers | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index aebb5100c2c..613e675cb0d 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -59,13 +59,13 @@ def main():
     plugins = []
     tinfoil = bb.tinfoil.Tinfoil(tracking=True)
     tinfoil.logger.setLevel(logger.getEffectiveLevel())
-    if global_args.force > 1:
-        bbpaths = []
-    else:
-        tinfoil.prepare(True)
-        bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
-    
-    try: 
+    try:
+        if global_args.force > 1:
+            bbpaths = []
+        else:
+            tinfoil.prepare(True)
+            bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
+
         for path in ([topdir] + bbpaths):
             pluginpath = os.path.join(path, 'lib', 'bblayers')
             bb.utils.load_plugins(logger, plugins, pluginpath)
-- 
2.39.5


