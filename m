Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC1C61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 01:31:31 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3352.1787707882865318517
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 18:31:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AbITU23v;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e65e18969so35758085a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707882; x=1788312682; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYedTuHIpyrsWrzGe833NzqIravMuWMM7NgdSj5Afdc=;
        b=AbITU23vVEg125ln1o65jLiyh4Phr//wyGPxuRFgPAw6o2Oxlo5lWyh0FxE1xUF3hw
         I0HArZzegOBgV84yTie7N8RZ+avhugkqf3vaOvdgXrgTlfxbIagAMR+gqDFNNs8rjwl+
         JiQkM7xqbDLRNzOfYh9GhOQ/NoCvdjfsFS1q7Qw7wdXcALr0eT7lWmZM8T9tD1AggUl3
         EfX/49S7EWCXZJ1nKs/W77DYo6+auU2swTFLreZ49FAtxer6rEoRGAByN1l4vVviuQPo
         NeekzfyHsqTka74E2OSYelcqEaPvWYt0qBdfc4oyavL8tZKAlSX2o5/EZ9ld16z7jBxa
         Tqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707882; x=1788312682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYedTuHIpyrsWrzGe833NzqIravMuWMM7NgdSj5Afdc=;
        b=c2rjsKrP9jtF2HfqHCOmc7QBIP7VXS6go0wyBLyZjq1nskGBPtOP5kO6uoqpddVByZ
         kDi7tW0NsVNbkAgOY+6w1iOiq3nDy6Y6pFF9gFB9z3L+QDpXF7jmO2MQUrMBy7bDiQL7
         /oemQYrwPVFzhFlpxmkTyfJA5X0y7wtuEr9zn0J//AB0oQjfT6kqDlkPdfbSLYqU8xgo
         gJC7Zy0eyl8Ndmxi5sPuSkNZnh9uwvJPhZ0eOgbLCosBYxI6MIVPvF7UxhMGM1pxu3F0
         DAaps2UWKvV+diQN/C3pqJa/TP7YNBd4kKSE4mGHuYZ9iQfnHI0GexP0i+YUeH4VKUlv
         Ao0g==
X-Gm-Message-State: AFuF++kZVHhdgIUkir7FL+2F6gsnCCCM0cm5HgCeSIYamicZlAiODBhX
	qRuGGWzRT7BOiQYfJvevFHigDJl13yH3cVKrFaCVC1W7d/y7An0gzxWi
X-Gm-Gg: AR+sD123lgshXlsAOrYNUxf0UKG1zyrplV47TCZQBTAqyAVypUKDZBNxHQSg8Wk9zPN
	yPNIXr9qeFh4rJJp1iqBn9Zuq/G/LWSXg8JeOVdujyaQvXGx8KsFWnTCmxMfojGksfZ339MxR1Y
	/BKVLhT3I+G1LJyA10y2b7K5Tapl645y3JV99vIJJWCm5N0gf5Jx4aahsoSR8BOmPdMYE2PTiT3
	Tr0UeHVtDVpzi9hoR3E+4xx1iTWhCpptGbl+PT21Xi7wCPY26onjZqc30+tpfAihmlxwyWsD3J5
	Qbr2JjLEb7WsqxoNPoV3gRHVl9xmXENdi5lGJh+bjD008m+UvQXyYCWCy3zJVzl5BcXIOMk/vOB
	M+YlzQqAHLUNZ2CU6xBknPjUpwMGs00YIGZgVc/wqto63PUeK2IPnVtC6Y2FIkJ0RdxWtb37F2N
	6dnq3+Bt9qJknxn67dzxaTSMNLuHRuVx0KIzp6CV6s5Hx96YHJI8fwFxpFVO6DIHPYT+E0QupfQ
	elHPA6DHUgIic8vU1radR/9gfhEg/s=
X-Received: by 2002:a05:620a:700c:b0:937:783f:4fa5 with SMTP id af79cd13be357-937783f54e3mr702291585a.19.1787707876878;
        Tue, 25 Aug 2026 18:31:16 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e36879asm105857785a.17.2026.08.25.18.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:31:15 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: state the language of six Python blocks explicitly
Date: Tue, 25 Aug 2026 21:31:13 -0400
Message-ID: <20260826013113.2673355-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 01:31:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20049

Six blocks show BitBake datastore and library calls - d.getVar,
d.getVarFlags, bb.fetch2.Fetch, bb.fatal - written in Python, and carry
no language:

  fetching.rst              "the code to execute the first part of this
                            process", the fetcher instantiation and the
                            two unpack calls
  metadata.rst              the BB_ORIGENV datastore example and the
                            getVarFlags/setVarFlags pair
  library-functions.rst     the f-string example, introduced with
                            "Python f-strings may also be used"

These are BitBake snippets, but "bitbake" is the wrong language for
them. In a recipe this code lives inside a python task, and the BitBake
lexer hands task bodies to the Python lexer; wrapping each of these in a
python task and comparing tokens by offset gives a result identical to
lexing it as Python directly. Presented as a bare block instead, the
BitBake lexer reads each line as a variable assignment at column 0 and
renders d.getVar( as part of a string value. BitBake's own parser agrees
it is not an assignment: there is no quoted value, so it would be a
parse error. So "python" is what the BitBake lexer itself produces for
this code in the context where it belongs.

Nothing renders differently today. Sphinx maps an untagged block to
"default", which is the Python lexer, so these are already highlighted -
by accident. The difference is what happens when that lexer raises:

  except ErrorToken as err:
      if lang == 'default':
          lang = 'none'   # automatic highlighting failed.
      else:
          logger.warning('Lexing literal_block %r as "%s" resulted in
                          an error at token: %r ...')

"default" is dropped silently to "none"; a named language warns, and -W
puts that in front of whoever made the edit. Naming the language turns a
guess that happens to be right into a statement that stays checked.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../bitbake-user-manual-fetching.rst                 | 12 +++++++++---
 .../bitbake-user-manual-library-functions.rst        |  4 +++-
 .../bitbake-user-manual-metadata.rst                 |  8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index b96018a4edcf..2993eda49439 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -27,7 +27,9 @@ and unpacking the files is often optionally followed by patching.
 Patching, however, is not covered by this module.
 
 The code to execute the first part of this process, a fetch, looks
-something like the following::
+something like the following:
+
+.. code-block:: python
 
    src_uri = (d.getVar('SRC_URI') or "").split()
    fetcher = bb.fetch2.Fetch(src_uri, d)
@@ -37,7 +39,9 @@ This code sets up an instance of the fetch class. The instance uses a
 space-separated list of URLs from the :term:`SRC_URI`
 variable and then calls the ``download`` method to download the files.
 
-The instantiation of the fetch class is usually followed by::
+The instantiation of the fetch class is usually followed by:
+
+.. code-block:: python
 
    rootdir = l.getVar('UNPACKDIR')
    fetcher.unpack(rootdir)
@@ -203,7 +207,9 @@ that updates an existing checkout *in place* rather than removing and
 re-cloning it. This is useful when the target directory may contain
 local commits that should be preserved across updates.
 
-The code to call the non-destructive update looks like the following::
+The code to call the non-destructive update looks like the following:
+
+.. code-block:: python
 
    rootdir = l.getVar('UNPACKDIR')
    fetcher.unpack_update(rootdir)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
index 09e353945bb6..8c9d9003dd7b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
@@ -29,7 +29,9 @@ Formatted string can also be used directly::
 
    bb.error("%s, we have a %s" % ("Houston", "big problem"))
 
-Python f-strings may also be used::
+Python f-strings may also be used:
+
+.. code-block:: python
 
    h = "Houston"
    bb.fatal(f"{h}, we have a critical problem")
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b0535b5dd459..a146b897c884 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1719,7 +1719,9 @@ environment into a special variable named :term:`BB_ORIGENV`.
 The :term:`BB_ORIGENV` variable returns a datastore object that can be
 queried using the standard datastore operators such as
 ``getVar(, False)``. The datastore object is useful, for example, to
-find the original ``DISPLAY`` variable. Here is an example::
+find the original ``DISPLAY`` variable. Here is an example:
+
+.. code-block:: python
 
    origenv = d.getVar("BB_ORIGENV", False)
    bar = origenv.getVar("BAR", False)
@@ -1732,7 +1734,9 @@ Variable Flags
 
 Variable flags (varflags) help control a task's functionality and
 dependencies. BitBake reads and writes varflags to the datastore using
-the following command forms::
+the following command forms:
+
+.. code-block:: python
 
    variable = d.getVarFlags("variable")
    self.d.setVarFlags("FOO", {"func": True})

