Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA516CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 13:16:49 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19355.1781788604071755682
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 06:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=B3DkBtZe;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=DZL5rVL2;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED4BE7A0147;
	Thu, 18 Jun 2026 09:16:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 09:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1781788602; x=1781875002; bh=/p
	EFyy8Yg9vbuYy2+ZYQSue9lnCFvI5uqM7qWyIc+wM=; b=B3DkBtZeGA3bdyf///
	SQV2SdHk166Y4kBAd8RdKK5bV5QKs90dQmUKs32/809WyfoxCi0viNnY0k/1eSGp
	rED1ZbCwAGZJCUddE7f+SR5amCXsqQyCmHex8H85bwJDjl/xapWkKZL/aVi0Rvqv
	rs+QGNTMZrnznIroic91CXxj65rm3Kcqh/APjKvkfwFlNUS8Rl/9mjy7xLjhmP7t
	ay3d8Wj8qIEXr4hVdX+QzM0loftKcREsYZFZc77J8NuZrObdrNZZy80sv17VnSL+
	pzolG7Js/R72YRA6OPcmE78xCjY3MDH8QDIugNiJ5CoGn8F4+Ir2lfw+N3xSJSuK
	ZANg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781788602; x=1781875002; bh=/pEFyy8Yg9vbuYy2+ZYQSue9lnCF
	vI5uqM7qWyIc+wM=; b=DZL5rVL24uQ7J7r6bzbDyMIAhuBo0j+NHRSbjH8b9B7v
	7J/YDNHSG05v43QKawt/Ws1Iet1D1EijcbABFShBRI3wsIjEo/P2fIqTphY2numu
	pZKTkJfCaaQHDffScPqWKEm+tM1OKyIbOWKcmqF9UTU1+W1W4/TxkuMBl4tDC3nv
	JImDOhKdS8enxarYVjjQe1uAhFJRJnJt5+TZb8yMOv5GhWeJE7ptvvaEZ0Ax+Hmd
	nhlkAdhwJ3OOYlPpuu1rr0yi/ryHYRsE9xJgG8J/MsN1oLJ9Qo92elfI7lXQGRZV
	F1Z39WnmFThHKFqlwdb99d7H+urF23wlEkOWSuYY5g==
X-ME-Sender: <xms:uu8zapjYFAYoULXk_HV2b4N__XxwuzBmjTrD9jIldmGiwYswj7BRUw>
    <xme:uu8zakBoLKZw9jrL3U8eTTxFVlwtblXF_rMCQqMZr0Tg6yLNy8ppXE446yn4itY3g
    wSzxU2a6345H6hzLIpsJl4LSRB-bKcSe7so4BHuGc1MLTkQDR-62YY>
X-ME-Received: <xmr:uu8zamvZ2nUDErOgoBJIkwWMvnepekvOt79WcqfWWaVMrJoIgqsbZIT-3h4sg78-Gzdy6ZUHKEJR0po2axfJXcuclgGJ6AI>
X-ME-Proxy-Cause: dmFkZTFCHpbihIuv/IpvkeTbxumH8LRKV8+Z083sJfO0VlZR0/yCCrgqnkeNkCcuI0NUZO
    BDtAJkYPc8NWDNberaUw+ox5odeNL0eObxvxqBpOqt368B5SCDa8F1z7F3gRfDSmDYCyq1
    C2tkL2Uqmr6nwImoR0aB4xX6Fw2r/7IfsDE6QTVS/8wFf2M2kUXMWFswMIs9BAmNJykoBJ
    cTnCUa0YrpmNJ1pDGq5kyTkEH/dZgo08VQgujzL+gUphUsC+bjYkMf7nHYaJs1E9A9WFid
    RkWJwLRa0IqsMDaEiueh3INf4p/grqfTshOAS/4Gu4Yv2g9wFO0zU1NRIbn/lm/ofTBOTv
    XjCak+qqM9VJ3Gc+WYMy8i26F0tGxvKJlyMl2aUM0h6wH0zHhN+kxsC1K34rsQ5nbI24/r
    Hky5kCy9eFFvAWvXx+s5VgdEpreqjUOfkNRbiDbTe6Q0Iy3FX0xTjfW8DpHfm9xaKN/KeV
    ft5EXz9nQqLB14HZjDtj8N1AgChZmVyK4fWSthIpgV9RLEfC73Y1+13GUqWZ3/OxdABDPE
    Pip9H19gMscA+LgO2H5XS0llS1cikAjBbaSmNtLKAVowBqQv0phbjkC20v8HCVNxjSePvG
    JeF/OI+XxDSxfIw0QLivRhiXkKr3/gki6OcUa7Fmeg3lnKcj3l5E65auO5QQ
X-ME-Proxy: <xmx:uu8zapb9Ai6vrM07Tu9T1wimgOA475NncncSFHj5DMLD_mAwXervDw>
    <xmx:uu8zapU6KQuuBLGqzXfXjzuyqDL_K4pwgCUgyVaEZKCMtJJDK5kXow>
    <xmx:uu8zat66I6AQJZhuPw11AldMv6sAOL510x73LFTWyf3NmCAKQDje9w>
    <xmx:uu8zaki3Vu1EvH1WtdrqOxBnfCgpaSdZs89RtrELn0N1uw-h78PSQw>
    <xmx:uu8zamFxYcc44ed0R6ZerkwBcPIeWdpfGss2q4fhnLe-IpMZrGHJtu5q>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 09:16:41 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Thu, 18 Jun 2026 14:16:33 +0100
Subject: [PATCH] readme: Update minimum Python version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-readme-v1-1-4ced84173c82@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIALDvM2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ML3aLUxJTcVN0UwxQL0xQjC8vk5CQloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AM04gD2oAAAA=
X-Change-ID: 20260618-readme-d1d85d289ccb
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=f3Eildlc+e9oncQ36DA1nfEmrYuHav4UYTrSppfZym0=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQZv9/2/f7fz+vnfI730f4czb874F2PvJz0cjV3jXuX3
 mrujH1Z3VHKwiDGxSArpsiyuefr/ae9jrwZIbcUYOawMoEMYeDiFICJtLEwMiz6Us/196vQYu8s
 WZeHiRs/TOlfOW1e8fxXZo1z9i2OZq1l+CscVLtuXuoaWy4V38n8ccYJ/1vzxSTDLDP0P3ac2XZ
 Omg0A
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 13:16:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19738

This was changed in commit 0d2e682d00df ("lib/bb: Bump minimum python
version requirement to 3.9").

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index e9f4c858ee14..39e4a97862f0 100644
--- a/README
+++ b/README
@@ -13,7 +13,7 @@ Bitbake plain documentation can be found under the doc directory or its integrat
 html version at the Yocto Project website:
     https://docs.yoctoproject.org
 
-Bitbake requires Python version 3.8 or newer.
+Bitbake requires Python version 3.9 or newer.
 
 Contributing
 ------------

---
base-commit: 7e6466f48191c1e4ab9b91705deb237eff2c7f01
change-id: 20260618-readme-d1d85d289ccb

Best regards,
--  
Paul Barker


