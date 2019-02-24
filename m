Return-Path: <alex.kanavin@gmail.com>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id D1815602D9
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Feb 2019 20:07:38 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id i16so7628553wrs.13
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Feb 2019 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=J8GgbfdylB8zopkQAng63jQZ+mJabcK5gQ+/LNiabeU=;
	b=Xg7v5MApuceGIudxIkmNN2DRVseZqsKF8aKtzMeMmwuALzQk0Bndf3cQNQFec0Msew
	YeGY9CB/XpksM2bCYkBb5RW9VKTywJiRiE1xA5QlqEA5zyiwFJM1AsTazN6mWEpKgkID
	JgsA+UlwYyuBynW9OJV7dUSNaD3WcpJoXW77bSQdscS+1hPP7Bh7ALekNpuuFQJrTm3S
	9VCwuvG5sxXTvEP5LAc70MXec7rhYcSGhkZOmBjL/XyJX7GWxETHCjpxe7RpJu4MN3ZL
	JviBr/28pYCu1YBtPn+Odued+4vRx7JBowEQi1LN0KFuKMEuuB4FjRZVpibh2f496+Jq
	SE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=J8GgbfdylB8zopkQAng63jQZ+mJabcK5gQ+/LNiabeU=;
	b=SGp+jYiL8sq3ZWXT/9qbtB9St1DKenJqWKu0QFqn0uhFPdAQaxumXgXfNd9bA+Mmzq
	NN9JQSKp9pEgiz+xpKu4OondYtyDkIupAYGg7Q8KLWUWInk3YNzuCxlW9HcM97gkCR9n
	PTaznlfNvF7OeVxq84vHyrTmvMoIXxQlSh5f6gmZ9aj91l7EmWHSP/OYc+EczDbmEuvm
	9vRoogtucmN5IY7Wd4DLB9FJND0kk7qxdeHeDzhKQY9ppufB0DQacr5Z/fY1YHBzYN3p
	itjAkvF814zbQTTTm8/ABN1iuSWA22Sm04efc+EmZAPV7dXMSQhY8QITY/lk6quWDgvL
	pq6g==
X-Gm-Message-State: AHQUAub/Vh4bTBGq1O2Lyl1l7FsaRu9zAQsDXkNCPrHhYpe5C5z9jczX
	f0rq38jC53OamJL9b7Y7/HpCVajP
X-Google-Smtp-Source: AHgI3IYj22QDRnO76Fp07kRV9p67MNb84jxRImy2bGUMMXjcZnS59qrqfLb9maZ76V2rD2D7KaycrA==
X-Received: by 2002:adf:8224:: with SMTP id 33mr10419183wrb.264.1551038859182; 
	Sun, 24 Feb 2019 12:07:39 -0800 (PST)
Received: from alexander-box.luxoft.com ([62.96.135.139])
	by smtp.gmail.com with ESMTPSA id d9sm9485428wrn.72.2019.02.24.12.07.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 24 Feb 2019 12:07:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Feb 2019 21:07:28 +0100
Message-Id: <20190224200728.110431-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] bitbake: fix version comparison when one of the versions ends in .
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
X-List-Received-Date: Sun, 24 Feb 2019 20:07:39 -0000

Previously, this would happen:

======================================================================
ERROR: test_vercmpstring (bb.tests.utils.VerCmpString)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/alexander/development/poky/bitbake/lib/bb/tests/utils.py", line 45, in test_vercmpstring
    result = bb.utils.vercmp_string('1.', '1.1')
  File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 143, in vercmp_string
    return vercmp(ta, tb)
  File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 135, in vercmp
    r = vercmp_part(va, vb)
  File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 124, in vercmp_part
    elif ca < cb:
TypeError: '<' not supported between instances of 'NoneType' and 'int'

----------------------------------------------------------------------

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 bitbake/lib/bb/tests/utils.py | 4 ++++
 bitbake/lib/bb/utils.py       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/tests/utils.py b/bitbake/lib/bb/tests/utils.py
index 2f4ccf3c62b..f1cd83a4195 100644
--- a/bitbake/lib/bb/tests/utils.py
+++ b/bitbake/lib/bb/tests/utils.py
@@ -42,6 +42,10 @@ class VerCmpString(unittest.TestCase):
         self.assertTrue(result < 0)
         result = bb.utils.vercmp_string('1.1', '1.0+1.1-beta1')
         self.assertTrue(result > 0)
+        result = bb.utils.vercmp_string('1.', '1.1')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1.1', '1.')
+        self.assertTrue(result > 0)
 
     def test_explode_dep_versions(self):
         correctresult = {"foo" : ["= 1.10"]}
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 9cb702dbb7a..b652a6838a2 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -121,6 +121,10 @@ def vercmp_part(a, b):
             return -1
         elif oa > ob:
             return 1
+        elif ca is None:
+            return -1
+        elif cb is None:
+            return 1
         elif ca < cb:
             return -1
         elif ca > cb:
-- 
2.17.1


