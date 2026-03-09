Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE4F3C27D
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:31:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28509.1773099105364821157
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 16:31:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=ZPp0LdFw;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C67043718;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A591C4CEF7;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773099104;
	bh=oTzWgxsxOXvjmbjq8qt/qPI414HTIyiopz/Z9CeCuy8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZPp0LdFwRAbzD2QiHXtVHtMjlrd8RTqIBl137UlOlrGCtEsSIybRPPrhH9ZVOHMrH
	 27TtIahvQymqPGDGw8ZpJvtP693FBsQpZNnSnm4emLxeZV0+UANB9gq241jLbj5wyk
	 ETb8Q+SI01TSvjgJS7KIcbCzuT5s0XZtzKGhwD2VvgAV5m4TVt4jKN5gnAKGzXhySJ
	 hZU1/3DIbxm0ZjA9ZYrOyh+asL23e9wR4tp9niJ0pGco97nohSBchJ2kHmqnkq2nyJ
	 n3Lcqfqmhf9+HT0nKcRMWooNcxy8c9eHu8MloB2HHn4TzKCYeLiTSpwfLLTJAFmjT7
	 N+InSHtwY5gGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD9BFCA16F;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Subject: [PATCH v2 0/4] fetch2: add alternative fetch method based on curl
Date: Tue, 10 Mar 2026 00:29:37 +0100
Message-Id: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFXr2kC/42NQQqDMBBFryKzbso4osWueo8iIU0mTUCNJKm0i
 Hdv6gm6fA/++xskjp4TXKsNIq8++TAXoFMF2qn5ycKbwkBIHTbYCmWMVGOWlrN2cuLsgpH6FUd
 xUfiwfacMUQNlv0S2/n2070Nh51MO8XNcrfXP/lNda4ECDRIht1a1/S3xWYcJhn3fv2nrpde/A
 AAA
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773099103; l=2161;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=oTzWgxsxOXvjmbjq8qt/qPI414HTIyiopz/Z9CeCuy8=;
 b=EY2P0nrM9NvcIAc2jA50bq7MgdjkQhO+UHyT4bfi6KyoXSm+o1s7rMkUwV9O9Sb4RrthqOSp6
 adYVlm+7V/CC0OL/4Ev7e/8YgHrIDnb+65ByoTqUNiiXjV6XeeD5eft
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 23:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19134

wget fetch method is used for web downloads with http, https, ftp, ftps
protocols. wget cmdline tool is missing some features such as hostname
resolution by the proxy when using SOCKS5 proxy. SSH tunnel provides
this feature for example.

This curl fetch method is based on curl cmdline tool and provides the
same protocols as wget and supports SOCKS5 hostname resolution.
This class inherits wget method in order to avoid code duplication as
much as possible.

wget remains the default download method. curl fetch method can be
enabled by setting a new bitbake variable:
  BB_FETCH_METHOD_HTTP = "curl"

The hostname resolution by SOCKS5 proxy is activated by setting
environment variable:
  all_proxy="socks5h://...""

a patch on ce-core will be sent if this proposal is accepted to
conditionnaly add curl to HOSTTOOLS variable in meta/conf/bitbake.conf:
HOSTTOOLS += "${@bb.utils.contains('BB_FETCH_METHOD_HTTP', 'curl', 'curl','', d)}"

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
Changes in v2:
- removed type hint unions and tested with Python 3.9, thanks Mathieu
  Dubois-Briand for reporting this.
- curl tests are now skipped when curl cmdline tool is not found.
- Link to v1: https://lore.kernel.org/r/20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com

---
Pascal Eberhard (4):
      fetch2: add curl method to fetch web content
      fetch2: make curl method activable with BB_FETCH_METHOD_HTTP
      lib/tests/fetch2: add tests for curl method
      doc: bitbake-user-manual-ref-variables: describe BB_FETCH_METHOD_HTTP variable

 .../bitbake-user-manual-ref-variables.rst          |   5 +
 lib/bb/fetch2/__init__.py                          |   2 +
 lib/bb/fetch2/curl.py                              | 162 +++++++++++++++++++++
 lib/bb/fetch2/wget.py                              |  10 ++
 lib/bb/tests/fetch.py                              |  75 ++++++++++
 5 files changed, 254 insertions(+)
---
base-commit: 48efc36b4e03f736e7521d269ced3417522784e9
change-id: 20260305-add_alt_fetch_method_curl-7a0bf96ad223

Best regards,
-- 
Pascal Eberhard <pascal.eberhard@se.com>



