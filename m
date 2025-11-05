Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959ECCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 23:27:50 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2580.1762385262366860974
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 15:27:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=oU/twgxZ;
 spf=pass (domain: smile.fr, ip: 209.85.221.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so223813f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762385260; x=1762990060; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/3xRkzlnFSArUplThiRA/xp6DMYuc5rwUuyGP+BpIM=;
        b=oU/twgxZ4UcqYaHfo35pVLK0/1OCsD7lQQiH8mlYBeSE314paCWirwayQ8ntSGpC8V
         EpLlseeoxTM0GVRvmZ5zMR+qOkE/SOnZCmdHU+PwgODV8pemoAFvGo6HLJ0rxZ2GEbbI
         qCNhuz/+Q+Dw5UQwwkdEIfjRx72kFR9JZksTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385260; x=1762990060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/3xRkzlnFSArUplThiRA/xp6DMYuc5rwUuyGP+BpIM=;
        b=a5pHlVp0H9zAegWg4skF7g2GgoLGAOL8GFCu4KpvpeK8hifGJoAUEmOe+/FPrU2Tkb
         9H3OSKgEKDRM6XUMgt0VmrfCUSMVJ2QTskj5N62TtcP/70H57EvWezDkQkmePIDsQ74I
         4siwsYPtAwpQ4HNhX/hzMvOTVjLgPGYOg5o1RzQ6BHb+OAHubAENtv5CziWjtMmQFgvz
         JZPXrv4M652NfzduDf5l53vCZclziWGIYg/JsRzfnclQFS5oc8cG2fPIXMDBEwSF+5cx
         uXIQiOPbQkh+RO7Z/UiqIIe0S55nfio0VNGB3KskfWmKO1y7FPtbnqu7pGO5ABmKZhV4
         vu+g==
X-Gm-Message-State: AOJu0YxQs5h1N0eXj0jLQHqA4vvzO+1KYUTI0ah5FwagftX5/lEA1+yl
	7Tg9LftXHzDNLU0sTudkJ6lzV9MoU0BNX8IILDC3T1wI13mS73aXd4NCE7fFDPW9tcVT+zgUgtt
	LzMhciuo=
X-Gm-Gg: ASbGncsKsE8Rc7MEb2i7xwXr+sxFMIa4ouzEFk/k1sQ7EER0DilyU0JpbQB4omthGqf
	tAeieSwJa7OTgJi1xXJaT/dmlMuY2eVf0z1j0FO8trYZG0DM40eoAkVgzpp8eS9vVbCyvZkhrZ8
	rbfJxVzhsvK2fziMWXRlcn8k7xUhZJEUDmmon/bNQxqdNEaHijnlEJALme+8AS9ezEQQ2Gm33GP
	lI9ildHnP07yYMSIfUExv1+L53JvqYO1ozkHeTpiOPt1P2yMWxXC4KmIIZxWmdiZxO5DNXZL+UO
	ptwbSd8K4/J1dfzcq4tKljb1uxn9tzP6mPIOY+TeaQ0lWAVusZH5LGKQmuXuaKuxZc+Ym01PvHP
	P5EKTBdB6/x/VWplKqUOVuSIoSV9AmQ2SAmCnmGvMjg+ryhdKX/mpgiZ5MKqHR/QH/7TroTqOBV
	OU9TS0nhFthqgGuNNLJUCv50T59DClKT1hda29J5ZsusokVzaZ7/GAc1vXMyF2jQsZp2TeCQhhK
	uWQiN/SVH8=
X-Google-Smtp-Source: AGHT+IGwh3uAlWLJ7yc2Fm7oHtCjbAsbLrcW67+VuYZXBp2kDa7afQGbUvhD1tR9+x3syev6BUleQQ==
X-Received: by 2002:a05:6000:290b:b0:427:492:79e5 with SMTP id ffacd0b85a97d-429e32e45fcmr3283058f8f.21.1762385260335;
        Wed, 05 Nov 2025 15:27:40 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49baaasm1381734f8f.38.2025.11.05.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:27:40 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yocto Docs ML <docs@lists.yoctoproject.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [master-next][PATCH] bitbake-user-manual-environment-setup: Document "{THISDIR}" in bb-layers
Date: Thu,  6 Nov 2025 00:27:18 +0100
Message-Id: <20251105232718.2801446-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 23:27:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18276

From: Yoann Congal <yoann.congal@smile.fr>

A "bb-layers" element can either:
* start with "{THISDIR}/meta-xxx", then "meta-xxx" is found relative to
  the configuration file,
* or not, the layer is found where bitbake-setup has cloned
  the layer from the "sources" list (usually a layers/ directory)

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Cc: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst                  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ad8143711..d9b7492b9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -593,6 +593,9 @@ These files are written in the JSON file format and are stored in a
       variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
 
    -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf`` file.
+      If the path starts by ``{THISDIR}/``, it will be relative to the directory
+      containing the configuration file. If not, it will be relative to the
+      directory used by ``bitbake-setup`` to store the sources.
       This cannot be used in conjunction with the ``oe-template`` option.
 
    -  ``oe-template`` (*optional*, OpenEmbedded specific): OpenEmbedded template

