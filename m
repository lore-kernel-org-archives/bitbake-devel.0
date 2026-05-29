Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D0CD6E4A
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 14:52:29 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12012.1780066346041308177
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 07:52:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cPpf8eWG;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso66998235e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066344; x=1780671144; darn=lists.openembedded.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udo3rAes79iFbhvR9E3S5fsK0/htyRsIDjiVIlf3XT4=;
        b=cPpf8eWGTj0TwjZnsRGdZ7e+Ejw0KEWifykZdZkpWOS1zBci4CeoyZE0oomTmBJWv1
         YKhdKXtFXdkuZO1V10xoeaVA/5uvaL9NwLqjtLbrvXZQGGY1MxgDsMwpFhQuW0CZtPt7
         jOzV2TZfbqhQUaM+1lOE2MFdjlPLlzzRSlfqhnFDQR82lY7FvfK32mQ0X3bE8HaIJVTG
         2yptm3cT78cKgDZ8IkhYjjNOR7HsX2M8tte8+hx7cdl/p2JpdY/sK05Fg4fEZBQxQUMs
         kFrhe7PkbeWOZ9JJFg4JZZ5xe9In/u4VUr7Nz9FvRpiOYv2q4x7Nv2NGE9foDQcMa4wm
         0+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066344; x=1780671144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udo3rAes79iFbhvR9E3S5fsK0/htyRsIDjiVIlf3XT4=;
        b=bsoD4VNzsaEZGZnn2LzCPlYpvLOf7z2fxS0ZcQYkI9/lU4V9+TP+hg48zyHOrMGfIp
         XfLqc3wtrCyFc9ICXU7s2W4NdfUvjOFWBtBsLpnfv68ucXnWAxnI6FKXpnpVAAMASYXW
         FxhgqK8Z8dDB0tmxcbyMwjnayNTAZtfvjZpJrYhcZx9rDQY71aUp5OOBc/HQYw95KVQm
         N49Fg75o2m5yl40QdkVUWOAcOWrQ+9tiV+FlJw2OtUSXyAbdSEMHnSlKxJpOjkLfsciw
         nrBWcSR5vp9qjChRhQR5IcqADfp7bt4lXT3QVJkk31Qry9AXimxzc918HyaBKCUzsL9a
         8Nig==
X-Gm-Message-State: AOJu0YwUDZ/kw0K5pLwLiNfVbgkGGC1cM9wSNu+iblIbz2/GE9G2zVb+
	qEyV93SOlxGhWDfEXgqYtwYW6j2r99Bx2Sx3121UdPqynKeBpusCuIBixNlSs2IV
X-Gm-Gg: Acq92OEKaDgc2JHx1CpywF9LxxkqKpXQ6KYnRN3jlyEhBLMOZL8o2ihxDtnubVwpbWH
	wWuo6NTawKlZQVZ34TUnR1R5RLTI77n1pdVVz517jo4K+rpH982pI645YhcEEpSAmsbe059dVt+
	L8AO3nsPNgIkfHvYrXABwASLuxqapsvM7FbiR9tCf/7wK4R0GfGp5Nw4/d6HkkRlPQjCGXS+7yu
	ye6edqZXp6ZdgXJiHkIPYPN6aqIGVeK+Xc5AMIPkhddYv7j1zBLlWEvnyLNAFH2j4AI2njwyOHj
	3oat/+3RcLaPq+0Ypsp+2AkdLUcR49FQQzMHLQUR2kEvSBslszUdRMYwQj27LUpBKPeo8h5Hulr
	CYCGhKEKfep4vVqL+TQtMhiws3huDFEbc+5Boh2LmJJiYIzx9VFyUIsEdP/t5VQ4A//cJLr4W+g
	raHEobnSmqLWIejcou9UsNOAs1lr6fombynMwHHaCOENTA0EvQBcpZYRPnhFgpQilU6bKwdefwS
	VqKUnKM4/URmoBbaeAx/apBPH8W7wullA5QAA==
X-Received: by 2002:a05:600c:4686:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-490a28d3f2emr287975e9.0.1780066344247;
        Fri, 29 May 2026 07:52:24 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c13d018sm21199535e9.8.2026.05.29.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:52:23 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH 0/2] bitbake-setup: improve source-overrides
Date: Fri, 29 May 2026 16:51:37 +0200
Message-Id: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmnGWoC/x3NwQqDQAyE4VeRnA3YBSv6KtKD7o5tDq5LolIQ3
 72hxw9+Zi4yqMBoqC5SnGKyZcejrih+pvwGS3JTaMKzaUPP88yG/Si8nVCV5MFa1LEi78Zo47S
 Ero9diuQjRbHI938wvu77B0Zn5pdwAAAA
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 14:52:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19560

Patch 1 fixes multiple --source-overrides arguments so override files are
merged in command-line order, matching the existing documentation.

Patch 2 adds default-source-overrides, allowing a configuration selected
from a registry or local file to provide default source override files.
This enables fixed revisions or other override source selections to live
in the registry itself, while keeping command-line --source-overrides as
a local user override applied last.

Tested with:
    ./bin/bitbake-selftest bb.tests.setup.BitbakeSetupTest

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

---
Ernest Van Hoecke (2):
      bitbake-setup: support multiple source override files
      bitbake-setup: support default source overrides

 bin/bitbake-setup                                  | 48 ++++++++----
 .../bitbake-user-manual-environment-setup.rst      | 13 ++++
 lib/bb/tests/setup.py                              | 86 ++++++++++++++++------
 setup-schema/bitbake-setup.schema.json             |  7 ++
 4 files changed, 116 insertions(+), 38 deletions(-)
---
base-commit: e9a06f79d9ec767c9d95470be78b006d6fd0d59c
change-id: 20260529-bb-setup-override-improvements-e5caf279c7dc

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


