Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id A8D607E961
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 16:46:23 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id n4so207461wrw.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=eQtnGel1zOa36OkEZYMjaGJm2UzDOfHIkR/FwY+Yscs=;
	b=m6u9CO1lyik+QgU76oorPpMYmoC+/hpjdK1FGSp69htNOOBZBwjIk3Ocf+AlZELcoO
	719sLoHlHs2bxWfivHirFBBv+DwyhcII/rBi/P6KsIVhHgIR5uQs5rxugyFbz2bSM8FU
	jCfyPenZs6ucz/Y7loy1GOpfBuq5WidX0Lc2RpkL/BvHg8E3cF4lAU0jYg6h8mP4L84v
	8ecQdYlAM1RRWDi72Z+itzx9hZRjhgaazgGv2qxnnSbJ/cpeO/xr0w7UVMyZjw919sn8
	xSyWbjDCc+SQBYGwmZUIT2YCRSQrCVFOpG7aE15nbBV6DKHgLcQjngjo7fDWUESeSICx
	m3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=eQtnGel1zOa36OkEZYMjaGJm2UzDOfHIkR/FwY+Yscs=;
	b=WKqxT/9B6sD5yUhfxRHUYgcTKuI6rXSGRXjc7E90rfq++MQhIIqX09eMRfl1KqGwYZ
	ej0hr0k0WvVyZ2vHuSBqSxKvzl0VqQmjbUaOSOOGuZhO+37APygM9uZZ4c8IDr+A1i1x
	m2pHRptMUhvPk0p82fJMliewawlQZ3OZ7ZSJOnozRvu9HUI8a9wAx6XUBkVE0mcAzGsA
	QdLYJ7UK5m17TUKc6KsL7MaO0oKAyElFuFKfPqLMbnuqpcN1C3xPf0p5ha0pI3hC7sNm
	U3eKxKkDR124d5xDPnfhXZXfcvjM1a1FynJpdjHn5tBDlkVDLCYSRJY8g3yo9Q8OPF6B
	hLmA==
X-Gm-Message-State: APjAAAWK06ec6SPfbCFvL74ss6HhCY4QnaE6dXl8dtJALQZUdGUnxTWb
	tnHsJodrkqV/BSGmJHWeAW6u7st+
X-Google-Smtp-Source: APXvYqx5qF3PMDcMpXXuHvMTU/b48S/I8ozcQ4P4gEGU7jTHBtnecQ5Bthzi4Qx0X3t3rz0DSBS+eQ==
X-Received: by 2002:adf:de90:: with SMTP id w16mr50122674wrl.217.1560876383999;
	Tue, 18 Jun 2019 09:46:23 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id
	v27sm30474914wrv.45.2019.06.18.09.46.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Jun 2019 09:46:23 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2019 16:46:28 +0000
Message-Id: <20190618164628.13811-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] tests/utils.py: add one more test cases for bb.utils.vercmp_string
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
X-List-Received-Date: Tue, 18 Jun 2019 16:46:23 -0000

* this is just another test case for issue already fixed in:
    commit fef56d28c3efec4876c379898cbc4d4c65303aee
    Author: Alexander Kanavin <alex.kanavin@gmail.com>
    Date:   Sun Feb 24 21:07:28 2019 +0100
    Subject: bitbake: fix version comparison when one of the versions ends in .

* The TypeError is triggered not by '.' at the end, but from the extra
  numberic component in one of the versions.

* When one version has fewer elements, it's extended by another (0, None)
  element where 0 means numeric component. Then the result cannot be
  decided by comparing the types (oa < ob, ob > oa) and it continues
  to compare values (ca < cb) which fails when one of them is the None
  from (0, None) appended before.

  ======================================================================
  ERROR: test_vercmpstring (bb.tests.utils.VerCmpString)
  ----------------------------------------------------------------------
  Traceback (most recent call last):
    File "lib/bb/tests/utils.py", line 32, in test_vercmpstring
      result = bb.utils.vercmp_string('1a', '1a1')
    File "lib/bb/utils.py", line 131, in vercmp_string
      return vercmp(ta, tb)
    File "lib/bb/utils.py", line 123, in vercmp
      r = vercmp_part(va, vb)
    File "lib/bb/utils.py", line 112, in vercmp_part
      elif ca < cb:
  TypeError: '<' not supported between instances of 'NoneType' and 'int'

  ----------------------------------------------------------------------
  Ran 3 tests in 0.002s

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/tests/utils.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 4d788281..f4adf1d4 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -29,6 +29,10 @@ class VerCmpString(unittest.TestCase):
         self.assertTrue(result < 0)
         result = bb.utils.vercmp_string('1.1', '1.0+1.1-beta1')
         self.assertTrue(result > 0)
+        result = bb.utils.vercmp_string('1a', '1a1')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1a1', '1a')
+        self.assertTrue(result > 0)
         result = bb.utils.vercmp_string('1.', '1.1')
         self.assertTrue(result < 0)
         result = bb.utils.vercmp_string('1.1', '1.')
-- 
2.17.1


