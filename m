Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89270CA5FFC
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 21:34:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.123.1791322435209244088
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Oct 2026 14:33:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=KbxbS4GE;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=aZ0GZ/Fd;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Hf36E1499784
	for <bitbake-devel@lists.openembedded.org>; Tue, 6 Oct 2026 21:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qNV19hSGOlZ
	yr/Dspkr9QViuGepSyKHaFFcwlkr2JAo=; b=KbxbS4GE+qMmG7ZeAQn5b44w32l
	b1QBcvuZeBReMbJLiyn3aABgSDZa1HU15BRGyGenui+hvBxWT9qBi+7i0hXNXoea
	ZjvidR6dtq1gW1BxTV5hv5rACyeL1ZRT/N1Z5TN2ma7I3MDhPJOPuePRAjXHkypl
	yw35X3clP4pe5Kwg/Xemm78oQ410AuAlkKEtdQckw1knRwxb1OC/B/jk0qKBkuWp
	rszFBXXsEtjfy98VLSwewoZPy/b58yh2V940/Ql/8KwLTUQN81qw6A9dVXpf2Ozs
	uEM+0vasSVEcd7146DorTT3/FLKA8a7dCQ/GEIwp5NvmQrDFV4NnQ1XyvFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9tv2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 21:33:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2f3251e91so27445785ad.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791322433; x=1791927233; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNV19hSGOlZyr/Dspkr9QViuGepSyKHaFFcwlkr2JAo=;
        b=aZ0GZ/Fdso/MtO0hm64qRweUAWrBpfvP8p0alU+5Qm6q/cNxWbgcqNG6jFkPWsWJ2T
         8DAAI49yiFy7mVINz1DygPDEEghz8dw7sO2XTiFdHd+OTJ7kAZDDYDRcAF/8SzPfumGr
         wVVthu1JIgj/zbGHhLJdsWfqtXHhRup9Y7pWVYq6la2q34GgsAZ4W4CDq93lmJvIcfOi
         A9hh7rkSl53XzqRSjIIbdl6XsidvOypPvFaKzfnEUcqxnaJvpOP7zkXJnf6GV+m/+zUI
         M5lbdALypy3LdWKmdE5z/iTcioX7D0khTutlLru0jpLxadxAa0ZE6BJc0ZcKjdKRk5gH
         asVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791322433; x=1791927233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNV19hSGOlZyr/Dspkr9QViuGepSyKHaFFcwlkr2JAo=;
        b=0RV8vF7PycZxBMp20tDDXm06Mf9xFFcdAgFbKZT4TwlOvUAMLgbHNg64mzhUJPZrFD
         BMXPkvoJzCR8uyhstc/+YIXVXfBouBnCcgxTiWlPoHF68fIP9qeKhJoKz9cJUb8WZyLw
         5rWss3NMFaiNOY0xUZntH39sfKRHsRSepnJBUzIWMZ8e++ATZPsYAViizF+pOlgmLpm5
         lyZFLuQe5La9Ap5yAxOP0727awyDDp5Dh1AuA4oaXoxULysNAYTvoxSPmAMPMgHZPQ+D
         Lmh27UcdmB8NOVf5RXNhrLValvzW7xPI3GnO48KwPobLOuYYlmG4s86vyNFHG/Oz0ywO
         hkWQ==
X-Gm-Message-State: AFq9FYLEW9y9eppCNui5Ff4JASv3he508w9kjhWbXvN6EY5mIjR2J98P
	Ao9FZ3PzBx5hgv3AAX5Orcpp1j/q7j2UGlVUFh/s79mSK4bpk7jAXhK9Kj1EoKAbPWl4cyM9sXW
	skPGk1eUEb7uHPla+w+OzuLe7JbZv+026jEnEc0uAksNB4GxMoVUVRWP55SkMcHjDWObrmevdDz
	J8s1sFVZzFN7fxa6k=
X-Gm-Gg: AYBFou3+mJpZNtZlXtmrPEO1kkQDgtGTTzRPYqyS+resUILtudsFLs7nZ2J+bt6cjap
	V0wpH9gYgGqz7GeoZ+RjWz7pJDugedxTCDCXzckdCB2n4eBUXk1e/hzHJPWFRzced6C1HY4O6UK
	eYGccmOAQO8FygX4OzQcOh15G/DFVLdcpUSUs25P1Kex29h7b0iURtff9NwzSspVltExTNurkEu
	rNzOsJrQFAPbm/kqMFl50SdH5N4odPJuS9jpYTDnwOLrX8VZyADTR028ZlS20KgAKRot89tNvnA
	xysQHtUSS1+iO/1tmilTJ28Wi3osPsZNuFSDxIefYk16NZIOY4pYQyhcNOR0nhZqYawMELwlewj
	yurXyLrMJbfXWK9Jqh2e8451dJ7FeBTT6dquXV47417o3WMdw+zmzyp3Vm7b6bO3xDruxgrBuo+
	NnxyefiDKYHa3GLZ61J7vIulWq75eREnOSwslcpg==
X-Received: by 2002:a17:903:1b6f:b0:2df:90d4:7847 with SMTP id d9443c01a7336-2e6004f5a13mr4585435ad.35.1791322432797;
        Tue, 06 Oct 2026 14:33:52 -0700 (PDT)
X-Received: by 2002:a17:903:1b6f:b0:2df:90d4:7847 with SMTP id d9443c01a7336-2e6004f5a13mr4585345ad.35.1791322432322;
        Tue, 06 Oct 2026 14:33:52 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60443ba83sm1446315ad.2.2026.10.06.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 14:33:51 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, jose.quaresma@oss.qualcomm.com
Subject: [PATCH] tests/fetch: don't rely on wget --continue in the corrupt partial test
Date: Tue,  6 Oct 2026 21:33:34 +0000
Message-ID: <20261006213334.3360919-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org>
References: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac56941 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=lWIw4zNB15KzJH3b:21 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8 a=Kd7isprs6xkq6Etl1qUA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4NSBTYWx0ZWRfX2a/dfxv2jD6E
 evgD9Igwc7jv3DPrXTvgLiA54/RntUs3FyoiLJc5SzFp99wdLu+nWZcBI4dTVc14iNnwzOGsye7
 gyEj9l+SvQfGa8xMsIXz2AtIdUTZyTE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4NSBTYWx0ZWRfX/83V9v5THMmh
 YIYfGDLg5dFFk7GwschwlSKgVTZH2dxT9Ct60Oi60ERaLTmOnQZPJxy5rJCqFgTRXB4pyBBzHi1
 vp0BisXwwuai4fUhg5SbsuaLb1HYKP5zbnA+pk1acD3yhMIwE3mqrd3ynI+4ydz6gxxaqtYrt6T
 XuWphA0HRTHfdhx4rtsWkYtpr+2/DXm2nsJob3lN109RO/wWBzu0yVSwdFbs1MfD/y2sIXw8CYX
 h0BPqSyicrGYZlNxHoT5JkwkumrctdC+MoN2n+dGehnOIPnRNi+AM6G5XdZQ1OznRSIJjbSs8JS
 Mwn0cAw6gMlh3tkIASVOQzTgBZGcpm9xdWXegbJkNdBYe6hgxViH1HHwgybbFdCEIm+Ehk+Zbi1
 N7wmIUT4bZc7q3+W34HH3MyVHqmiznt6bKxURDfQs6UCekFUKPltZkW7RmpIrm0EkRpVRvEWiS+
 NJABYZKKNqKxt5tAeZg==
X-Proofpoint-ORIG-GUID: e-1qltn5bt2f_ybonDytRNcI-P-znEFw
X-Proofpoint-GUID: e-1qltn5bt2f_ybonDytRNcI-P-znEFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 21:34:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20301

test_wget_corrupt_partial_download expected wget --continue to leave an
existing .tmp file as large as the remote one alone when the server
ignores Range, which is what GNU wget 1.21.4 does. wget2 2.1.0 rewrites
the file instead, so the fetch succeeds, and wget2 2.2.1 (Fedora 45)
appends the whole download to it, so the bad file ends up under another
checksum than the one the test looks for. Don't run wget for that first
fetch, so the fetcher sees the partial download as it was left,
whichever wget is in use.

Tested with wget 1.21.4, wget2 2.1.0 and wget2 2.2.1 (Fedora 45). The
test still fails without the fetcher fix.

Fixes: 37b9c56ae3b2 ("fetch/wget: rename the partial download on checksum mismatch")
Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 lib/bb/tests/fetch.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9627b3b1b..0f29cdf11 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1708,8 +1708,6 @@ class FetchLatestVersionTest(FetcherTest):
 
 class WgetChecksumTest(FetcherTest):
     content = b"bitbake wget test data\n" * 64
-    # As large as the real file, so wget --continue has nothing left to fetch
-    # and keeps it as is
     corrupt = b"x" * len(content)
 
     def setUp(self):
@@ -1743,8 +1741,10 @@ class WgetChecksumTest(FetcherTest):
         self.write(os.path.join(self.dldir, "test.bin.tmp"), self.corrupt)
 
         fetcher = bb.fetch.Fetch([self.url], self.d)
-        with self.assertRaises(bb.fetch.FetchError):
-            fetcher.download()
+        # Skip wget, so the fetcher verifies the file seeded above as is
+        with unittest.mock.patch.object(bb.fetch.wget.Wget, "_runwget"):
+            with self.assertRaises(bb.fetch.FetchError):
+                fetcher.download()
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test.bin.tmp")))
 
         fetcher.download()
-- 
2.43.0


