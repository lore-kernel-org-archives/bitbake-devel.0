Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF9C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 20:45:44 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.1543.1708029938002692608
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 12:45:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J4stdlH8;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0c7e6b240so17994871fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029936; x=1708634736; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQD1Oue9DehmSDPehbfju6Ht4lk9p2ync5+rojIjjOU=;
        b=J4stdlH8k28aJpl3oNB0VsR5hlqaBAEa/5adpfp9z9mmD13jux5rc41KzR3snG0+Q6
         X5gcD5BqZQ/BNBLW+d+H+DZRlxZ6YN+wQPxfMhHu3mtKadxhtHAii/pu4zpd8b3/voO7
         dLDN2Eqj5LRzKFh8y0YYVYimIcYa0bVAYb8eeX5+AXV82AVqYIBbumv6zDzauqYaqmEi
         ptcCZ6CYJISrtiyHFG3yTskzJh49Gtgs9wOnNINV6WuCF8aXBx/s52bJl++Uny9reMGY
         8auaRfd9BDuS4z1pue4PpRf7Vb3xeWJEs2q15CtpHr8FQUWYXzo+sdDM3sR+DZck0zhy
         TUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029936; x=1708634736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQD1Oue9DehmSDPehbfju6Ht4lk9p2ync5+rojIjjOU=;
        b=bv4zbEc+07XFaXRKju028WHOJPn9sWNt+2duPRLBR3I3/TOrJW34aZm/OCh94PzPui
         y0w6Brq3/+jQwassRRvs9PjFtNwIv2Wf+hjDKVWE6ZODqaykpaKEVH43LicFzgPtvvam
         lX6qsAF//2zA95dlxXPTSniGpqVFyNsuOB5WYWUfXateq9wCCNlLzHgMZ+30K3fJdrch
         qBaEE/UY08uLTkedkHvAU8GeweBrhRB9AXxoErmssxvMoCwvsyDnqOVZD7Js524g2/oo
         MDpryM/gesGjI2GLVX3HQ2Io8w+aXrzIvXTfZHvrzQeHRdoaeTV0ZhCGuRaZIPm6AcBs
         CLeQ==
X-Gm-Message-State: AOJu0Yzw4x474g/YMIHmZ/hnN6LJ9Vmvz/daMGJkhj3/GAiwbGzNfuoK
	jQ5Ql+Cd5ssO5DckLzP1qb/BfpswQbBpn+X/vQtRSdy88xS81EotUL409WUX
X-Google-Smtp-Source: AGHT+IFiT79jACX4A69GjBlZpHwHzz9ezfokQrc3f6Kg/TUo/UqISXIsQILq8144puppoccFZUY2ow==
X-Received: by 2002:a05:651c:1033:b0:2d0:8ecb:c431 with SMTP id w19-20020a05651c103300b002d08ecbc431mr1838869ljm.2.1708029935648;
        Thu, 15 Feb 2024 12:45:35 -0800 (PST)
Received: from wsadrian16.fritz.box ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id er17-20020a056402449100b0056058f2603asm883058edb.3.2024.02.15.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:45:35 -0800 (PST)
From: Adrian Freihofer <adrian.freihofer@gmail.com>
X-Google-Original-From: Adrian Freihofer <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [2.0][kirkstone][PATCH 0/3] pick python 3.12 fixes
Date: Thu, 15 Feb 2024 21:44:49 +0100
Message-ID: <20240215204524.320874-1-adrian.freihofer@siemens.com>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 20:45:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15900

These 3 patches are fast forward cherry picked from master branch.
They fix some oe-selftests on Fedora 39 with Python 3.12.

git cherry-pick 5419a8473d6d4cd1d01537de68ad8d72cf5be0b2
git cherry-pick de8ba2770d9a1a94af3d084f9540da7e2fae6022
git cherry-pick a5f1bc69ef2e456bd163303a07cfb73825b01576

More fixes are needed and will be sent to oe-core.

Adrian Freihofer (1):
  bitbake/lib/bs4/tests/test_tree.py: python 3.12 regex

Alexander Kanavin (1):
  bitbake/codeparser.py: address ast module deprecations in py 3.12

Chris Laplante (1):
  codeparser: replace deprecated ast.Str and 's'

 lib/bb/codeparser.py       | 24 ++++++++++++------------
 lib/bs4/tests/test_tree.py |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.43.1


