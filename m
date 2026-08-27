Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33007C61DC2
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 12:52:55 +0000 (UTC)
Received: from mx07-0040c702.pphosted.com (mx07-0040c702.pphosted.com [205.220.184.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35469.1787834400893054820
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 05:40:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@karlstorz.com header.s=S-DKIM-20210427 header.b=jXD6rJsP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: karlstorz.com, ip: 205.220.184.135, mailfrom: prvs=26993c4956=rouven.rastetter.ext@karlstorz.com)
Received: from pps.filterd (m0267679.ppops.net [127.0.0.1])
	by mx07-0040c702.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCCkSg3555141
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 12:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlstorz.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=S-DKIM-20210427; bh=sybA8
	W1TPAeLpojMWDvVkOjw7KWzlZsrOsROWL8uwmU=; b=jXD6rJsPmtLNqWw/kB2TF
	K2KqRK7mpTz2Oo9SSnKkPesIXShyxdkU9v4lBv7I32MsPO2jQzezPqzE//VAJPxU
	ChfY2XzpWyb6xaAApHX8pNOHzp/TPjRIfO4wq0yO6nV4EKgVGTg2XREzlKZA3dEi
	Ku9RnQhCLuz5B77ip9+642gOH+Jzi+9nzmcoyfmfYp8S4rJXoJ/6nXtUXUa9aZNr
	I2KeRTVsU+1lNjTNzmyoi/n+GRWRz02z0iZJzHW2kexbh5joGP0kW6EZ8XTreunf
	fftbZ5ekNZSubL3+gMdFXI5YcwuCM+PE6IXUEY4V0FtFTPVhj3fw8wLZFIFAFi7U
	w==
Received: from tut-ex01-pv.kstg.corp ([62.134.76.232])
	by mx07-0040c702.pphosted.com (PPS) with ESMTPS id 4ga90na2fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 12:39:58 +0000 (GMT)
Received: from TUT-EX02-PV.KSTG.corp (10.0.10.191) by TUT-EX01-PV.KSTG.corp
 (10.0.10.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 14:39:57 +0200
Received: from tutn-jjhfqf4.kstg.corp (10.0.10.41) by
 InternalSMTPRelay.KSTG.corp (10.0.10.191) with Microsoft SMTP Server id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 14:39:57 +0200
From: "Rouven Rastetter" <rouven.rastetter.ext@karlstorz.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rouven Rastetter <rouven.rastetter.ext@karlstorz.com>
Subject: [PATCH] knotty: Hide 'Bitbake still alive' message with quiet>2
Date: Thu, 27 Aug 2026 14:39:25 +0200
Message-ID: <20260827123925.633743-1-rouven.rastetter.ext@karlstorz.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwNSBTYWx0ZWRfX2JQngDgJO/rE
 7ShW6f+HU29dlqZRyKe1B32PYFJvWAG4fjQAvdZ1g9uuroT02PQfjZnAmPsPF3IKy6+8K6n8oci
 u1LGguES2PEv5w4EAYlUJ73+LWl7Ek4ZYDqlHUB/ySpdkZq+XZtmExjDqSyVc6Ig/fGsO0NOw2D
 WBhNiNY3yiRzxHVib44w5ZnhtbEGr1Lbi2a+IX+ujHx5esNGKoqmG4pRsJdhtZXjdqkCLmcfMfB
 mAvOFIe4YZdS83iZ/aEZ0hzv9VJFQEYPvb39wmyl970lTBlRH4aFzkTS3LYSxnXN0BiUdFH/QG7
 xFlCLj/0IstXxiUp8K2RPcN1gaXeIn5YyVSOZANDYwuquB5C1xBc9KF9KcFXIr9rbra/HAWNPzB
 Y/IcRU+sm8ZEEpxBzMxJxJirWiF9V49vlgytemSwSZgqYu4u7FJrJIdG1CzAQXVTiu6T8H9R6fM
 Utcmr2a/OvrpBIo6Vug==
X-Proofpoint-ORIG-GUID: o1LtqG3EgfRpaNyfgaiIfvWxLXtKPt31
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwNSBTYWx0ZWRfX82VdRPQl9xiT
 sglDuzyFNYw8QnRJFekKU1QC0cRVwlzfCrRIGqyRT/nB0YcFsZJ0AQ8i87shfxZA821F7vdt2ge
 d0poV7fHaj+7+q37PGW4H5eps2TE3JtIrWUOEu2P9lT+Yr7FcqGu
X-Proofpoint-GUID: o1LtqG3EgfRpaNyfgaiIfvWxLXtKPt31
X-Authority-Analysis: v=2.4 cv=PLE/P/qC c=1 sm=1 tr=0 ts=6a90301e cx=c_pps
 a=OToaj9FDvIz41JSycRbD4A==:117 a=OToaj9FDvIz41JSycRbD4A==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=DBWTBMGyQNCzyBkTEoZL:22
 a=Mf5tFF2oQ1p1YQ6vkpes:22 a=Y5sarPMaG061xzWOCRIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 12:52:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20066

It can happen that bitbake-getvar takes a very long time, probably due
to NFS locking. But even with the `--quiet` flag (which equals
`self.quiet=3` in `TerminalFilter`) the 'Bitbake still alive' message is
still printed, causing errors when using the output of `bitbake-getvar`
in scripts.

This change silences the 'Bitbake still alive' message for `self.quiet>2`.
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 15025e8dd..185c7f307 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -262,7 +262,7 @@ class TerminalFilter(object):
             return "%ds" % (sec)
 
     def keepAlive(self, t):
-        if not self.cuu:
+        if not self.cuu and self.quiet <= 2:
             msgbuf = ["Bitbake still alive (no events for %ds). Active tasks:" % t]
             for t in self.helper.running_tasks:
                 msgbuf.append(str(t))

