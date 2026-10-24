Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5422.1792845244693043855
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 24 Oct 2026 05:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U3PmEHvF;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6FF161A1313
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F13DC60769
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C109103284BB;
	Sat, 24 Oct 2026 14:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792845241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=p5PyeJaG1IaizlLM4EVN0EfMt8M7f0vYdzhVEuvAMUE=;
	b=U3PmEHvFCCo9zue+XsO66u1YpmwM5hHdw6uCBpyW+dwnI/8hI/S+NYbp8qDQWYMjm4CRbb
	KeU/Qo1rQ0gbcn9/ZU9xivkzFrzjBV4iDG34HXqPU6R3btX2AIX3a+UJF9Z2TixmXwCjiP
	Xg2vB8nUfYeyL3cmgX4N4Vd+dmlIlihD84tAFqlAG3Z9RdlLjW9DU6vATOckWs9RJ1MKEV
	2bTOQSE1NhUHIENlBvl8IhGpG1ZIG4fU3+aA21TdXZeQMFN6/zEYjjQX8Z7LD4PxG9euRF
	OcEAhodObbd1HyjaPjctoXP6zGzxr7rtf6sFdYrb9M/qOzEHenH3a5EXqrKt8A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH RFC 0/3] Preparatory work for sstate cache log replay
Date: Sat, 24 Oct 2026 14:33:31 +0200
Message-Id: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJul3GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNj3dzEkozM1FLdlNSk0nTdotSCnMRK3TITXTNTS5M049TkxBQjUyW
 g7oKi1LTMCrDJ0UpBbs5KsbW1APs11f9uAAAA
X-Change-ID: 20261023-mathieu-debug-replay-v4-6594f3ecad25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792845239; l=1190;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=teoY2BU1INGTWM4dEzmy29ouq1OAhwPpuOUQYRu5QaI=;
 b=5xFJvwngIGzLKwesjSVG5m/Tgx2UAdRlHdJQBkkbyOcwIP7WUPaBD0FsyqLemyIRj50ZUv3sl
 DKAGOV59lqmBl/r7Lp+e/7JL+hoDdVPQa9pZeAji/Rhlhyec5qoAyLO
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20373

The sstate cache mechanism currently has a blind spot: log messages shown
while a task first runs are not replayed when the task output comes back
from the cache. This is particularly true for warnings, which are
effectively hidden unless the task is rebuilt.

This bitbake series provides the needed support, storing each task's log
to a file that the openembedded-core series can later retrieve.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (3):
      utils: Extend LogCatcher to record raw messages and levels
      build: Attach a log catcher to tasks and save their records
      runqueue: Hand each covered task's log to a single setscene task

 bin/bitbake-worker    |  1 +
 lib/bb/build.py       | 13 +++++++++++++
 lib/bb/runqueue.py    |  9 +++++++++
 lib/bb/tests/utils.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       |  4 +++-
 5 files changed, 68 insertions(+), 1 deletion(-)
---
base-commit: 1763256342ae4d7f8028e8222400c6fc8c24d4a3
change-id: 20261023-mathieu-debug-replay-v4-6594f3ecad25

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

