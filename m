Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
	[209.85.215.179])
	by mail.openembedded.org (Postfix) with ESMTP id 9BEFF7F847
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:46 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id k197so8183180pga.10
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=TwnYRglVEcPc18tD3m5MK4bznFox4HA/ISn9Nu9Uc0Y=;
	b=S2bU4RQgZEQ66ez0Mnc6QOnBa44uK+kCsgAYlZpcBdP6+8nZZ1/b83e9/tKSwSQ+zT
	ad8NkescWhVmBHq0l34fNz1z88YOwYhUX+KPJl5mmOYszKemzLchswOQPhDN133RsBaW
	OF57Blq8W/FcC3fVAf8uLpPDd6mNJ7KDEbowsZ4dhySI/8zmzreWpQWWY10s32Y7l3yD
	YVS1JUo4EYGsfTXMU58KcL5p89/HZ6ezqOR3SQfNtjAywICsKV17yQm6UExzYfShPZGf
	7TLIt5VRPqZg+Bpu2TklVBDWByzbptIOTfna+g/7qU1uBWCcJ/higjehtJe27a8jh/Po
	QRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=TwnYRglVEcPc18tD3m5MK4bznFox4HA/ISn9Nu9Uc0Y=;
	b=Ip8q+aJRDCHnzKo1kuJRNXhl+UORndbtxJ9jTEgGLM7p2GZpL4+7TIQ/6cIZomb2Wj
	wVx11iHqvijy6tODmth9hvhSULG/cyrGsOuxXiSiPE2kqil50O4MqyKpdlrSahc3Y+ez
	aXHxq0ioF1xliOeJIB6SXCpJ4Op+lzwWOOxdvt4UTz4BdIjhGnksEnNvWpdx1Y19tc/I
	1PK7F/kECW+cFvKEPOFHPz0p+a0ACAPI6p1lo2QpRN+KcHlx1l2LLLrDsfJFthhqw+lV
	iuA32TBIokducoKP3l//eXTPREwIWI5kPHXdjKOB9+CrAc9BIm7RBdR+3eo1eP/lZhh1
	iNTg==
X-Gm-Message-State: APjAAAXJ0EhFcbJ35WjUKijVge7aewieXJB7z7DjCeSLZ06JMBdvFPa0
	8q0DyhZaLQ5XCex6jcTBeGs3IaQzTsE=
X-Google-Smtp-Source: APXvYqx+ug7J8L5YRQ5N2zbe84+WvPnGbBWXfegvEGfHKJsdddD4/rVLtpEEbqjBUw9cD7F/bP6TZA==
X-Received: by 2002:a63:950c:: with SMTP id p12mr29612476pgd.85.1577076647486; 
	Sun, 22 Dec 2019 20:50:47 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.46
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:47 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:25 -0800
Message-Id: <0d154434ed8e3e88ad440a8dd21a164e72ba4ac5.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 01/18] hashserv: Add support for equivalent hash reporting
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:46 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The reason for this should be recorded in the commit logs. Imagine
you have a target recipe (e.g. meta-extsdk-toolchain) which depends on
gdb-cross. sstate in OE-Core allows gdb-cross to have the same hash
regardless of whether its built on x86 or arm. The outhash will be
different.

We need hashequiv to be able to adapt to the prescence of sstate artefacts
for meta-extsdk-toolchain and allow the hashes to re-intersect, rather than
trying to force a rebuild of meta-extsdk-toolchain. By this point in the build,
it would have already been installed from sstate so the build needs to adapt.

Equivalent hashes should be reported to the server as a taskhash that
needs to map to an specific unihash. This patch adds API to the hashserv
client/server to allow this.

[Thanks to Joshua Watt for help with this patch]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 674692fd46a7691a1de59ace6af0556cc5dd6a71)
---
 lib/hashserv/client.py |  8 ++++++++
 lib/hashserv/server.py | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index f659566..ae0cce9 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -148,6 +148,14 @@ class Client(object):
         m['unihash'] = unihash
         return self.send_message({'report': m})
 
+    def report_unihash_equiv(self, taskhash, method, unihash, extra={}):
+        self._set_mode(self.MODE_NORMAL)
+        m = extra.copy()
+        m['taskhash'] = taskhash
+        m['method'] = method
+        m['unihash'] = unihash
+        return self.send_message({'report-equiv': m})
+
     def get_stats(self):
         self._set_mode(self.MODE_NORMAL)
         return self.send_message({'get-stats': None})
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 0aff776..cc7e482 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -143,6 +143,7 @@ class ServerClient(object):
             handlers = {
                 'get': self.handle_get,
                 'report': self.handle_report,
+                'report-equiv': self.handle_equivreport,
                 'get-stream': self.handle_get_stream,
                 'get-stats': self.handle_get_stats,
                 'reset-stats': self.handle_reset_stats,
@@ -303,6 +304,41 @@ class ServerClient(object):
 
         self.write_message(d)
 
+    async def handle_equivreport(self, data):
+        with closing(self.db.cursor()) as cursor:
+            insert_data = {
+                'method': data['method'],
+                'outhash': "",
+                'taskhash': data['taskhash'],
+                'unihash': data['unihash'],
+                'created': datetime.now()
+            }
+
+            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
+                if k in data:
+                    insert_data[k] = data[k]
+
+            cursor.execute('''INSERT OR IGNORE INTO tasks_v2 (%s) VALUES (%s)''' % (
+                ', '.join(sorted(insert_data.keys())),
+                ', '.join(':' + k for k in sorted(insert_data.keys()))),
+                insert_data)
+
+            self.db.commit()
+
+            # Fetch the unihash that will be reported for the taskhash. If the
+            # unihash matches, it means this row was inserted (or the mapping
+            # was already valid)
+            row = self.query_equivalent(data['method'], data['taskhash'])
+
+            if row['unihash'] == data['unihash']:
+                logger.info('Adding taskhash equivalence for %s with unihash %s',
+                                data['taskhash'], row['unihash'])
+
+            d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+
+        self.write_message(d)
+
+
     async def handle_get_stats(self, request):
         d = {
             'requests': self.request_stats.todict(),
-- 
2.7.4


