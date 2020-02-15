Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 5F59F60221
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Feb 2020 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=axis.com; l=810; q=dns/txt; s=axis-central1;
	t=1581737400; x=1613273400;
	h=from:to:subject:date:message-id:mime-version:
	content-transfer-encoding;
	bh=Yus6S3vOgk6AWLnzRGVStntHoOlmhM9joL7/sKZeaNg=;
	b=eeR/ET73aHABCyn26gjaSo2WJm/wJb6UDshDGqx2sU+YyAdBQr6ywoq/
	OPaQHDjrQcwtim96H5L+IQjsEktS+iWo079yUJNUdgjm7K5WshIyRnw+1
	XhyA6oUZ/uLX5nbbp1fMhDPZgWqsrwKYG3a8Ea4n8L4IatvqJPIYUicrI
	+PInlzNwFGNcoPQ+yUI6LZcHuvVZu0sUIbaRTosBgCvG3L+IGf5Pdc1Pp
	j9QAzyxdip0B3PF4hie5iN4A5GG1NPc3MDc689BYKFFRe9Tf/MO4fRQhr
	8WCiLxryou7bWXkyPO/d0glQwau08NBByg37515rHpFrHJ3l7nwmSl3JN w==;
IronPort-SDR: Zkaw+lpiHP70I5aV+6W7yQzvMen/tEcqpFTj/sH1F9A6lDSJx6aq4jBs1jNs9FL3MtErXqKQCN
	3SCVx3on1jUrbCdjHB23Hmhkng50LcAUqaa0auloshoaMvjn1GuMpPQVoIsDAtJkxpkzu9xh0H
	6F6Rvy2fkcpVhL+gMw2CAYsg0iZZltFrdoi42rvKHB3e+59bmvhMKtjfNXoHKanbFY+JdUUH59
	U8NJJvAz0KikeL7uWQ0uaqvT4fRRbMDqZ+1LJCUptOdKgBpGvO/wjQRlcOiLKlXJG5XU2IJAQd
	VWk=
X-IronPort-AV: E=Sophos;i="5.70,443,1574118000"; 
   d="scan'208";a="5300873"
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 15 Feb 2020 04:29:53 +0100
Message-ID: <20200215032955.3958-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Subject: [master][zeus][PATCH 1/3] knotty: Make the bb.command.CommandExit event terminate bitbake
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
X-List-Received-Date: Sat, 15 Feb 2020 03:29:58 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This matches the other bb.command.Command* events and without it,
running `bitbake --revisions-changed` will hang indefinitely if there
are changed revisions.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a0340dfc20..cbb289b05f 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -590,6 +590,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.command.CommandExit):
                 if not return_value:
                     return_value = event.exitcode
+                main.shutdown = 2
                 continue
             if isinstance(event, (bb.command.CommandCompleted, bb.cooker.CookerExit)):
                 main.shutdown = 2
-- 
2.21.1


