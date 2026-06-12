Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F9CD98CE
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 14:43:31 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72225.1781275408602486064
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 07:43:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=QlpUOhwh;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so729936f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781275407; x=1781880207; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EuaAlwOiJAcy4ittLh2HA8/TFqvyDdmKaRjFGfA+VW4=;
        b=QlpUOhwhodtlc1hEYpnamUUktKogpuPxsPdKc3KhxIv9LbouEvlauYLpKe9XFSoYsu
         sMRtsiPikYlHx1VYFv4Sjtzf0Z5QtwvefMkrvdLXPzPU+YDl+n3VXfOOrG93d+7+e9Wg
         0VB7P39FYJ1Yb/beoejRU8uqIZDELRm6exhGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275407; x=1781880207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuaAlwOiJAcy4ittLh2HA8/TFqvyDdmKaRjFGfA+VW4=;
        b=Ot0cVsaJ7mRgoB/5FovyihZ2mLen6/wY0SAGVfNzSo5BRca0ykJpHQjH5CwY4haLed
         05DIQQlrzLRPQ9I0M56CCvXWwFbUlnIM6pR47FKEncrfozM+Oidncu5FcBnDpOMJ7jr6
         7B/mexstQ6q/FQS6hsvHn93AJH5ABi7YCBrVs7GxDas54Js9kjgDeyzUlBzQL/uuaQjO
         Vkn3Ee2qkFEeeD9+3+S0j0PXaD/7UJcJb55+JJtyy8ZqW5/r+qJENgR7BM1VYWFMqAal
         Om6ge/T91wmGo8e1nrDqouWa7FKwKvrrK8ID9+c4L7sEXhIHCnopYmn2ZmsMGdDvnjbA
         AkWg==
X-Gm-Message-State: AOJu0Yyvu6uEgAzrue4STOrHRlYCi+9M0Jw3B05mQ4Z0kzpyuMhuj1iA
	c1cubeiuYc0UA6db+8BdPcjBDmXXJZvUR9TxmidcfkEV5YKeOAcGCKhvteYUM4st/VAo+EhblRO
	GEm3e
X-Gm-Gg: Acq92OESowOhximOqbxDgEbpo3iKgt4AbO8FVdMFofYrSHWKFYtYFRp5gML+j+yHV5R
	SW8xJAr1lk/RjSaVpJjYt/mIyy4zhEOu1b+E5WHRouSzKN0Q7w4uROOWdUPY86EQO4jebuh0AD5
	NiSwH6sFc73Qfnj392fHZhigGUFK2NVUQs4wbTXQLXiKD/Os5v4du+1A4T+q8j7fYtwJMB4NnJY
	HT1O60vHcxgFMqF7BP0eJQINF1hPUvrc7wMMM4vAQsMafAdGkvUNazUTrdw8v39khr1FK+4Jh1H
	2c1sHg1oIzXq1eOJkPAooE10H4Z9z0ScUeQzwwo2qv5grGKcAbkF0mEV6CgI8DzyNIaxXtT8qma
	cOmQJIoxkbJkkih9qIPHvULvvMvSXbjmi60VrpwLB2yWaf1VGcKtmiVijIq7hwp3DMVHcQkaasq
	hoU+BpJu1a8fbsiarwtzKpXJ3kzTuC1D/uPHv75eVfjITGTgDlcWXXj1oDV1zgafSsmdkQv5NTH
	aipJkMWdV8cBq4o9QjuYXmTB0+S
X-Received: by 2002:a05:6000:607:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-4606dba77dbmr4873788f8f.31.1781275406936;
        Fri, 12 Jun 2026 07:43:26 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a71583d8af7a53fb.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a715:83d8:af7a:53fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f20e77asm6935868f8f.0.2026.06.12.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:43:26 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/8] Pull request (cover letter only)
Date: Fri, 12 Jun 2026 16:43:11 +0200
Message-ID: <cover.1781275259.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 14:43:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19680

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1781183212.git.yoann.congal@smile.fr/T/#t

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3975
* the meta-qcom warning is not related to this series and has been
  reported upstream:
  https://github.com/qualcomm-linux/meta-qcom/issues/2436

The following changes since commit 294074e65f37822a0f31bb11eb968d311b54a66a:

  toaster: use https for clones, remove cgit in links in defaults (2026-06-06 01:17:50 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

for you to fetch changes up to acfe02fa38b5da9e6a36c6cedcf91d4fcbefbfbd:

  tests/fetch: cover checkstatus redirect auth handling (2026-06-11 11:50:29 +0200)

----------------------------------------------------------------

Anders Heimer (2):
  fetch2/wget: limit auth on checkstatus redirects
  tests/fetch: cover checkstatus redirect auth handling

Anthony Squires (1):
  fetch2: reraise IOError during download

João Marcos Costa (1):
  layerindexlib: restapi.py: fix unbound variable

Marcio Henriques (1):
  bitbake: fix issue with varflag exclusion

Thomas Perrot (2):
  fetch2/crate: skip yanked versions when reading cargo index
  fetch2/crate: guard against empty version list

hongxu (1):
  fetch2: allow empty value for params while formatting URI string.

 lib/bb/data.py               |  2 +-
 lib/bb/fetch2/__init__.py    |  8 +++--
 lib/bb/fetch2/crate.py       |  7 ++--
 lib/bb/fetch2/wget.py        | 27 ++++++++++++--
 lib/bb/tests/fetch.py        | 68 ++++++++++++++++++++++++++++++++++--
 lib/layerindexlib/restapi.py |  2 +-
 6 files changed, 102 insertions(+), 12 deletions(-)


