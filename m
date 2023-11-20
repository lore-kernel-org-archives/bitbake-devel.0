Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A3C2BB3F
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 14:53:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.50783.1700488825483120914
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 06:00:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=KkC/SnYV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-202311201400221862a73f487eb729f8-ucks8a@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202311201400221862a73f487eb729f8
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 20 Nov 2023 15:00:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=C8zlHcxZJK704IOqH7Si17MuR/0XZ8OKGg/yX+9dEk4=;
 b=KkC/SnYVfrVXO1K0dO7xI/kRhKH8eP6Qs6dPHshOTmnBd4b0qKPPTFz8CJ70GO7MJdmfK7
 QcUktiJzp2ekfun1AZG6Ti03YIL/t0ORC6wQ3x9K2RgS1KcNj2dziaVSGaPDx2Ugn1X7LhJI
 mq6FebA2lPxhWAyNn9Y5OZc31U35g=;
From: "Felix Moessbauer" <felix.moessbauer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: wei.wh.huang@siemens.com,
	andre.bossert@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Zhi Bin Dong <zhibin.dong@siemens.com>
Subject: [PATCH 1/1] fetch2/aws: forward env-vars used in gitlab-ci K8s
Date: Mon, 20 Nov 2023 14:59:33 +0100
Message-Id: <20231120135933.129426-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 14:53:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15540

This patch adds the following variables to the allow-list, which are
used in the "IAM roles for AWS when using the GitLab chart":

- AWS_ROLE_ARN
- AWS_WEB_IDENTITY_TOKEN_FILE

These variables are set in the CI job environment and are needed to
access the sstate cache artifacts in a connected S3 bucket.

[1] https://docs.gitlab.com/charts/advanced/external-object-storage/aws-iam-roles.html

Reported-by: Zhi Bin Dong <zhibin.dong@siemens.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 35e9ca96..22a2f801 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -872,6 +872,8 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'AWS_PROFILE',
                      'AWS_ACCESS_KEY_ID',
                      'AWS_SECRET_ACCESS_KEY',
+                     'AWS_ROLE_ARN',
+                     'AWS_WEB_IDENTITY_TOKEN_FILE',
                      'AWS_DEFAULT_REGION',
                      'GIT_CACHE_PATH',
                      'REMOTE_CONTAINERS_IPC',
-- 
2.39.2


