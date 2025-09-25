Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2718CAC5A7
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 14:36:50 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.13473.1758811010039049893
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Sep 2025 07:36:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=FgRNzhm0;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.173, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27ee55fa1c0so4043715ad.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1758811009; x=1759415809; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5F7J3zyeTWE1FbsJkwmyzpHjBVnBX63QHSP/H+cQAk=;
        b=FgRNzhm0nAbwgrYTfdkKKu+AKzCtQFHvzfH6MvofcZGp7/kACGW/MLpYxBQzARNzls
         tUbaHYlE4PIP1RzY4cPQ3AgJa71aVPcgjO+oeFkFgV5rT+SEXTu4vZzFr02dA9UnG0ff
         hBMgqIjEl3nhukC7Pf8CH1pZy54DgmGplpTQKLB1C4e9Xqv1oSMlZLh7FWYES64YhmnN
         ohCdGIq9rbYAlsMKYWYQ//xj7B9EYG7Ujp7rm48dl+JbbAOInOkf6SrkPY8nh+Q/Blwr
         XuFnObB4QAHEXFx/ntHR7+1w45rOCSVYijzsj7RmVN1S76zuz+9ntPZIdGN69iwJtfb8
         p2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758811009; x=1759415809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5F7J3zyeTWE1FbsJkwmyzpHjBVnBX63QHSP/H+cQAk=;
        b=cVGGpo8RNkdG65kYoZzDuKKVWqVc6ZqJizGAvokUfala+pm+zqemcj2TEckSZFq6nu
         jTcYLggCSGQkNwV4/BroZiocpF0/c5lYqwVzYCLMADk5ou9l95+HO8tr8T6rIJNNd+7z
         TQpvCT1cc6SYl3sN51v/sZgjz5xMl0hd4ks9iSdgI/FfbuEUPk+gOe4Oa5r/Yn/fAr5o
         /AhZVWD+pqlHLXIeC1eB87uweLfwYIKfnErMuCLXMM53h+6zaLtS5J7RysN8gCkSuK+d
         6CmLyeSgkSEA5w/yDKaOBDiAKM662o8hSZFgcN9H+eZv2GRm28kS1Dz54P2bxqaRbbYu
         UCJw==
X-Gm-Message-State: AOJu0YzIBzXH1H45iCiJf0lMtDY66tJpW/NQOEHl9EMglMnYJCOhJsU+
	SjZy+KSpwqd4/1rk92P9IgYeL/oHL4tygGXAM93R3Q/zjc5BqnbYwrrEYbPJ5QGgGx/w4jSfXPq
	lsMxt
X-Gm-Gg: ASbGncvqF+pJFg8c0bZKtv1pif8+lrnCnaDTs3ZOMmgpXGr5JeYyhTRKOqpZebalimV
	bV+8cqTMnTOcfYk/rZOLydbFzuXtozbsIijREsHmnlGzT6HT58zrtZWLXDLrzHwF6x3rTH8M3/U
	FFzLOr0KT4Je8WnRP41GsU+G7kj1aHmxwRAPQP86a9mYhjYqkE+sXRciSdcpVewhTF6T3Bz4A1k
	EuzOCkkjMCPqRaY703ZNSQnSS400sSHWdD6sumiKHQhl0gAJgZ4bzcDOwP2yqcq4I7ZO7QKOpIU
	Xd4QtglyIzH953+HJn0TSVJyzAuxCzFm3d4GYqgDoQB1uClfyUxvo6jZZBTdi3cBbYLMvXDnjsQ
	gDPSqNQrW+7OJfg==
X-Google-Smtp-Source: AGHT+IGbL6yNzSbCITLg3rO/UPcgY5UOXJeirKx6/zeBub+vr1+jWGZ1QeUP6MOC/xivjY0Au1wKeg==
X-Received: by 2002:a17:903:3845:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-27ed722bb71mr34041785ad.18.1758811008504;
        Thu, 25 Sep 2025 07:36:48 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:127b:348d:dc99:9937])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a98b9sm26114015ad.111.2025.09.25.07.36.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:36:48 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
Date: Thu, 25 Sep 2025 07:36:38 -0700
Message-ID: <cover.1758810898.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 14:36:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18094

The following changes since commit 1c9ec1ffde75809de34c10d3ec2b40d84d258cb4:

  bitbake: Bump version to 2.8.1 (2025-09-17 23:22:33 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Bin Lan (1):
  bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()

 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


