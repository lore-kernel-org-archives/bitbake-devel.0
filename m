Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55121E732F9
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 17:06:09 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.19054.1695920762078512614
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Sep 2023 10:06:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SF9a/P8K;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57bc2c2f13dso4123819eaf.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695920760; x=1696525560; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opxTwZ1am1DanXDb688FjBHsuGD2K0vtpsvToRLtLr8=;
        b=SF9a/P8KHeoA3of4SDmZFKUAXEda43mECR1kpuCCcnNlkFWRJInCSsnS0A3vWSR2qu
         5okNJFatKfIx4j2to21szxKkVIL5LMZZzHHSSGkZfaqh/PlA5sSIHiMhHDca3Nyw07Ul
         j2LuaPtCWZ236tTSYNdIeiATU3aLEgkneKSh6Z0cuE3MQ7h8UhHNZ5GJ+0K1n2cDv4vS
         ajXy7oQ3pa/GeEoa5miZVj3l1OQos6GlRhkKdJbNe1oU0Gpzu2L8WI7itJ00KOSW8h8q
         UneRtTDvVQ+70+AvHXqTwU6hoz3LMdRLQsFy6qMxZGgNKKN01zwDAtGKpCXfYapsz7I3
         fseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920760; x=1696525560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opxTwZ1am1DanXDb688FjBHsuGD2K0vtpsvToRLtLr8=;
        b=QaFysnBZxSs2hAb/AxOo1vsi4JmAyQdo4nrvzIpjWFDUfTQnCjQkK1u5b8Z3mEFW2B
         Uryj4nnoZ+35BTPxs0XMooqkm+SOk0cgh0xASO+cQSnYI32Ni3BrWUdUFSG3oDX0HhTh
         YQPA0wyqf4VPM2lPjB0JWz2ZmfVcKQ25lkM+AXZTOTxWTGFyKMh8VkjMGix1vkAadQME
         SZb6XasZsWuMymLiH85YD6wECHe1RqFTbEv6KMk7KelF0c/vd0QDHfWiIU9Be3H6QhpB
         /MBTf9gJYpe8+qJ8z8MCqqrXsa48pu0gAdk/1ZriKVCxogbQ4QwOXzZt54QVUMdW6C9U
         kclw==
X-Gm-Message-State: AOJu0YyNqkBhxR4fZqgiVVK8vreQ9w4DZRJCAntXaoDBL9fRmLc3y8vn
	ReOoA5J0QWl1QKDKYKs621PF+zgphs4=
X-Google-Smtp-Source: AGHT+IGi49CCN9TPeV0ZSqXHERtNdze1ltFwiTHXMTP7T8vhNpwaLXB9vxNhWMSoNNB/DC7zLo3gFA==
X-Received: by 2002:a05:6870:d60e:b0:1dc:ddd0:6ee1 with SMTP id a14-20020a056870d60e00b001dcddd06ee1mr1866196oaq.38.1695920760560;
        Thu, 28 Sep 2023 10:06:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::f27c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm1389772oal.1.2023.09.28.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:05:59 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC 3/5] bitbake-hashclient: Add remove subcommand
Date: Thu, 28 Sep 2023 11:05:49 -0600
Message-Id: <20230928170551.4193224-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928170551.4193224-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 17:06:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15145

Adds a subcommand to invoke the remove API on the server

[YOCTO #15064]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 13 +++++++++++++
 bitbake/lib/hashserv/server.py | 10 +++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 494f17592ac..d09104336ab 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -113,6 +113,14 @@ def main():
                     with lock:
                         pbar.update()
 
+    def handle_remove(args, client):
+        where = {k: v for k, v in args.where}
+        if where:
+            result = client.remove(where)
+            print("Removed %d row(s)" % (result["count"]))
+        else:
+            print("No query specified")
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -137,6 +145,11 @@ def main():
                                help='Include string in outhash')
     stress_parser.set_defaults(func=handle_stress)
 
+    remove_parser = subparsers.add_parser('remove', help="Remove hash entries")
+    remove_parser.add_argument("--where", "-w", metavar="KEY VALUE", nargs=2, action="append", default=[],
+                               help="Remove entries from table where KEY == VALUE")
+    remove_parser.set_defaults(func=handle_remove)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 7e8aeefef30..99ba904b1f0 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -516,13 +516,17 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 query = ('DELETE FROM %s WHERE ' % table_name) + ' AND '.join("%s=:%s" % (k, k) for k in where.keys())
                 print(query)
                 cursor.execute(query, where)
+                return cursor.rowcount
 
+            return 0
+
+        count = 0
         with closing(self.db.cursor()) as cursor:
-            do_remove(OUTHASH_TABLE_COLUMNS, "outhashes_v2", cursor)
-            do_remove(UNIHASH_TABLE_COLUMNS, "unihashes_v2", cursor)
+            count += do_remove(OUTHASH_TABLE_COLUMNS, "outhashes_v2", cursor)
+            count += do_remove(UNIHASH_TABLE_COLUMNS, "unihashes_v2", cursor)
             self.db.commit()
 
-        self.write_message({})
+        self.write_message({"count": count})
 
     def query_equivalent(self, cursor, method, taskhash):
         # This is part of the inner loop and must be as fast as possible
-- 
2.34.1


