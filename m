Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D995CDB47F
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12954.1782321627052891583
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=fUVLo3KO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxU2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MQZiVDF1XLRfUO5t2msZCSo88P7A0w0GSONiaJpE8+k=; b=
	fUVLo3KO8Q8/a5X864yZXC2W/3o6+LtEuv6J+SKdH6ZpTkwIz2PZLSHKBRZkjZ1X
	ktTafoNMqSWJ1faHqDtCb3ZaZZlxMTQVs85RLbPI4mnNmp+WpNqThSSHKJy3NeVu
	KYgn7VrwrWlXeW/qY0rfswTiJN+qtAlNoSEBvt8YJnWSS5q3cKXMPauGS1MH6gnX
	nllbm8Tiv7+Sg12BYGEKStNTVXJOD5SxPZkg1bXt/4Qtc/zuXNuaiZw6C2/Em7c7
	9Yeica5fqfNTa0CcQxGxwyjMPwBi9qI+fx2ywGpqflwse2UH6fKnEk0eBX1fjSc5
	5dGeLtBjDZlGyWyPPMOz1Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:24 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:13 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:13 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:07 -0700
Subject: [PATCH v4 07/11] Add vendor patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260624-add-pypi-v8-v4-7-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfXxscItJ+3/J43
 GSwEcSSA190WXnSbVoLXIG8YQbLDyXUfrEwXh4BICY+Ob/un7eDur7Lrx+HVPDDHsMhnHj33Td3
 Tio9mRXuelzfZFZR2/F452PRN+XI2q4VwryuqVZtvxklDGS+dCv56iycZIftiUBao2kaDoP718K
 tMc7LJj7tjptfGk07USY4AOC5m+k8Hi4cqznKSTTX9wTH/+mb3iozTkdIrcz/oMYbfw7cmDKATw
 57HIFzwr0K+/i9y0bSosDDTbs9Njs0EXpVI2FnDktzPCavZuGfYASFmrebCy+qcq3EsOWNPcFzb
 TE2sQxtSnKpFdCD6/f9a7TTr+zzEcMBEHBV3fNG/YTq97RIfVUKC8e84cb/K9lOHCQKTnswiTXb
 pr34zGnlgxC+ekF1bNzwsgGd/5RxUA==
X-Proofpoint-ORIG-GUID: SJX0aggBNtTvXESfTOBs0-M37hebV11-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfXx5PiynzNHhyz
 8QRJ1TWouIhhxMSjl+zc+UCfA/yDhJgY3IPpOH8WusMJDJ1/h1f469JYqYWFxTRuZsbxmIUTX4H
 ix4VoWsYllOWe7SInZm8VwwBFBVOu248nwV1TdEbwinbJJLXzk+H
X-Proofpoint-GUID: SJX0aggBNtTvXESfTOBs0-M37hebV11-
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11d8 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=aRxQL1JOAAAA:8 a=P-IC7800AAAA:8
 a=3-RhneuVAAAA:8 a=uvxgbxF22WCvZ4Xt2W0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=lBRdisTmIr2YKkuu8atg:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 65OEegxU2602576
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19774

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 vendor/licenses/ply/LICENSE                        |  32 ++++++
 .../bs4-0010-lib-bs4-Avoid-soupsieve-warning.patch |  40 +++++++
 vendor/patches/bs4-remove-double-imports.patch     |  23 ++++
 ...lib-implement-basic-task-progress-support.patch | 126 +++++++++++++++=
++++++
 ...-initial-pass-of-SPDX-license-headers-to-.patch |  80 +++++++++++++
 ...gressbar-accept-value-over-initial-maxval.patch |  55 +++++++++
 ...-Add-self._fd_console-to-use-for-self._ha.patch |  54 +++++++++
 ...ar-Make-bars-show-correctly-with-maxval-0.patch |  32 ++++++
 ...-knotty-Allow-mixing-log-messages-and-pro.patch |  32 ++++++
 9 files changed, 474 insertions(+)

diff --git a/vendor/licenses/ply/LICENSE b/vendor/licenses/ply/LICENSE
new file mode 100644
index 000000000..d050b2ef9
--- /dev/null
+++ b/vendor/licenses/ply/LICENSE
@@ -0,0 +1,32 @@
+# ----------------------------------------------------------------------=
-------
+# ply
+#
+# Copyright (C) 2001-2018
+# David M. Beazley (Dabeaz LLC)
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions are
+# met:
+#
+# * Redistributions of source code must retain the above copyright notic=
e,
+#   this list of conditions and the following disclaimer.
+# * Redistributions in binary form must reproduce the above copyright no=
tice,
+#   this list of conditions and the following disclaimer in the document=
ation
+#   and/or other materials provided with the distribution.
+# * Neither the name of the David Beazley or Dabeaz LLC may be used to
+#   endorse or promote products derived from this software without
+#  specific prior written permission.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+# ----------------------------------------------------------------------=
-------
diff --git a/vendor/patches/bs4-0010-lib-bs4-Avoid-soupsieve-warning.patc=
h b/vendor/patches/bs4-0010-lib-bs4-Avoid-soupsieve-warning.patch
new file mode 100644
index 000000000..ef0f1cc6b
--- /dev/null
+++ b/vendor/patches/bs4-0010-lib-bs4-Avoid-soupsieve-warning.patch
@@ -0,0 +1,40 @@
+From 8e444cd9913d1ee0672b5583e263e5927c3221df Mon Sep 17 00:00:00 2001
+From: Richard Purdie <richard.purdie@linuxfoundation.org>
+Date: Fri, 31 May 2024 13:09:44 +0100
+Subject: [PATCH 10/11] lib/bs4: Avoid soupsieve warning
+
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+---
+ lib/bs4/css.py | 10 ++--------
+ 1 file changed, 2 insertions(+), 8 deletions(-)
+
+diff --git a/lib/bb/_vendor/bs4/css.py b/lib/bb/_vendor/bs4/css.py
+index 245ac6010..cd1fd2df8 100644
+--- a/lib/bb/_vendor/bs4/css.py
++++ b/lib/bb/_vendor/bs4/css.py
+@@ -24,23 +24,14 @@
+     Optional,
+     TYPE_CHECKING,
+ )
+-import warnings
+ from bs4._typing import _NamespaceMapping
+=20
+ if TYPE_CHECKING:
+-    from soupsieve import SoupSieve
+     from bs4 import element
+     from bs4.element import ResultSet, Tag
+=20
+-soupsieve: Optional[ModuleType]
+-try:
+-    import soupsieve
+-except ImportError:
+-    soupsieve =3D None
+-    warnings.warn(
+-        "The soupsieve package is not installed. CSS selectors cannot b=
e used."
+-    )
+-
++# We don't use soupsieve
++soupsieve =3D None
+=20
+ class CSS(object):
+     """A proxy object against the ``soupsieve`` library, to simplify it=
s
diff --git a/vendor/patches/bs4-remove-double-imports.patch b/vendor/patc=
hes/bs4-remove-double-imports.patch
new file mode 100644
index 000000000..f7be7d029
--- /dev/null
+++ b/vendor/patches/bs4-remove-double-imports.patch
@@ -0,0 +1,23 @@
+commit 741db6719efca5aa9ef2c15e60cdd624e4aa1a8d
+Author: Michael Estner <michaelestner@web.de>
+Date:   Tue Feb 25 19:34:25 2025 +0100
+
+    lib: Remove double imports
+   =20
+    * Remove double imports mentioned by pylint
+   =20
+    Signed-off-by: Michael Estner <michaelestner@web.de>
+    Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+
+diff --git a/lib/bb/_vendor/bs4/__init__.py b/lib/bb/_vendor/bs4/__init_=
_.py
+index d8ad5e1dc..725203d94 100644
+--- a/lib/bb/_vendor/bs4/__init__.py
++++ b/lib/bb/_vendor/bs4/__init__.py
+@@ -1173,7 +1173,5 @@
+=20
+ # If this file is run as a script, act as an HTML pretty-printer.
+ if __name__ =3D=3D "__main__":
+-    import sys
+-
+     soup =3D BeautifulSoup(sys.stdin)
+     print((soup.prettify()))
diff --git a/vendor/patches/progressbar-0001-lib-implement-basic-task-pro=
gress-support.patch b/vendor/patches/progressbar-0001-lib-implement-basic=
-task-progress-support.patch
new file mode 100644
index 000000000..2f91b4b53
--- /dev/null
+++ b/vendor/patches/progressbar-0001-lib-implement-basic-task-progress-s=
upport.patch
@@ -0,0 +1,126 @@
+From 0d275fc5b6531957a6189069b04074065bb718a0 Mon Sep 17 00:00:00 2001
+From: Paul Eggleton <paul.eggleton@linux.intel.com>
+Date: Thu, 23 Jun 2016 22:59:05 +1200
+Subject: [PATCH 1/6] lib: implement basic task progress support
+
+For long-running tasks where we have some output from the task that
+gives us some idea of the progress of the task (such as a percentage
+complete), provide the means to scrape the output for that progress
+information and show it to the user in the default knotty terminal
+output in the form of a progress bar. This is implemented using a new
+TaskProgress event as well as some code we can insert to do output
+scanning/filtering.
+
+Any task can fire TaskProgress events; however, if you have a shell task
+whose output you wish to scan for progress information, you just need to
+set the "progress" varflag on the task. This can be set to:
+ * "percent" to just look for a number followed by a % sign
+ * "percent:<regex>" to specify your own regex matching a percentage
+   value (must have a single group which matches the percentage number)
+ * "outof:<regex>" to look for the specified regex matching x out of y
+   items completed (must have two groups - first group needs to be x,
+   second y).
+We can potentially extend this in future but this should be a good
+start.
+
+Part of the implementation for [YOCTO #5383].
+
+Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+---
+ lib/progressbar/progressbar.py | 16 +++++++++++----
+ lib/progressbar/widgets.py     | 36 ++++++++++++++++++++++++++++++++++
+ 2 files changed, 48 insertions(+), 4 deletions(-)
+
+diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/=
progressbar/progressbar.py
+index 0b9dcf763..2873ad6ca 100644
+--- a/lib/bb/_vendor/progressbar/progressbar.py
++++ b/lib/bb/_vendor/progressbar/progressbar.py
+@@ -3,6 +3,8 @@
+ # progressbar  - Text progress bar library for Python.
+ # Copyright (c) 2005 Nilton Volpato
+ #
++# (With some small changes after importing into BitBake)
++#
+ # This library is free software; you can redistribute it and/or
+ # modify it under the terms of the GNU Lesser General Public
+ # License as published by the Free Software Foundation; either
+@@ -261,12 +263,14 @@ class ProgressBar(object):
+         now =3D time.time()
+         self.seconds_elapsed =3D now - self.start_time
+         self.next_update =3D self.currval + self.update_interval
+-        self.fd.write(self._format_line() + '\r')
++        output =3D self._format_line()
++        self.fd.write(output + '\r')
+         self.fd.flush()
+         self.last_update_time =3D now
++        return output
+=20
+=20
+-    def start(self):
++    def start(self, update=3DTrue):
+         """Starts measuring time, and prints the bar at 0%.
+=20
+         It returns self so you can use it like this:
+@@ -289,8 +293,12 @@ class ProgressBar(object):
+             self.update_interval =3D self.maxval / self.num_intervals
+=20
+=20
+-        self.start_time =3D self.last_update_time =3D time.time()
+-        self.update(0)
++        self.start_time =3D time.time()
++        if update:
++            self.last_update_time =3D self.start_time
++            self.update(0)
++        else:
++            self.last_update_time =3D 0
+=20
+         return self
+=20
+diff --git a/lib/bb/_vendor/progressbar/widgets.py b/lib/bb/_vendor/prog=
ressbar/widgets.py
+index 6434ad559..77285ca7a 100644
+--- a/lib/bb/_vendor/progressbar/widgets.py
++++ b/lib/bb/_vendor/progressbar/widgets.py
+@@ -353,3 +353,39 @@ class BouncingBar(Bar):
+         if not self.fill_left: rpad, lpad =3D lpad, rpad
+=20
+         return '%s%s%s%s%s' % (left, lpad, marker, rpad, right)
++
++
++class BouncingSlider(Bar):
++    """
++    A slider that bounces back and forth in response to update() calls
++    without reference to the actual value. Based on a combination of
++    BouncingBar from a newer version of this module and RotatingMarker.
++    """
++    def __init__(self, marker=3D'<=3D>'):
++        self.curmark =3D -1
++        self.forward =3D True
++        Bar.__init__(self, marker=3Dmarker)
++    def update(self, pbar, width):
++        left, marker, right =3D (format_updatable(i, pbar) for i in
++                               (self.left, self.marker, self.right))
++
++        width -=3D len(left) + len(right)
++        if width < 0:
++            return ''
++
++        if pbar.finished: return '%s%s%s' % (left, width * '=3D', right=
)
++
++        self.curmark =3D self.curmark + 1
++        position =3D int(self.curmark % (width * 2 - 1))
++        if position + len(marker) > width:
++            self.forward =3D not self.forward
++            self.curmark =3D 1
++            position =3D 1
++        lpad =3D ' ' * (position - 1)
++        rpad =3D ' ' * (width - len(marker) - len(lpad))
++
++        if not self.forward:
++            temp =3D lpad
++            lpad =3D rpad
++            rpad =3D temp
++        return '%s%s%s%s%s' % (left, lpad, marker, rpad, right)
+--=20
+2.49.0
+
diff --git a/vendor/patches/progressbar-0002-bitbake-Add-initial-pass-of-=
SPDX-license-headers-to-.patch b/vendor/patches/progressbar-0002-bitbake-=
Add-initial-pass-of-SPDX-license-headers-to-.patch
new file mode 100644
index 000000000..09f68b97b
--- /dev/null
+++ b/vendor/patches/progressbar-0002-bitbake-Add-initial-pass-of-SPDX-li=
cense-headers-to-.patch
@@ -0,0 +1,80 @@
+From ff237c33337f4da2ca06c3a2c49699bc26608a6b Mon Sep 17 00:00:00 2001
+From: Richard Purdie <richard.purdie@linuxfoundation.org>
+Date: Tue, 30 Apr 2019 11:05:26 +0100
+Subject: [PATCH 2/6] bitbake: Add initial pass of SPDX license headers t=
o
+ source code
+
+This adds the SPDX-License-Identifier license headers to the majority of
+our source files to make it clearer exactly which license files are unde=
r.
+
+The bulk of the files are under GPL v2.0 with one found to be under V2.0
+or later, some under MIT and some have dual license. There are some file=
s
+which are potentially harder to classify where we've imported upstream c=
ode
+and those can be handled specifically in later commits.
+
+The COPYING file is replaced with LICENSE.X files which contain the full
+license texts.
+
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+---
+ lib/progressbar/__init__.py    | 2 ++
+ lib/progressbar/compat.py      | 2 ++
+ lib/progressbar/progressbar.py | 2 ++
+ lib/progressbar/widgets.py     | 2 ++
+ 4 files changed, 8 insertions(+)
+
+diff --git a/lib/bb/_vendor/progressbar/__init__.py b/lib/bb/_vendor/pro=
gressbar/__init__.py
+index fbab744ee..c545a6275 100644
+--- a/lib/bb/_vendor/progressbar/__init__.py
++++ b/lib/bb/_vendor/progressbar/__init__.py
+@@ -4,6 +4,8 @@
+ # progressbar  - Text progress bar library for Python.
+ # Copyright (c) 2005 Nilton Volpato
+ #
++# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
++#
+ # This library is free software; you can redistribute it and/or
+ # modify it under the terms of the GNU Lesser General Public
+ # License as published by the Free Software Foundation; either
+diff --git a/lib/bb/_vendor/progressbar/compat.py b/lib/bb/_vendor/progr=
essbar/compat.py
+index a39f4a1f4..9804e0b51 100644
+--- a/lib/bb/_vendor/progressbar/compat.py
++++ b/lib/bb/_vendor/progressbar/compat.py
+@@ -3,6 +3,8 @@
+ # progressbar  - Text progress bar library for Python.
+ # Copyright (c) 2005 Nilton Volpato
+ #
++# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
++#
+ # This library is free software; you can redistribute it and/or
+ # modify it under the terms of the GNU Lesser General Public
+ # License as published by the Free Software Foundation; either
+diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/=
progressbar/progressbar.py
+index 2873ad6ca..e2b6ba108 100644
+--- a/lib/bb/_vendor/progressbar/progressbar.py
++++ b/lib/bb/_vendor/progressbar/progressbar.py
+@@ -5,6 +5,8 @@
+ #
+ # (With some small changes after importing into BitBake)
+ #
++# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
++#
+ # This library is free software; you can redistribute it and/or
+ # modify it under the terms of the GNU Lesser General Public
+ # License as published by the Free Software Foundation; either
+diff --git a/lib/bb/_vendor/progressbar/widgets.py b/lib/bb/_vendor/prog=
ressbar/widgets.py
+index 77285ca7a..0772aa536 100644
+--- a/lib/bb/_vendor/progressbar/widgets.py
++++ b/lib/bb/_vendor/progressbar/widgets.py
+@@ -3,6 +3,8 @@
+ # progressbar  - Text progress bar library for Python.
+ # Copyright (c) 2005 Nilton Volpato
+ #
++# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
++#
+ # This library is free software; you can redistribute it and/or
+ # modify it under the terms of the GNU Lesser General Public
+ # License as published by the Free Software Foundation; either
+--=20
+2.49.0
+
diff --git a/vendor/patches/progressbar-0003-bitbake-progressbar-accept-v=
alue-over-initial-maxval.patch b/vendor/patches/progressbar-0003-bitbake-=
progressbar-accept-value-over-initial-maxval.patch
new file mode 100644
index 000000000..93a773c8c
--- /dev/null
+++ b/vendor/patches/progressbar-0003-bitbake-progressbar-accept-value-ov=
er-initial-maxval.patch
@@ -0,0 +1,55 @@
+From 7cea7f7a87da041fc1ad370c5c3d15aabad3a0d4 Mon Sep 17 00:00:00 2001
+From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinu=
x.com>
+Date: Thu, 22 Feb 2024 16:21:53 +0100
+Subject: [PATCH 3/6] bitbake: progressbar: accept value over initial max=
val
+
+There is a very rare case where the maxval is improperly computed
+initially for cache loading progress, and the value will go over.
+
+Explanation from bitbake/lib/bb/cache.py:736 in MulticonfigCache:__init_=
_:progress()
+    # we might have calculated incorrect total size because a file
+    # might've been written out just after we checked its size
+
+In that case, progressbar will receive a value over the initial maxval.
+This results in a ValueError stack trace as well as bitbake returning 1.
+    Traceback (most recent call last):
+    File ".../poky/bitbake/lib/bb/ui/knotty.py", line 736, in main
+        cacheprogress.update(event.current)
+    File ".../poky/bitbake/lib/progressbar/progressbar.py", line 256, in=
 update
+        raise ValueError('Value out of range')
+    ValueError: Value out of range
+
+This fix mirrors the behavior of MulticonfigCache and accepts the new
+value as the new maxval. This is also what the percentage printout
+is doing in bitbake/lib/progressbar/progressbar.py:191 in ProgressBar:pe=
rcentage()
+
+I encountered this issue randomly while working on a project with
+VSCode saving files while commands where fired.
+
+Note: This file is a fork from python-progressbar. It hasn't been
+refreshed in 8 years. We did only two commits, 5 years ago with minor
+modifications. This new change is also not how the upstream project is
+behaving.
+
+Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoir=
fairelinux.com>
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+---
+ lib/progressbar/progressbar.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/=
progressbar/progressbar.py
+index e2b6ba108..d4da10ab7 100644
+--- a/lib/bb/_vendor/progressbar/progressbar.py
++++ b/lib/bb/_vendor/progressbar/progressbar.py
+@@ -253,7 +253,7 @@ class ProgressBar(object):
+             if (self.maxval is not widgets.UnknownLength
+                 and not 0 <=3D value <=3D self.maxval):
+=20
+-                raise ValueError('Value out of range')
++                self.maxval =3D value
+=20
+             self.currval =3D value
+=20
+--=20
+2.49.0
+
diff --git a/vendor/patches/progressbar-0004-progressbar-Add-self._fd_con=
sole-to-use-for-self._ha.patch b/vendor/patches/progressbar-0004-progress=
bar-Add-self._fd_console-to-use-for-self._ha.patch
new file mode 100644
index 000000000..b8eb1e7f3
--- /dev/null
+++ b/vendor/patches/progressbar-0004-progressbar-Add-self._fd_console-to=
-use-for-self._ha.patch
@@ -0,0 +1,54 @@
+From f8c76eb89d52b1c28407f0b52dfe4318faa47cd2 Mon Sep 17 00:00:00 2001
+From: =3D?UTF-8?q?Benjamin=3D20Sz=3DC5=3D91ke?=3D <egyszeregy@freemail.h=
u>
+Date: Sat, 25 Jan 2025 13:27:49 +0100
+Subject: [PATCH 4/6] progressbar: Add self._fd_console to use for
+ self._handle_resize()
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+Introduce self._fd_console as a dedicated attribute of self._handle_resi=
ze().
+
+Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
+Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+---
+ lib/progressbar/progressbar.py | 11 +++++++++--
+ 1 file changed, 9 insertions(+), 2 deletions(-)
+
+diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/=
progressbar/progressbar.py
+index d4da10ab7..eccc45849 100644
+--- a/lib/bb/_vendor/progressbar/progressbar.py
++++ b/lib/bb/_vendor/progressbar/progressbar.py
+@@ -110,12 +110,20 @@ class ProgressBar(object):
+         self.widgets =3D widgets
+         self.fd =3D fd if fd is not None else sys.stderr
+         self.left_justify =3D left_justify
++        self._fd_console =3D None
+=20
+         self.signal_set =3D False
+         if term_width is not None:
+             self.term_width =3D term_width
+         else:
+             try:
++                # Check if given file descriptor is resizable for examp=
le belong
++                # to a terminal/console as STDOUT or STDERR. If file de=
scriptor
++                # is resizable, let's allow to use for self._handle_res=
ize()
++                # in a dedicated self._fd_console in order to be able t=
o set
++                # temporarily/permanently self.fd to any StringIO or ot=
her
++                # file descriptor later.
++                self._fd_console =3D fd
+                 self._handle_resize()
+                 signal.signal(signal.SIGWINCH, self._handle_resize)
+                 self.signal_set =3D True
+@@ -182,7 +189,7 @@ class ProgressBar(object):
+     def _handle_resize(self, signum=3DNone, frame=3DNone):
+         """Tries to catch resize signals sent from the terminal."""
+=20
+-        h, w =3D array('h', ioctl(self.fd, termios.TIOCGWINSZ, '\0' * 8=
))[:2]
++        h, w =3D array('h', ioctl(self._fd_console, termios.TIOCGWINSZ,=
 '\0' * 8))[:2]
+         self.term_width =3D w
+=20
+=20
+--=20
+2.49.0
+
diff --git a/vendor/patches/progressbar-0005-progressbar-Make-bars-show-c=
orrectly-with-maxval-0.patch b/vendor/patches/progressbar-0005-progressba=
r-Make-bars-show-correctly-with-maxval-0.patch
new file mode 100644
index 000000000..1905ca0ba
--- /dev/null
+++ b/vendor/patches/progressbar-0005-progressbar-Make-bars-show-correctl=
y-with-maxval-0.patch
@@ -0,0 +1,32 @@
+From 736b5b33a5d656a6d5cb6a3180ab529832f77b16 Mon Sep 17 00:00:00 2001
+From: Peter Kjellerstedt <pkj@axis.com>
+Date: Sat, 11 Oct 2025 06:23:10 +0200
+Subject: [PATCH 5/6] progressbar: Make bars show correctly with maxval =3D=
=3D 0
+
+While it can be argued how useful a progressbar created with 0 as
+maximum value is, it should still show two states, started (empty) and
+finished (full). Setting the maxval to _DEFAULT_MAXVAL instead will
+accomplish this.
+
+Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
+Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+---
+ lib/progressbar/progressbar.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/=
progressbar/progressbar.py
+index eccc45849..a8e2dc09c 100644
+--- a/lib/bb/_vendor/progressbar/progressbar.py
++++ b/lib/bb/_vendor/progressbar/progressbar.py
+@@ -106,7 +106,7 @@ class ProgressBar(object):
+         if widgets is None:
+             widgets =3D list(self._DEFAULT_WIDGETS)
+=20
+-        self.maxval =3D maxval
++        self.maxval =3D maxval if maxval !=3D 0 else self._DEFAULT_MAXV=
AL
+         self.widgets =3D widgets
+         self.fd =3D fd if fd is not None else sys.stderr
+         self.left_justify =3D left_justify
+--=20
+2.49.0
+
diff --git a/vendor/patches/progressbar-0006-progressbar-knotty-Allow-mix=
ing-log-messages-and-pro.patch b/vendor/patches/progressbar-0006-progress=
bar-knotty-Allow-mixing-log-messages-and-pro.patch
new file mode 100644
index 000000000..223cb0d29
--- /dev/null
+++ b/vendor/patches/progressbar-0006-progressbar-knotty-Allow-mixing-log=
-messages-and-pro.patch
@@ -0,0 +1,32 @@
+From e827db50d8f61f0d04c9bd0753c05aeb1ed0715f Mon Sep 17 00:00:00 2001
+From: Richard Purdie <richard.purdie@linuxfoundation.org>
+Date: Tue, 24 Mar 2026 21:37:25 +0000
+Subject: [PATCH 6/6] progressbar/knotty: Allow mixing log messages and
+ progress bars
+
+If we try and print a log message in the middle of progress bar, the dis=
play
+can be corrupted. Add a clear() method to progress bars allowing them to=
 be
+removed for the log message, then reprinted using update().
+
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+---
+ lib/progressbar/progressbar.py | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/=
progressbar/progressbar.py
+index a8e2dc09c..1562774ba 100644
+--- a/lib/bb/_vendor/progressbar/progressbar.py
++++ b/lib/bb/_vendor/progressbar/progressbar.py
+@@ -278,6 +278,9 @@ class ProgressBar(object):
+         self.last_update_time =3D now
+         return output
+=20
++    def clear(self):
++        self.fd.write(" " * self.term_width + '\r')
++        self.fd.flush()
+=20
+     def start(self, update=3DTrue):
+         """Starts measuring time, and prints the bar at 0%.
+--=20
+2.49.0
+

--=20
2.49.0


