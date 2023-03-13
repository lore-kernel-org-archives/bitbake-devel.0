Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C93CC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 16:52:16 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.25115.1678726329293548594
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Mar 2023 09:52:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=MCoZUM+3;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id p6so13702575plf.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112; t=1678726328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mRPrzAHDi612S7ffqbDlCVpfO6lCEEFjROG9i3Cy+o=;
        b=MCoZUM+3VU3C2ssfp2erhmoFOWX86TfZHz1o0tBrvfDoB7XonooKFJCVBveddzvCyg
         6v91z7p1D5sxxpMHb5jYmgnMGJ/uBpRTQm76knHrk1XCsBB0/HReg49fa+jMvelOP4d4
         vYBvfR2shLh/fWckGtSqITT6ExWHm6/Bls903UEGdRZy9L+qYAB4cpRT9SPDbbOBvLUn
         mV9xZ1ZGBuazEuT5C/jv0LEu7cXKj8oB2LHj6ZgUvfvKED8At6vCBqrLNcbc3jYfAz4e
         RDTShXG3khEx6z19bxW3YGbAsEFAGHey4WZzHLHNvxxu3Oc3sF79XO5x3v6hqvLnghCy
         kVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mRPrzAHDi612S7ffqbDlCVpfO6lCEEFjROG9i3Cy+o=;
        b=yWWvxVFf3JFLP6mF1VhKH4yVPP9JT7/uswheOjxTFpmpmXKG0QdlxiAZjk79BXZpWi
         T6WSdeGmv/YRrFz85suOHPxwjQwVI1qt9XjfDOAKd0KN7mBJZqy3XaYh9W9gWa0MDW1a
         y45AZp7bLTYKx9YGk82JLiF2g06x3uC+Vd/WksNm7KsK/oMZ/BFek7KEOh0fXFegdkw2
         rzLcOAcWexJG5MwzvHfUP3XdLtbpnk3pmYP9weWUOhuqWd8f8QRH6mka8fG8PJsYFL8j
         oyHNM8CkwMSYtgSCx+c/FHyHI3jzzEINEy/Lvpa/+B3rb7RnHsLgOqyk20yNS8LsQfkL
         EiRw==
X-Gm-Message-State: AO0yUKUgOxI4tQy8TuJN7wAzasPMmPgbZmHRjS0+HJaxm+ThJ9gU3fLA
	KPmnPj/gEq/9x97zy8WHAXokLDzsegB26Kn0GDo=
X-Google-Smtp-Source: AK7set9Ho3BAptrPg6mB55ibIvV5FI09fTObG3TfmD4CPT44082Em/1pxchC+WvnAJXVXT6iumEyvg==
X-Received: by 2002:a17:90b:3c49:b0:237:40b6:1011 with SMTP id pm9-20020a17090b3c4900b0023740b61011mr36091994pjb.47.1678726328339;
        Mon, 13 Mar 2023 09:52:08 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id ij17-20020a170902ab5100b00199536fbc6fsm82534plb.280.2023.03.13.09.52.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:52:08 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/5] Pull request (cover letter only)
Date: Mon, 13 Mar 2023 06:52:03 -1000
Message-Id: <cover.1678726195.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 16:52:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14553

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5031

With the exception of a transient failure on oe-selftest-arm due to a
temporary outage at gitlab.gnome.org.  Passed on subsequent retest.

The following changes since commit 89f13cd4a927a73de98998c27082c63b07671525:

  bitbake-diffsigs: break on first dependent task difference (2023-02-10 09:35:44 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Martin Jansa (1):
  fetch2/git: show SRCREV and git repo in error message about fixed
    SRCREV

Richard Purdie (4):
  utils: Allow to_boolean to support int values
  cookerdata: Remove incorrect SystemExit usage
  cookerdata: Improve early exception handling
  cookerdata: Drop dubious exception handling code

 lib/bb/cookerdata.py | 17 ++---------------
 lib/bb/fetch2/git.py |  2 +-
 lib/bb/utils.py      |  3 +++
 3 files changed, 6 insertions(+), 16 deletions(-)

-- 
2.34.1


