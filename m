Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C1C0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 11:57:45 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.193])
 by mx.groups.io with SMTP id smtpd.web10.8580.1737806264069304373
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 03:57:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=S9N2GI11;
 spf=pass (domain: freemail.hu, ip: 46.107.16.193, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YgCq8603ZzNvH;
	Sat, 25 Jan 2025 12:57:40 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] bitbake: cooker: Fix performance issue in EventWriter() class
Date: Sat, 25 Jan 2025 12:56:40 +0100
Message-ID: <20250125115640.1302-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737806261;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 11:57:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17082

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1953; bh=okk/tT651LeBSVyAf2AOO0WIVGpcyHb/Ga2ccGkHU9E=;

	b=S9N2GI11WOVw6Ge94jecTFV3BpsBGQ7dU9J+f2Y3CH+6mdFJWGi6NuINxYrhITr9

	cE8aBvQJDvG/be3N4DUVYgDrTqCKVXWbxVdVg6T8d8GZ9/78Y08Fe1vRwrMdqVuxsls

	nkMCbJVyiKaBQ1LDNejdFlf2QCTnyOhDfn0OdMczjim3vKvlAr9+1KsjFkcvYe3V+zx

	P8acFvSFYrUa3JM4KYLojfteH/W4jQe0w7F6aT2OedmhJznAcSDwd9XgUV+8DnW12pD

	FTYx9ZYLbq8GccVmjPvKpSfkpz8wV7DMTr7jAJKk12BWf4MBIxFROAavavVyklVurHG

	VBvokIZ0+A==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Reopen eventfile is a very time consuming call in every send() calling. I=
t was
fixed by -> open its file descriptor in __init__() and close it in __del_=
_().
Remove unused self.event_queue =3D [].

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/cooker.py | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5b885cddd..485c3d3ad 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -100,24 +100,26 @@ class CookerFeatures(object):
=20
=20
 class EventWriter:
+    # 2 MBytes buffer for eventfile
+    _BUFFER_SIZE =3D 2 * 1024 * 1024
+
     def __init__(self, cooker, eventfile):
         self.cooker =3D cooker
-        self.eventfile =3D eventfile
-        self.event_queue =3D []
+        self._f =3D open(eventfile, "a", buffering=3Dself._BUFFER_SIZE)
+
+    def __del__(self):
+        self._f.close()
=20
     def write_variables(self):
-        with open(self.eventfile, "a") as f:
-            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.g=
etAllKeysWithFlags(["doc", "func"])}))
+        self._f.write("%s\n" % json.dumps({ "allvariables" : self.cooker=
.getAllKeysWithFlags(["doc", "func"])}))
=20
     def send(self, event):
-        with open(self.eventfile, "a") as f:
-            try:
-                str_event =3D codecs.encode(pickle.dumps(event), 'base64=
').decode('utf-8')
-                f.write("%s\n" % json.dumps({"class": event.__module__ +=
 "." + event.__class__.__name__,
-                                             "vars": str_event}))
-            except Exception as err:
-                import traceback
-                print(err, traceback.format_exc())
+        try:
+            str_event =3D codecs.encode(pickle.dumps(event), 'base64').d=
ecode('utf-8')
+            self._f.write("%s\n" % json.dumps({"class": event.__module__=
 + "." + event.__class__.__name__, "vars": str_event}))
+        except Exception as err:
+            import traceback
+            print(err, traceback.format_exc())
=20
=20
 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D#
--=20
2.47.1.windows.2


