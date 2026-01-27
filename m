Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D710AD2FEED
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 21:53:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1277.1769550796957273229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 13:53:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=iWjm7R8v;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHi76h2478632
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:16 GMT
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by20y0rba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b715b26fc3so8357461eec.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769550796; x=1770155596; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QGykXcHNBCzD4a9WrSHB7YM+MoKuxAs38SRHDzn45k=;
        b=iWjm7R8v7lvFVlMTl52eSfJOyTMLUxzb9H3F/TRwY3Otie6dpsdrIygu7cn+Ok8IPf
         SAuhjC92qas6SvNmhRPcRdT/hDODrGCpWTun0lSlzsy+lAOVXlG/A6wnU0lT+H9znM9r
         pGjckHmEgFrgC/JYZXxDpBxgrYQMg/njJDMllk3a9d0BslCdG51fS6DNFNPDknjCW2qu
         7fOQMLD00o8/maGHqXxCD+UBQJRRLdOd7R8NfbDLQUpogof6wUOO22rEjr3Du3K+ls8I
         SyIRR44YhGxFALXkOgjPq8oNkK43A9vod7gtZVjKyjEhyGpYG2nDM4g5AnaHMWJI/KK7
         j2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550796; x=1770155596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGykXcHNBCzD4a9WrSHB7YM+MoKuxAs38SRHDzn45k=;
        b=dLtO8xq/dw9WOOr0V5k7duHdCGZByNU1X/9pFexL96piYEAl+tGhOH6cFjtAeadKpL
         UwZIpxRPQKR7P2GJUWErkjHcXlz9b9qAStnC6+TR1cTxbU/RA7abnkNrUUrrpboS8RYz
         vEwg+Y8VwTdyxUl+TLEGsl7wB1MXqI/gXlZElXpTjPXZxd9u+Bdzw0nLGVYh/ncmOalf
         j3xf46hTulUdbqMqId9Eqgj7XuM0D+Xyi58kHzaiO2IA54g6qE6N9Vz76sYwD2Cm30AC
         IvE58Gv40RHdp5bPyVPS6xc/tc0Jz4bbhSp5yA/Seo3tmx2j8+8BUUGUFmpvsCQ8FtL4
         x2ew==
X-Gm-Message-State: AOJu0Yy/v0las/iQ1sPf9Gb0R1q+S0mZ2cK3a7BXARqcQy2i37gBwZIr
	e2DMm4mF31LihXphfICbGscAywaA9gB6JoVDG/PsXoJzHxKA7j64Zh92LhI0Lu8hU/ECRcDyk4p
	x6qvwHNskODXuTmw8Y3dbiJkN9gZ2Qy5cwsUYDfYzmf6Hg7VTHTh6ryKbyuEw3R9QKPxgzcraPp
	CIPlM67HLF
X-Gm-Gg: AZuq6aLXMGiisiGBF4LIZpYFquE8uY5AcZE0I4zuztndwTfnlDC67RivOllLrQHy5R4
	MgSPSK3DK4xmsPyWOIMJ/lFpmk4xXSzk0BLg/Lq8pte+GJdmQpTdfRvL5of4a4si2c6/76ooOyf
	+q+7ryab8b1zqZq8+V90pRzgMkR6/V6xO75XFLMID3zbEGduIsvHTMHCLLDypeQA71A3EwXblIn
	8o4P6SbAOsuALQWxVWwf9lBC3PfmPEtIu4LwlMddJZxK8ijRce9kzHzeFQCgrq8cXDVqBjPxKFo
	/XTHlph0yiM59kagfSPWJTd55ma72h11PamVuBkRtw4dVtOJ+25UfvJGx8rUD4q3yMm66Htdy5P
	ElKaE+ta1iDaD9dEo621vx28AU8aKnVvHLxkye68K4RgHFkxuW2qW83wmani9fYuzIiddpD/SHj
	ebIQ==
X-Received: by 2002:a05:7301:fa8b:b0:2b7:2ae8:9b0d with SMTP id 5a478bee46e88-2b78d8a8ce6mr1836497eec.3.1769550795651;
        Tue, 27 Jan 2026 13:53:15 -0800 (PST)
X-Received: by 2002:a05:7301:fa8b:b0:2b7:2ae8:9b0d with SMTP id 5a478bee46e88-2b78d8a8ce6mr1836483eec.3.1769550795131;
        Tue, 27 Jan 2026 13:53:15 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm31627c88.0.2026.01.27.13.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:53:14 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH v2 0/4] Change terminology
Date: Tue, 27 Jan 2026 18:52:59 -0300
Message-Id: <20260127215303.512936-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X5RzUlqeYu_Sao3a9K2F4M_ue3-Fd6g1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3OCBTYWx0ZWRfX7G4ufbaOK93E
 6Cur5N7kJB8y32bLA3v4l4xJHxBX1qO1AAp+H/Pw0KBkiMwQXX9MZYaZHCXDUk4z6iSLa5W4UXI
 1OBn2+rvMqHx9h9sb2m0b9LBoqtREV+DJmJLwXuVmhCPs1s7RqwYXLO7rOqeZgHNM7tglVY75tn
 43LePKL4ak/rt8CEXImkXIAMLz2J2PO11oezneeytv6RXJM3mERwfiXgCGK12sJ5ul+jlNXJTDY
 qTrcCXh0e/juhmWELHA/jDJu663PyXGYZ+PFyc4yjA1KstJsN69epYxU2BreAcSzOgMUOp4R6oV
 uh45wmBL3RH6me/bw7H/n15o8mW+7RsoakqJFRsS8ur77sT3GFMsbflbWh5OvF58UvcJq///k+K
 Vwz7vxadQYwSyzBp2HFyt5dI8MXnglNpXayv0sWQzOVPodlYWtPSeSEaqpVJBCJg1TWNTZQKeL5
 w6HDaBmxMWzsG+OxPKA==
X-Proofpoint-GUID: X5RzUlqeYu_Sao3a9K2F4M_ue3-Fd6g1
X-Authority-Analysis: v=2.4 cv=IKgPywvG c=1 sm=1 tr=0 ts=697933cc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RadlWFi-fh3R0DILXfQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18905

The goal is to replace some terminology used in the documentation and reflect
that in the script output.

Change in v1:
  Generic Configuration  -> BitBake Setup Template
  Specific Configuration -> BitBake Setup Instance
  nested configurations  -> Variant
      
Change in v2:
  Generic Configuration  -> Configuration Template
  Specific Configuration -> Configuration Instance
  (no change for variant or nested configuration)

In addition to that, there are a fix in a leading text and "sources" is fixed
from **optional** to **required**.

The commit adding the "Variant" term into glossary was removed.

Daiane Angolini (4):
  doc: change some terminology around bitbake-setup
  bitbake-setup: Change the output to match the terminology in the docs
  docs: Fix leading text for bitbake-setup init
  docs: Fix sources as required

 bin/bitbake-setup                             |  6 +-
 .../configurations/poky-master.conf.json      |  2 +-
 .../configurations/poky-whinlatter.conf.json  |  2 +-
 .../bitbake-user-manual-environment-setup.rst | 97 ++++++++++---------
 4 files changed, 54 insertions(+), 53 deletions(-)

-- 
2.34.1


