Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9BC0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 03:08:57 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.34293.1737515332642641611
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 19:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=x+jikmMa;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so8413726a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 19:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737515332; x=1738120132; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkwOsktr8uT8QI0w66yJB+FTKrn6Go3ZptreKqbQpbg=;
        b=x+jikmMaenK3G3v4ByR3U4vI0bTvNs6vAXd2oYuhGXyQ8c4rf3Vo4bgS2uHfLqd+QN
         Sxhr2mVtDAUeC21alU+ybcRtM042wseb2tQVCyXY7gSPCjONqbWGhA8NctWNPiMcDtAA
         zcXecNDdXZLBEfhG3W8oH2j+tXxNzA9nNaq63E/tdzVz0jSlUar/DbmQJx28Upb10V3b
         w5MC9H4mN/KKQ3t7eC9UcvITyDSE4+eeZcMjLJ3VRys5rkX9DFBu4aGgnK1CU7uXLcmH
         fmhzuCFFa0u6p0qmdt2mDbI3sbZsVHOntFDINZYdw4SRO1dRYQ/HJgGV5JWx1JtjLYoE
         PiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737515332; x=1738120132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkwOsktr8uT8QI0w66yJB+FTKrn6Go3ZptreKqbQpbg=;
        b=jzEmRdF3U3oz/zXC0YRuwSCn17qCoaCzcheTWBxXFVCurs9Drguyf12UYftSEJSfh7
         cgNuSIVah1iG4U4/esvar1RNWktbrM/1NW91Pi8XAvUlRTVMyN8drtmVhzGdjQQLYM6x
         3Zk2i/oIQBAhdLXJmvgchbYlDUELK4gLeQFindfpng9odEtOMltL1ofOlX4OhIDHM+EJ
         n6QiAHVgM/fGT3o/vVYEl+oQY+GzuMfb/4Htqqa+500ba369IwhyBgjKEqgSC0yBkllr
         jW3RxJy9GArVveROBGqSGPL0JMzElpyOwn+E1REHR1dQYYIMCKn+36ZoOAPzPhSasq+T
         MKFg==
X-Gm-Message-State: AOJu0Yx4+y3L0h0BF2xH18NaafCpsrBxfwUFvCzMrUDBLjixzJryIAmi
	YmqIIgRn6VZMhgV5lgYM72uExTTZd7xnhsJ6heOEIhopOu6oyZwydWOVQ8AJZb+xZj4zQyOGptg
	hSp8=
X-Gm-Gg: ASbGncus+Y99LhgAFDIuOm/1kmOd/CGCsSgmLZrJt5LYNDv3QVmmUBLadBpLxDkzZrl
	GYN/Ju4x0CwYZIlHCzn5nsA0kDPCh19yKTPtF/SSZ6mAooZJWLodC4Canyrz6I7Nl2Rs0JjexlS
	p33LnAC+lAPPjm2RsqjWHqNBQuU1HUKzUGQRIAqSV7Ql/JwtbF/l4aXdkmvi2SFaX8XnLoIIz8b
	mmDa8ChcherNuP08qocPr5rQO+m7nH4f+ch69HpeS5Uy/9Mp9seGrqxBqk=
X-Google-Smtp-Source: AGHT+IGvPhXZxpKpizE1SSbXW6qXz6w7dGeSKwGZlrm6OZ1e5qtQwglZTsj8ghMZRqr6ZxmmW2iweg==
X-Received: by 2002:a05:6a00:2296:b0:72a:8b90:92e9 with SMTP id d2e1a72fcca58-72daf931244mr25017217b3a.5.1737515331681;
        Tue, 21 Jan 2025 19:08:51 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm10050820b3a.66.2025.01.21.19.08.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 19:08:51 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Patch review
Date: Tue, 21 Jan 2025 19:08:43 -0800
Message-ID: <cover.1737515198.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 03:08:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17052

Please reviwe this set of changes for 2.8/scarthgap and have comments back
by end of day Thursday, January 23

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/856

The following changes since commit f40a3a477d5241b697bf2fb030dd804c1ff5839f:

  runqueue: Fix scenetask processing performance issue (2024-12-03 06:34:38 -0800)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Chris Laplante (3):
  ui/knotty: print log paths for failed tasks in summary
  ui/knotty: respect NO_COLOR & check for tty; rename print_hyperlink =>
    format_hyperlink
  cooker: Make cooker 'skiplist' per-multiconfig/mc

 lib/bb/command.py     | 21 ++++++++++++++++++---
 lib/bb/cooker.py      | 11 ++++++-----
 lib/bb/tinfoil.py     | 16 ++++++++++++----
 lib/bb/ui/knotty.py   | 20 +++++++++++++++++---
 lib/bblayers/query.py | 14 +++++++-------
 5 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.43.0


