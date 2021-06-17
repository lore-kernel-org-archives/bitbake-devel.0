Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web12.4634.1623958694361965982
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jun 2021 12:38:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rqk2a7wz;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso7254952otl.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Jun 2021 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwGlpnpV8xP+ugUSSF6Pq5+SCFI3PxuAsIcby3QHZNU=;
        b=rqk2a7wzBWirOjDNFykELfdPRGYESQ47fCeeiZz7xq1XjnS0lpKZUpDagfR0a4zD8a
         lsuQb3MRAnBLpRmEuoOg7PHqmGnhkt61J38TLcOE89tUeHwfYqhRYE26zgcgDCjkfMu1
         RVdFTRJaAtD3aYYq4642VVfYnfYPMqjh0aBSMqCiluvAIB+OkDklUxwgqGiDwCLaXkLi
         RAKqV7vSYE/GYffeueY4V1r7rdOrTAN2yZZdK6P/7aQCdXXHUj2qfCn+UGPI3ARUR2vw
         gsPdLDkV8r4WTMTkcmSYZuvk9go02v/IKnkp2JwG1yAxiEliKfXHyBEgQaXNz+c7mnM0
         9Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwGlpnpV8xP+ugUSSF6Pq5+SCFI3PxuAsIcby3QHZNU=;
        b=GPP4nE/yC0fmFWw8t74msZy7kH/L3O3tWaUEEqa5cUu1VzB5z1KBHPkqCQ7BfKQj9v
         qvtZAuXTy3EcG6KZcIQQuILP2xWowcscRjRVrxZzQp5ryLv7uDEtZSyYknwd3aE9m6Dq
         ZmiJlsZzjDeLIplPKpVoagMWnCogrDLSixEiZUpCSkDa7ADWEN3WM8UjrVzwqQg5YiqK
         lhgkpXs1zZEBYbqyVTLRhKjnYaO8juCATgWJARxLfjuVjHOzLkewxvTAfe4SMSvRwe4V
         tRU0bbQR6j2ZU7gC9y5YDz+YFWIn5Xx16F0/WaDrfnXUMoffmGhDc0uTrOowFw+6kIS9
         yNig==
X-Gm-Message-State: AOAM532Ox8Uueg+pKFMnW7XicVxBdOmE7BNkpC9MQPfxko1qjzR0u6t5
	LC6xXpcMhED/p5/aeGC53xwnfKBgOm4=
X-Google-Smtp-Source: ABdhPJy1zHCZcROKaZ7as6YPTVL/pPOpzCc92j7kcQdsrV1/26Sm9/NX6v1ij3UISMSQzM/KsgnoHA==
X-Received: by 2002:a9d:3e15:: with SMTP id a21mr6117071otd.366.1623958693433;
        Thu, 17 Jun 2021 12:38:13 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id l28sm1450123otd.66.2021.06.17.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:38:13 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] bitbake: Add piping compression library
Date: Thu, 17 Jun 2021 14:38:09 -0500
Message-Id: <20210617193809.33714-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617175617.2731-1-JPEWhacker@gmail.com>
References: <20210617175617.2731-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a library that implements file-like objects (similar to
gzip.GzipFile) that can stream to arbitrary compression programs. This
is utilized to implement a LZ4 and zstd compression API.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
V2: Now with tests!

 bitbake/bin/bitbake-selftest        |   1 +
 bitbake/lib/bb/_pipecompress.py     | 194 ++++++++++++++++++++++++++++
 bitbake/lib/bb/lz4.py               |  17 +++
 bitbake/lib/bb/tests/compression.py |  82 ++++++++++++
 bitbake/lib/bb/zstd.py              |  27 ++++
 5 files changed, 321 insertions(+)
 create mode 100644 bitbake/lib/bb/_pipecompress.py
 create mode 100644 bitbake/lib/bb/lz4.py
 create mode 100644 bitbake/lib/bb/tests/compression.py
 create mode 100644 bitbake/lib/bb/zstd.py

diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index 757441c754..63762fe794 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -29,6 +29,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.runqueue",
          "bb.tests.siggen",
          "bb.tests.utils",
+         "bb.tests.compression",
          "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
diff --git a/bitbake/lib/bb/_pipecompress.py b/bitbake/lib/bb/_pipecompress.py
new file mode 100644
index 0000000000..4b9f662143
--- /dev/null
+++ b/bitbake/lib/bb/_pipecompress.py
@@ -0,0 +1,194 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Helper library to implement streaming compression and decompression using an
+# external process
+#
+# This library should be used directly by end users; a wrapper library for the
+# specific compression tool should be created
+
+import builtins
+import io
+import os
+import subprocess
+
+
+def open_wrap(
+    cls, filename, mode="rb", *, encoding=None, errors=None, newline=None, **kwargs
+):
+    """
+    Open a compressed file in binary or text mode.
+
+    Users should not call this directly. A specific compression library can use
+    this helper to provide it's own "open" command
+
+    The filename argument can be an actual filename (a str or bytes object), or
+    an existing file object to read from or write to.
+
+    The mode argument can be "r", "rb", "w", "wb", "x", "xb", "a" or "ab" for
+    binary mode, or "rt", "wt", "xt" or "at" for text mode. The default mode is
+    "rb".
+
+    For binary mode, this function is equivalent to the cls constructor:
+    cls(filename, mode). In this case, the encoding, errors and newline
+    arguments must not be provided.
+
+    For text mode, a cls object is created, and wrapped in an
+    io.TextIOWrapper instance with the specified encoding, error handling
+    behavior, and line ending(s).
+    """
+    if "t" in mode:
+        if "b" in mode:
+            raise ValueError("Invalid mode: %r" % (mode,))
+    else:
+        if encoding is not None:
+            raise ValueError("Argument 'encoding' not supported in binary mode")
+        if errors is not None:
+            raise ValueError("Argument 'errors' not supported in binary mode")
+        if newline is not None:
+            raise ValueError("Argument 'newline' not supported in binary mode")
+
+    file_mode = mode.replace("t", "")
+    if isinstance(filename, (str, bytes, os.PathLike)):
+        binary_file = cls(filename, file_mode, **kwargs)
+    elif hasattr(filename, "read") or hasattr(filename, "write"):
+        binary_file = cls(None, file_mode, fileobj=filename, **kwargs)
+    else:
+        raise TypeError("filename must be a str or bytes object, or a file")
+
+    if "t" in mode:
+        return io.TextIOWrapper(
+            binary_file, encoding, errors, newline, write_through=True
+        )
+    else:
+        return binary_file
+
+
+class CompressionError(OSError):
+    pass
+
+
+class PipeFile(io.RawIOBase):
+    """
+    Class that implements generically piping to/from a compression program
+
+    Derived classes should add the function get_compress() and get_decompress()
+    that return the required commands. Input will be piped into stdin and the
+    (de)compressed output should be written to stdout, e.g.:
+
+        class FooFile(PipeCompressionFile):
+            def get_decompress(self):
+                return ["fooc", "--decompress", "--stdout"]
+
+            def get_compress(self):
+                return ["fooc", "--compress", "--stdout"]
+
+    """
+
+    READ = 0
+    WRITE = 1
+
+    def __init__(self, filename=None, mode="rb", *, stderr=None, fileobj=None):
+        if "t" in mode or "U" in mode:
+            raise ValueError("Invalid mode: {!r}".format(mode))
+
+        if not "b" in mode:
+            mode += "b"
+
+        if mode.startswith("r"):
+            self.mode = self.READ
+        elif mode.startswith("w"):
+            self.mode = self.WRITE
+        else:
+            raise ValueError("Invalid mode %r" % mode)
+
+        if fileobj is not None:
+            self.fileobj = fileobj
+        else:
+            self.fileobj = builtins.open(filename, mode or "rb")
+
+        if self.mode == self.READ:
+            self.p = subprocess.Popen(
+                self.get_decompress(),
+                stdin=self.fileobj,
+                stdout=subprocess.PIPE,
+                stderr=stderr,
+                close_fds=True,
+            )
+            self.pipe = self.p.stdout
+        else:
+            self.p = subprocess.Popen(
+                self.get_compress(),
+                stdin=subprocess.PIPE,
+                stdout=self.fileobj,
+                stderr=stderr,
+                close_fds=True,
+            )
+            self.pipe = self.p.stdin
+
+        self.__closed = False
+
+    def _check_process(self):
+        if self.p is None:
+            return
+
+        returncode = self.p.wait()
+        if returncode:
+            raise CompressionError("Process died with %d" % returncode)
+        self.p = None
+
+    def close(self):
+        if self.closed:
+            return
+
+        self.pipe.close()
+        if self.p is not None:
+            self._check_process()
+        self.fileobj.close()
+
+        self.__closed = True
+
+    @property
+    def closed(self):
+        return self.__closed
+
+    def fileno(self):
+        return self.pipe.fileno()
+
+    def flush(self):
+        self.pipe.flush()
+
+    def isatty(self):
+        return self.pipe.isatty()
+
+    def readable(self):
+        return self.mode == self.READ
+
+    def writable(self):
+        return self.mode == self.WRITE
+
+    def readinto(self, b):
+        if self.mode != self.READ:
+            import errno
+
+            raise OSError(
+                errno.EBADF, "read() on write-only %s object" % self.__class__.__name__
+            )
+        size = self.pipe.readinto(b)
+        if size == 0:
+            self._check_process()
+        return size
+
+    def write(self, data):
+        if self.mode != self.WRITE:
+            import errno
+
+            raise OSError(
+                errno.EBADF, "write() on read-only %s object" % self.__class__.__name__
+            )
+        data = self.pipe.write(data)
+
+        if not data:
+            self._check_process()
+
+        return data
diff --git a/bitbake/lib/bb/lz4.py b/bitbake/lib/bb/lz4.py
new file mode 100644
index 0000000000..c2bda291d3
--- /dev/null
+++ b/bitbake/lib/bb/lz4.py
@@ -0,0 +1,17 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import bb._pipecompress
+
+
+def open(*args, **kwargs):
+    return bb._pipecompress.open_wrap(LZ4File, *args, **kwargs)
+
+
+class LZ4File(bb._pipecompress.PipeFile):
+    def get_compress(self):
+        return ["lz4c", "-z", "-c"]
+
+    def get_decompress(self):
+        return ["lz4c", "-d", "-c"]
diff --git a/bitbake/lib/bb/tests/compression.py b/bitbake/lib/bb/tests/compression.py
new file mode 100644
index 0000000000..f663853901
--- /dev/null
+++ b/bitbake/lib/bb/tests/compression.py
@@ -0,0 +1,82 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from pathlib import Path
+import bb.lz4
+import bb.zstd
+import contextlib
+import os
+import shutil
+import tempfile
+import unittest
+import subprocess
+
+
+class CompressionTests(object):
+    def setUp(self):
+        self._t = tempfile.TemporaryDirectory()
+        self.tmpdir = Path(self._t.name)
+        self.addCleanup(self._t.cleanup)
+
+    def _file_helper(self, mode_suffix, data):
+        tmp_file = self.tmpdir / "compressed"
+
+        with self.do_open(tmp_file, mode="w" + mode_suffix) as f:
+            f.write(data)
+
+        with self.do_open(tmp_file, mode="r" + mode_suffix) as f:
+            read_data = f.read()
+
+        self.assertEqual(read_data, data)
+
+    def test_text_file(self):
+        self._file_helper("t", "Hello")
+
+    def test_binary_file(self):
+        self._file_helper("b", "Hello".encode("utf-8"))
+
+    def _pipe_helper(self, mode_suffix, data):
+        rfd, wfd = os.pipe()
+        with open(rfd, "rb") as r, open(wfd, "wb") as w:
+            with self.do_open(r, mode="r" + mode_suffix) as decompress:
+                with self.do_open(w, mode="w" + mode_suffix) as compress:
+                    compress.write(data)
+                read_data = decompress.read()
+
+        self.assertEqual(read_data, data)
+
+    def test_text_pipe(self):
+        self._pipe_helper("t", "Hello")
+
+    def test_binary_pipe(self):
+        self._pipe_helper("b", "Hello".encode("utf-8"))
+
+    def test_bad_decompress(self):
+        tmp_file = self.tmpdir / "compressed"
+        with tmp_file.open("wb") as f:
+            f.write(b"\x00")
+
+        with self.assertRaises(OSError):
+            with self.do_open(tmp_file, mode="rb", stderr=subprocess.DEVNULL) as f:
+                data = f.read()
+
+
+class LZ4Tests(CompressionTests, unittest.TestCase):
+    def get_cls(self):
+        return bb.lz4.LZ4File
+
+    @contextlib.contextmanager
+    def do_open(self, *args, **kwargs):
+        with bb.lz4.open(*args, **kwargs) as f:
+            yield f
+
+
+class ZStdTests(CompressionTests, unittest.TestCase):
+    def get_cls(self):
+        return bb.zstd.ZstdFile
+
+    @contextlib.contextmanager
+    def do_open(self, *args, **kwargs):
+        with bb.zstd.open(*args, **kwargs) as f:
+            yield f
diff --git a/bitbake/lib/bb/zstd.py b/bitbake/lib/bb/zstd.py
new file mode 100644
index 0000000000..1f46087ec9
--- /dev/null
+++ b/bitbake/lib/bb/zstd.py
@@ -0,0 +1,27 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import bb._pipecompress
+import shutil
+
+
+def open(*args, **kwargs):
+    return bb._pipecompress.open_wrap(ZstdFile, *args, **kwargs)
+
+
+class ZstdFile(bb._pipecompress.PipeFile):
+    def __init__(self, *args, num_threads=1, **kwargs):
+        self.num_threads = num_threads
+        super().__init__(*args, **kwargs)
+
+    def _get_zstd(self):
+        if self.num_threads == 1 or not shutil.which("pzstd"):
+            return ["zstd"]
+        return ["pzstd", "-p", "%d" % self.num_threads]
+
+    def get_compress(self):
+        return self._get_zstd() + ["-c"]
+
+    def get_decompress(self):
+        return self._get_zstd() + ["-d", "-c"]
-- 
2.31.1

