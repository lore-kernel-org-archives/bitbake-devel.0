Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web08.13987.1608656523085373008
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Dec 2020 09:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Sm+6+J3M;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.47, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f47.google.com with SMTP id v1so1612372pjr.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 22 Dec 2020 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=IeFIftUPP18dHvH0X4yHXq0iEEcO2rnWqGjVzoQRvdg=;
        b=Sm+6+J3M9fpsIiWGokyfUcb6EHWXeymy9Czq7FHA/FM+B8lvvlf4v/z1s8obrezyQv
         yXa0JL702kRN3CJk8Q+BgEfGeahKpGRAhaSbFMHlJoZuFPp/x4xj7YKbX80p4LiARUaw
         j3lriUz/HFwDFwSERDs8zjPnk3S5+palxG8MqbT+3OifGtE2MHIMgfteaX54cp17EIFN
         npHY8GtNFEF3u0FETFDXH5TIDoeSb/MUzDwaA5dH/8fRYf1EiyX/DYBH3oF6NspBlyqQ
         p7b/49dy3xzlAbvHdIkbOYtWXqIUGlvcTsK6Lht+RpeFsZHLWdyUsXQiqqSEUEuzY8eJ
         Jg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=IeFIftUPP18dHvH0X4yHXq0iEEcO2rnWqGjVzoQRvdg=;
        b=cxMlrb6oyJU1sJtsLY6agSqfQq7hbum3bbIqn6PY+9HZVPcOH+2knZw+yKoIL9i3dI
         brTXOHhxff7v8HBAhi5zQSOMfVyj+YilBSaSMrjuFw3jfnycwA32NDlVf2jpHGgLPeis
         y9LvaJbLqNEXPm75qlOm4QiIEKoxVNz6qlOSVgxfCffZjZy3QsJcoLU11ZtHlaaViwg4
         Gxg+fFxhG4Va7+6jaK3JzOQsU37DFr6Ot4n1o8YMZUDx+lqULtF2/OjwbwprFPIGsOcW
         fB2t8UP+zXP6LLfHO9fx+7loR+x8vvHOwpngbmV+zJlyF5mA5HDpiQbzSHaUq8ctX8cd
         fcNA==
X-Gm-Message-State: AOAM530hRYg86MT4mALD5ApGTmfeWR+rU/Bya1YNYxJXez/dL6axi9cU
	odgLA4KMzdxhCpKUGqnyk2Jm7v9eIjOct+yM
X-Google-Smtp-Source: ABdhPJxCvxXtK/fUyvdrq3jZ17N6OtRoVOpI/jQgOozA+9y69yNN9j4DAmKsrfkMRIVQqXI2n0lYFg==
X-Received: by 2002:a17:902:a983:b029:dc:2564:91f2 with SMTP id bh3-20020a170902a983b02900dc256491f2mr21211067plb.46.1608656522011;
        Tue, 22 Dec 2020 09:02:02 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id 36sm14851397pgr.56.2020.12.22.09.02.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 09:02:01 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/4] Pull request (cover letter only)
Date: Tue, 22 Dec 2020 07:01:51 -1000
Message-Id: <cover.1608656427.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

The following changes since commit d171188cf966852326916f726cbd3ca9627b831c:

  taskexp: update for GTK API changes (2020-12-01 04:05:42 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

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
 41 files changed, 6509 insertions(+), 11846 deletions(-)
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

