Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FE7C47DDB
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 19:44:13 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.3864.1706039048172403816
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jan 2024 11:44:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LnAKjl+e;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2906866861bso1547272a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jan 2024 11:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706039047; x=1706643847; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qte0rycpOAmL397rZBfE6VA6XLGWwOY/Nvjhs+SYM6k=;
        b=LnAKjl+eTCh9jrZn+ZWDF499J8e4Dt5T7jTzYFmsoxo3FJDC/qshaWAuFDShf6x9Tm
         2TJ1lRQ8PsHJGCZ/ryRrbYyoW8IJRpwGsxABY16+TzLUCb25fFIC6UV4swVul2DymIqb
         jdas4x6QbJ5sgurVAfpKk0bELA6FNfc1TVnYr/F6LZrpp1Iefy2biljrqioNn6d3qxuc
         FptH8lx4CBF56u0ni0xbocTNCXWaJxxUoukOBT3kkOCrVh2/hNmNbOPzjlwF9LGo+6mB
         F0J9SQHNGcRFRqRMt5ebe16AMsyjC36FQ4EGwSwTc6gETBnQl33ZuoL4HkuPZKFPB8qN
         4ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039047; x=1706643847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qte0rycpOAmL397rZBfE6VA6XLGWwOY/Nvjhs+SYM6k=;
        b=GZOCX/2HgLVY0I3oV9pmmKh1UJIn4bBNNJCtK8RNvvGuTtR/Q3Xy4+GXYMlwC1bsDb
         6ei/N16qCui32i8h4554ydqzElXjybRm05zbG0aYgv/8x77RbWHGSnPzIBiDMqwF77kb
         wzu0QcwJbUpKabsR/O8nffzsRTswyGZxpxFTa8ESFYYEQaFp94s9uNGQr/VC0N36ZZ7o
         7NBnAVR2JU3N2Q9lxAlv/hS/WhZMdM9CZQAtR6pSOmZAYBmsMiP8ChVwb0nbvzgHe9Rq
         V9NDiiaHEAia1cfmhHCqYSD06T9AFZGtnj9LcMgdywwh8jdouHe+q1yJmqj53aXtobrK
         tKEQ==
X-Gm-Message-State: AOJu0YxAsmJhyj+y1SYkjlw6rareANFPKa6lfCdL8tJ7wxqutae4Qyx+
	zDQ4ivFUtqoVt416gSYmZm4McxGJJy/46T8YoQN4Cgt8SAF2tvK1IBAJdU3T
X-Google-Smtp-Source: AGHT+IGJXS8scdaUc7hwdmTzSi1cllQsz6j3oyQTSgEtFF4FlcFaidwgSJmRIG2geUe4P4GHkKd/LQ==
X-Received: by 2002:a17:90b:1241:b0:290:6fdf:f754 with SMTP id gx1-20020a17090b124100b002906fdff754mr2422670pjb.59.1706039047052;
        Tue, 23 Jan 2024 11:44:07 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca01:19f0:7044:2ea6:7a6d:2e77])
        by smtp.gmail.com with ESMTPSA id sy14-20020a17090b2d0e00b0029005525d76sm12119142pjb.16.2024.01.23.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:44:06 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Diego Sueiro <diego.sueiro@arm.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][dunfell][PATCH] layerindex: Fix bitbake-layers layerindex-show-depends command
Date: Tue, 23 Jan 2024 11:42:44 -0800
Message-Id: <20240123194243.1760477-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Jan 2024 19:44:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15798

From: Diego Sueiro <diego.sueiro@arm.com>

Running 'bitbake-layers layerindex-show-depends meta-filesystems' fails with:
```
Traceback (most recent call last):
  File "<...>/poky/bitbake/bin/bitbake-layers", line 93, in <module>
    ret = main()
  File "<...>/poky/bitbake/bin/bitbake-layers", line 86, in main
    return args.func(args)
  File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 209, in do_layerindex_show_depends
    self.do_layerindex_fetch(args)
  File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 182, in do_layerindex_fetch
    args.shallow)
AttributeError: 'Namespace' object has no attribute 'shallow'
```

Initialize the shallow attribute to fix it.

Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
Backport from 71f095c14

 lib/bblayers/layerindex.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 95b67a662..f64d18e81 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -206,6 +206,7 @@ class LayerIndexPlugin(ActionPlugin):
 """
         args.show_only = True
         args.ignore = []
+        args.shallow = True
         self.do_layerindex_fetch(args)
 
     def register_commands(self, sp):
-- 
2.34.1


