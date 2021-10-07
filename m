Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC14C433FE
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:33 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web08.13161.1633619191987942618
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=PMzHTuxM;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.222.179,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qk1-f179.google.com with SMTP id 73so6264811qki.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6HcQ2Dw7ntgsn5BSHHKl19W8zCZJxprXcFSIRtyVEI=;
        b=PMzHTuxMaXoiyLH0Au90U51UoILhwOzXENVT/L2NteB4YRvufGtuhwF+StdUvGbEDA
         uwKeX/3ba4TmYJPOzfiknhQdThVD+Egz2iGFv+WT43EWLgCRf0LArdEps2Lru7Uf+mTY
         CgUCJt+rrCa5G3enCt3DQ6jmimTjnhnodWJxZKQDWRPZtYHzeMNXVbgYVmKUSn531bYb
         o75Y9J85fsva86MeljWdbyUCE1zOyHi8VGeY2dn25PMQBa99xbinCrT37Xy+xWv/smIj
         arWP2PvHOCk6T9X0MQ/oCdjuzow9zp20LSwTb+74DZ0nABZ+08P3Jqk3x2vnqc/FQx7U
         wJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6HcQ2Dw7ntgsn5BSHHKl19W8zCZJxprXcFSIRtyVEI=;
        b=EUGxg/WDnJvuX4zXCoy9zjRNzFgPhMuvvIYHxwStCvo5SXhVF7dSCxaJ3XNSCLQ8Sy
         lnO4AXFMEyZ+4nTGnh+dKT9npMby/aPeoZkhW3PJ2poDfM4kCs7ZoSjJOXqPlZMdxAq6
         1YABQRpJupB6OW2UiFOsgyr9T+wcDg23yHzEsgpZn0P9L1vOKkM0mTWCouzxQO2dPphh
         g78HpJPvwakGcJnKotMWkm1pQ1bvyOZ4/Zv/6ixoUck3MHrToI2H/YUzayOLqlEwChST
         WdbK+9dlgwamyVdtVgE4KLO1A2EzGn9xcDawNARZe0YyN+JbyrRFknsuGYPPzQTeDOux
         NCiw==
X-Gm-Message-State: AOAM531zVd8mUqS+QrCyMh6C9AmoeelhYolI/5jpm5hwJDmYOLqOhDca
	/24rG/sf81G2lYQBLFGFLfU3cCF5qejN1w==
X-Google-Smtp-Source: 
 ABdhPJwHgXvG8HfkSSNIVutsNzpLrDwlTxXEQRdERrTyQqjZ/x583pfCKTaRDLiJvdu4ubUbJgv9Jw==
X-Received: by 2002:a37:a546:: with SMTP id o67mr3648430qke.24.1633619191016;
        Thu, 07 Oct 2021 08:06:31 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 bk20sm15056180qkb.13.2021.10.07.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:30 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 0/8] replace http with https for URLs
Date: Thu,  7 Oct 2021 11:06:22 -0400
Message-Id: <20211007150630.22138-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12741

This started off with a simple request to change http to https in the
documentation.  It quickly went off the rails when I decided to change
all of the http to https, and then found broken links and a myriad of
other things.  I broke up the patches so they can be applied to their
respective git repos, but I'm sending as a series so that it can be
seen as a single push to get rid of http.

Of note: https://sstate.yoctoproject.org doesn't work (bad cert), and
https://sources.openembedded.org doesn't work (no https).

If there are problems with some of the patches, like the SSTATE URL,
feel free to drop them.

Thanks,
Jon

Jon Mason (8):
  oeqa/manual: Fix no longer valid URLs
  bitbake:toaster:test: Update SSTATE URL
  meta: replace http with https for URLs
  yocto-bsp/poky: replace http with https for URLs
  bitbake: replace http with https for URLs
  documentation: replace http with https for URLs
  documentation: use YOCTO_DL_URL
  dev-manual: remove errant /

 README.OE-Core.md                             | 10 +++---
 bitbake/README                                |  8 ++---
 bitbake/doc/README                            |  2 +-
 .../bitbake-user-manual-fetching.rst          |  2 +-
 .../bitbake-user-manual-hello.rst             |  4 +--
 .../bitbake-user-manual-intro.rst             |  6 ++--
 .../bitbake-user-manual-ref-variables.rst     | 10 +++---
 bitbake/lib/bb/tests/fetch.py                 | 36 +++++++++----------
 bitbake/lib/layerindexlib/__init__.py         |  4 +--
 bitbake/lib/layerindexlib/restapi.py          |  4 +--
 bitbake/lib/layerindexlib/tests/restapi.py    |  2 +-
 bitbake/lib/toaster/orm/fixtures/oe-core.xml  | 12 +++----
 bitbake/lib/toaster/orm/fixtures/poky.xml     | 24 ++++++-------
 .../orm/management/commands/lsupdates.py      |  2 +-
 bitbake/lib/toaster/tests/builds/buildtest.py |  2 +-
 .../toastergui/templates/layerdetails.html    |  2 +-
 .../templates/package_detail_base.html        |  2 +-
 documentation/dev-manual/start.rst            |  4 +--
 documentation/profile-manual/usage.rst        | 28 +++++++--------
 documentation/ref-manual/faq.rst              | 16 ++++-----
 documentation/ref-manual/variables.rst        |  8 ++---
 documentation/toaster-manual/reference.rst    |  8 ++---
 meta-poky/README.poky.md                      | 12 +++----
 meta-poky/conf/distro/poky.conf               | 16 ++++-----
 .../devtool/devtool-test-local_6.03.bb        |  2 +-
 .../devtool/devtool-test-patch-gz.bb          |  2 +-
 .../devtool/devtool-upgrade-test2_git.bb      |  2 +-
 .../devtool-upgrade-test2_git.bb.upgraded     |  2 +-
 .../git-submodule-test/git-submodule-test.bb  |  2 +-
 .../recipes-core/busybox/busybox_%.bbappend   |  2 +-
 meta-yocto-bsp/README.hardware.md             |  2 +-
 meta/classes/insane.bbclass                   |  2 +-
 meta/classes/mirrors.bbclass                  | 20 +++++------
 meta/classes/sstate.bbclass                   |  2 +-
 meta/classes/toaster.bbclass                  |  2 +-
 meta/conf/distro/include/maintainers.inc      |  2 +-
 meta/conf/distro/include/yocto-uninative.inc  |  2 +-
 meta/lib/oe/package_manager/__init__.py       |  2 +-
 meta/lib/oeqa/manual/eclipse-plugin.json      |  6 ++--
 .../lib/oeqa/manual/toaster-managed-mode.json |  8 ++---
 meta/lib/oeqa/runtime/cases/buildlzip.py      |  2 +-
 meta/lib/oeqa/sdk/cases/buildlzip.py          |  2 +-
 meta/lib/oeqa/selftest/cases/buildoptions.py  | 22 ++++++------
 meta/lib/oeqa/selftest/cases/devtool.py       |  4 +--
 meta/lib/oeqa/selftest/cases/fetch.py         |  2 +-
 meta/lib/oeqa/selftest/cases/recipetool.py    |  2 +-
 meta/recipes-core/dbus-wait/dbus-wait_git.bb  |  2 +-
 .../images/build-appliance-image_15.0.0.bb    |  2 +-
 meta/recipes-core/psplash/psplash_git.bb      |  2 +-
 meta/recipes-devtools/glide/glide_0.13.3.bb   |  4 +--
 .../opkg-utils/opkg-utils_0.4.5.bb            |  6 ++--
 meta/recipes-devtools/opkg/opkg_0.4.5.bb      |  2 +-
 meta/recipes-devtools/prelink/prelink_git.bb  |  4 +--
 .../pseudo/files/build-oldlibc                |  2 +-
 meta/recipes-devtools/pseudo/pseudo.inc       |  2 +-
 meta/recipes-devtools/pseudo/pseudo_git.bb    |  4 +--
 ...ssing-libraries-to-Extension-for-mul.patch |  2 +-
 ...t-fail-to-build-on-some-PPC32-config.patch |  2 +-
 meta/recipes-gnome/gcr/gcr_3.40.0.bb          |  2 +-
 .../libsecret/libsecret_0.20.4.bb             |  2 +-
 .../libfakekey/libfakekey_git.bb              |  2 +-
 .../matchbox-session/matchbox-session_0.1.bb  |  2 +-
 .../matchbox-wm/matchbox-wm_1.2.2.bb          |  2 +-
 .../mini-x-session/mini-x-session_0.1.bb      |  2 +-
 .../xcursor-transparent-theme_git.bb          |  2 +-
 ...-workarounds-in-cpu-features-detecti.patch |  2 +-
 meta/recipes-graphics/xrestop/xrestop_0.4.bb  |  2 +-
 ...der.c-when-env-var-is-set-do-not-fal.patch |  2 +-
 .../matchbox-config-gtk_0.2.bb                |  2 +-
 .../matchbox-desktop/matchbox-desktop_2.2.bb  |  2 +-
 .../matchbox-keyboard_0.1.1.bb                |  2 +-
 .../matchbox-panel-2/matchbox-panel-2_2.11.bb |  2 +-
 .../matchbox-session-sato_0.1.bb              |  2 +-
 .../matchbox-terminal_0.2.bb                  |  2 +-
 .../matchbox-theme-sato.inc                   |  2 +-
 .../sato-screenshot/sato-screenshot_0.3.bb    |  2 +-
 .../settings-daemon/settings-daemon_0.0.2.bb  |  2 +-
 meta/recipes-sato/webkit/webkitgtk_2.32.3.bb  |  2 +-
 meta/recipes-support/icu/icu_69.1.bb          |  2 +-
 .../libunwind/libunwind_1.5.0.bb              |  2 +-
 .../ptest-runner/ptest-runner_2.4.2.bb        |  2 +-
 scripts/autobuilder-worker-prereq-tests       |  6 ++--
 scripts/create-pull-request                   |  4 +--
 scripts/install-buildtools                    | 10 +++---
 scripts/lib/build_perf/html/report.html       |  2 +-
 85 files changed, 210 insertions(+), 210 deletions(-)

-- 
2.20.1


