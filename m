Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.905.1792720785854396348
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Oct 2026 18:59:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=DjGALnKW;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=j7H/yTpx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N1EqWr1335001
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 01:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cLPzF7sXDuqyY69/W5wAYJNRPPdKqb9Rly0
	OBnseLDA=; b=DjGALnKWdxDQdyKoi4tjzl/Td74/etr3LYDnkkp72ibp4+dMuQo
	+cL0zFTAaPy4ImAWWdz1p7pYm6OR651KePc0GeMTGPxt+bKEodFDo/QMpmRdjanU
	0k4kFZyxSpNuNxEy6lKNsZDjP/VB9a8mjTGkP1EWpy2QuKop9RW9xlgXmEM0szas
	dl1bOMQyQ1VETxUheM3UTEBT3hSCcfI1Q9AaLHCpCLbZdNJ9eaO9rNGFJafu+bHX
	5+86UNOZd7C6Vc0YZr8ryxtly2qkJJWNHLqXRNx4vQee3ZD09qaCVDZ837OzPe2T
	k4sFbKzLAuWHNt6AwJr4jZsWy57IO9tpTjA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8udh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 01:59:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ec17386b57so67164e0c.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792720784; x=1793325584; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLPzF7sXDuqyY69/W5wAYJNRPPdKqb9Rly0OBnseLDA=;
        b=j7H/yTpxY8T2uY9CgIU/CV+DP0B6QYvlS1UpjFn2pyCnCjoNspJ9wqgxSGdzBW8czv
         0xTXuqyltQkSnkfDD+IlMpEODd4+A6W6xX3MeV9MjfODMb1lscSuPef4ginBOfH6EKIV
         OoOzJhxT6ikIRsi/QiwXiXe33Uc8EAoVzk2dXgJgRBEtYmumUSLPjK2NyvR83qgeNazi
         S9U6ZDx8XK6FATdHvu0BDwGhtJPl2jjeWBBkLzzFg6PHAUX89Fk9oXQ16E2+Q/hgTozb
         Qq04HdTvLy9bfrn39wplvcYArLfTdtSQ9VKojEsKo1GkjvpV+FmL/rcIZ+uWlC8rSeRU
         r7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720784; x=1793325584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cLPzF7sXDuqyY69/W5wAYJNRPPdKqb9Rly0OBnseLDA=;
        b=t1g4mWl+3jHz4GqXFijxmiwSDHRuKJ80Bi1LlsylfR9OWz0eBVTUHwgnwBHd+iRuXB
         k+6lxzckxxmrhGV6SqckmjaD5WONoRrcuRzWo5LYMeezwEg4LzrHyUj2tlTYT8mKlGlY
         CpXbTef7BKfOysc1SiIfPaD4J2ZSL6Gq2bzzntTd2+liJbGHEcogToZIw/jP3LSGeVaz
         1+KkS8yQO9GsTZunJclu3R7esN/OdiLTr/vyQPvjgUkeEG8FYQh/SNOO45SHcu12IpUN
         hjMxLCr/iuZ2sN9tK2Lvq2biHBRg4Ekosf6y+osD6ABWnBEEo0IRQGbYdFReKF6GZUt3
         TcUg==
X-Gm-Message-State: AFq9FYLehB03HDj8lHAbJri/NXBKb3yRGjoudLraWrXI6AiybOyXXNBA
	zOkbvAJpw2cdUNTyrg9iV2byK9aCTW8jk+DbpxqYEgnu1XQdYAk66BXSJU06nICoj2IsusAX/eW
	1XxpwWyqaA6qdLOn96sT98yJnvPdXZIiPxoJAVxvino/3q7RyRfslA1nbdyQwZ3doYrwPOp5gpQ
	7bRmePdSnXEf6D
X-Gm-Gg: AYBFou2ouvqC6bAPUzOUE1lBg9X7QBgHmL3oFz81B+Sztjm5REpHc188fxHfip0FdfJ
	jLW4I++trnVMm3WiYxtCR4t825VMaMwyFIAj5f5r0WALFs3/kX6WMdBJH2ZblIlgiIEIxDhVQzr
	r1JWnnrE5TCOV4Uc0dxGt0yRLuZwWNp16AE/Ls4AUxRlbClSeB/djAM+x9bD+X6uXBZTdxssJZL
	UpGNCNsKq+W5ErjW+5nNO7v792KITQs5LWGvU4iGVH0A2VhmwVIUZrj19Z+At2axYNQGYzUDqao
	Lu0IJe0bcWIW8fzK9xSjf1cIe5A34j1wU3ohpe3dW2wxt1kApVLew52Jwl5SmuOk9ntyPElQq3J
	8kLh2Sda2tA==
X-Received: by 2002:a05:6122:1da0:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ec14b4644fmr266564e0c.20.1792720783620;
        Thu, 22 Oct 2026 18:59:43 -0700 (PDT)
X-Received: by 2002:a05:6122:1da0:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ec14b4644fmr266554e0c.20.1792720783102;
        Thu, 22 Oct 2026 18:59:43 -0700 (PDT)
Received: from evatuf ([187.65.213.234])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13ea828bsm969258e0c.4.2026.10.22.18.59.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:59:42 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cache/checksum: Split file-checksums with str.split() when possible
Date: Thu, 22 Oct 2026 22:59:32 -0300
Message-ID: <20261023015932.2298868-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXyYkh59NxB+2e
 Sv5DiBysKCdGY/NbjHSkwWWd/A3ADCJ0KJ3mMIw2MijW5H4n8Z6AJdM/Ei+Tv9xuWJn+6/ci9Hp
 tA27jBcqfBvszVjHk6+8Kq+LXm+ME8a9I0zKEb3pLE7ME3SBuLLljHPrRbDWx/gpMZF7JdorZnC
 V6ViFUS+fMp4Nw+2/bkss+b/hf1WRC0DnNWC0sT4qFEKJivIAuoiAOe+PE93NfbTg3vHfF1FGj9
 29sHf5NyBWpspLKyHXb6bPAIihXiUHIvKM7Io4PWKjC86IYUrpWNyaMnE+aCKEvwYYXZyhl2K54
 Wc64zTCI+qnUhFPFaUoN6wSxRnuvM9fVEFA6GcB+9i+gJdsHmMRBp7XwhbXN/JfDn7YGQROddSg
 buHa9r5ks6UGo8QGT/g9q2lPCaA65n3XrxoX52AIQKnR3dLKB7Q+gHiS5LfeRsVIufrPP89Wuwl
 jX1h7uTBbalTPKw7gCw==
X-Proofpoint-ORIG-GUID: Ax2OCh1Lart6Mp440b7GGy7m3CLGMW3C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX9mr4mn9llRxV
 qAl290THiScCGkRElloAPavQZoFPDx7202x+3aDYPtLQHVZWSKV7pSz1VqX3fwEEOflPSTXnD/G
 Vz8m7W8UTrm7YX07aae/kcuW3MVxZDw=
X-Proofpoint-GUID: Ax2OCh1Lart6Mp440b7GGy7m3CLGMW3C
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adabf90 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=H6YuGxh2q6KyqgzzRUCmUw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3yAZMjii9DFNjklCfTgA:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 01:59:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20370
Content-Type: text/plain; charset="utf-8"

cacheValidUpdate() splits the file-checksums values of every recipe on
every warm parse, with a regex matching the whitespace after ":True" or
":False" since paths can contain spaces. The values have an entry for
every FILESPATH directory searched for each local file (229 KB for
busybox with 18 layers), so the regex split is slow.

Add bb.utils.split_file_checksums(), which uses str.split() when every
word ends with ":True" or ":False", as happens when no path contains
whitespace, and the regex otherwise. The result is identical to the
regex split, as str.split() and \s agree on what is whitespace.

A warm 'bitbake -p' with 18 layers goes from 8.24s to 6.92s, and with
OE-core from 2.11s to 1.98s (median of 10 runs). Task signatures and
'bitbake -e' output are unchanged.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 lib/bb/cache.py       |  4 +---
 lib/bb/checksum.py    |  5 +----
 lib/bb/tests/utils.py | 26 ++++++++++++++++++++++++++
 lib/bb/utils.py       | 29 +++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index d05d341f4..f09716fa7 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -23,7 +23,6 @@ from collections import defaultdict
 from collections.abc import Mapping
 import bb.utils
 from bb import PrefixLoggerAdapter
-import re
 import shutil
 
 logger = logging.getLogger("BitBake.Cache")
@@ -404,7 +403,6 @@ class Cache(object):
         self.data_fn = None
         self.cacheclean = True
         self.data_hash = data_hash
-        self.filelist_regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
 
         if self.cachedir in [None, '']:
             bb.fatal("Please ensure CACHE is set to the cache directory for BitBake to use")
@@ -614,7 +612,7 @@ class Cache(object):
                 if not fl:
                     continue
                 # Have to be careful about spaces and colons in filenames
-                flist = self.filelist_regex.split(fl)
+                flist = bb.utils.split_file_checksums(fl)
                 for f in flist:
                     if not f:
                         continue
diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 3fb39a303..8df69bbe3 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -11,13 +11,10 @@ import os
 import stat
 import bb.utils
 import logging
-import re
 from bb.cache import MultiProcessCache
 
 logger = logging.getLogger("BitBake.Cache")
 
-filelist_regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
-
 # mtime cache (non-persistent)
 # based upon the assumption that files do not change during bitbake run
 class FileMtimeCache(object):
@@ -112,7 +109,7 @@ class FileChecksumCache(MultiProcessCache):
             return dirchecksums
 
         checksums = []
-        for pth in filelist_regex.split(filelist):
+        for pth in bb.utils.split_file_checksums(filelist):
             if not pth:
                 continue
             pth = pth.strip()
diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 52b7bf85b..0c3360505 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -703,3 +703,29 @@ class FilemodeTests(unittest.TestCase):
         with self.assertRaises(ValueError):
             bb.utils.to_filemode("999")
 
+
+class SplitFileChecksums(unittest.TestCase):
+    def check(self, filelist, expected):
+        regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
+        self.assertEqual(regex.split(filelist), expected)
+        self.assertEqual(bb.utils.split_file_checksums(filelist), expected)
+
+    def test_simple(self):
+        self.check("/a:True /b:False", ["/a:True", "/b:False"])
+        self.check("/a:True", ["/a:True"])
+        self.check("", [""])
+        self.check("   ", ["   "])
+
+    def test_whitespace(self):
+        self.check("/a:True\t/b:False\n/c:True  /d:False", ["/a:True", "/b:False", "/c:True", "/d:False"])
+        self.check("/a:True\xa0/b:False\u3000/c:True", ["/a:True", "/b:False", "/c:True"])
+        self.check("  /a:True /b:False  ", ["  /a:True", "/b:False", ""])
+
+    def test_spaces_in_paths(self):
+        self.check("/a b/c:True /d e:False", ["/a b/c:True", "/d e:False"])
+        self.check("/a:True /b c:False /d", ["/a:True", "/b c:False", "/d"])
+
+    def test_suffix_lookalikes(self):
+        self.check("/a:Truex /b:False", ["/a:Truex /b:False"])
+        self.check(":True :False", [":True", ":False"])
+        self.check("/a:True:False /b:False", ["/a:True:False", "/b:False"])
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ec6eb2181..f0f24b8de 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2359,3 +2359,32 @@ def is_path_on_nfs(path):
     import bb.process
     fstype = bb.process.run(['stat', '-f', '-c', '%T', path])[0].strip()
     return fstype == "nfs"
+
+_file_checksums_regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
+
+def split_file_checksums(filelist):
+    """
+    Split a file-checksums value into its ``path:True`` and ``path:False``
+    entries at the whitespace following ``:True`` or ``:False``, since the
+    paths can contain whitespace.
+
+    Arguments:
+
+    -  ``filelist``: the file-checksums string.
+
+    Returns the list of entries. When every whitespace-separated word ends
+    with ``:True`` or ``:False`` (the usual case), this is the same as
+    splitting on whitespace, which is much faster for long values than the
+    regular expression.
+    """
+    words = filelist.split()
+    if words and all(word.endswith((":True", ":False")) for word in words):
+        # Match the regular expression split exactly: leading whitespace stays
+        # with the first entry and trailing whitespace gives an empty entry
+        leading = len(filelist) - len(filelist.lstrip())
+        if leading:
+            words[0] = filelist[:leading] + words[0]
+        if filelist[-1].isspace():
+            words.append("")
+        return words
+    return _file_checksums_regex.split(filelist)
-- 
2.55.0

