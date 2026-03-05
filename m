Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E83EEF318
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:32:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46941.1772724741208090903
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 07:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=qt3ajmTO;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F52161339;
	Thu,  5 Mar 2026 15:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FB1C116C6;
	Thu,  5 Mar 2026 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724739;
	bh=ihFxY3TCVaHzWHIqpRps9YRVw2y0wDa0845NlkZJCeM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qt3ajmTORhXaTAND27FZiyc4hxBbS9RCbpwOmk+67JrPRqsNG5R4LFBJJBTik0gnW
	 s0fX8SY7kHtBRHGgF2/TJAuKGFd0ZW8LJeHf57tYm2Ubw29/Fw+o3BB6AlQFzpbT6Y
	 I/0caLn34XGEG7jGeRfCngtr7g3/HoohIhH6V8ac5Q3gVY+bKzZfL2NKvDhFf873kU
	 8ZB3PBRsYjZjnfVRJdEzaDdG7sVqs36269nMflGXJDwAkKGi2lesBgjpEnEQoo9MQo
	 PnXUYX9Ozfcefr3XVx4PmQTFpZhyGp9iePh0gurqXzW4wlQk1FHPwKOtgd/VZ21Wp0
	 r39MloDt9ZTWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F7F33A74;
	Thu,  5 Mar 2026 15:32:19 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Subject: [PATCH 0/4] fetch2: add alternative fetch method based on curl
Date: Thu, 05 Mar 2026 16:32:13 +0100
Message-Id: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP2hqWkC/x3MQQqDMBBA0avIrBuIEZV6FSlhzEzMgFVJYimId
 ze4fIv/T0gchRMM1QmRf5JkWwvqVwUu4DqzEioGo02nG90qJLK4ZOs5u2C/nMNG1h1xUT3qyb8
 7JGMaKP0e2cv/eY+f67oBNKxzQ2sAAAA=
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772724738; l=1861;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=ihFxY3TCVaHzWHIqpRps9YRVw2y0wDa0845NlkZJCeM=;
 b=jJYogJaaMlHbaYKAXV8MkCR8NogIPOzVt81BzdJWaK1VE4cZHNEhH+NUjMLyoKc9mVeqnybA5
 Y6sP+/85uJgBt0n/MovXRw9JSUkSNHqY7xOCHHBVmZtgRk2CQblDQX7
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 15:32:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19114

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
Pascal Eberhard (4):
      fetch2: add curl method to fetch web content
      fetch2: make curl method activable with BB_FETCH_METHOD_HTTP
      lib/tests/fetch2: add tests for curl method
      doc: bitbake-user-manual-ref-variables: describe BB_FETCH_METHOD_HTTP variable

 .../bitbake-user-manual-ref-variables.rst          |   5 +
 lib/bb/fetch2/__init__.py                          |   2 +
 lib/bb/fetch2/curl.py                              | 162 +++++++++++++++++++++
 lib/bb/fetch2/wget.py                              |  10 ++
 lib/bb/tests/fetch.py                              |  68 +++++++++
 5 files changed, 247 insertions(+)
---
base-commit: 48efc36b4e03f736e7521d269ced3417522784e9
change-id: 20260305-add_alt_fetch_method_curl-7a0bf96ad223

Best regards,
-- 
Pascal Eberhard <pascal.eberhard@se.com>



