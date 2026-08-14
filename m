Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC3C5DF6A
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15590.1786721770353876627
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 08:36:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=sj3jTCvV;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 663623D818D3
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 11:36:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ttxBRtV72kAN; Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E73FE3D818BE;
	Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E73FE3D818BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786721767; bh=nyWI/cM8rRMdQ0lenySben3jXa+nF6rPivNI9L/uKko=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=sj3jTCvVdZaPq3ZAd8PDBfAsIo4osVun8zPk+tOqZb9QQIdipItLArIKp6GVjhRGK
	 4Bvk8VD6YOqM57RSt+Nw5Csu6rS4K+HNmNzBCBI6ZR3Yl7VDyC7U4iKtY/DBfi2lg+
	 vKH/HTWKgWaT8dU8Ba8nYrv7rwRjBJFacTm9tLqI8df+9uT9mhhGANFTPCaWQEri7F
	 XLoELFiCLDODi3DNHaBHfip6RQD+odSlHfIcEKPoLg14T9Ysw91yqiNxUM+RQIF+no
	 82VZlujK7TZVh1NP1NBrihUu8QJdlbU0VqjVE/2h9cnDjkfcXBQHtKg5yayn8kksxE
	 41mMuq0Q4eI1g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4piz_sonw8Je; Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
Received: from pwattebled.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CAB283D8189E;
	Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Subject: [PATCH v2 0/5] toaster: Add per-recipe variable view
Date: Fri, 14 Aug 2026 11:35:53 -0400
Message-ID: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 15:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19939

Toaster currently records global build variables but does not expose the
final values associated with individual recipes.

This series collects variables defined or modified by recipes, matching
bbappends and recipe include files. It stores one compressed, build-speci=
fic
snapshot per recipe and exposes the values through a searchable and pagin=
ated
Variables tab.

The snapshots contain final expanded values and variable flags, including
PACKAGECONFIG[...] entries. Values inherited unchanged from global
configuration or classes, functions and inactive overrides are excluded.

This information is intended to provide build-specific context to tools u=
sing
Toaster as a backend, including vulnerability-assessment agents consuming=
 the
data through MCP.

The series is split into separate changes for variable collection, databa=
se
schema, persistence, reusable table controls and the user interface.

Changes in v2:
- Split the original patch into five incremental patches.
- Cover direct assignments, variable operations and active overrides.
- Include recipe and bbappend .inc files while excluding class-only metad=
ata.
- Preserve variable flags, including PACKAGECONFIG[...] values.
- Store one compressed snapshot per build and recipe.
- Add transactional replacement and backward-compatibility handling.
- Add extraction, persistence, pagination, searching, escaping and count =
tests.
- Keep the BitBake cache version at 157.

Testing:
- PATH=3D"$PWD/bin:$PATH" PYTHONPATH=3Dlib python3 -m unittest \
    bb.tests.cache_extra bb.tests.parse
- Focused Toaster database and view tests
- Python compilation and git diff --check

Paolo Wattebled (5):
  cache_extra: Collect recipe variable snapshots
  toaster: Add recipe variable snapshot model
  toaster: Store recipe variable snapshots
  toaster: Generalize detail table controls
  toaster: Add recipe variables view on UI

 bin/bitbake-selftest                          |   1 +
 lib/bb/cache.py                               |   2 +-
 lib/bb/cache_extra.py                         | 101 +++++++-
 lib/bb/cookerdata.py                          |   5 +-
 lib/bb/tests/cache_extra.py                   | 235 ++++++++++++++++++
 lib/bb/ui/buildinfohelper.py                  |  21 +-
 .../orm/migrations/0022_recipevariable.py     |  27 ++
 lib/toaster/orm/models.py                     |  10 +
 lib/toaster/tests/db/test_db.py               | 101 ++++++++
 lib/toaster/tests/views/test_views.py         | 155 +++++++++++-
 lib/toaster/toastergui/buildtables.py         |  11 +-
 .../templates/detail_pagination_bottom.html   |   4 +-
 .../templates/detail_search_header.html       |   2 +-
 lib/toaster/toastergui/templates/recipe.html  |  32 +++
 .../toastergui/templates/recipe_packages.html |   7 +
 lib/toaster/toastergui/views.py               |  68 ++++-
 16 files changed, 770 insertions(+), 12 deletions(-)
 create mode 100644 lib/bb/tests/cache_extra.py
 create mode 100644 lib/toaster/orm/migrations/0022_recipevariable.py

--
2.55.0


