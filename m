Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12648.1794580489537023365
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Nov 2026 06:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=RFdrddVt;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D3EB1C4F76D
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 14:34:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3384160015
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 14:34:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0E9111BC040F;
	Fri, 13 Nov 2026 15:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794580486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ej4plLy9azKfHrrm7YighmJP1wFJgpQlsNUVT6D/z40=;
	b=RFdrddVtm/KMZEzt9J4865OooRsCLvBy5KW6EVPJOGzVZbXrC+qqC98Md0n80QztqjCtNr
	MA7+ceMiDY0seU+OS+PKRAb6QLDuUOZKoniGfllvNSG+euyXHZhGlypd9aLRgM2jOhHm4G
	V5/GzP0A2X9ZqMVCcJ9ZKr81Ry1DzCZfdt3GVZXLQU3aA06zQaCqPvT+gJ2k1Ro8FB+C4p
	EfDguqSCmjNR/TFBPbO/MGWBHvnbLKvCg0I97LlLf20/zKSijLXGMPOOrQnut7jrwLV/H7
	im81z3M9BSxCuYH4TEHvB7hRqrrbucs9zI1g/yt8muS63y7lHqa7yjN9d0DiyA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 13 Nov 2026 15:34:36 +0100
Subject: [PATCH] cooker: create missing eventlog directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mathieu-b16492-write-variables-v1-1-9f1f86aebc8b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPsf92oC/x3NywqDMBBG4VeRWXfASYPEvkrpIml/dUBtmXgpi
 O/e0OW3OeegDFNkulUHGTbN+p4L5FLRc4hzD9ZXMbnaNSJy5Skug2LlJI1vHe+mC3iLpjGNyOx
 b7xEQQko1lcjH0On3P7g/zvMH8rD4qHAAAAA=
X-Change-ID: 20261113-mathieu-b16492-write-variables-4944e8e88bb0
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794580485; l=1926;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=rQxaT4ljhnGNA6vCy8mtF1RIMI2/uYkppaZQtXvGQb0=;
 b=cwgvWEjjg4cRmuy0z3/7u94G/rxQnJCdqp5EfOKYd3YilG28T7+Zpr88hhibRf2BzNWBY6fbT
 7+J7AI1pX07C1P+dTJo9ShFQ6kiWvXynnKkiPz7xO8o7/KarkK+qYZf
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 14:34:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20430

If the eventlog folder is removed while bitbake is still resident in
memory, it will not be re-created on the next build and result in an
exception while trying to write event logs. Catch this exception and
create the folder as expected.

[YOCTO #16492]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/cooker.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8a422e50621a..5b8b35c133bd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -112,12 +112,22 @@ class EventWriter:
         self.eventfile = eventfile
         self.event_queue = []
 
+    def _open(self):
+        try:
+            return open(self.eventfile, "a")
+        except FileNotFoundError:
+            # setupEventLog() creates the folder, but will not re-create it if
+            # it is removed between two builds, with the resident process still
+            # in memory. Catch the resulting exception and re-create it.
+            bb.utils.mkdirhier(os.path.dirname(self.eventfile))
+            return open(self.eventfile, "a")
+
     def write_variables(self):
-        with open(self.eventfile, "a") as f:
+        with self._open() as f:
             f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
 
     def send(self, event):
-        with open(self.eventfile, "a") as f:
+        with self._open() as f:
             try:
                 str_event = codecs.encode(pickle.dumps(event), 'base64').decode('utf-8')
                 f.write("%s\n" % json.dumps({"class": event.__module__ + "." + event.__class__.__name__,

---
base-commit: f22df7e0e00be1f3c406138b8b7269d47ea491fe
change-id: 20261113-mathieu-b16492-write-variables-4944e8e88bb0

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

