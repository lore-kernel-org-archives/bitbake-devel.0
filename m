Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3247F33A9D
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:32:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46940.1772724741185458018
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 07:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=ZVDBLmph;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5FE0461421;
	Thu,  5 Mar 2026 15:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11FCFC2BC9E;
	Thu,  5 Mar 2026 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724740;
	bh=cvbiLheeJnhWQf/i0mAc32p4j272BkKF0rHKq4OAZSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZVDBLmphrcflcZo+q38HmAg8qopETTPQ6/+4AR1zkj6SiOULpo06Jc0sUmn6pD3iJ
	 4plrHhjOZd83RCKmyg/thbmLOrUPZqqu/hV+Ly26V3L4uBXLjOI+Fxgq+aq+MurvIG
	 +tNVsJTh9MLxlg30ycThWQGMU3R5N5O16XrhbOBT3kx/FVPbpX1e/KHxG4Nzawhytt
	 poxmBNtRorwnHhW8qaOoHMcyANW6CcmdqvV2UCwPrrN8zJhkGbaPQdktMi2jG0GNle
	 t+FPraeCJtrBzyaoJHNAeNb/Byg53YLed0G+fOhx1sI0ofAARWmYSydleQO7zQAQOO
	 O1kD45q/8Ebtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09927F33A74;
	Thu,  5 Mar 2026 15:32:20 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Date: Thu, 05 Mar 2026 16:32:17 +0100
Subject: [PATCH 4/4] doc: bitbake-user-manual-ref-variables: describe
 BB_FETCH_METHOD_HTTP variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-add_alt_fetch_method_curl-v1-4-0d0220e5fa59@se.com>
References: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
In-Reply-To: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772724738; l=1168;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=mMN0eDTcP33G0a41mnOnUsgTrlLpjDXr5F9CTc4gENE=;
 b=3YjjWTMx3mANJIpSQ3N7C9AFZ0pigBV1/zGFUDpdMnAmlPKaLJHCKCfUOjjcq3UyunLVWA08e
 mICrzrkBdgZCJwDVJI38STe2y0Pfi+9wh1C35j4K/SF9g1PGaCR26b4
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 15:32:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19111

From: Pascal Eberhard <pascal.eberhard@se.com>

add BB_FETCH_METHOD_HTTP variable to select between wget and curl method
for http, https, ftp, ftps protocols.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 06bd53619..c459ed3af 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -311,6 +311,11 @@ overview of their function and contents.
       search the main :term:`SRC_URI` or
       :term:`MIRRORS`.
 
+   :term:`BB_FETCH_METHOD_HTTP`
+      When set to "curl", cause BitBake's fetcher to use curl method for
+      downloading web artifacts via http, https, ftp or ftps.
+      When not set (default) or set to "wget", wget method is used.
+
    :term:`BB_FILENAME`
       Contains the filename of the recipe that owns the currently running
       task. For example, if the ``do_fetch`` task that resides in the

-- 
2.43.0



