Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5870.1794742428833567994
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Nov 2026 03:33:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WY043Hu5;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8CE181A166F
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A95560238
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E909D11BC0029;
	Sun, 15 Nov 2026 12:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794742426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/wqIvbFOXfIMtcUs+SIOJIZvrbv56h4aW8MzVE6MSiM=;
	b=WY043Hu5Niu3ZbBjPxI5WdwhsizVAag6UZkb1+nQdFzOTR+14TxeAwG2US45bTSDZG7dxA
	meI6cZq0lorxiDirORbphGo/GyKObrHRkzUiLeywZXevbQuxWa2Lp3ZMB/g9aY8iVYywYJ
	pmYuLRFt6iLNorLojmbv2YCFpZwejB4ourcShSj6WAHw4OpVRLyRqqqMdVKgK1PP7Z1BUq
	4cYb9qvoRA/x6GEqudaj7KL4hVqhb5IPJVrgTWpsRtb1Gy9jNJuuXMTpCvZP4y3CZ9FP/T
	CcQ98jUgbODB6IziPn7lofYEIdJ1R7wUbwQpCtKa/Y/WbLOo0LG/KP3BJGmMZQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH RFC v2 0/3] Preparatory work for sstate cache log replay
Date: Sun, 15 Nov 2026 12:33:38 +0100
Message-Id: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKY+WoC/3WNwQqDMBBEf0X23C2aqG09FQr9gF6Lh6gbXVAji
 YaK+O8N0muPb4Z5s4Ejy+SgiDaw5NmxGQOIUwR1p8aWkJvAIGKRJ7GQOKi5Y1qwoWpp0dLUqxV
 9inl2S7WkWjUig7CeLGn+HOY3vJ4PKEPYsZuNXY83nxzVT5z+FfsEY5T6ojOhZHWl/F4ZM/c8n
 mszQLnv+xeOFkXFxQAAAA==
X-Change-ID: 20261023-mathieu-debug-replay-v4-6594f3ecad25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794742425; l=1648;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=sFTIX47scyQIqcZIzRy10aI8rEIh6qtsjdcnRuUUzEw=;
 b=zxPlVI5VDCLsei6RlXyj+hper4GYxTEj0gxNdAZU3vjmsR+0m6k6ATgn0WOwvp6iyFn0Awo6z
 L9f//oanNj1DiZdbMAnQfm/V2YD4sunwzWDwFfJbcCJtRrJ1gJ9cJ3B
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20435

The sstate cache mechanism currently has a blind spot: log messages shown
while a task first runs are not replayed when the task output comes back
from the cache. This is particularly true for warnings, which are
effectively hidden unless the task is rebuilt.

This bitbake series provides the needed support, storing each task's log
to a file that the openembedded-core series can later retrieve.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Store task log records in a shared ${TMPDIR}/logrecords store.  This
  lets tasks find records from other recipes.
- Always write the record file, even when empty, to clear stale messages.
- Claim covered tasks from any recipe, not only the current one, and pass
  their tids through BB_SETSCENE_CLAIMED_TASKS.
- Link to v1: https://lore.kernel.org/r/20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com

---
Mathieu Dubois-Briand (3):
      utils: Extend LogCatcher to record raw messages and levels
      build: Attach a log catcher to tasks and save their records
      runqueue: Hand each covered task's log to a single setscene task

 bin/bitbake-worker    |  1 +
 lib/bb/build.py       | 15 +++++++++++++++
 lib/bb/runqueue.py    | 11 +++++++++++
 lib/bb/tests/utils.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 13 ++++++++++++-
 5 files changed, 81 insertions(+), 1 deletion(-)
---
base-commit: f22df7e0e00be1f3c406138b8b7269d47ea491fe
change-id: 20261023-mathieu-debug-replay-v4-6594f3ecad25

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

