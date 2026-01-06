Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DECDC183
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88590.1767701444446940170
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E+lNxBlG;
 spf=pass (domain: gmail.com, ip: 209.85.218.67, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b79ea617f55so185309366b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701443; x=1768306243; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq2HYK3ovBdUnncix2/oKx2HCz3tbzN+EdAxiupZnf4=;
        b=E+lNxBlGtLOjJ+hTGlTQkhfeOGnGqHm6Qv5w/4r2Kp/q3gP0eNPlThqMWQWMc1O+F9
         HyeWuYjxR1MsAHwQR/WuiKmn+HZyvmLqaV1LLokCxoQkcTwI71IIRJNmUlXxyUlb5AV0
         XeRBxVUMpTtD9ushx599ODdTwPh/jwMX9ERd8puRZgytFNIR6YSHXXr93kgyyj6DmxW3
         1kKU+pcJiNyyp3838j1aScmlNVMtBYESXyhiHfApEPC4OwIGjRwdvTRCkK5qBT7Dvbrt
         9gpjCjI1NSipi0PNLI3+y0uit4FyFDe8adKOhWqdlPnWQmcLhWZ33Tk38YM8WGu9M/A+
         sqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701443; x=1768306243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nq2HYK3ovBdUnncix2/oKx2HCz3tbzN+EdAxiupZnf4=;
        b=rR4Vd8ZSIQbHnq18y05SK68U93dXcxkyWKal0sLXujTnUhHz1cyWdj7Hmvj/y7n7D+
         WkjJRCeOpN+8gWyPPGrofNOz1gFveDOa6B7mFONETAwawTIjFglKAkKykuqhqy5GC4B9
         a+qygP9+20dnQbGs9FPRM2Kz5LObMt/2UZK3F2K59ZKz8BMWdxy4r84o+j5RFns+ar4e
         iMLWClRthSI/4bYnH0Ez32krck9R7PuVslWfzrrDXDhTW4yTI1bBD3kyiIN8reoIvdum
         1RccMNXTHUhZW2qQGVL60Ki2eJNrAkCNyegITZ5X2MrEOTfy2mCEVN2iXEyBLtHraz5c
         F14g==
X-Gm-Message-State: AOJu0YybeUR9nRn+EKYBfwt8h+rxlcy3MgxS2JSsyyqyG+nKw8cdc0GL
	dRn317fEpGsqpgN2P5UZoQhpiuLYi1YD1JzDpi+dm/Due+ycKhY4G34zJKc3IZXK
X-Gm-Gg: AY/fxX6kbH5ukBR7yGhSInR+dMxX+Av91/6Kk3iICSaU3Dw4d8puOsfgPY7Uyv3knMP
	SSD2hbx70YEGYGHKK/1mZIOCVdrUbn0d0q5bNaRFEybX5sa2HKhTqyAHVQUUkW6knWMrg0oo0vp
	1oCjurMebujLSfm+eUmfJRAvrFL71VY3B5PohWmodPNr+jxNmMI49Wjmc5FyxAh2qOb6AAhK+qS
	9DbkoQePmwBjXA7ncVttkqzcLWBuoF2XDB7GdxdnLLbZAuMgogmWIcPSBZ6hrnQYp21yFgHHcMb
	UWIcnFutQYDNrMWEkXo08n/3RvsRBvRpNtvQJion5q7BHTI5l0Vs9pxstO5bf1m5p9iUoaa+1kb
	FroaShVd1FtsqPmoqTyDpHzsCIXiP291m08Qc6GON0kVaxYAlVMZ9vYWHBZOU+fL052QdZ7b6QB
	RQJevmA1ATzwDe94CH1FMXb3Sk00Kdm87eOIL9+099pNHz6F+hzH8yA+lkCQ==
X-Google-Smtp-Source: AGHT+IHwl7arRnDGmS+jv/9FYqdm/9diIV7IAnT4dzc60Jlwy03imhB9Dka/7avZgPD+rx1LyobrFQ==
X-Received: by 2002:a17:906:c101:b0:b77:1b03:66a1 with SMTP id a640c23a62f3a-b8426bc2947mr286645966b.41.1767701442619;
        Tue, 06 Jan 2026 04:10:42 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:42 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 09/10] doc: document fixed revisions override in bitbake-setup manual
Date: Tue,  6 Jan 2026 13:10:31 +0100
Message-ID: <20260106121033.3892596-9-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18699

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
v2: address feedback by Antonin
---
 .../bitbake-user-manual-environment-setup.rst | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..fcffab812 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -938,3 +938,51 @@ Here is an example file that overrides the branch of the BitBake repository to
 -  The ``sources`` section contains the same options as the ``sources`` option
    of a :term:`Generic Configuration` file. See the
    :ref:`ref-bbsetup-section-config-reference` section for more information.
+
+.. _ref-bbsetup-fixed-revisions:
+
+Fixed source revisions
+======================
+
+:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
+Bitbake-setup will make sure the actual revision will match the tag or branch when performing
+initializations or updates, and will capture the revisions in a :ref:`_ref-bbsetup-source-overrides`
+file.
+
+This file is named ``sources-fixed-revisions.json`` and is available in ``layers/``
+under the :term:`Setup` directory (as well as under ``config/`` for backwards compatibility).
+It can be used to keep record of what was checked out when using configurations that do not
+specify exact revisions.
+
+Also, as it is an override file, it can be combined with the original configurations
+to initialize a setup in a reproducible way that guarantees an exact, never-changing
+set of revisions, by using the ``--source-overrides`` option of the
+:ref:`ref-bbsetup-command-init` command.
+
+For example if the original configuration had specified only a master branch
+for a source::
+
+     "bitbake": {
+         "git-remote": {
+             "remotes": {
+                 "origin": {
+                     "uri": "https://git.openembedded.org/bitbake"
+                 }
+             },
+             "branch": "master",
+             "rev": "master"
+     }
+
+
+the override will contain the exact revisions::
+
+     "bitbake": {
+         "git-remote": {
+             "remotes": {
+                 "origin": {
+                     "uri": "https://git.openembedded.org/bitbake"
+                 }
+             },
+             "branch": "master",
+             "rev": "720df1a53452983c1c832f624490e255cf389204"
+     }
-- 
2.47.3


