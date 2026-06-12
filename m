Return-Path: <jeremy.rosen@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCECD8CA8
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:20 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71947.1781274550420602001
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 07:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Vf1w3bkE;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: jeremy.rosen@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4908b92904fso10721695e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781274549; x=1781879349; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=588iyXimsmSNsa2xGLe2nZ7x0pGOVFDoFPBnCZMYmmk=;
        b=Vf1w3bkE5G9hYGYfSujRg+ORj9lgaHCF/klInATzKA+EXrdmR9jP5z7/xazMPyxU8x
         rF4NMoNuAcmZxBStxOfKzgfeS7u1NKVWsbhlAt/0Qo/is/kjSG2H0YQasqbonLnS5jz5
         xgTIT+EKgus8x1LkLh1ECkjIR/PVwz5Qt3sic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274549; x=1781879349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=588iyXimsmSNsa2xGLe2nZ7x0pGOVFDoFPBnCZMYmmk=;
        b=LeIwVmA33CsEO648XGs8/QY9zvTUyFEo745fKDmTKhTjQoLI2Qsf68RYf4EnQ1lQx8
         R5IJBdIuSah9zJkCQYqZv6jrwI1SjXZ2kbkx1ESU9C5UK5dsUdqCYtYhi2AfU+eMdUsV
         zux/TxyQ8M0aH2V6jHnigpKGfvCJXY2PDH9HtXK1/jW9MpIXI3wMs2Dv787KBHkNve6I
         OMwc4Q1bNpTAlIS/J5mlvPadnx8sqndxbTwK6Pign9rdoq2xe4JHNMc2IUtyj0LDnwlM
         l8wAxEIY09nUDOQS2Dff6eT2bE6kQKSZPCP6MO4Wtj5fWbV5wjDxFYdj3RBgcv5FUDGq
         FngQ==
X-Gm-Message-State: AOJu0YxftbJ/X3xnalO8mm0yOFPsvjBBa61Q7bUC82WFjO7GPEp1Guzn
	BoIIbtBI7XwOzCCuHV06XphUio1zSNgAsLzKaxHfB83Nreq9fAcG41GrtLXH1FAyJ5cS+Cye4e0
	MQtqtDQ==
X-Gm-Gg: Acq92OFvD80MG7s141bfEgIwLfjJ/1f/Yziqib2TzbCYYFwQHsvJ8hKQzYNGpKOJZqW
	6q1U8elVFsbQKUBXYj44bGXXoIBh7CnVyrXpoMI66FjqGZ8IQAWdq+4w2x5u5lR6S17e7Hh8SQh
	JyYM6NdTwZ/Q6bxcYgNytdj3nej1TiIMtzjmHHrJbL0gDHwc7paEWHYq5qy/BPD+nc57cePbYx3
	OissrNfMD0VSxzaXzwImAmHZ3O0dYSitiviu+yiohaSBsg2t9YsUmh5kuPio7o4avZCRH6ypz2e
	J9IO6meOJrfZjgiZIeQVi2NE/HFh/rizmrnWys6OFhdPgdpVUnkrf6yl9g3p+531rptvPLpq7Qb
	yUxa6qkCmA9OefByRq5YUBbxlMrBHK+Tuk1YmJCpmTGQk/rKQ0vf9tZ5iL7o3QaUZNqcbrXjg4J
	2Quncub7+q3mhk67PlYjPRLwk=
X-Received: by 2002:a05:600c:3583:b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490ec4e74dbmr50703735e9.12.1781274548796;
        Fri, 12 Jun 2026 07:29:08 -0700 (PDT)
Received: from Logrus.lan ([2001:861:560f:240:8dd0:2c2:7492:641b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea8123e1sm74072065e9.0.2026.06.12.07.29.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:29:08 -0700 (PDT)
From: Jeremy Rosen <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Patch review
Date: Fri, 12 Jun 2026 16:28:59 +0200
Message-ID: <cover.1781271084.git.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 14:29:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19675

(Acting as LTS maintainer in training, process has been reviewed by
Yoann Congal)

Please review this set of changes for scarthgap and have comments back by 
end of day Tuesday, June 16.                                                                                                                                                                                                              

please not that patch 0001-fetch2-wget-handle-HTTP-308-Permanent-Redirect.patch 
was added to the patchset to enable backport of
0002-fetch2-wget-limit-auth-on-checkstatus-redirects.patch

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3980

The following changes since commit a4daa14312d659333984aa1ae58ddfe0c96392f1:

  hashserv: validate unihash values (2026-06-06 15:52:19 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to 0880963fea4d91a034e4a6e007d23f98658ab986:

  data: fix issue with varflag exclusion (2026-06-12 11:39:20 +0200)

----------------------------------------------------------------

Anders Heimer (2):
  fetch2/wget: limit auth on checkstatus redirects
  tests/fetch: cover checkstatus redirect auth handling

Marcio Henriques (1):
  data: fix issue with varflag exclusion

Ross Burton (1):
  fetch2/wget: handle HTTP 308 Permanent Redirect

 lib/bb/data.py        |  2 +-
 lib/bb/fetch2/wget.py | 65 +++++++++++++++++++++++++++++++++++++++----
 lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 6 deletions(-)

-- 
2.53.0


