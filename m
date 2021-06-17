Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web12.3324.1623952584665214474
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jun 2021 10:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Spd4ye+6;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id b18-20020a0568301052b0290449ba7eff3cso5193037otp.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Jun 2021 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djqCepZpYLgvDRN7eIErDpN284j4dEbxxjwWs+DBJLE=;
        b=Spd4ye+69mblyh22kzz791u0UnWQZXWfhKcRRaf20uctAxa6gFYUYv0bdbr3FTJJCw
         2u2CWir9tMnmWjoC9ras52v5YnqWFN+ELJyByeNTE8zHZZY6zMsnTN4IgdE7D5HVezi6
         1ED895PGusf/hGTbnDcqGkZHSxSdA7ugdSoM/9QQ1LvlfCLMemfIdXYMGx77GVllFKwP
         /aUiCZyjprH2XZNXRe7pBp7BpV/KlACfMtBwoq1JbMUgU8IxbNt+BAY/FdMoBAdt46Mo
         6zxGoEidhA1voV3VK9qaZfswH5PLeFtuFBbYP9kgIvh+swQwlQoeJ8tA0yVxwUuHKrE8
         qijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djqCepZpYLgvDRN7eIErDpN284j4dEbxxjwWs+DBJLE=;
        b=TtKXxYpFLGU1l6ILSGzQPggawKKjLcsyj4v5FcfYDpjGz/aOQb/ZwR8FwYxvFEucw1
         putTrIHj9H0OQvAuiWiMb6IBO1kuHBRUjHugV7pfVLCY4mobC9WuWwbdi3Rup04YIUaZ
         Xwshoc3YYgE+QnCZSXLrP8tpF/luxe71SyO1On3rmGBttNj1CJXNUppmFSpmLDzbny6v
         NOsy23upt4GDPQLZAzmO4oBBCp5KH0TChRij2hNgb7z138J+oQGISctq15Yz8rEOkap2
         U+Pi4WRFSv4QadLbhDxivHRhpMLq8QOQvhFq79DsO4T4RzDjSl8LdvIMHqOMEOf4pgGz
         77Yg==
X-Gm-Message-State: AOAM533O+G6ZLfeuqeX2quc7/V6PztogEnjxzMR4VCtjSxpMNp3YThzf
	hCcugtItCmJbvdRGfVfdbewrTPfHuQ4=
X-Google-Smtp-Source: ABdhPJwc6b+0h+B0ELTuoQDIGp8FU2a+jBWP91EBPjdmcOadYPpE8vc3kJT5ROQ5TLwyfxBC4NDUAA==
X-Received: by 2002:a9d:6c91:: with SMTP id c17mr5655995otr.48.1623952583727;
        Thu, 17 Jun 2021 10:56:23 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id n8sm1105892oij.38.2021.06.17.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:56:23 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: Add piping compression library
Date: Thu, 17 Jun 2021 12:56:17 -0500
Message-Id: <20210617175617.2731-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a library that implements file-like objects (similar to
gzip.GzipFile) that can stream to arbitrary compression programs. This
is utilized to implement a LZ4 and zstd compression API.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/_pipecompress.py | 170 ++++++++++++++++++++++++++++++++
 bitbake/lib/bb/lz4.py           |  17 ++++
 bitbake/lib/bb/zstd.py          |  27 +++++
 3 files changed, 214 insertions(+)
 create mode 100644 bitbake/lib/bb/_pipecompress.py
 create mode 100644 bitbake/lib/bb/lz4.py
 create mode 100644 bitbake/lib/bb/zstd.py

diff --git a/bitbake/lib/bb/_pipecompress.py b/bitbake/lib/bb/_pipecompress.py
new file mode 100644
index 0000000000..3404be98d6
--- /dev/null
+++ b/bitbake/lib/bb/_pipecompress.py
@@ -0,0 +1,170 @@
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
+    def __init__(self, filename=None, mode="rb", *, fileobj=None):
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
+                close_fds=True,
+            )
+            self.pipe = self.p.stdout
+        else:
+            self.p = subprocess.Popen(
+                self.get_compress(),
+                stdin=subprocess.PIPE,
+                stdout=self.fileobj,
+                close_fds=True,
+            )
+            self.pipe = self.p.stdin
+
+        self.__closed = False
+
+    def close(self):
+        if self.closed:
+            return
+
+        self.pipe.close()
+        self.p.wait()
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
+        return self.pipe.readinto(b)
+
+    def write(self, data):
+        if self.mode != self.WRITE:
+            import errno
+
+            raise OSError(
+                errno.EBADF, "write() on read-only %s object" % self.__class__.__name__
+            )
+        return self.pipe.write(data)
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

