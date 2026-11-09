Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1562.1794210412383899729
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2026 23:46:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=orb7I5Q5;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+patrick.vogelaar.belden.com@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 747FC41905;
	Mon,  9 Nov 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794210411;
	b=o2Im0I3gLQh2fpdhRMt+dE/tGap43zuBCObsJnI/+viY1o7e+9UBAjdjChCAXRkv0Hkj
	 zA5JEJ2EseyDP3bCj1GvrshWmukJAVjmpiqNe/1nSyzSRHNpb4ZprhH5uDzzLco4EoZeB
	 5nrMxqbUSyLe8jiISR4ZtsCwwlK95squIkdwbtQyZJNAfuI8RBSAFAKt3frXx/cS5Fdk8
	 BAHN3bu+kbdn3Wtvu/BMm6tXYlz1Ohw0M1vYFan85lWFeZslALnF38gQMwBSYM4qcvebT
	 e7v/7QBrxIbTy5HRxOD/7SPp7JJo4K7BgAoNoS/DQ0VgjghBDjf9EFuQlObWOLSMlUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794210411;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kyCUsKJM5Liwm98LvUReixMLxU7gf+l9kvCid5atfYE=;
	b=VeEH35hVcWIA52iz+I9TzPlGHiq1+4se01Jsn2JejtX3NX3ZMhNKf0xwBmMOQpg42sKu
	 rgRM6GYlzBL02A3w+9Ds5Wc8gLvRZAo5p+pVCskqG1q347jxGaJTO1we4EL07TxTwJuMZ
	 BNsLInPyUIg5q32rhzOT530GS8F3OKV4p/TiTdNe7EegUhzro0e73X8kVq7YNP+T4fNtm
	 fpLOW4c7euhqRUFyppw73qWDhI05dwiwq5qFG8CNzMunCWB/ss9wqS5j5ydcZiv7wwO3S
	 On8ro4D9p+87M8RDGRmH7ygrcXfXrBsDR71ELgKH2Eu5BM8pYujaMN17EljpTPSIYwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2CDA1F008A1;
	Mon,  9 Nov 2026 07:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210411;
	bh=kyCUsKJM5Liwm98LvUReixMLxU7gf+l9kvCid5atfYE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=orb7I5Q5XloHnTQ16dHL9Q0ebEgIXvBkdpozJKFNqTlr5YqofpaYEQiG3UNmEMgxG
	 Btg9DJ5aBI763MdoB7nJUhFMLXecoF+QOBZUGQnppuoLUX58ZxHqqSXDs1ILCdgPoE
	 VcUyUIATSjBKHMYOidk8iJ1TnmA6nsriMW7Q0XKDlcmowDJyvJ9BKB4Fm14zjO3YSG
	 /yLu9FV6TE064NnFQPCnlOxoShGvsB84A71wr8IxhUd90mkAOb4Qmpj8Mc3RhSavA8
	 AIMMYBa+KDSSZbHVI6MSVf+7zZE/vMyZRFdXrlcx+7+rOT5Q7p0bfZkjmxHkPTNcQY
	 3ejW7qmbTSQNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4119848337;
	Mon,  9 Nov 2026 07:46:50 +0000 (UTC)
From: Patrick Vogelaar via B4 Relay <devnull+patrick.vogelaar.belden.com@kernel.org>
Subject: [PATCH 0/3] toaster: changes with regards to read-only log viewer
Date: Mon, 09 Nov 2026 08:46:36 +0100
Message-Id: <20261109-toaster-projects-nobuild-v1-0-7e65cadc2d39@belden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFx68WoC/yXMQQqDMBBA0avIrDuQRLGlVyldmDhpp5REZqIUx
 Ls36vIt/l9BSZgU7s0KQgsr51RhLw2E95BehDxWgzOut9Z0WPKghQQnyR8KRTFlP/N3RO/a2F6
 70Edzg5pPQpF/x/rxPK2z35v9B9v2B9SfUF98AAAA
X-Change-ID: 20261104-toaster-projects-nobuild-b23f374c6f08
To: bitbake-devel@lists.openembedded.org
Cc: Patrick Vogelaar <patrick.vogelaar@belden.com>, 
 patrick.vogelaar.dev@mailbox.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794210409; l=3007;
 i=patrick.vogelaar@belden.com; s=20240201; h=from:subject:message-id;
 bh=VCr0jHm4/PNvKc7k52uK8u8JX9Pb+Vwb6LJyxkNolO8=;
 b=darhvCPqPTqyRmQ4Kf9cmSRY8vH3aUxWSM3tAltXj5Pb3K1VRXcC2kNRiMpBUMANvb0Jj1FlE
 GgEYENzHeV3AtZtBfwBv9Yb9Au0Ys6yV22/Lx9GVRF8HMr6rsAOy84N
X-Developer-Key: i=patrick.vogelaar@belden.com; a=ed25519;
 pk=w0QU8RmOR3hQv1DxMcz6KmySeE8yqbvO0xC1ZSSUNqY=
X-Endpoint-Received: by B4 Relay for patrick.vogelaar@belden.com/20240201
 with auth_id=125
X-Original-From: Patrick Vogelaar <patrick.vogelaar@belden.com>
Reply-To: patrick.vogelaar@belden.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 09 Nov 2026 07:47:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20408

We use Toaster as a read-only build viewer for CI. Every CI build
uploads its bitbake event log to a shared Toaster instance, which
imports it with toaster-eventreplay and is started without build mode.
This works today, but has three limitations that this series removes:

* All imported builds land in the "Command line builds" project, so
  builds of differeent branches or CI instances cannot be told appart.
* Whithuot the build mode. projects are hard to reach because the
  "All projects" tab is hidden and project links lead to the configuration
  page for builds.
* And IMHO there was a bug that the time of the import instead of the
  actual start time.

Patch 1 shows projects and their builds without build mode and hides
the configuration pages and build actions there.

Patch 2 adds the TOASTER_PROJECT variable: if it is set, a command line
build or replayed event log goes into the project of that name, which
is created if needed. Without the variable nothing changes. It also
decides whether a build is a command line build from the absence of a
BuildRequest instead of from the default project, so command line
builds in named projects get no Rebuild/Cancel actions.

Patch 3 takes the build start and end time from the log and task
events, so a replayed log keeps the times of the original build. Live
builds are unchanged apart from at most a few seconds.

Signed-off-by: Patrick Vogelaar <patrick.vogelaar@belden.com>
---
Patrick Vogelaar (3):
      toaster: show projects and builds without build mode
      toaster: group command line builds by TOASTER_PROJECT
      toaster: take build times from the events

 bin/toaster                                        |   2 +-
 .../bitbake-user-manual-ref-variables.rst          |  13 ++
 lib/bb/ui/buildinfohelper.py                       |  54 +++++++--
 lib/bb/ui/toasterui.py                             |   1 +
 lib/toaster/tests/browser/test_all_builds_page.py  |   2 +
 lib/toaster/tests/buildinfohelper/__init__.py      |   0
 .../tests/buildinfohelper/test_build_time.py       |  62 ++++++++++
 .../tests/buildinfohelper/test_cli_project.py      | 131 +++++++++++++++++++++
 lib/toaster/tests/views/test_nobuild.py            |  94 +++++++++++++++
 lib/toaster/toastergui/templates/base.html         |   2 -
 .../toastergui/templates/basebuildpage.html        |   4 +
 lib/toaster/toastergui/templates/mrb_section.html  |   4 +-
 .../toastergui/templates/projecttopbar.html        |   2 +-
 .../toastergui/templatetags/project_url_tag.py     |  11 +-
 lib/toaster/toastergui/views.py                    |  13 ++
 lib/toaster/toastergui/widgets.py                  |   2 +-
 lib/toaster/tox.ini                                |   3 +-
 17 files changed, 378 insertions(+), 22 deletions(-)
---
base-commit: 0f33b68cbabab26c9ed1585e3ee109689d206812
change-id: 20261104-toaster-projects-nobuild-b23f374c6f08

Best regards,
--  
Patrick Vogelaar <patrick.vogelaar@belden.com>


