Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id 1A9D37F2BC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 11:53:03 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id d16so3593085wre.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 03:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SG4SQOHu19+GnH1xfpmRckTPs8bcEJsjS0TeDdsI1xI=;
	b=DDdjAogj/2+mlLJ7W4OWrSnHuQmFEbS3DM5US3ygdBTFVajnUhgz2NTdA+lHRGYOB1
	vuzwApyJsK247KQMIe99/51hEuKXvEVDuv2icGT0ZtAwuSnGROjq5sVYkzL4sq+fHhak
	I5IzZ25fSJNYt3uUcRi5q6AHNBnNltfL/7N8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SG4SQOHu19+GnH1xfpmRckTPs8bcEJsjS0TeDdsI1xI=;
	b=Kw6u99Lh+Vj9n8lYHuXssdedfTiXIHyqJSlv/q+Yn0Ii1h+NVJZ005QiHlA9EUWG3j
	AJCYeHiUsnE22/Kdns4x2opcLbnRz8NRYXooVuh6jusGpFZ4ubDnereU9EyZu7392gg4
	3yfJpJX90MKSL8YxwHWiYPKy1zPapMBsuL5PE7Sl8830AHUWZEZQrXf3vI/kn7KvMd0q
	MqX2N5wXz9ETZsX0BfrZMtgb7fcmIqdlI9URv9hZ/HZ1bt8Mw0ldR623e45gDVxYic1O
	LBGXRiZxI7Jl99kbMaObnAS80ZQlhRz6jfZI612O611AdP1Zo2al4Dodfqyknd4JQpnL
	6jvw==
X-Gm-Message-State: APjAAAUVngZ/qkCKpNiGvIK7sOGkZIQhDg1FShs5aFHDOC+Dc2FlZSLz
	I3A7teN+/36QsumhCKfUwwmAh5qCHwE=
X-Google-Smtp-Source: APXvYqxyXHgb9OxdYZbaGh+FFBWX+GZmdZP3dQB5KeCyl1pU/LsBaT0nbYkmY3tQBCrm4BpEvgLlLQ==
X-Received: by 2002:adf:9124:: with SMTP id j33mr3717137wrj.357.1575460384290; 
	Wed, 04 Dec 2019 03:53:04 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o4sm7813059wrw.97.2019.12.04.03.53.03
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Dec 2019 03:53:03 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Dec 2019 11:52:59 +0000
Message-Id: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/4] hashserv: Add support for equivalent hash reporting
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
X-List-Received-Date: Wed, 04 Dec 2019 11:53:04 -0000
Content-Transfer-Encoding: 8bit

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
---
 lib/hashserv/client.py |  8 ++++++++
 lib/hashserv/server.py | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index f65956617b..ae0cce9df4 100644
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
index 0aff77688e..cc7e48233b 100644
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
2.20.1


