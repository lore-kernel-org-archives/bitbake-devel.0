Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10D0C54EAA
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 18:28:41 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.109920.1674844111752021532
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jan 2023 10:28:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WW+Tfne5;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 635F420007;
	Fri, 27 Jan 2023 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1674844109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1P2gt6Oo+l4W7hKD/MQEutW7QgWaivBqs3mXpr1S7A=;
	b=WW+Tfne5ydaNJXur6AkmrWjKlNvuqDrHlVaCbfunhmoLYUFkCQFDmBIZQcztP3Lp7OmANh
	D3z8c5ZJq6CxFg9D8+UMErXCYVK+QZ3FOO/M6VOQJ+B6LrE23gj6+FEGnIG63Tqf/xQXeY
	B/q4iAsWT0I0oad1mzQc7oysq23HtAzFYPgDIleEpMsmDw7Tmq+avnAABfquApV+2puuVp
	duI4IlM+ZawM7dCdgXZv2umziCS22FN6ElAH/IF6sw5/SscPsDetcWj+SnLB7HIEGCBBmG
	3sUyc7ekho+T+dXPmis2yTmsokpY7kLwRawyf8I41KYq3y9YbTKFyJN6JDAIwg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH] bitbake-user-manual: show how use BB_LOGCONFIG to log warnings
Date: Fri, 27 Jan 2023 19:28:24 +0100
Message-Id: <20230127182824.104830-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <45d84a3f5003bb58e14d51bbe4134e6aa46acde6.camel@linuxfoundation.org>
References: <45d84a3f5003bb58e14d51bbe4134e6aa46acde6.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 18:28:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14362

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Suggested-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../bitbake-user-manual-execution.rst         | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index f6ebf7ba..4fa3ca4b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -656,7 +656,7 @@ builds are when execute, bitbake also supports user defined
 configuration of the `Python
 logging <https://docs.python.org/3/library/logging.html>`__ facilities
 through the :term:`BB_LOGCONFIG` variable. This
-variable defines a json or yaml `logging
+variable defines a JSON or YAML `logging
 configuration <https://docs.python.org/3/library/logging.config.html>`__
 that will be intelligently merged into the default configuration. The
 logging configuration is merged using the following rules:
@@ -690,9 +690,9 @@ logging configuration is merged using the following rules:
    adds a filter called ``BitBake.defaultFilter``, both filters will be
    applied to the logger
 
-As an example, consider the following user logging configuration file
-which logs all Hash Equivalence related messages of VERBOSE or higher to
-a file called ``hashequiv.log`` ::
+As a first example, you can create a ``hashequiv.json`` user logging
+configuration file to log all Hash Equivalence related messages of ``VERBOSE``
+or higher priority to a file called ``hashequiv.log``::
 
    {
        "version": 1,
@@ -721,3 +721,40 @@ a file called ``hashequiv.log`` ::
            }
        }
    }
+
+Then set the :term:`BB_LOGCONFIG` variable in ``conf/local.conf``::
+
+   BB_LOGCONFIG = "hashequiv.json"
+
+Another example is this ``warn.json`` file to log all ``WARNING`` and
+higher priority messages to a ``warn.log`` file::
+
+  {
+      "version": 1,
+      "formatters": {
+          "warnlogFormatter": {
+              "()": "bb.msg.BBLogFormatter",
+              "format": "%(levelname)s: %(message)s"
+          }
+      },
+
+      "handlers": {
+          "warnlog": {
+              "class": "logging.FileHandler",
+              "formatter": "warnlogFormatter",
+              "level": "WARNING",
+              "filename": "warn.log"
+          }
+      },
+
+      "loggers": {
+          "BitBake": {
+              "handlers": ["warnlog"]
+          }
+      },
+
+      "@disable_existing_loggers": false
+  }
+
+Note that BitBake's helper classes for structured logging are implemented in
+``lib/bb/msg.py``.
-- 
2.37.2


