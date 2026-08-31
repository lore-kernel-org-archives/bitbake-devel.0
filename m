Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A7C61DE4
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 03:14:59 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21901.1788146091037682972
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Aug 2026 20:14:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DR08aZjx;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed3993c1eso144196585a.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788146090; x=1788750890; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3qld+8w/IZVgjPjWx14n99ySoyUmzgosZgtpW8SFds=;
        b=DR08aZjxIqbRpr9xsz9Whufqace/NO6/vZsgqjDa4pRrCbvpn06FZZLucwnW5Wabz/
         kPJhKWDKR0FmBfVsmohs+A8cDsQ5yUnuYaIPOSrFMaAkrhbQ1NwfKA3QNyWGIOqKr1jK
         Sajb3JAdjDKN0BMczTzKeymutVRQv69ul/cG1c5OqI39XD69U04+WJPl6CJs0IbzcELZ
         qWTXz0uZfsc+L9ItYsGj+CwiuBkslADJLeHF9pt+TYJOKzRkXABMAngwkGUjGiqDawSO
         YHCpLZaGKr3r/r/5lju8WoigBJucAzT9Ctpv52OKqoGu+BLyrzIBFd0BCCWA2womJzjM
         BtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788146090; x=1788750890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3qld+8w/IZVgjPjWx14n99ySoyUmzgosZgtpW8SFds=;
        b=PkbPx1+LXUpG/5WZ14xsd/YO3tNnj71JP9gbr0zTMDHm/n3yi5taNS6W0Mk6g1VLtR
         01RToT8RNUkifIGPO5i4EVxzUodKct+cNdQGgyHXG+5J2uB//2qG1HoBVI6Khqp92gsk
         felNrfqfhg4Gj1MlzRnWh5edFoqaHDiPWQKFdbyKvO5BCHi1lLrBZDMqN9wBUPMFJkpM
         HtwiqB0BTtsWoBUAqlUJBEJhvN5Vy4YUNTNEavadYOgfUb1jP1DC7q+XpnSXtCByYQdt
         +NCYyPkbKkGycNqLeFRXTkg8RzzsyUs7zPDy2dkI1kPyE3nRPRTDmTsyjun9GBaXvVqL
         9aRg==
X-Gm-Message-State: AFuF++nMWuFdDB52JLQrATXwoJR8K7wPGdaYGKy3EpioTEqhzIUseQnu
	SOuMHzepl58AMHn+S06vWMfLRpI9LqXTjFUF1Aqa8dAsGD3TEIjWjWfFzU9SkqGp
X-Gm-Gg: AR+sD10pS7PxAB5FizpsOlXx97+g/7HM6idFtc5Ac8sIpKFolefhWCQEOU6mP4Vq7U+
	DXlX3i7J4W7Gb99xwFKfiGpuS6hxuy3DoySLO4V1lGQeKdP5tD1uV/0334/W/cW3+YzICZrRSuf
	s3xVja+muh/Ej8+hkv5xetuNHlWUIUcLNhXUnREUXkLokIGbO2PXDEuvzh8F2LGDKvXPfLjYqWM
	kluV3ZYq7JD+foUyE/CteQEhI24NLtpfm0b3Lzst86kxx8ABQtVqOv4olKXLzEskY75n2C235Xz
	ze6HE9UhIt+/6oI/FK/1K04aRQMC6P3E+xuF4tOTGzD6fbIOgFMpC7dzgz2loaip2+kodoy66Ut
	C1u9xFmIZr7HLB+T5T8r/m8UbaOHT8lN8wm88LRGumOz8fW0/Epdt0/Q4eXtMqKRw+o1A9ctJPL
	AV9vaqLdfki2pVEux0qTbmRiDlQx6sZY9Bs9iHHKIpSPsjHbKFQJxONjbpeMoiiAAub56JtQht8
	Id7Vc/56FVwmJkNupAzx9kcX4nZhw==
X-Received: by 2002:a05:620a:3197:b0:937:2d64:57ae with SMTP id af79cd13be357-93913517ff1mr2606918085a.0.1788146089719;
        Sun, 30 Aug 2026 20:14:49 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93922e5278fsm510791785a.14.2026.08.30.20.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 20:14:48 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: document the conventions used in the manual
Date: Sun, 30 Aug 2026 23:14:44 -0400
Message-ID: <20260831031444.4070152-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 03:14:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20131

The manual uses angle brackets for placeholders and a prompt to mark a
command, and says so nowhere. A reader can only infer both.

AI-Generated: codex/claude opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 doc/conventions.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++
 doc/index.rst       |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100644 doc/conventions.rst

diff --git a/doc/conventions.rst b/doc/conventions.rst
new file mode 100644
index 000000000000..ab020113d046
--- /dev/null
+++ b/doc/conventions.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: CC-BY-SA-2.0-UK
+
+=================================
+Conventions used in this document
+=================================
+
+Placeholders
+============
+
+Text enclosed in angle brackets is a placeholder. Replace it, including the
+brackets, with a value of your own:
+
+.. code-block:: none
+
+   SRCREV:pn-<recipe> = "${AUTOREV}"
+
+Here, ``<recipe>`` stands for the name of your recipe. A placeholder is
+never text to be copied as it stands, and an example containing one will
+not work until every placeholder in it has been replaced.
+
+Commands and prompts
+====================
+
+Commands are shown with the prompt that runs them, and the prompt is not
+part of the command. Do not type it.
+
+A ``$`` introduces a command you run as your normal user:
+
+.. code-block:: console
+
+   $ bitbake core-image-minimal
+
+Where a command needs administrative privileges on your build host, it is
+shown with ``sudo`` rather than with a root prompt:
+
+.. code-block:: console
+
+   $ sudo apt install gawk
+
+A full prompt ending in ``#`` introduces a command run as ``root``, usually
+on a target machine rather than on your build host:
+
+.. code-block:: console
+
+   root@qemux86-64:~# gdb /bin/cat
+
+Within an example, a line beginning with ``#`` is a comment rather than a
+command:
+
+.. code-block:: console
+
+   # This is a comment, not a command to run as root.
+   $ bitbake core-image-minimal
diff --git a/doc/index.rst b/doc/index.rst
index 9f2a9067d385..d9547e1c723d 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -29,6 +29,8 @@ BitBake User Manual
 
 ----
 
+.. include:: /conventions.rst
+
 .. include:: <xhtml1-lat1.txt>
 
 | BitBake Community
-- 
2.50.0.173.g8b6f19ccfc3a


