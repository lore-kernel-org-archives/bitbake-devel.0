Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.61548.1600093155466456265
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2020 07:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=e/wXHfrL;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id kk9so5449036pjb.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2020 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSxdlR0BCmuA3mclYy5/tlmhwlGvMCfjXxJwk8XluSk=;
        b=e/wXHfrLaP2F4nqqz39yufgAk5WqpBpRlifFhVLVxpxpun9HwsR/4gkLkcaPPVhTjI
         2/e/GBiSkq7fU+C7E5lnBO0dH8oOdow9vwnl1P9z6QGC7i07jDKUnV6ZEf/w+jXFCc9/
         f4Lvqf7W7j8MxQ2NQoNraFZg6Y/Bfa5QkHLGzkcjG24qhufPvj7V0OJNJFeMYCFJHzYY
         8SrquurRAxS4aBorDogK2UWPibS647G05QmUS8TC5EQImZ4keQhfQXfdQxmQ2iVGcOqP
         HLdZb08rYPyhd5tH2EMBcBMEw5nl6bwpSKle93R0KiFdSYJ6vKtpYjCiHJpsdEzpxPZr
         1D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSxdlR0BCmuA3mclYy5/tlmhwlGvMCfjXxJwk8XluSk=;
        b=qnaqiDoguA7Np8TtJK4HtxR+wVymzBRJK05ejboKqnyxKq/nH8b9bztnUV2D7BPwar
         ONj50k40qTXjpshpi86aPI23InGYdR12LaJoo/k0taN0C84rxEyo6Ir1veaPAEc8Z4rd
         Kd3yzYwH9LPQMRjCIFlFb0QM4hL16c9rKTiXfVu3TykV4+Ju5AHO4v0oVVegGH2KBtou
         XxyR8SGH/zAq1j4IyfMUx0AjSva0IUezlhlYSUe/If15lN/CABtUr1Xzr/Mw3oVCxV/i
         xKGN9ihJsYQ7KUaaiUH2dREpptzleUAoElYERTqhOnQ1iKqvzIdr9PBbTjznxt3+2I71
         R6jQ==
X-Gm-Message-State: AOAM5333sF+bEtAhfWtNUXUYet3mJjiB8qKZg0SLTW0sMmMt0Zpi1Rkc
	yWlsEH1FaM104WGjAeBHbqHSgbfeFSV2zMbP73U=
X-Google-Smtp-Source: ABdhPJy8LqK1Ge1m8PHVoteaph3vfwuBrRm3oAgWgMeBo/hMRKk5QUccTxrQToU4kb4ME+rrSGOSow==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr14040633pjb.196.1600093153974;
        Mon, 14 Sep 2020 07:19:13 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id gn24sm9738003pjb.8.2020.09.14.07.19.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:19:13 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Mon, 14 Sep 2020 04:19:02 -1000
Message-Id: <cover.1600092861.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please review this set of patches for dunfell and have comments back
by end of day Wednesday.

Tested on dunfell autobuilder builds over the past few weeks.

The following changes since commit 838a89141fd6a75da9f982ad2b035e823b692d2a:

  server/process: Account for xmlrpc connections (2020-07-29 00:21:29 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Jean-Francois Dagenais (1):
  siggen: clean_basepath: remove recipe full path when virtual:xyz
    present

Richard Purdie (1):
  fetch2: Drop cups.org from wget status checks

 lib/bb/siggen.py      | 2 +-
 lib/bb/tests/fetch.py | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.1

