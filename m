Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.8940.1608130366334618646
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Dec 2020 06:52:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=u8FOFAxc;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id j1so13071264pld.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Dec 2020 06:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=RLhcRzFyYrS5SAoXQM8AZtTgjqC91XYhg2nq38kVwEM=;
        b=u8FOFAxckhodBfkEed/q3DcXxu0WEZbv+r319hsAOuXRVz0I1JOKJLevjw+fSoW23P
         YHSZzTXnm3/uBWOMzGnd39ZOsqPZ03kcP1LdLMLnLpq/lg8ucGCotMDiHe2wfleCqsJF
         tCWrTZtLEk0AFKaNOmi3ojoQjZtVHDfG6htjlLkTaAua+TfN/wMFk4nFDMWbm0Tup50X
         qCH8O+pezljK0mbtiftnvjb53oh4/bbHs1YugrSrJMahYQwvB1+Rtb22gGo5Gq4jfWRN
         MZzDzoH+p0nT+3c3vXadAV3qCP5PWPdjMXX7lvJYWytAOOfZy3tikRfZyHMkf8rEu+uL
         Op3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=RLhcRzFyYrS5SAoXQM8AZtTgjqC91XYhg2nq38kVwEM=;
        b=iFHALX3Mf12jEYmoPe+Lx7vQKPBHpJ3P2pepaEN5CLJYsevI5s3dzX+2joGjxOT1vo
         lZMD4Fwubk+TMBFQVBBE8HeZo3NbYrJT25UZx4ZF2iUVvVB1AKrLYG/Z3xjgnfKH1Ptj
         lOzY7+cenfdnQq9uNZMV3wmazpp4LoS+6pckANIQN5xPl1oxiaomEuQJX4PsvguQoNV4
         BGX+G2x/SiaDQSdHIf3Bgz+0uRSHK/UERKXVUQTJ3/FvDnhCXyYMew9sagjqriOWVBqd
         Vk/ud9UxuIuVzOnsqSML9MlhX3D41jbHI82hJ7586dp1GkFqKt/n/NllWyOJqqzn9QVs
         0OWw==
X-Gm-Message-State: AOAM530wjQIKNTMdknCSaf7zzCYM+sfb6WtAo9K/71E+RoboJwN43VpE
	6ZR1qEvglUp2F+oKXTjdihBVaWfgvt5Hb0In
X-Google-Smtp-Source: ABdhPJxJ8HmAa6dznPcGHj1/2SVTfa6yaqzwksg1XvyVJSII+l2jRFgtzdF5aQlijtdMbZ/tDzesJA==
X-Received: by 2002:a17:902:c395:b029:da:9aca:c972 with SMTP id g21-20020a170902c395b02900da9acac972mr32211434plg.32.1608130365224;
        Wed, 16 Dec 2020 06:52:45 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id 197sm2984024pgg.43.2020.12.16.06.52.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:52:44 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/5] Patch review (cover letter only)
Date: Wed, 16 Dec 2020 04:52:31 -1000
Message-Id: <cover.1608130045.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

Please review this set of patches that switches the 1.46 (dunfell) documentation
to use sphinx.  Have comments back by end of day Friday.

Since this patch set is extremely large I am sending only this cover
letter. Please refer to the git repo link below to reviw the changes.

Many thanks to Nicolas Dechesne for assembling this patch series for dunfell!

The following changes since commit d171188cf966852326916f726cbd3ca9627b831c:

  taskexp: update for GTK API changes (2020-12-01 04:05:42 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Jacob Kroon (1):
  lib/bb/utils.py: Do not preserve TERM in the environment

Mert Kirpici (1):
  doc/conf.py: add missing import sys

Nicolas Dechesne (3):
  sphinx: import sphinx docs
  sphinx: undo (bitbake-user-manual: Remove TERM from
    BB_HASHBASE_WHITELIST example)
  sphinx: partial undo (bitbake-user-manual: update perforce fetcher
    docs)

 doc/.gitignore                                |    1 +
 doc/Makefile                                  |  108 +-
 doc/README                                    |   50 +-
 doc/_templates/breadcrumbs.html               |   14 +
 doc/_templates/layout.html                    |    7 +
 .../bitbake-user-manual-customization.xsl     |   29 -
 .../bitbake-user-manual-execution.rst         |  733 +++++
 .../bitbake-user-manual-execution.xml         | 1029 ------
 .../bitbake-user-manual-fetching.rst          |  621 ++++
 .../bitbake-user-manual-fetching.xml          |  868 -----
 .../bitbake-user-manual-hello.rst             |  415 +++
 .../bitbake-user-manual-hello.xml             |  513 ---
 .../bitbake-user-manual-intro.rst             |  651 ++++
 .../bitbake-user-manual-intro.xml             |  891 -----
 .../bitbake-user-manual-metadata.rst          | 1969 ++++++++++++
 .../bitbake-user-manual-metadata.xml          | 2862 -----------------
 .../bitbake-user-manual-ref-variables.rst     | 1372 ++++++++
 .../bitbake-user-manual-ref-variables.xml     | 2537 ---------------
 .../bitbake-user-manual-style.css             |  984 ------
 .../bitbake-user-manual.xml                   |   88 -
 doc/bitbake-user-manual/html.css              |  281 --
 doc/conf.py                                   |  101 +
 doc/genindex.rst                              |    3 +
 doc/index.rst                                 |   38 +
 doc/poky.ent                                  |   51 -
 doc/releases.rst                              |  130 +
 doc/sphinx-static/switchers.js                |  233 ++
 doc/sphinx-static/theme_overrides.css         |  162 +
 doc/template/Vera.xml                         |    1 -
 doc/template/VeraMoBd.xml                     |    1 -
 doc/template/VeraMono.xml                     |    1 -
 doc/template/component.title.xsl              |   39 -
 doc/template/db-pdf.xsl                       |   64 -
 doc/template/division.title.xsl               |   25 -
 doc/template/fop-config.xml                   |   58 -
 doc/template/formal.object.heading.xsl        |   21 -
 doc/template/gloss-permalinks.xsl             |   14 -
 doc/template/permalinks.xsl                   |   25 -
 doc/template/section.title.xsl                |   55 -
 doc/template/titlepage.templates.xml          | 1259 --------
 doc/tools/docbook-to-pdf                      |   51 -
 lib/bb/utils.py                               |    1 -
 42 files changed, 6509 insertions(+), 11847 deletions(-)
 create mode 100644 doc/.gitignore
 create mode 100644 doc/_templates/breadcrumbs.html
 create mode 100644 doc/_templates/layout.html
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-customization.xsl
 create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-execution.rst
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-execution.xml
 create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
 create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-hello.rst
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-hello.xml
 create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-intro.rst
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-intro.xml
 create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
 create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual-style.css
 delete mode 100644 doc/bitbake-user-manual/bitbake-user-manual.xml
 delete mode 100644 doc/bitbake-user-manual/html.css
 create mode 100644 doc/conf.py
 create mode 100644 doc/genindex.rst
 create mode 100644 doc/index.rst
 delete mode 100644 doc/poky.ent
 create mode 100644 doc/releases.rst
 create mode 100644 doc/sphinx-static/switchers.js
 create mode 100644 doc/sphinx-static/theme_overrides.css
 delete mode 100644 doc/template/Vera.xml
 delete mode 100644 doc/template/VeraMoBd.xml
 delete mode 100644 doc/template/VeraMono.xml
 delete mode 100644 doc/template/component.title.xsl
 delete mode 100644 doc/template/db-pdf.xsl
 delete mode 100644 doc/template/division.title.xsl
 delete mode 100644 doc/template/fop-config.xml
 delete mode 100644 doc/template/formal.object.heading.xsl
 delete mode 100644 doc/template/gloss-permalinks.xsl
 delete mode 100644 doc/template/permalinks.xsl
 delete mode 100644 doc/template/section.title.xsl
 delete mode 100644 doc/template/titlepage.templates.xml
 delete mode 100755 doc/tools/docbook-to-pdf

-- 
2.17.1

