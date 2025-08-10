Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3971CA0EC0
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 22:24:01 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.35538.1754864639623588885
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Aug 2025 15:24:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LST1BUtK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso22253265e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754864637; x=1755469437; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ge3xop/MrVua8gW4fIDPXW77s7+sMAuucXyprWMd1A=;
        b=LST1BUtKbDiyHcqkHG1/ETaNOqmq6kCj6rcPBgEoHxnza/1xYm8erClKXxLlmS3WRF
         oveoB+Kzhux4ryHdF84eCPQvU6F34vW8TBn3T/UX3IX1oVgw5rl6db9coeK5ALd//UKi
         YCxZrJzmgy1TYSeIxQ8ZszQuEwS99rufNuV7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864637; x=1755469437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ge3xop/MrVua8gW4fIDPXW77s7+sMAuucXyprWMd1A=;
        b=EGHyCLh5eoDkdY1oaKSCXmhaHGdcm7hwZ7BzX2yQHYb9HuWUyzqyZJaisKeGlGZOPv
         6ZKlHq3Ibc6wK/QnjDBCZWBGd7Kyp21QufRsK7QpumEpKozxZskngYtIcEDABgEZ0QtU
         Mm9W1ld/JWXF7fSIvBwWeSJYL7SGApmFlzrmK5eCKmTSAaNx7nl4jeEqqXpf0ZLH87RS
         xPaYU47SMaFr2zl5lGNPaJPFNIx2+5A+ddbWGdUv1PFq3Q/Hq44A/hLgAyE1wrdQ1IgW
         InUErziNrKb7sYt8Ep8x/QEgzhO5t7L+HnZ2EN1X5lMB0+dpKs1uAX4aDH4lwEVtQhUG
         I4yw==
X-Gm-Message-State: AOJu0YxMu0aL+TYg7teSfH66tTPfSdMiGnFiP59UJhOObpt2gvAeue4a
	hKVlkIqmvd/fL+pU+Fk+1nRNIeOGMzEKiu6CbLHios5lZsmrt43+ozyHGZguA7bzflHOuujjlj1
	hr6uE
X-Gm-Gg: ASbGncuYyOC3xRF7cm5qoXu8FXbXWBEWyv2JnMCuc8DxYvsmnFwuJt5Oz4LwBSBtsK0
	4mNX4Zx4sgS/28Ean0VFB8jaTySrjbMnbc114eJ6JX+5sfQxDB9rCqIGd2N0bPuWEM7ulsZGpRV
	QDbQ7s93rJptD32Tvnoup38F7AARiThdhWcxHnywqsv0OfOL5RdBtXH7hnyc7ZHxeywD6rRndGX
	3o8FXYDepENrZ+f0ZG1rCYV7BwkZ8jT+MO2VkiCsR17+LbGsOcxIyvTVvjK6uD22HLtDvAuyV6a
	pEqzN9RE3KRRt1u1Vw8d3DkiAC/ais0RLtF8dyRBIdTV97q+FTzzYnqlE2J9N2XZiish4hcP70o
	M9AF2RjuqcVrlPQuLs8UDLplQTZkgYmqrJY21WENu3/nGNTOInrM=
X-Google-Smtp-Source: AGHT+IG25eYOBm+8LCFpUoHoc/xXs/jm+cxaHfhF3RRqoQLAQWCXkwVcYNOWd+sJkqS4Nslp2ZtU5A==
X-Received: by 2002:a05:600c:450e:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-459f4f12658mr93108865e9.16.1754864637323;
        Sun, 10 Aug 2025 15:23:57 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2db4:de3e:1e1f:36bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0cd2c90sm274039325e9.17.2025.08.10.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:23:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 1/3] lib/bb: Add filter support
Date: Sun, 10 Aug 2025 23:23:52 +0100
Message-ID: <20250810222355.2486772-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 22:24:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17850

From: Joshua Watt <JPEWhacker@gmail.com>

Add the python API for applying filters to a string and being able to
register functions as filters.

Filter functions are pure functions where an input is translated into
an output and there are no external data accesses. This means translations
can be cached as they won't change.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-selftest   |   1 +
 lib/bb/filter.py       | 142 +++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/filter.py |  88 +++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 lib/bb/filter.py
 create mode 100644 lib/bb/tests/filter.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 8c1e6d3e7e7..fb7c57dd837 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -33,6 +33,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.siggen",
          "bb.tests.utils",
          "bb.tests.compression",
+         "bb.tests.filter",
          "hashserv.tests",
          "prserv.tests",
          "layerindexlib.tests.layerindexobj",
diff --git a/lib/bb/filter.py b/lib/bb/filter.py
new file mode 100644
index 00000000000..0b5b5d92cac
--- /dev/null
+++ b/lib/bb/filter.py
@@ -0,0 +1,142 @@
+#
+# Copyright (C) 2025 Garmin Ltd. or its subsidiaries
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import builtins
+
+# Purposely blank out __builtins__ which prevents users from
+# calling any normal builtin python functions
+FILTERS = {
+    "__builtins__": {},
+}
+
+CACHE = {}
+
+
+def apply_filters(val, expressions):
+    g = FILTERS.copy()
+
+    for e in expressions:
+        e = e.strip()
+        if not e:
+            continue
+
+        k = (val, e)
+        if k not in CACHE:
+            # Set val as a local so it can be cleared out while keeping the
+            # globals
+            l = {"val": val}
+
+            CACHE[k] = eval(e, g, l)
+
+        val = CACHE[k]
+
+    return val
+
+
+class Namespace(object):
+    """
+    Helper class to simulate a python namespace. The object properties can be
+    set as if it were a dictionary. Properties cannot be changed or deleted
+    through the object interface
+    """
+
+    def __getitem__(self, name):
+        return self.__dict__[name]
+
+    def __setitem__(self, name, value):
+        self.__dict__[name] = value
+
+    def __contains__(self, name):
+        return name in self.__dict__
+
+    def __setattr__(self, name, value):
+        raise AttributeError(f"Attribute {name!r} cannot be changed")
+
+    def __delattr__(self, name):
+        raise AttributeError(f"Attribute {name!r} cannot be deleted")
+
+
+def filter_proc(*, name=None):
+    """
+    Decorator to mark a function that can be called in `apply_filters`, either
+    directly in a filter expression, or indirectly. The `name` argument can be
+    used to specify an alternate name for the function if the actual name is
+    not desired. The `name` can be a fully qualified namespace if desired.
+
+    All functions must be "pure" in that they do not depend on global state and
+    have no global side effects (e.g. the output only depends on the input
+    arguments); the results of filter expressions are cached to optimize
+    repeated calls.
+    """
+
+    def inner(func):
+        global FILTERS
+        nonlocal name
+
+        if name is None:
+            name = func.__name__
+
+        ns = name.split(".")
+        o = FILTERS
+        for n in ns[:-1]:
+            if not n in o:
+                o[n] = Namespace()
+            o = o[n]
+
+        o[ns[-1]] = func
+
+        return func
+
+    return inner
+
+
+# A select set of builtins that are supported in filter expressions
+filter_proc()(all)
+filter_proc()(all)
+filter_proc()(any)
+filter_proc()(bin)
+filter_proc()(bool)
+filter_proc()(chr)
+filter_proc()(enumerate)
+filter_proc()(float)
+filter_proc()(format)
+filter_proc()(hex)
+filter_proc()(int)
+filter_proc()(len)
+filter_proc()(map)
+filter_proc()(max)
+filter_proc()(min)
+filter_proc()(oct)
+filter_proc()(ord)
+filter_proc()(pow)
+filter_proc()(str)
+filter_proc()(sum)
+
+
+@filter_proc()
+def suffix(val, suffix):
+    return " ".join(v + suffix for v in val.split())
+
+
+@filter_proc()
+def prefix(val, prefix):
+    return " ".join(prefix + v for v in val.split())
+
+
+@filter_proc()
+def sort(val):
+    return " ".join(sorted(val.split()))
+
+
+@filter_proc()
+def remove(val, remove, sep=None):
+    if isinstance(remove, str):
+        remove = remove.split(sep)
+    new = [i for i in val.split(sep) if not i in remove]
+
+    if not sep:
+        return " ".join(new)
+    return sep.join(new)
diff --git a/lib/bb/tests/filter.py b/lib/bb/tests/filter.py
new file mode 100644
index 00000000000..245df7b22bc
--- /dev/null
+++ b/lib/bb/tests/filter.py
@@ -0,0 +1,88 @@
+#
+# Copyright (C) 2025 Garmin Ltd. or its subsidiaries
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import unittest
+import bb.filter
+
+
+class BuiltinFilterTest(unittest.TestCase):
+    def test_disallowed_builtins(self):
+        with self.assertRaises(NameError):
+            val = bb.filter.apply_filters("1", ["open('foo.txt', 'rb')"])
+
+    def test_prefix(self):
+        val = bb.filter.apply_filters("1 2 3", ["prefix(val, 'a')"])
+        self.assertEqual(val, "a1 a2 a3")
+
+        val = bb.filter.apply_filters("", ["prefix(val, 'a')"])
+        self.assertEqual(val, "")
+
+    def test_suffix(self):
+        val = bb.filter.apply_filters("1 2 3", ["suffix(val, 'b')"])
+        self.assertEqual(val, "1b 2b 3b")
+
+        val = bb.filter.apply_filters("", ["suffix(val, 'b')"])
+        self.assertEqual(val, "")
+
+    def test_sort(self):
+        val = bb.filter.apply_filters("z y x", ["sort(val)"])
+        self.assertEqual(val, "x y z")
+
+        val = bb.filter.apply_filters("", ["sort(val)"])
+        self.assertEqual(val, "")
+
+    def test_identity(self):
+        val = bb.filter.apply_filters("1 2 3", ["val"])
+        self.assertEqual(val, "1 2 3")
+
+        val = bb.filter.apply_filters("123", ["val"])
+        self.assertEqual(val, "123")
+
+    def test_empty(self):
+        val = bb.filter.apply_filters("1 2 3", ["", "prefix(val, 'a')", ""])
+        self.assertEqual(val, "a1 a2 a3")
+
+    def test_nested(self):
+        val = bb.filter.apply_filters("1 2 3", ["prefix(prefix(val, 'a'), 'b')"])
+        self.assertEqual(val, "ba1 ba2 ba3")
+
+        val = bb.filter.apply_filters("1 2 3", ["prefix(prefix(val, 'b'), 'a')"])
+        self.assertEqual(val, "ab1 ab2 ab3")
+
+    def test_filter_order(self):
+        val = bb.filter.apply_filters("1 2 3", ["prefix(val, 'a')", "prefix(val, 'b')"])
+        self.assertEqual(val, "ba1 ba2 ba3")
+
+        val = bb.filter.apply_filters("1 2 3", ["prefix(val, 'b')", "prefix(val, 'a')"])
+        self.assertEqual(val, "ab1 ab2 ab3")
+
+        val = bb.filter.apply_filters("1 2 3", ["prefix(val, 'a')", "suffix(val, 'b')"])
+        self.assertEqual(val, "a1b a2b a3b")
+
+        val = bb.filter.apply_filters("1 2 3", ["suffix(val, 'b')", "prefix(val, 'a')"])
+        self.assertEqual(val, "a1b a2b a3b")
+
+    def test_remove(self):
+        val = bb.filter.apply_filters("1 2 3", ["remove(val, ['2'])"])
+        self.assertEqual(val, "1 3")
+
+        val = bb.filter.apply_filters("1,2,3", ["remove(val, ['2'], ',')"])
+        self.assertEqual(val, "1,3")
+
+        val = bb.filter.apply_filters("1 2 3", ["remove(val, ['4'])"])
+        self.assertEqual(val, "1 2 3")
+
+        val = bb.filter.apply_filters("1 2 3", ["remove(val, ['1', '2'])"])
+        self.assertEqual(val, "3")
+
+        val = bb.filter.apply_filters("1 2 3", ["remove(val, '2')"])
+        self.assertEqual(val, "1 3")
+
+        val = bb.filter.apply_filters("1 2 3", ["remove(val, '4')"])
+        self.assertEqual(val, "1 2 3")
+
+        val = bb.filter.apply_filters("1 2 3", ["remove(val, '1 2')"])
+        self.assertEqual(val, "3")

