Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
	[209.85.214.170])
	by mail.openembedded.org (Postfix) with ESMTP id CF9107F98A
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:14 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id c13so19665664pls.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=6bQKooXyuoH7psTkcZwWKaBo2B1xCfR1d+uO6pvRaa4=;
	b=WI7SFCTB3bud3jtC+iVjAyiGptkvcX8Wn2Nm/3n9iVXX2aHXiPTNZeSQcxEWlu7GB8
	XuwBdbh59lkp6iPQ+v8usY6a7DndAg0Sz9Dd0EwKC1JWY9ex2yCzmAR7p1EySXJ9xx3+
	h+n6gd+w7iW6ptahjvO9yopgDYej7ggO/O4TcVcHOKEZGDtdyM3SqWaSNt/A+xVTxj2X
	LAc48ojMzQ94ywjxwWyTEbjNzm2/vXj+WpNlAe7LCiVMCbfEU/0ltvED4DHZYOuTJ1sq
	gFFgtNTbVzlZWKio3SFSWO/LEN3byP20cAASgOVBIVQ7lVdP9JcH4WLn2f/Geq3EkfPn
	1C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=6bQKooXyuoH7psTkcZwWKaBo2B1xCfR1d+uO6pvRaa4=;
	b=YwZpLgayLmxafi2VQ6vIaV00jcx+jYQH/pc+MqJmcLT+xMLliXNoX9g6AmbmfGgCNy
	lk6wSMcNjl4ZTDpz+lq6TnIAZDShjbxMGQogGba6Fgw7nKYwJ8o/whGDmskg4aLVQLSB
	1rTY+o+DwLUPO+rv/IQvsgjP5gvPubpYa0fKmpE6vEW2iEacP/+zan7ay+CY07WQT4vX
	Fc0lZ+wJ+rqVkNOXaeG6YFjAdpYWoSJ9jbUVEqx/J9QvwuAfM1Bbp4cmPjHkdAMykoKL
	pxBh3t+CcUxDvAnUY6x9d6mXL/PxJT7N5ffoWoW1lZyA/R1+hydDLxYVkSvqDypuKGfu
	EYxQ==
X-Gm-Message-State: APjAAAXdHJ6OyVHWpWAr2f3bNslA+q9sjj0OipBlHypxro75AqXh/9TK
	o3U4YY3l/Or+w+rjZRD0VSUE4TdpSZg=
X-Google-Smtp-Source: APXvYqwAFRweMkrFby/KTQ4n5zj9n79RwUOwVD4olF19vueQZPypUrCJUYi4XeTAJ18LsRH1Dalxsw==
X-Received: by 2002:a17:902:d686:: with SMTP id
	v6mr96565262ply.266.1578104595672; 
	Fri, 03 Jan 2020 18:23:15 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:15 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:46 -0800
Message-Id: <0d154434ed8e3e88ad440a8dd21a164e72ba4ac5.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 01/25] hashserv: Add support for equivalent hash reporting
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:15 -0000

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


