Return-Path: <michaelestner@web.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ECC021A9
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 15:30:10 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mx.groups.io with SMTP id smtpd.web11.54410.1739806204890725048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 07:30:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=michaelestner@web.de header.s=s29768273 header.b=NOIogh0m;
 spf=pass (domain: web.de, ip: 212.227.15.4, mailfrom: michaelestner@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739806203; x=1740411003; i=michaelestner@web.de;
	bh=+OBdRzssYQgwnd9kv8N+BUAZjegsa5KilWNUOSRbJgM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NOIogh0mMvl5fhA9Bv6QyQZxPvGEQkIvsD5InvpaVx+hLxRYBllqixQgsrzruQ6e
	 oaTrw8tM54K6Io6ObGKeqOcRuXnFufggY9fUw5TT+pncKtu60ISqiIcX+YON1JjvA
	 tjDCePu5x5SMp367odnvvcRINp2Oahv1YxuCH8eWnEfK6LZuNR9cWEieD/DTWrhPk
	 MTvzCKxsZreCQw3bWd3oZyfMqLWyozp5LiwvrbVQU7tk7hXt44Kg6fR6kQMuD+4YE
	 IBgXw9Ju7TeNBwi/dx1LPq77SoOuAlzzNuCFRPHbkBygWcnxkQ2IBH9mJSaeTYqCL
	 aegbfnSs80qq4Tdfuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from del01453.ebgroup.elektrobit.com ([84.190.164.64]) by
 smtp.web.de (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N01di-1tOeGT0Qcw-016WoP; Mon, 17 Feb 2025 16:30:03 +0100
From: Michael Estner <michaelestner@web.de>
To: bitbake-devel@lists.openembedded.org
Cc: Michael Estner <michaelestner@web.de>
Subject: [bitbake-devel][PATCH 1/1] utils: pylint: clean up imports
Date: Mon, 17 Feb 2025 16:29:53 +0100
Message-Id: <20250217152953.70557-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VWJ/vUyojScyjw8gj6Wh1CPgXOvMH37+J8LJZyuHZUnBl5fxQfz
 w7H5017L1Ym1UVyVhIcjJjxuTYXLj+DCqP74LDmsXZW8zqGLTENGwfdxAO1xTRKRq9tXQqx
 8IDdkAG5bv81qJEjHfRt9aYfqBSelt2ealWwE+oKrIvNV96GAz/gm22o2M83kubO6/0Tu0z
 lRSXPWIKYjAJzYU/+K+ZQ==
UI-OutboundReport: notjunk:1;M01:P0:qw6NWslWqzc=;C/qvRfRdZOO/eh3npp8v9Pg5N+r
 E2h/IzTImF7w5XmYAgqwWX0wGiv9tWB8xNJizuwinrS4RrpK2TIfe7p9zf6NVBAlz11ZGbx0M
 RxQ3y3RZSm2qCZ8Pd1VH8QvaV93ql7aEv1s88YyOJ+qV1PgKo9J4eGY1qtJfmNJao3F1md8dD
 wzeGrFIStJkfeJjt7KO9zgYncgOv2B8jK77H3JT2luPL3mgNBqzojSRACSfiFLi/EMLVsBZe0
 0cdQByQDT3J2pdUl+4Fa5IHIGCHLcW5ySXM07kyOOXx0diuyUObzFZxT7XvtVx2pe/k69AOrA
 BkmR2zWxTDWijAULR5G6HdWfH8oWLSdhrlC2gJngUd/Gi8ehaULJMoRHOHFN8mqfVm07J90IO
 hZzml0k1ArLchBuvSm3dJE3ZUPTixSaqVm/lZh5a2JGwbO+8B1ZIQCwey5mcx2sGJBE6RC9kh
 P16vEr68NtoCOpjtVZoXYoWweA2qhSMCgTla54XaHfpjPVqdBRE0hQoqxfOMFyySP/d6v75Xc
 phyfUKE3Jg3C3swUlLKiqwBQ6K2NFtkzNVGL7c3Gn0ZBvrhmkUfD1AIDp9kBB9or4Eu9COCdc
 ss2vpRKPPkuNb1i+wkX+qOUKu358BH9qreqr2XueFhTjk26HajUvxWaPUd0GU3DFnb1gSgMw0
 xPZX62g8ouo8deeaAh49/iwVaOUzd0qAcP7wD+IGMTOdYaf50TkpR755eXPfgduqIhnTA0Hci
 IO32LidiUxvkljRAgreR5B1M2suXEssremlQydOmKTWhIvCrTRr984+lzInyoCoeCy0Kk5Z0S
 HOh/GAfJbwd4EtMDq0m7M9lKK0OlIzwmwFbwSUXxvjPO1m9peddfhY20ym7TrBv+vmR/9GSEP
 Ue3XBw9Mt0iP288H6FOwQADrdy82IOdHcqKqIwih77SaOzcQdiRrL5ycckrnJ0dYn2fKAzHoj
 k8Mr9RniHASUwtwcGF6fFTmRHf25zux6e3IVeTAqEk9yzcNXe9U1886g49JEl85thM0LAL/+i
 5NgqD46ra38K+lcw52ZcG0n0qnG4bpzcx0F2plM5hv0+8ZFIBmsnjOEKBzIVKUTzLEegrVmZl
 eeweMIEb32ByIR1GicBYoVdLLlir/igEAD3O043Uuu/3q3BYKW8N0keNyQzdsm3EzbFZXts2w
 6PDYdPEt1julWJTrXL+C4xx7ve0RhSQ37YlVV9KqVYWqvq2YlKn56X8wOhe0jtM1EvH0NrQvZ
 fvT3z8wG6BNpA0czPfY9arPp20AxtYqug1Of6mGecqDcF7vJO70QJYJ7xuwLvn0cXiwd6JDzr
 m8e4Gw8dAW4BuEx2Nouj+VN4693iJqtdpFfdpcPIMDXj8hxferFkwRtpYtFcBn0BFkjejv82b
 mDtQ6SRSwh4Fzy4jw/ZkLFaegXFl3jYZrD6Zhv2iQEk7ovZIWp/+5l1vK3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 15:30:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17234

As mentioned in the TODO file I run pylint
and start clean code including:
Remove double imports
Order the imports as mentioned by pylint.
First small patch to see if what I do
fits the expectations.

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 lib/bb/utils.py | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 135c71c00..3cb59d807 100644
=2D-- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -11,11 +11,8 @@ import re, fcntl, os, string, stat, shutil, time
 import sys
 import errno
 import logging
-import bb
-import bb.msg
 import locale
 import multiprocessing
-import fcntl
 import importlib
 import importlib.machinery
 import importlib.util
@@ -24,7 +21,6 @@ import subprocess
 import glob
 import fnmatch
 import traceback
-import errno
 import signal
 import collections
 import copy
@@ -36,6 +32,8 @@ import tempfile
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
+import bb
+import bb.msg

 logger =3D logging.getLogger("BitBake.Util")
 python_extensions =3D importlib.machinery.all_suffixes()
@@ -1457,8 +1455,6 @@ def edit_bblayers_conf(bblayers_conf, add, remove, e=
dit_cb=3DNone):
             but weren't (because they weren't in the list)
     """

-    import fnmatch
-
     def remove_trailing_sep(pth):
         if pth and pth[-1] =3D=3D os.sep:
             pth =3D pth[:-1]
@@ -1649,7 +1645,7 @@ def ioprio_set(who, cls, value):
         bb.warn("Unable to set IO Prio for arch %s" % _unamearch)

 def set_process_name(name):
-    from ctypes import cdll, byref, create_string_buffer
+    from ctypes import byref, create_string_buffer
     # This is nice to have for debugging, not essential
     try:
         libc =3D cdll.LoadLibrary('libc.so.6')
=2D-
2.25.1


