Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33729E81E0E
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 15:36:52 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web11.16217.1696606609886463901
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 08:36:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D+bHb3eE;
 spf=pass (domain: gmail.com, ip: 209.85.160.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1dd8304b980so1444330fac.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606608; x=1697211408; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nejb4+4tLHBP47n/jpFJyqJFyBc6x9fqhYNuvmJa7xw=;
        b=D+bHb3eE4BM2g0Ixh4lFflHsEhYNND6KuJDQXUC0q0x1U33zbi++dQsYyPb2O9PETD
         +puaid3icJfdMQELIvJnz7Fs0YGnQeSEDe4NmqcroNtZ9+W9To00aRozCHRpYLeisTfz
         BwhTYqwVuTlT44D+5SIt7zVGVRlkgAPjfC//NhqZry6MFC2KXTOX4cFxvoz4pvBKwl7g
         0JGd2eaVpPtKLx9z2TmtkNORYeVm7yH6Saeec7CDtHjhsccNPftyUZnd2svI+IHL3cx2
         aj4iZSre2XBzDIW3uHTMtHnSzfxYMF9Mr4m/9qtFxM5qdUYIsmp9fYait8wzyCpVhKgp
         i1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606608; x=1697211408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nejb4+4tLHBP47n/jpFJyqJFyBc6x9fqhYNuvmJa7xw=;
        b=Ie6/lUxxJGibMrW3/h7Sa3XfXFw51OIbnu+7LBzLOasIaUHfkyeiVS4OwDml38NrIQ
         BJT55WN3sSOVU/DhsoxSwy0YGa5Rf2grHHQ3tkaxjdB0DK6OOQ5pIVMpiIUcTzAVYk35
         v16kO5YwoxzrEmCOtmf5tHWKTgNSvKIHXYsd57T2Ni/iUTNLe2EGKS08F8oA3Y5sqmeH
         72Ytngy6m0/Wl3sFLMt7aQPj7v3Bts1Jy6W+4Z/LLCZigpt521eSBCcQ2KIug0S9Fxy+
         q0D55Lsgde4wdhChJY+BMdt4FBcpeATGyBHrn3kLena85OrKreHlQJ+B9XQzEmSpDE/Y
         GUhA==
X-Gm-Message-State: AOJu0Yx2qB0O1Y0YIKCbNgBHUYO9JUF/E9rpf7d+PP4Hny6bIqS0GGaP
	76ogDa+9AMJTK6OfregnJAJic1DHh84=
X-Google-Smtp-Source: AGHT+IE6A5EOTwu8qVNurJuZ+u/pV/k3JlFpDKF9vyuoyvX3CoAN689rt+r+RycZBj72ToxSOspMCQ==
X-Received: by 2002:a05:6870:d38a:b0:1be:fd4e:e36c with SMTP id k10-20020a056870d38a00b001befd4ee36cmr8911357oag.2.1696606608472;
        Fri, 06 Oct 2023 08:36:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001dd395339c3sm780426oac.19.2023.10.06.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:36:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/5] Add cleanup commands for hash equivalence
Date: Fri,  6 Oct 2023 09:36:40 -0600
Message-Id: <20231006153645.1609760-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 15:36:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15187

Adds two new APIs and corresponding `bitbake-hashclient` commands for
the hash equivalence server. 

The first command is `remove` (`bitbake-hashclient remove`) and it can
be used to remove database entries that match the specified criteria. It
can be useful to remove entries in the in database that are know to be
no longer valid.

The second command is `clean-unused` (`bitbake-hashclient clean-unused`)
which will remove any database entries that are older than the specified
age and are not referenced by a valid unihash.

[YOCTO #15064]

Joshua Watt (5):
  hashserv: Add remove API
  bitbake-hashclient: Add remove subcommand
  hashserv: Extend get_outhash API to optionally include unihash
  hashserv: Add API to clean unused entries
  bitbake-hashclient: Add clean-unused subcommand

 bitbake/bin/bitbake-hashclient | 22 ++++++++
 bitbake/lib/hashserv/client.py | 14 ++++-
 bitbake/lib/hashserv/server.py | 93 ++++++++++++++++++++++++++++------
 bitbake/lib/hashserv/tests.py  | 52 +++++++++++++++++++
 4 files changed, 163 insertions(+), 18 deletions(-)

-- 
2.34.1


