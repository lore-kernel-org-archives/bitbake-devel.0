Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206A9D59D88
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:08:23 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1149.1765566500897144794
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 11:08:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZYX5YHnU;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so2258998a12.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765566499; x=1766171299; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9rXQwEoZ1u3NrqA9WWWu3ZWiMiZegioRhz5eM1kfRI=;
        b=ZYX5YHnUiBZgESffLwomR24LDdo/MWFXHXyj8KuNXS5gw18ncdT/+qyapHxT48mxmG
         5THnZ5ma0+MCP4wG8uw6Of5j+vp7Obmf1nE4Av6/0N05JThSG8+uk32naE7HqKgn0+bh
         a2rGEg0b9M7SHPG8Vl7Vy5KLxUyZChQ5IvBmGqTyeIaMJUSr8lLdJgZPg6LJzk3a3ciH
         0G7Xz8z4pzwpWW4Xn0+AhIdUVyrtIbj52q6J4YPs/to/I61ASctbN1Uqv4/peJIfdJgy
         3n3x+yPzN/ia0sEcnWR40cx+7bmour/cUU5LeAhxbkbr/V5+S5PcnzuFIgFUrZ180wTG
         y4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765566499; x=1766171299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9rXQwEoZ1u3NrqA9WWWu3ZWiMiZegioRhz5eM1kfRI=;
        b=fhtx6EACj9bzFCw46vhwelqKvxx0kT5AuaLTUgoboiyFMI8D4o5kNWS48xUucpqS91
         fAERhaNyE1IEE5sLLfeOjaRYHOLMOsyDD5iFzWVCV5NNn4QOneSpNF8ouphpLScar/Gv
         ZweZUwpkm+5aTJximw3JHmsAABbP9sKSIB0QpsPwq4hWxwnzAuooX35BV7Iy9nuX1zZe
         3rNkS4KxylTANl8CXJd6cdlsTquBYCltEp8DzUMX1N33FNT5ogCfVDvT0sTUjXk7Ak/+
         890hJW24B/g5+KCZpn/aFGhPTk9nJwHZLL/NU4GtgA3rwxU/vEf4snEt9wa/wwXtnZca
         Raqg==
X-Gm-Message-State: AOJu0YxV8sRLbgGMnfbmRksPRz11Kq89RQ+M8XH7mH+5MlR68+AnINCM
	w1YRR/NJWcaLGymvUAwtdEZ4TF0f6sSSklEPpEZCXFtC3aLVsX0BHf+9DHc7hg==
X-Gm-Gg: AY/fxX4Zv2YREQcyqfhGgmCy8g+Mhmq/QgeK7akY0k+V17XuCPLCz2Xeth53x/xzMGZ
	NtW5CqEDOfscLNMD8RX8FWMEs+xahbDYhzYqF6xbs1Jv+pVZ3Ng1IbQ26Cs1VjMkJgI2AKjYqEb
	w3eHVcogBbRYaGixhmxtsve4fTH2dEOfhUe9g8MC+SxnBIjmoQ2ZLi90A3tWMrUwExiN0kByMQ7
	DsyuNXeofNtGGUEDt7LmI33J6nDd2OB8EejbIlwygdkoj8Vwj6yfw2t2lckahqcul5gTJevOpsi
	6FBvXMJTvjg1EhXYVLmtW1tytXZAxBzp17v5vTPBcoiI1oI3pvg6S0Cm8njdeZvjH5Gb7emoRuu
	IiBRrgXQHe5JeYWaxATnpCle1tWB2B7cM6sTuQPgcsR/qJYnZx4APziIXMCMgqm2BCWYHUJW00u
	QPzOGAfmytvealiRjINVH6rbEloA==
X-Google-Smtp-Source: AGHT+IEByYMGnZD0xfFlkP6FlI4zih1QjI82BXHpVZiPopHUlPQOddxe0qUG25QeJuy76GGHgn2BlA==
X-Received: by 2002:a05:6402:1474:b0:647:7a1e:f42 with SMTP id 4fb4d7f45d1cf-6499b1fa92emr3362974a12.18.1765566498919;
        Fri, 12 Dec 2025 11:08:18 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210de23sm6147003a12.28.2025.12.12.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:08:18 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 0/4] bitbake-layers: layerindex-fetch: respect --branch for already-configured layers
Date: Fri, 12 Dec 2025 20:08:02 +0100
Message-ID: <20251212190806.32476-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 19:08:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18579

[YOCTO #7852]

This patch series fixes issues with the layerindex-fetch command when --branch
is specified for layers that are already configured in bblayers.conf.

The series is organized with bug fixes first (for potential backporting),
followed by feature additions:

1. Fix undefined stderr variable (bug fix - may need backporting)
2. Fix branch detection method (bug fix)
3. Respect --branch for already-configured layers (feature)
4. Add branch check/switch for cooker layers (feature)

The main issues addressed:
- Early exit without branch verification when layer is already configured
- Cooker layers being skipped entirely, preventing branch checking
- Fragile branch detection using 'git branch' output parsing
- Undefined variable bug in error handling

Osama Abdelkader (4):
  bitbake-layers: layerindex-fetch: Fix undefined stderr variable
  bitbake-layers: layerindex-fetch: Fix branch detection method
  bitbake-layers: layerindex-fetch: Respect --branch for
    already-configured layers
  bitbake-layers: layerindex-fetch: Add branch check/switch for cooker
    layers

 bitbake/lib/bblayers/layerindex.py | 51 ++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 6 deletions(-)

-- 
2.43.0

