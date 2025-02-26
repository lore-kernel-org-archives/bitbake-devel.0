Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C90C021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 12:47:20 +0000 (UTC)
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
 by mx.groups.io with SMTP id smtpd.web10.4928.1740574039052807354
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 04:47:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KCB+9ufo;
 spf=pass (domain: gmail.com, ip: 209.85.222.193, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7c0848d475cso917670885a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 04:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740574038; x=1741178838; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzVRc5h3oVrGGcP1BdM/2camwFuYzClT3WdW845ow1E=;
        b=KCB+9ufoLwqgZhs5mdBIr6mzgMrNrRbegD73+jnHduvYzhU2185lXDTp7zFvSUv++p
         Zp9PrE7A06cdU6v+ehUw/+tch+U5fXv23+lUi5GWv3UIBRxfvZ/DclxPKGGn5rkVEfT+
         jNsQupkT6qm+QXrm/KcaOVyzL7g1WPW0WyXiyILEaLMDVNGlTTZlSl5gnGMlwzl0NaZi
         Sa5b8zGw2fphlCquP//p405nET36EBX7FVQlY2JFGFWUcn8xBaK3DMPf/QEjh/RQcfXN
         recXW8dEx6lrSlwoFyd5dHjMvPlQPNZVGp7i6ePzmV6a8MWdXz47fs8ddzC/cH+R6ptB
         GD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574038; x=1741178838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzVRc5h3oVrGGcP1BdM/2camwFuYzClT3WdW845ow1E=;
        b=Y/X5J7DzTyxnTYrzOrxGjaZ2MjIZvn2tyxVBv8PnRgrc+5dcBwRNWU+hKk87s+qD4e
         YioD/DFUAq9DQ88DnR8KGy8GRk1RuvqxnmGzODZ+O0cPvu/zHk33HJE7TtD+IL2OATb9
         21g/FuPFsKhcU20qIhThIBzSdmfPjxAvyEoEPjD+Ct+eiSR4RF/kqQUJNe2EIDTTvs9f
         QVYTv1VVtfAEG3ThwZ1BWAdbPpZ3XJU9teWbQfTEcVhmfmuMACLxlJqkoMlsiOHRrLLp
         UPzOUbPXXc923PN69DnGlbBGfvsMProRDMXnTSST/A0SE1olK3VjyVuZnrtQLxcBmAOC
         FLrA==
X-Gm-Message-State: AOJu0YxPS/Ohd/jsN2Vwd/K6dwR/tJn+H0a8qVDnpKBkRapsLlw7CLP8
	fcbZEImbNaSELBUX+n8xad1MAIXFUZQoQDbg8h2i/sM1N6Kt1lvoOIvBwXg8
X-Gm-Gg: ASbGncu1jz9m642TvUq6YENUdsNTeMp8D8htlkRu2Bp+SKUM8JHljyfQF425+SU6Hdd
	Ku3XeoLfvrBzMNyietayD54sfJyRNvPozZJe4QDxxtWzOpMagQO15PqtYX5FEwSSeTc4Lg7rXr5
	eJFHLWVf6rE4VN1TFrASDrXORn9rsNkNsvBhT6/DNOFAeBNuw0bRsdlaTp5ZPXilkFwqUUYtKH7
	2FSpqUPjWx77cWIlELrFnHV1aIWePHQKShzt95wkBcl+qjTqtpXCsLUx7LxD4UURc+s4auwSwH0
	Vq1an1sfZF0Res3TL0Gtq0CQ9aaGdJDGwpjHT5OV/oaBXJ47mij+/WhYUDJZwBdfXU/TF4Ky21o
	vgd0E9fYhP32wULhNkR4xwxE=
X-Google-Smtp-Source: AGHT+IG5nL+mtVyjoQE1EkAEeEeRYGjJGAlwtyEvwtr8LQhXWBCu6actbJ4H+AOE/O+tVSGTQ3pfSg==
X-Received: by 2002:a05:620a:9370:b0:7c2:40e3:546a with SMTP id af79cd13be357-7c240e35490mr687810585a.9.1740574037938;
        Wed, 26 Feb 2025 04:47:17 -0800 (PST)
Received: from d6f1eae97500.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c29a8eesm236960585a.21.2025.02.26.04.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:47:17 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>
Subject: [PATCH v3 0/1] NPM Fetcher Private Registry Authentication Support:
Date: Wed, 26 Feb 2025 12:47:19 +0000
Message-Id: <20250226124720.6462-1-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 12:47:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17328

Changes in this commit include:
- npm fetcher changes:
    - Adding support to detect .npmrc file within user's home directory, copy it over
      to the tmp npm environment, then append on any user configs passed in. This models
      similar behavior within the wget fetcher (which uses a netrc file for authi).
    - The above is ONLY done when BB_USE_HOME_NPMRC_FILE is set to 1
- This is the third revision at adding npmrc support, with the following two threads being below:
   - v1: https://lists.openembedded.org/g/bitbake-devel/topic/110839321
   - v2: https://lists.openembedded.org/g/bitbake-devel/topic/111289667

Eric Meyers (1):
  fetch2/npm: Adding npmrc support for private registry authentication

 lib/bb/fetch2/npm.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


