Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C7D5B86D
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 09:48:01 +0000 (UTC)
Received: from esa13.hc324-48.eu.iphmx.com (esa13.hc324-48.eu.iphmx.com [207.54.72.35])
 by mx.groups.io with SMTP id smtpd.web11.11011.1730281678611358903
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 02:47:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=J3vRG5GT;
 spf=pass (domain: bmw.de, ip: 207.54.72.35, mailfrom: prvs=026b2e8c7=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1730281678; x=1761817678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2gnA1fcjgI+lYJhSowtLWAtVki3TI6HCMiRB75rfh5g=;
  b=J3vRG5GTn9C+TB2wJ5hRzLv5DD1ABo0vIqJ7Rkf3/NefjG9m7Dtu4F2e
   JLWOWq/V1e86neSlhbq6H/mp0kX49ErQCZxkJVAoV0hOEO3ldmiiCyr3I
   6xWZ9zD6rukcxBmwxXfN3m0MFgYou9byC/xmWDZpumJz2lSDmmWFflAoF
   s=;
X-CSE-ConnectionGUID: 32iDGmuGRoGj3VPr8KZ9kg==
X-CSE-MsgGUID: KTHckVvuRvOZPhVcZ+2Opg==
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 30 Oct 2024 10:47:56 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw5.muc with ESMTP/TLS;
 30 Oct 2024 10:47:56 +0100
Received: from smucmp10e.bmwgroup.net (HELO SMUCMP10E.europe.bmw.corp) ([10.30.13.87])
 by esabb2.muc with ESMTP/TLS; 30 Oct 2024 10:30:47 +0100
Received: from localhost.localdomain (10.30.85.211) by SMUCMP10E.europe.bmw.corp
 (2a03:1e80:a15:58f::2027) with Microsoft SMTP Server (version=TLS;
 Wed, 30 Oct 2024 10:30:46 +0100
X-CSE-ConnectionGUID: ILDn/NEXQR655CzX9DQNgA==
X-CSE-MsgGUID: TbeW85vARRyXDEYJfdl99A==
X-CSE-ConnectionGUID: /0MvMWaaQEiTEWTQBumTJg==
X-CSE-MsgGUID: Wls5m7tRTG+k1KZtxlz6YA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Philip Lorenz <philip.lorenz@bmw.de>
Subject: [2.0][PATCH 0/1] Restore codeparser compatibility with Python 3.6
Date: Wed, 30 Oct 2024 10:26:42 +0100
Message-ID: <20241030092643.1598956-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP08H.europe.bmw.corp (2a03:1e80:a15:58f::1:1d) To
 SMUCMP10E.europe.bmw.corp (2a03:1e80:a15:58f::2027)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:48:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16742

Hi all,

sorry my previous patch missed the "[2.0]" prefix so I am resending with
the correct subject in place. The patch is only needed for kirkstone as
all newer (active) releases require Python 3.8 or newer which already
use `ast.Constant` for string nodes.

Philip Lorenz (1):
  codeparser: Fix handling of string AST nodes with older Python
    versions

 lib/bb/codeparser.py | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
2.47.0


