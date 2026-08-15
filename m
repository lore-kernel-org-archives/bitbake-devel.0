Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A9C5DF70
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:40 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9200.1786801649528083339
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=ZAmjsgNh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260815134726c3db8467dd00020722-s9omaf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260815134726c3db8467dd00020722
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CQsZcXpyWyLGilMjc623DfKQubRBA7EI/l7O4xW1Ylk=;
 b=ZAmjsgNhlWpb6gzlQWxU56j9KeaSWy833KGEzUUMEhI/B6hapYPFhBdFCHzukrIDo19aLb
 IsKSq/OKMewShbS+UxIBelxkc1vC0LJajtUeQHsmT+PBB5Vxj7DHWYPwcc9+kKw1Cbgk/GCK
 ND8dDMnQiPQP46maiG2KPF6/R1W/5ElLlxOINA45rvWsv89aDKGmrgOI54eSAmbTcVhnv6LA
 jlxhXXV8DXUCon8x2fhosWhiJBygR3DxK5ul1VyWn7KB4iQWXxnRZyrkGUnPvyajO3KsiuoE
 IDmwGdkjwChoqUMdLHdBc+XnLBaBTUxuZHd3CI6d46K3nkYqbkv+CTDA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/7] cooker/tinfoil: fix -b bbappend handling and add single-task prepared-task API
Date: Sat, 15 Aug 2026 15:46:51 +0200
Message-ID: <20260815134722.497586-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 13:47:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19951

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Hi Richard,

Probably you remember how many attempts I tried to solve this nasty issue for
devtool ide-sdk already. I hope you consider this usage of AI as a positive
one. I also flagged these commits as AI-generated to be transparent. I also
tested them extensively with my WIP devtool ide-sdk branch.

This series makes the BitBake side of the devtool ide-sdk workflow reliable by:
1. fixing `bitbake -b` so recipe `.bbappend` files are actually applied,
2. adding a single-task execution path for already-prepared tasks, and
3. adding regression coverage for both behaviors.

It also includes two related correctness fixes:
1. setConfig now preserves boolean types (instead of turning False into
   truthy "False"),
2. include_all now ignores empty BBPATH segments to avoid false
   duplicate-include warnings.

Thanks for reviewing.

Adrian Freihofer (7):
  cooker: fix bitbake -b silently ignoring bbappends
  tests/cooker: add a bitbake -b bbappend test
  command: fix setConfig coercing bool config values to truthy strings
  cooker: add a buildFile mode that runs a single task
  tinfoil: add a prepared task runner
  tests/cooker: add TinfoilTests for run_prepared_task
  parse/ast: skip empty BBPATH segments in include_all

 lib/bb/command.py      |   8 +-
 lib/bb/cooker.py       |  14 ++-
 lib/bb/parse/ast.py    |   4 +
 lib/bb/tests/cooker.py | 211 +++++++++++++++++++++++++++++++++++++++++
 lib/bb/tinfoil.py      |  23 ++++-
 5 files changed, 253 insertions(+), 7 deletions(-)


base-commit: 2c236d8bdc51742cbc5a97e30fb126d82d4a908a
-- 
2.55.0


