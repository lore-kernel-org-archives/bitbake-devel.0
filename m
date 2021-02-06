Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.13625.1612652932210799358
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dW2lsnlV;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id l18so5997705pji.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hNwAaNzXuG89p8qLBkS5FWkXfOEQd0r4QDOKaw/HFVI=;
        b=dW2lsnlVtt/KUSfAw89f19GamglkAvhL2/3MbqnZqTbWzs6Y00utyVZlMaMqdC75E+
         lvAdX8YI64wuHd0aCNJcS2lxtN4TdquCxH7O6dfcrSC+A5qeSvdCXZkaLz8IYnKZgFaT
         dhu0mvFdGHa7aJPawkodz84HuVioxZeUwiDj1n4ek7IPCaINo/IS1omsWybGkB4KaF7E
         flaThvdIadcJUymq2V1XfjPDrq4IUhuiqaYb8oghaKzKjSqU+UNpObsWTgFkgTA67LSd
         AyDWkz6N2gF+zED4WVVLxbM9pv8AtaoyoloSuoPcZWJhZed1QOQpJTD6MX0a7uXdwtl0
         xDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hNwAaNzXuG89p8qLBkS5FWkXfOEQd0r4QDOKaw/HFVI=;
        b=sNvXlzm/rycTwkD5pBgyYwH9TpQW52yn34j+ipHSm+tGAJm9JBw4AuYq5GGmDc32Zf
         DLlqGIY6oebg9WtJmmvAMB/B/FN6XnBv4hzJtQcY4ncLJgxBeHMjTmXZblCCinZ95WlC
         3clI+DTLGQ6tfAAyruHPayGuVD3PtLFrXdwC/3I9dtKJlM/b5S5Sma6LveyIYdVy0/50
         8zmPaEsFJz1dLmU+Tov9apf8m+xOX5J50JMRL4t/7EiStkPkx/9Zd4TyLWfQ3JOijkbd
         9ct8v9iyG+LJJ/tiotTQAoIMFOzSPpWkmeg3/bauB62iHyit7PbqBIFWeNB2Ac0LHpkr
         rlBQ==
X-Gm-Message-State: AOAM533ShR9ATSg0cLQAsgxD70F7I7y9Ikv/DgvmyynqBI0npgKqaBF2
	jrZq8nnli0xEnOkBunM1UL3zk7zfOYY+zg==
X-Google-Smtp-Source: ABdhPJxLkJhSeJfxE2QZ/OLley98K189Q5xsbc8fQ6swousqOqkqjdXDS2nUXqFPvNCHUJ6XgqqH9A==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr9911072pjb.62.1612652931334;
        Sat, 06 Feb 2021 15:08:51 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:50 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 00/10] patch review Feb 06
Date: Sat,  6 Feb 2021 15:08:37 -0800
Message-Id: <cover.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Next Gatesgarth patch review.
Please have comments back by Monday.


The following changes since commit 6ff4bd4f345b4e8030b9197d13097308df521576:

  postgresql: Update to 12.5 (2021-01-18 08:20:58 -0800)

are available in the Git repository at:

  git://git.openembedded.org/meta-openembedded-contrib stable/gatesgarth-nut
  http://cgit.openembedded.org/meta-openembedded-contrib/log/?h=stable/gatesgarth-nut

Anatol Belski (1):
  xmlsec1: Fix configure QA error caused by host lookup path

Dmitry Baryshkov (2):
  xterm: install xterm and uxterm desktop files
  xterm: provide virtual/x-terminal-emulator

Mikko Rapeli (2):
  flatbuffers: whitelist CVE-2020-35864
  giflib: apply patch for CVE-2019-15133 and set CVE_PRODUCT

S. Lockwood-Childs (1):
  sip3: simplify recipe

Søren Andersen (1):
  zram: fix sourcing of zram parameters

zangrc (2):
  iscsi-initiator-utils: upgrade 2.1.2 -> 2.1.3
  openldap: upgrade 2.4.51 -> 2.4.56

zhengruoqin (1):
  openldap: upgrade 2.4.56 -> 2.4.57

 ...Compare-with-max-int-instead-of-max-.patch | 48 -------------------
 ....1.2.bb => iscsi-initiator-utils_2.1.3.bb} |  3 +-
 .../flatbuffers/flatbuffers_1.12.0.bb         |  2 +
 .../giflib/files/CVE-2019-15133.patch         | 23 +++++++++
 .../recipes-devtools/giflib/giflib_5.1.4.bb   |  7 ++-
 meta-oe/recipes-devtools/sip/sip3_4.19.23.bb  | 17 ++-----
 .../recipes-extended/zram/zram/zram-swap-init |  2 +-
 .../recipes-graphics/xorg-app/xterm_353.bb    | 16 ++++++-
 ...{openldap_2.4.51.bb => openldap_2.4.57.bb} |  6 +--
 .../xmlsec1/ensure-search-path-non-host.patch | 22 +++++++++
 .../recipes-support/xmlsec1/xmlsec1_1.2.30.bb |  1 +
 11 files changed, 78 insertions(+), 69 deletions(-)
 delete mode 100644 meta-networking/recipes-daemons/iscsi-initiator-utils/files/0001-libopeniscsiusr-Compare-with-max-int-instead-of-max-.patch
 rename meta-networking/recipes-daemons/iscsi-initiator-utils/{iscsi-initiator-utils_2.1.2.bb => iscsi-initiator-utils_2.1.3.bb} (96%)
 create mode 100644 meta-oe/recipes-devtools/giflib/files/CVE-2019-15133.patch
 rename meta-oe/recipes-support/openldap/{openldap_2.4.51.bb => openldap_2.4.57.bb} (97%)
 create mode 100644 meta-oe/recipes-support/xmlsec1/xmlsec1/ensure-search-path-non-host.patch

-- 
2.17.1

