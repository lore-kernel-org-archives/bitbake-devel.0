Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
	[209.85.215.175])
	by mail.openembedded.org (Postfix) with ESMTP id 7B7FC6C0C0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 02:12:08 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id q206so2689732pgq.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 19:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=QQ03yYFZCnHzjzp5a5YpYg9+X0nOm3HBxgUDDcjPKLI=;
	b=Qdkj97QqJ+qTzemFnAYoOUZF3XOJYOKqgFTRh4rb7pf/+GGkK6gQshmjgpQpkqZQZW
	ER/Sh3azxMAy+2DoADeCpu3R84euNBR29V38EYJluqUxPz8mvfO0bdNab51dkAdedcT+
	1LYKCR026w8x8Yq5RvXj90d0AHen8c/+ecLzdvbboAv6971yaV/v3ND0dHykdUrRDbD+
	43st6yP0xcucp+vjNi0/f9PU5vf7o3p7PQiERAEGInQVzz+oetRMDbacEdW4E6h4D15w
	GS1jGt2Pm+K3l39t0vMdHCy2BwilIhZEMCapvfLRUGMU9YaWAoixfgItCWo4RxKFrz4J
	8f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=QQ03yYFZCnHzjzp5a5YpYg9+X0nOm3HBxgUDDcjPKLI=;
	b=RWuzHw9VI1Jk2FXeGqDmB3Tg2hpVjvzjF/COduSUkbbWNfTPTtbET6VePQNeyNLG/c
	ijBy4mzHxzJ4zVK+iSn30WY+lD9W/2HjQ4tHrQLO8jh1QS52YvnwF6mDYA90+0Lv9JKd
	rzvj4adUjHyFLoZnASCA6PCU/aumJfsQMMKV1J83FHWF8YKAqFtlf+sV1BsLrVnspY0Z
	dmehVKi5fJW5d3wbQHIL5Jd7GMR/Txu/x5A9rjO5BWLVyG/y9eXaOjuhEIE8xxRMwh15
	pPQaujLrOwzamnqGnHY6hVyzYzC2Xna0FfGeOq0qTfIVyUIbzUI26gYph+vSmrVoSaMf
	zY+Q==
X-Gm-Message-State: APjAAAVsr0iW/bZ8r1MU82fLw4nXyg4fGSs1x21R6y9TBct3bXkL3EfO
	Hd33brLG0GQOy8ESU2Deyh2pPkY5
X-Google-Smtp-Source: APXvYqzVKLbOQLi37wYd7FF0SgMr4bWreGYlkegQDOGp2ODX+PAyy8Mff+KzCxrO2DMOCFySM70k5Q==
X-Received: by 2002:a17:902:bb86:: with SMTP id
	m6mr12861897pls.4.1553307129328; 
	Fri, 22 Mar 2019 19:12:09 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:45a8:35fd:6c1a:9e02])
	by smtp.gmail.com with ESMTPSA id s5sm4765246pgv.8.2019.03.22.19.12.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 22 Mar 2019 19:12:08 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Mar 2019 19:11:53 -0700
Message-Id: <cover.1553306877.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 00/12] Sumo pull request
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 23 Mar 2019 02:12:08 -0000

Please consider this for the next sumo update

The following changes since commit 6d56e912fbbaa22830b4da5ab230586a3d15b23e:

  package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25 22:13:08 +0000)

are available in the git repository at:

  git://git.openembedded.org/openembedded-core-contrib stable/sumo-next
  http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next

Chen Qi (2):
  systemd: fix CVE-2018-15686
  systemd: fix CVE-2018-15688

George McCollister (5):
  systemd: fix CVE-2018-15687
  systemd: Security fix CVE-2018-16864
  systemd: Security fix CVE-2018-16865
  systemd: fix CVE-2018-6954
  systemd: fix CVE-2019-6454

Marcus Cooper (1):
  systemd: Security fix CVE-2018-16866

Mingli Yu (1):
  logrotate.py: restore /etc/logrotate.d/wtmp

ROGEZ Matthieu (1):
  systemd: Fix typo in root home variable.

Richard Purdie (1):
  oeqa/runtime/dnf: Fix test error when static libs are enabled

Stefan Agner (1):
  run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts

 meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
 meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
 ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
 ...eserializing-state-always-use-read_line-L.patch |  250 +++
 ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
 ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
 .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828 ++++++++++++++++++++
 ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
 ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
 ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
 ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
 .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
 ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
 meta/recipes-core/systemd/systemd_237.bb           |   13 +-
 .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
 .../run-postinsts/run-postinsts.service            |    1 -
 16 files changed, 3694 insertions(+), 13 deletions(-)
 create mode 100644 meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
 create mode 100644 meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
 create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
 create mode 100644 meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch

-- 
2.7.4


