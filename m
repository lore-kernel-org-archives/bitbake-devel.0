Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail.openembedded.org (Postfix) with ESMTP id 925997FCA5
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:49 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id m13so7970502pjb.2
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=6bQKooXyuoH7psTkcZwWKaBo2B1xCfR1d+uO6pvRaa4=;
	b=RxOQecSgbfTUmmpXKsSy0ccIsdrUsaQJTVHqrzqAOITvsfiWhA/NI/i+1Mi+AmErLj
	rEFRykxhW6RNYyVtxsFuVZZmv6FwZpZAC6VBdJ2pRZE3xm80to/adrmui6RADdN07Cud
	OC4OeVT43AnNacvoB2TJuU84uzFjRibiE/I1jYzaA6yUw8a4rYLRfdpsqOHGAibOGPTB
	+kH4HU9AcxPJfxx46NfzhKa3c3V6wMKaL0PaO7Wzdm8n8s/QkGEYt2e2Ld4WD7OrFyaA
	znrmioZrk77z/2GILbm7WzF//e01I/gbambu3onWTLcuUFHhJ3c8tAErSYAyrL2Yfcsy
	n4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=6bQKooXyuoH7psTkcZwWKaBo2B1xCfR1d+uO6pvRaa4=;
	b=Kjp4S19KjYJkm8/C6gYxUSKYg/nJoevBANdGDhkpmpzIbIkN1OuPKn2cPUwJjRePPz
	yF9NnhNE70EdpKoaAIaagJ2DsoOdPwfDiFNh2WFx+P3OA5KMRSB5XKwDCLtCkuc7vcmZ
	I59R5MPwNbMDvXkKex46g8Q2MY6SDGJGXRFTZ3KRJtazc6oOT7x6w5tM+EBbIgtKv/EL
	9CImUmXNxeiqjBvhCNumPRjuz9TVZlfvzmRl0K2+ul2h0Z4wEG8p6xMEBpOh99gl04M9
	+pUwv0JtSRgOVthzig644DuatSKkOVeB2u/lp/BF3xNzZ8MgFMF83qIF4s4DG5JBAQ0k
	U0BA==
X-Gm-Message-State: APjAAAWCjVgK1Mh7OplPwhM6YgE/Mf33n2aJg98rtvxVZHKejPAQI7g+
	Rd5TnRnPCTYTRd4O2YXidQ5ZSnr8
X-Google-Smtp-Source: APXvYqx6605pYU8gufklP6BEsCVYSvrp4ZINhDNc839ODEn4DTdNETrODFl/RvRPxsQUfMm6pzIK4w==
X-Received: by 2002:a17:90a:d995:: with SMTP id
	d21mr44097286pjv.118.1578328010745; 
	Mon, 06 Jan 2020 08:26:50 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.49
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:50 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:22 -0800
Message-Id: <0d154434ed8e3e88ad440a8dd21a164e72ba4ac5.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 01/25] hashserv: Add support for equivalent hash reporting
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:50 -0000

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
index f6595661..ae0cce9d 100644
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
index 0aff7768..cc7e4823 100644
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
2.17.1


