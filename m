Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1SwAO4-00011d-U8
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jul 2012 13:13:16 +0200
Received: by bkcik5 with SMTP id ik5so2508646bkc.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Jul 2012 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=S9Ws608r2/w39pYUzqzXsKjuXKNUVfbUH++r+sJLXlM=;
	b=M2oFivp5ZuKDI62Ury8S66XZGQUBB4nxE1InFfTIYqgvpPrb0ALMzHpvivoCfK4uyd
	oc2v8n68XhQXGoNWqB0b25SoIKvLmI1qV02+souYjEEQIROBRrYvitXSeJwpBoITzNjU
	Paif5x1d4Og2YV974MIjFikxiRqoaYqTV/xoEbBUgwEfPvqtBxh0Wum8wyihA3gDqyfF
	1pQkkQ0J0tss9uWKs77vtkMAsxUp3kJ9uqt+RvvuTlsOMMBgEG2SHQ1ceXHbf9BYacuW
	v5zuj1GJkn4NTLW/QpNRFU/k6OOkl7UAOFu0c+nat4jKmviOkvmeHrslYk9UPO8S9GHt
	NK8w==
Received: by 10.204.149.86 with SMTP id s22mr5053755bkv.1.1343732500142;
	Tue, 31 Jul 2012 04:01:40 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id n5sm5123705bkv.14.2012.07.31.04.01.36
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 31 Jul 2012 04:01:39 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jul 2012 13:01:31 +0200
Message-Id: <1343732491-12072-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.6
Subject: [PATCH] fetch2: print checksums when they are different then expected
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 31 Jul 2012 11:13:17 -0000

* in form which can be copied into a recipe without modification
* like oe-classic did since:
  http://git.openembedded.org/openembedded/commit/?id=68abc465559a68e9201c9525be3c4acc6297eaed
* it shows them in right form when they are missing completely, but in
  more verbose form when different

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/__init__.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fa963be..46e9b6e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -348,6 +348,9 @@ def verify_checksum(u, ud, d):
     if sha256mismatch and ud.sha256_expected:
         msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected)
 
+    if md5mismatch or sha256mismatch:
+        msg = msg + '\nYour checksums:\nSRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
+
     if len(msg):
         raise ChecksumError('Checksum mismatch!%s' % msg, u)
 
-- 
1.7.8.6



