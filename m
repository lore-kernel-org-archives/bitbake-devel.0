Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5ACCA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 01:28:51 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74540.1790645321711819543
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 18:28:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=a89SgPYb;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=ZCtMXQEs;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0jNj82342781
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 01:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fcnzxnAL0Agr2D0LR04S0srOziYIvdLRsrN
	bOYeyBrU=; b=a89SgPYb+gz10h5Ga667eIM+hO1x5nQM3eFflPsYHnzzEMxLZxg
	DZGhqMdGMPW2El/chsTVXCnWvXHn99i7DCVrYEbKCoZ4ZrZOE4ZC/z/oBfeGrbax
	fhwBt6CLQ4Q66lY5GL5skJwFXTjg7n2kNRWE1iZK6BH4Qck/wDggGllxzGmoFoxy
	p72G3kmuhnH4MFWfJ+ehOK+bxvhZXnTsMsRq6swUJOWylYCkGfRKTvVGmYKOTTxS
	uNCKhAXttHqdqQJP06o5X8r2QVgXSibu2wpUME3gwrv40E4MsLzN8wK44WBfm1Dz
	BGzm75uWlt9hHzAP1zbnA3qEOo4Y8j5W4cw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw21jtv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 01:28:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e124796da0so21393635ad.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790645320; x=1791250120; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fcnzxnAL0Agr2D0LR04S0srOziYIvdLRsrNbOYeyBrU=;
        b=ZCtMXQEso5wtJmpYHy+lFLQHkxO6DSgbrsrHYN9N69k0XOuigE+h6L1CgExERpwByp
         t1bQzqOuWq0ERaUFGs/nXHSPNOdytxX5lgsycVZX+irFGN5QIVEnUFPFtaEji1nlxuoZ
         fxaSFVtn6kK0HGC0Jn/3aS8lz7+QmpJ6KdzjAmEJhw1XkR/Wth6TEuVmhRQoRkYGA0Lh
         pM6RfSwLoLn0A284CmS9mvgy6rXEe9cQJcq2NjE7xArRch3q0oemdicvj/dzmYGtSI9a
         Hgyu23IPU9ztdumbXDjLz+WqxHAtm1B2EdQETv8Okz8VBvIoZ8A0cnzEgtLkmRBbUh+N
         /osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790645320; x=1791250120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fcnzxnAL0Agr2D0LR04S0srOziYIvdLRsrNbOYeyBrU=;
        b=LE09cIbBOtO9n3ozG/iokL4Iku/QQgcHl0+RHpB6Mb/OIgkjWO8+QkK9bg/J3FG4Cm
         //xiks4ed9Vk6ZdvV7wwLQgDoyLWAsfZjY+B6UPlSviTMczqR91motybBAIX8qoVdjcs
         KLVYKMl/qF+2FhTSmGC8WMcA8Bng4cF7eGAwRoIQN1nI1VHxlsGgwfudWLDBiv1qrXAo
         VAjuAX+QnSxt1zy9LFCZXDB3q4qQ+0v09B3wyWAI+rmTeAOindbmkVzDwbvqoYd5UnO1
         uRJ6vyYQ40N5irxoVZRW/Qr7teYeD8Z4CX+5rWiY0WWqYzzpCZ1oOimgcHcfgu9zvtDx
         s06w==
X-Gm-Message-State: AFq9FYJES+5ofZKIjqpZXxqwlrrQthBsOua6KDEaNLX1sFfu0nx04EMi
	GGADb2GiLs8RseH4MZ7kG09cpTeN3wonziKSw7Ze6KSJ4gLcQLyZ2g8A7tHIIvUXdC3Q0Ci/SC6
	hTkQF60pe/UjM6sJ6rg2KEXpZWhCr2oUfpqiM4DFRuSNV2cDtFE2uam/G027o7Q84FSaIB72cEx
	TD2EHISySPOQ==
X-Gm-Gg: AYBFou2KKsL5HnndGAm7GlO49uFwMpQuRWn4PLOpQs3iDAWa2t84M15cHJViWhJ2Ykh
	s3VfKbWjpdaT3qgYW+Ea4CYYceZus/Ag/Nvw8sof3BkYzdWNBgVmz83UiqM7Be1wo50+qSU9vHx
	LUDZpNOEJlpbU7HcWc3Y71Kq+d72I2nAcuZcQJ53gnWVR7ZpTBNdTyPnPmb3poLw5mnpIhbGDtD
	T+M8ujsiTx7gLDj6LStzI4/fbdjEWNLYSrHxXI2HaOdMd0Wx5jopJ9EdT3MxIYf9I1iEvbrIVLe
	JU0DpE3U4kZ1fpLxnZyE1Wbmtr/bYsQGDgW8mK/N4vkYoksbxIA0TqOPSS6vHYd9QUiOe16EEIL
	AF9WRoHLyaYQU2Hdkd5PLw2MqUtvD6xyq3Vina8x8HMOII0KFA8hx51MSs8BLUEHER33uT7icgn
	gj5p9wJwPCoKKKpe5sv9TuRTHOdpsXNWGJQLBSBg==
X-Received: by 2002:a17:90a:e7c4:b0:39e:6c6a:4b73 with SMTP id 98e67ed59e1d1-3a098e3eef6mr12866627a91.61.1790645320050;
        Mon, 28 Sep 2026 18:28:40 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c4:b0:39e:6c6a:4b73 with SMTP id 98e67ed59e1d1-3a098e3eef6mr12866568a91.61.1790645319419;
        Mon, 28 Sep 2026 18:28:39 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497e90165sm2281976a91.1.2026.09.28.18.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:28:39 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: bitbake-devel@lists.openembedded.org
Cc: jose.quaresma@oss.qualcomm.com
Subject: [PATCH] fetch/wget: rename the partial download on checksum mismatch
Date: Tue, 29 Sep 2026 01:28:31 +0000
Message-ID: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb1448 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=LRLYrf9nAAAA:8
 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=vORqFKdVhVzt_H80W40A:9 a=lqcHg5cX4UMA:10
 a=r-HJ9bD__24A:10 a=Wpz8ju6o9T4A:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=ctNd1-se8QBkj9sPkfQg:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: 4wkUwazOqClWRjYCvTPEH0efWupw190y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAwNSBTYWx0ZWRfX6PhmVftu9DCD
 29kJ2cFX8I7lnRAGSI1lTbaOAT4K+BfwsZ31BBMAXd86CZL77IqcfUyZeuQNkG949ntYYMP7uCH
 EXcCogx1oURoVpPKQ4V74JRyMq1Sw/TqQuWuZdtT8ZY7rBcsIHVHGZyUYgFdyJAsF6hgfz49lDP
 C6yTuuRu84elLw0hq2DF18R6jvNdwCywwn6/3mSnZz3lALmNkpOuoWKLFFw+wVfg16myAgKlcNu
 p6fie9NA4PYoDDWSfWjXCsAh2RQfzAxFtptidipJil6lUZqFTRisbTLyrDSfdJmvtU5/gf0C76w
 SwS6l+dSKlIMlNbwOLMwW/rtYU/StW8wBA9rNE5z1STYnFPOXN8678XCVqnmRexSAgShHuNEUF0
 /slGdv+AFikG3f/LWdGhXZCAw5Ue0U8cqQhqHICmkBIzLLWamupm63K41WeT05GknsUGFRbWtlW
 GIOD1daz4x0YGriD40Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAwNSBTYWx0ZWRfX2zIVWkWV3Kqj
 OVxeanfYSc8Wpcs21OuuInNXg3kKY7r6P9YO7OS0o4Gp4IvHaaqqKnwlFvsVw7lK/lqr+/j4aPS
 6a2Zxh612jtvVe8dS1HwxvtyzjTdQFc=
X-Proofpoint-GUID: 4wkUwazOqClWRjYCvTPEH0efWupw190y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290005
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 01:28:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20277

The wget fetcher downloads into a .tmp file which is resumed with
--continue and is shared with the mirrors of the same file. When it
fails checksum verification it is left in place, so MIRRORS reuse the
bad file instead of downloading their own copy and, without a mirror,
every retry fails the same way until it is removed by hand. Rename it
with rename_bad_checksum(), as done for any other file with a bad
checksum, so it can be inspected and the next attempt starts from
scratch. Mirror downloads skip this check and are still handled by the
existing code once moved into place.

Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
mounted over NFSv4.2. What corrupts the file there is not addressed,
only the recovery on retry. Tested with the new tests, which fail
without the fix.

AI-Generated: Uses Claude Code (Claude Fable 5.1)
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 lib/bb/fetch/__init__.py | 11 ++++++---
 lib/bb/fetch/wget.py     |  8 +++++-
 lib/bb/tests/fetch.py    | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index fb6278439..eb3483a48 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1079,7 +1079,7 @@ def build_mirroruris(origud, mirrors, ld):
 
     return uris, uds
 
-def rename_bad_checksum(ud, suffix):
+def rename_bad_checksum(ud, suffix, localpath=None):
     """
     Renames files to have suffix from parameter
     """
@@ -1087,10 +1087,13 @@ def rename_bad_checksum(ud, suffix):
     if ud.localpath is None:
         return
 
+    if localpath is None:
+        localpath = ud.localpath
+
     new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
-    bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
-    if not bb.utils.movefile(ud.localpath, new_localpath):
-        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (ud.localpath, new_localpath))
+    bb.warn("Renaming %s to %s" % (localpath, new_localpath))
+    if not bb.utils.movefile(localpath, new_localpath):
+        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (localpath, new_localpath))
 
 
 def try_mirror_url(fetch, origud, ud, ld, check = False):
diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
index 972c84048..6259c1245 100644
--- a/lib/bb/fetch/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -167,7 +167,13 @@ class Wget(FetchMethod):
         # Try and verify any checksum now, meaning if it isn't correct, we don't remove the
         # original file, which might be a race (imagine two recipes referencing the same
         # source, one with an incorrect checksum)
-        bb.fetch.verify_checksum(ud, d, localpath=localpath, fatal_nochecksum=False)
+        try:
+            bb.fetch.verify_checksum(ud, d, localpath=localpath, fatal_nochecksum=False)
+        except bb.fetch.ChecksumError as e:
+            # The download is resumed with --continue, so a bad file left in place
+            # would be reused by the mirrors and by every later attempt
+            bb.fetch.rename_bad_checksum(ud, e.checksum, localpath=localpath)
+            raise
 
         # Remove the ".tmp" and move the file into position atomically
         # Our lock prevents multiple writers but mirroring code may grab incomplete files
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 71b0a63fe..9627b3b1b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1706,6 +1706,59 @@ class FetchLatestVersionTest(FetcherTest):
                 r = bb.utils.vercmp_string(verstring, v_larger)
                 self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
 
+class WgetChecksumTest(FetcherTest):
+    content = b"bitbake wget test data\n" * 64
+    # As large as the real file, so wget --continue has nothing left to fetch
+    # and keeps it as is
+    corrupt = b"x" * len(content)
+
+    def setUp(self):
+        super().setUp()
+        self.serverdir = os.path.join(self.tempdir, "server")
+        for subdir in ["upstream", "mirror"]:
+            os.makedirs(os.path.join(self.serverdir, subdir))
+        self.server = HTTPService(self.serverdir, host="127.0.0.1")
+        self.server.start()
+        self.baseurl = "http://127.0.0.1:%s" % self.server.port
+        self.url = "%s/upstream/test.bin;sha256sum=%s" % (
+            self.baseurl, hashlib.sha256(self.content).hexdigest())
+
+    def tearDown(self):
+        self.server.stop()
+        super().tearDown()
+
+    def write(self, path, data):
+        with open(path, "wb") as f:
+            f.write(data)
+
+    def assertDownloaded(self):
+        with open(os.path.join(self.dldir, "test.bin"), "rb") as f:
+            self.assertEqual(f.read(), self.content)
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test.bin.tmp")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir,
+            "test.bin_bad-checksum_%s" % hashlib.sha256(self.corrupt).hexdigest())))
+
+    def test_wget_corrupt_partial_download(self):
+        self.write(os.path.join(self.serverdir, "upstream", "test.bin"), self.content)
+        self.write(os.path.join(self.dldir, "test.bin.tmp"), self.corrupt)
+
+        fetcher = bb.fetch.Fetch([self.url], self.d)
+        with self.assertRaises(bb.fetch.FetchError):
+            fetcher.download()
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test.bin.tmp")))
+
+        fetcher.download()
+        self.assertDownloaded()
+
+    def test_wget_mirror_after_checksum_failure(self):
+        self.write(os.path.join(self.serverdir, "upstream", "test.bin"), self.corrupt)
+        self.write(os.path.join(self.serverdir, "mirror", "test.bin"), self.content)
+        self.d.setVar("MIRRORS", "%s/upstream/ %s/mirror/" % (self.baseurl, self.baseurl))
+
+        fetcher = bb.fetch.Fetch([self.url], self.d)
+        fetcher.download()
+        self.assertDownloaded()
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-- 
2.43.0


