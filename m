Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B044BC3DA65
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 18:53:27 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web10.1919.1692298404380260264
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Aug 2023 11:53:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=WZ91xztN;
 spf=pass (domain: gmail.com, ip: 209.85.167.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3a81154c570so58012b6e.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692298403; x=1692903203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQgku/aaO9aBcO94aVll4W+yqmpMnJ/8POnedvMm2x4=;
        b=WZ91xztNkdrCTRTJph8g61zMoz3jVNF/DqwOLMjr1bdOgQ4qOAU++dlzOiRp5CjTON
         1QwgPonAiVsrltudxTUbrLuRxMLgv63BsnjePV+bDkF8zYg33NUttb0G2xS4E3Jahjup
         SzZzmBHlQ1V8foA+oii+pR2X6mTqFPdPJQ75YYKe92zokWd1yf+dfOIiy6A4SU4YrMeZ
         b3HWaL+4JKGtXn9/pbNtL/WdVS/aBfe+gzpokXiRaojHb+8dKE5Z3UisWe/Ep/Ehwcx9
         rtx16SYYwJY5j9L0QJkDOWbg5VQtcxdfU6XKuvFOttXGwZff+MC72gSYWTgUYwtII4nC
         XILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298403; x=1692903203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQgku/aaO9aBcO94aVll4W+yqmpMnJ/8POnedvMm2x4=;
        b=cJEnjWqhSBlVyM66BH3pXBDYcdsDz2ypUJYUTdQ1OIqgoLHFDXwQCio096bgQ6O4A7
         9XVXQ+cek4OxQTpBHjIPv2m/yCehbPc2S8WiTPOMjRtBZpou0/LbHMdajSkRpDZXWvg1
         ZLrsEYEm6sFocbCpi1L7j7/m9Br2hJN2hACcGE8tllQ95VTabO3eTcFCYRJzh7p4O8/f
         zOqRaXFvSwlO3AGn92sy3g/Laa5YjELQhvf+sEY7jujheEtsOzxNw5dNbHm5EMJT46GG
         KKxY/vOjZfqRK0DQasweQUPea3C1lKdVLHxDPKbKWZf6OK0Jhf1a3HJIpeXiN1k/ZGKB
         qNwA==
X-Gm-Message-State: AOJu0YzHwScn0n8VJdMhfuHXvYyBNlh2cyJJHRfn4MWxtwb6FQeWnOMs
	WKa54xhthvZqT23A+KKrj5hYqtMhX8k=
X-Google-Smtp-Source: AGHT+IElveIFPndCoY50/pHhD8AAn0aTQuTNu1Zf2JrD5qg3G97N142d1K0prUzq5CGfOR//a2sqjg==
X-Received: by 2002:a05:6808:140c:b0:3a7:4987:d4a with SMTP id w12-20020a056808140c00b003a749870d4amr481649oiv.9.1692298402992;
        Thu, 17 Aug 2023 11:53:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
        by smtp.gmail.com with ESMTPSA id fa19-20020a0568082a5300b003a7543bb635sm140851oib.22.2023.08.17.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:53:22 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: p.lobacz@welotec.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] Add xattr and acl libraries
Date: Thu, 17 Aug 2023 12:53:18 -0600
Message-Id: <20230817185318.1562354-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 18:53:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14950

Adds Python wrappers around the xattr API from libc and the ACL API from
libacl.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/acl.py   | 215 ++++++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/xattr.py | 126 +++++++++++++++++++++++
 2 files changed, 341 insertions(+)
 create mode 100755 bitbake/lib/bb/acl.py
 create mode 100755 bitbake/lib/bb/xattr.py

diff --git a/bitbake/lib/bb/acl.py b/bitbake/lib/bb/acl.py
new file mode 100755
index 00000000000..0f41b275cf6
--- /dev/null
+++ b/bitbake/lib/bb/acl.py
@@ -0,0 +1,215 @@
+#! /usr/bin/env python3
+#
+# Copyright 2023 by Garmin Ltd. or its subsidiaries
+#
+# SPDX-License-Identifier: MIT
+
+
+import sys
+import ctypes
+import os
+import errno
+import pwd
+import grp
+
+libacl = ctypes.CDLL("libacl.so.1", use_errno=True)
+
+
+ACL_TYPE_ACCESS = 0x8000
+ACL_TYPE_DEFAULT = 0x4000
+
+ACL_FIRST_ENTRY = 0
+ACL_NEXT_ENTRY = 1
+
+ACL_UNDEFINED_TAG = 0x00
+ACL_USER_OBJ = 0x01
+ACL_USER = 0x02
+ACL_GROUP_OBJ = 0x04
+ACL_GROUP = 0x08
+ACL_MASK = 0x10
+ACL_OTHER = 0x20
+
+ACL_READ = 0x04
+ACL_WRITE = 0x02
+ACL_EXECUTE = 0x01
+
+acl_t = ctypes.c_void_p
+acl_entry_t = ctypes.c_void_p
+acl_permset_t = ctypes.c_void_p
+acl_perm_t = ctypes.c_uint
+
+acl_tag_t = ctypes.c_int
+
+libacl.acl_free.argtypes = [acl_t]
+
+
+def acl_free(acl):
+    libacl.acl_free(acl)
+
+
+libacl.acl_get_file.restype = acl_t
+libacl.acl_get_file.argtypes = [ctypes.c_char_p, ctypes.c_uint]
+
+
+def acl_get_file(path, typ):
+    acl = libacl.acl_get_file(os.fsencode(path), typ)
+    if acl is None:
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err), str(path))
+
+    return acl
+
+
+libacl.acl_get_entry.argtypes = [acl_t, ctypes.c_int, ctypes.c_void_p]
+
+
+def acl_get_entry(acl, entry_id):
+    entry = acl_entry_t()
+    ret = libacl.acl_get_entry(acl, entry_id, ctypes.byref(entry))
+    if ret < 0:
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err))
+
+    if ret == 0:
+        return None
+
+    return entry
+
+
+libacl.acl_get_tag_type.argtypes = [acl_entry_t, ctypes.c_void_p]
+
+
+def acl_get_tag_type(entry_d):
+    tag = acl_tag_t()
+    ret = libacl.acl_get_tag_type(entry_d, ctypes.byref(tag))
+    if ret < 0:
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err))
+    return tag.value
+
+
+libacl.acl_get_qualifier.restype = ctypes.c_void_p
+libacl.acl_get_qualifier.argtypes = [acl_entry_t]
+
+
+def acl_get_qualifier(entry_d):
+    ret = libacl.acl_get_qualifier(entry_d)
+    if ret is None:
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err))
+    return ctypes.c_void_p(ret)
+
+
+libacl.acl_get_permset.argtypes = [acl_entry_t, ctypes.c_void_p]
+
+
+def acl_get_permset(entry_d):
+    permset = acl_permset_t()
+    ret = libacl.acl_get_permset(entry_d, ctypes.byref(permset))
+    if ret < 0:
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err))
+
+    return permset
+
+
+libacl.acl_get_perm.argtypes = [acl_permset_t, acl_perm_t]
+
+
+def acl_get_perm(permset_d, perm):
+    ret = libacl.acl_get_perm(permset_d, perm)
+    if ret < 0:
+        err = ctypes.get_errno()
+        raise OSError(err, os.strerror(err))
+    return bool(ret)
+
+
+class Entry(object):
+    def __init__(self, tag, qualifier, mode):
+        self.tag = tag
+        self.qualifier = qualifier
+        self.mode = mode
+
+    def __str__(self):
+        typ = ""
+        qual = ""
+        if self.tag == ACL_USER:
+            typ = "user"
+            qual = pwd.getpwuid(self.qualifier).pw_name
+        elif self.tag == ACL_GROUP:
+            typ = "group"
+            qual = grp.getgrgid(self.qualifier).gr_name
+        elif self.tag == ACL_USER_OBJ:
+            typ = "user"
+        elif self.tag == ACL_GROUP_OBJ:
+            typ = "group"
+        elif self.tag == ACL_MASK:
+            typ = "mask"
+        elif self.tag == ACL_OTHER:
+            typ = "other"
+
+        r = "r" if self.mode & ACL_READ else "-"
+        w = "w" if self.mode & ACL_WRITE else "-"
+        x = "x" if self.mode & ACL_EXECUTE else "-"
+
+        return f"{typ}:{qual}:{r}{w}{x}"
+
+
+class ACL(object):
+    def __init__(self, acl):
+        self.acl = acl
+
+    def __del__(self):
+        acl_free(self.acl)
+
+    def entries(self):
+        entry_id = ACL_FIRST_ENTRY
+        while True:
+            entry = acl_get_entry(self.acl, entry_id)
+            if entry is None:
+                break
+
+            permset = acl_get_permset(entry)
+
+            mode = 0
+            for m in (ACL_READ, ACL_WRITE, ACL_EXECUTE):
+                if acl_get_perm(permset, m):
+                    mode |= m
+
+            qualifier = None
+            tag = acl_get_tag_type(entry)
+
+            if tag == ACL_USER or tag == ACL_GROUP:
+                qual = acl_get_qualifier(entry)
+                qualifier = ctypes.cast(qual, ctypes.POINTER(ctypes.c_int))[0]
+
+            yield Entry(tag, qualifier, mode)
+
+            entry_id = ACL_NEXT_ENTRY
+
+    @classmethod
+    def from_path(cls, path, typ):
+        acl = acl_get_file(path, typ)
+        return cls(acl)
+
+
+def main():
+    import argparse
+    import pwd
+    import grp
+    from pathlib import Path
+
+    parser = argparse.ArgumentParser()
+    parser.add_argument("path", help="File Path", type=Path)
+
+    args = parser.parse_args()
+
+    acl = ACL.from_path(args.path, ACL_TYPE_ACCESS)
+    for entry in acl.entries():
+        print(str(entry))
+
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/bitbake/lib/bb/xattr.py b/bitbake/lib/bb/xattr.py
new file mode 100755
index 00000000000..7b634944a40
--- /dev/null
+++ b/bitbake/lib/bb/xattr.py
@@ -0,0 +1,126 @@
+#! /usr/bin/env python3
+#
+# Copyright 2023 by Garmin Ltd. or its subsidiaries
+#
+# SPDX-License-Identifier: MIT
+
+import sys
+import ctypes
+import os
+import errno
+
+libc = ctypes.CDLL("libc.so.6", use_errno=True)
+fsencoding = sys.getfilesystemencoding()
+
+
+libc.listxattr.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_size_t]
+libc.llistxattr.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_size_t]
+
+
+def listxattr(path, follow=True):
+    func = libc.listxattr if follow else libc.llistxattr
+
+    os_path = os.fsencode(path)
+
+    while True:
+        length = func(os_path, None, 0)
+
+        if length < 0:
+            err = ctypes.get_errno()
+            raise OSError(err, os.strerror(err), str(path))
+
+        if length == 0:
+            return []
+
+        arr = ctypes.create_string_buffer(length)
+
+        read_length = func(os_path, arr, length)
+        if read_length != length:
+            # Race!
+            continue
+
+        return [a.decode(fsencoding) for a in arr.raw.split(b"\x00") if a]
+
+
+libc.getxattr.argtypes = [
+    ctypes.c_char_p,
+    ctypes.c_char_p,
+    ctypes.c_char_p,
+    ctypes.c_size_t,
+]
+libc.lgetxattr.argtypes = [
+    ctypes.c_char_p,
+    ctypes.c_char_p,
+    ctypes.c_char_p,
+    ctypes.c_size_t,
+]
+
+
+def getxattr(path, name, follow=True):
+    func = libc.getxattr if follow else libc.lgetxattr
+
+    os_path = os.fsencode(path)
+    os_name = os.fsencode(name)
+
+    while True:
+        length = func(os_path, os_name, None, 0)
+
+        if length < 0:
+            err = ctypes.get_errno()
+            if err == errno.ENODATA:
+                return None
+            raise OSError(err, os.strerror(err), str(path))
+
+        if length == 0:
+            return ""
+
+        arr = ctypes.create_string_buffer(length)
+
+        read_length = func(os_path, os_name, arr, length)
+        if read_length != length:
+            # Race!
+            continue
+
+        return arr.raw
+
+
+def get_all_xattr(path, follow=True):
+    attrs = {}
+
+    names = listxattr(path, follow)
+
+    for name in names:
+        value = getxattr(path, name, follow)
+        if value is None:
+            # This can happen if a value is erased after listxattr is called,
+            # so ignore it
+            continue
+        attrs[name] = value
+
+    return attrs
+
+
+def main():
+    import argparse
+    from pathlib import Path
+
+    parser = argparse.ArgumentParser()
+    parser.add_argument("path", help="File Path", type=Path)
+
+    args = parser.parse_args()
+
+    attrs = get_all_xattr(args.path)
+
+    for name, value in attrs.items():
+        try:
+            value = value.decode(fsencoding)
+        except UnicodeDecodeError:
+            pass
+
+        print(f"{name} = {value}")
+
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.33.0


