Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8745CCD1BB
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 18:29:56 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.20567.1761071386721410578
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 11:29:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MK1LzrWp;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b40f11a1027so1161328766b.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071385; x=1761676185; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xogk4w+al1KGVn4q6jdyfAcJ/RKkDBe5+ck4RSUmtw=;
        b=MK1LzrWpBPPIvqrpKPdTqsrBRWSlt2Z+OBlUgfx+tKJSsvg2OX3xbOdSI7ZGGLzNK4
         pK56oII5fIf7dAmBMJPXyuEugYsRoIYWOEniZSxrsS1vwQhkH8u+x3xf+f/Q2fxZK3jr
         obzlx1f+z6pQ2QAwlJ4f3j5sMnEB/102HL+4sV5IjZlItu6209Egs3ZHcbC14sVig72/
         6wXn1Mk3gt9zF48f+z4JN8a8ZGqmSsEC0wJY61FrOPwc968hG6dlUPbp6E//DzqzMVJB
         ejttl+fjWbhsvOktLLqE4hIhFU7AYTeQRzhcGzYLrlERk56XDgzPUaYaiFcr6VfnHIBJ
         uAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071385; x=1761676185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xogk4w+al1KGVn4q6jdyfAcJ/RKkDBe5+ck4RSUmtw=;
        b=NQJPMsBWPa0/rKA04kzsUWNuYu7xmGlc6r5YYT7UKYQ0kDrWFj8iob/tJUACcEkE9M
         VmhsnhxGh29lRKY75yGdIoxFrhLmV/Oc8LtwC0TxgAlTTzct32QZYqy/W/IvJKpH4b7m
         AUIt1VP9ZvswADR3eVuZFJsUIvvCMlkmuT0KOYXo/L6r5mBBTeFVilE/4vTQd+ITczon
         H2tNYwvMLA0u9qZBuA2pkrjrHdN5jl4fS9+xJhmA9CMuJecVmtBi7Iqu7wwnc3IVt0jQ
         /PZLuILOks7mb+jboCJZUaY1CMzmbtIuYYsQ4EcYDLFlZp1G4khm2rlEGAc6/oqALeCZ
         /XDA==
X-Gm-Message-State: AOJu0YyZ3GqyndVB++47A6Qn2VMztQiLEvJuJ5gxY7EgdVKlbikA1naU
	Ii2O5r9bJCamkkH6ZCPdyT6/f9k9YXqinotpFDCztNCd281sofqISdqwyfMUBQ==
X-Gm-Gg: ASbGnctx4LFytfY228H90EHd0WxL7/ecPOT9s5gPsbvct/+QS70Q4GNQPf/eDSSaNj3
	TJjVUsducvbjCAlg/AOFoGxzGzOS6lNgTsdVspb3o/a5r4k6rPozbJ55u6+7y+wm3Q4hF733uyW
	rgqhSC+TqxmVdM8IU2sAlZDa2OLObG40X/gRSwhnEWwvTv10tQXyYeLeQGlDzWa8onDVv/yPwhI
	s7FCMevYbzo1XYrdrJmBWiEzKlPnfrcZGSAAyLK/v0GcWB2BmscAPrCzHqlr8NdxDZW9B41a0v4
	eC86hQYBIvyxS5KBueKceq6r3U5tiVADHIjoGUK1Ehw0JdN0xyH+MvcXzXulgCIBt/V3LxR1+ae
	V/bZqjqj3ly/TIZ63BR3sZul4pkoLWbayfp0WFv4X0ArXovr1sqfgPPnlyK8U3KVizjaq9+fEsO
	wIqUD3wgAPUe87/qNbZlso
X-Google-Smtp-Source: AGHT+IGLv9XuE0H7Vrg5DSNJrd+d+5gIF7K15u5pV/9OwCU4/KinvfDeh9YbU3+iSTzN8dHBiV+8aA==
X-Received: by 2002:a17:907:7f2a:b0:b3d:c3ee:406b with SMTP id a640c23a62f3a-b6475706d92mr2014686466b.61.1761071384947;
        Tue, 21 Oct 2025 11:29:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:564c:7f09:5ade:5a5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm1151383166b.54.2025.10.21.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:29:44 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH 0/3] Describe AUTOREV and SRCREV_FORMAT roles in fetching
Date: Tue, 21 Oct 2025 20:28:31 +0200
Message-ID: <20251021182834.11403-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 18:29:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18197

Fix encountered style issues, add missing variable
descriptions and references.

Adam Blank (3):
  doc: bitbake-user-manual: describe UNPACKDIR in fetching
  doc: bitbake-user-manual: AUTOREV and SRCREV_FORMAT roles in fetching
  doc: bitbake-user-manual: style and completeness corrections

 .../bitbake-user-manual-fetching.rst          | 119 ++++++++++++------
 .../bitbake-user-manual-ref-variables.rst     |  22 +++-
 2 files changed, 99 insertions(+), 42 deletions(-)


