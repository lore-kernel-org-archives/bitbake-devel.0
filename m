Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F425CCD1A4
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 23:15:25 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.5846.1760742916103866704
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 16:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=odZ/Kqu5;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so1204196f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760742914; x=1761347714; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4f64taTCnqYbk0xZ/wJQIk0mSDXHE0GorZR1F6XCRA=;
        b=odZ/Kqu54jQAgx9SZ+SpeqzLjJ1y1bicJb7P7oO2l3ZoAW15YuAM+SN3xyVV/y0mvo
         bJJCLgxsXXH9f3q6mQm+sHoxViJVcjUjUTR5TfYNcxy2RENMhJaP9wU+eMo3ZZb6Vry9
         agoNDdPjZ7vovnD2mWOCQ2NnUda1eOVVesxE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742914; x=1761347714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4f64taTCnqYbk0xZ/wJQIk0mSDXHE0GorZR1F6XCRA=;
        b=w4Nz5opm78HgSY6FiXjQ0e/RpFXsEs4zvuwKu5W1xbTQ+VhJcfHBS7o2xPANZujWu4
         g/AKTOtiYhtyYZZEdC06dasMQkCzB7yQNgLKwljpzEKM6jZ5dCgdpd51Zk3dW+l+lefY
         7lhP48GlmuS5eQNHoezxAiVFD8+rdfzhIYdPdkeThtT6EDRcdp3qiOhr9tAuV+uhNMj1
         L63Hsxmy9JbIQpAeXSdSNAWBHLnXaJmcMPrLBfy8XNRm73IGqabR9vaSJB0kArGk/wi/
         O39YbfDTzpd3ErOz4e61xjTnPCg2bM8Xr7fbFrhKOV4y2NLdgk/8TOdq+r6j8fwXKjVi
         mlxg==
X-Gm-Message-State: AOJu0YxDpJNBsUJ1MH9aj/quzoHP5q+B6ec7f07JVHIm+JUBGF8LpX3e
	qCDRqbf/LmkU9IEFMIwIHHWJdBzGPNC51z9h32bedInuqIiB/2Wrd44ckeZCIAS7ox6ubEGHea2
	qkdvjdvM=
X-Gm-Gg: ASbGnctokbhkHP6LEN6zEadWh7iq1OppAFidjIzCfnIsEDukk1YxmQWUIQtgijw0HJH
	sXmuxtG1Dzi3XDVS3qG65vDZYiI1kjYem8DwOijSGkPhG/c8nw8/6+0ejWWbr0NJYuZigpKdWXU
	LNsNf8uC7rdd1ho6clTDHPfk/1jf9QNRLE4l6cEM8xaTmwiyH7H+JLp+FgknuKQNjnXSlKgIdZJ
	yoqZT6SRuyflKS4bOlolgFL+8Ol8GzhRjqPe0pKCo94DxCF2w3OF4DqXbckn5kZUAiZ56q4zhT8
	uOMoPGSkH8XiBTk8xNCV71G7ENd2dXmIUFJShFfO+kKysNqGTG3I9NTtuzaCDKfoiPD7tTaekNF
	bi4vmMcE/12YA7qjc6FKFXM+H37m0QgzkQbtQKR586df5XBYJIUwxPxMa1eyG4nbmh/4jozElcw
	/B4L7UqnOQ+KaY2kZlC6PyNH81viQySVeZJTTtVNu2ybfaq0CiZ24OzAjWzpMuIt0YNmU9ZixBI
	i/uND+0b67w
X-Google-Smtp-Source: AGHT+IH6hJceMjANlWtnNp93lG/MfR2P/2GDX2pByhSNJOMSk+bogJ0UpCbpDGA74ydtqZxcnjIhxQ==
X-Received: by 2002:a05:6000:4606:b0:427:608:c64d with SMTP id ffacd0b85a97d-4270608c806mr3086006f8f.37.1760742914094;
        Fri, 17 Oct 2025 16:15:14 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm1638330f8f.19.2025.10.17.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:15:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH 0/5] Bitbake-setup configuration schema
Date: Sat, 18 Oct 2025 01:14:39 +0200
Message-Id: <20251017231444.374436-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 23:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18186

This series focuses on adding a JSON-schema for the bitbake-setup
configuration format. I still have some doubt about how strict I should
make the schema (hence this RFC).

Also I tested by adding a validation step to the bitbake-setup
selftest but it has non-stdlib dependcies (also a RFC about how to
handle that).

Regards,

Yoann Congal (5):
  schemas: import layers.schema.json from OE-Core
  schemas: add $schema specification to the layers schema
  schemas: Add bitbake-setup JSON schema
  bitbake-setup: Add an option to validate the schema
  lib/bb/tests/setup.py: validate JSON schema during tests

 bin/bitbake-setup                 |  41 ++++++++++++
 lib/bb/tests/setup.py             |   2 +-
 schemas/bitbake-setup.schema.json | 108 ++++++++++++++++++++++++++++++
 schemas/layers.schema.json        |  77 +++++++++++++++++++++
 4 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 schemas/bitbake-setup.schema.json
 create mode 100644 schemas/layers.schema.json


