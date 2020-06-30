Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web12.7567.1593486524848637482
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:08:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=f5oeqH1O;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.193, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f193.google.com with SMTP id q17so8770485pfu.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=2nunJphVXWlHjijxKu+5ujqN1Zole2t5ZOJT2BlpF7I=;
        b=f5oeqH1OiMzR0FGAaDtOi+EBROK1ms93BLYb4LfrjvWbmhhuqytoEkcndXJbk7eOVl
         IItuwq5IMdTJu9hPLk9ReokLl+kJV8UllCIonipdLPNpVuzWIpIvxqEMT6GBcvLGpmqY
         o7nVrOGe/6nwFIjyRdAoaBYlKvkW7QX1W3bl2XzmBZKzjuKmyCimOXziqt9uIMe0MJDS
         cjXkhUx35weiLRYCEMXBbw9U0Xy80Hb0v57fFE5Mm/CU8ZvdP9BigTxyXxeDwnkb5Krr
         a+KbLdyfJr+tp7Qp2MlLt97BWiYlWwCf8F7e9J7opgtlq64kSf5h8epcGkckuOaUhtuO
         G/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2nunJphVXWlHjijxKu+5ujqN1Zole2t5ZOJT2BlpF7I=;
        b=e1sP0TmBqbTpzzMojf88I/0eqPjUISEJQTO1MEuukBP8shZjgWIQ+XhHQO2qSZaZqL
         JpgYCDCWucaVQGrrbehAZJTttp6cI3UHClDgwKoAsIuDTN+jprK5zP1TUViRELhaC2+i
         9FSG1Jg4h9wUx3q+jfVyq895GE+WxP/4HnyZ9Tk3Vr8VILo0Qxg25TDiiOk7J72ONKrz
         okAt6uG96cWXflBKqvt2xWrVRGDJRaLpyoA3+nMZFnXYkFqaoFXefiHKXHI/OwNprhkn
         Mmllz52xfGUEtvkXhQ0S3hRxkcNy3cQ7+g+kbInWJsgLcXqu8BJaKnEOD8P7Azhy0/QE
         OhfA==
X-Gm-Message-State: AOAM5330nhdKvFt/URGRmfqrxA/w8gIu80Q6NjgcH+j+y4Wbjcvr+pSX
	BjCbGpvs1DmAjTGXyI2/eEEu91fFl0+Y7w==
X-Google-Smtp-Source: ABdhPJxgH+5USe4RN4eOOq6kY9z29Iw4m/qmNgFjRx37+ggX7bCDlpzXcfcBh9WeNxxyNIFpddmSrA==
X-Received: by 2002:a05:6a00:801:: with SMTP id m1mr17460475pfk.200.1593486523912;
        Mon, 29 Jun 2020 20:08:43 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.08.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:08:43 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/6] Patch review
Date: Mon, 29 Jun 2020 17:08:20 -1000
Message-Id: <cover.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

Please review this next set of patches for 1.46 (dunfell) and have comments back
by end of day Wednesday.

The following changes since commit 83296870bede70e31bdf6e73683bcc30681023fc:

  tests/fetch: Switch from git.infradead.org to a YP mirror (2020-06-22 20:53:17 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Joshua Watt (2):
  hashserv: Chunkify large messages
  siggen: Fix error when hash equivalence has an exception

Richard Purdie (3):
  taskdata: Improve handling of regex in ASSUME_PROVIDED
  runqueue: Avoid unpickle errors in rare cases
  msg: Avoid issues where paths have relative components

akuster (1):
  test/fetch: change to better svn source

 lib/bb/msg.py            |   2 +-
 lib/bb/runqueue.py       |   9 +++-
 lib/bb/siggen.py         |   1 +
 lib/bb/taskdata.py       |   9 +++-
 lib/bb/tests/fetch.py    |   2 +-
 lib/hashserv/__init__.py |  22 ++++++++
 lib/hashserv/client.py   |  43 +++++++++++++---
 lib/hashserv/server.py   | 105 +++++++++++++++++++++++++++------------
 lib/hashserv/tests.py    |  23 +++++++++
 9 files changed, 169 insertions(+), 47 deletions(-)

-- 
2.17.1

