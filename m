Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDD8CA5FB1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 23:02:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1582.1790722944259231578
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Sep 2026 16:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=VaGP+T2R;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Tyv9ckwr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TIrDTH1649654
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 23:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JSUqGLzMSXL2yrdvRjtkLJ3chLL5oTlBSrB9W4tAplQ=; b=VaGP+T2RsVsNq6lQ
	Z+C9jhfhF1dtwfep5MEHf8oUzhzSBut6sGg7FAY7jWHK+fYFId5IBv4KS5vehf/k
	g/EDMht2JsgFYvoEk/TIgoHfqqNM//pVqw1YGj55fzJoRRb4EI/MSs5ynxXBNhLr
	yhFnTHxosNrR24Rn7SdAiEQL7Lc/4GQfRHyYOAoT6VRrnfL8XtxeVj3Z1bZC7jtE
	M6Sk8qu9AD++8u6W7EV1+46m76CeHWdeNdaL3KvfAjcXl0SvDt3fHFyZ2z09/joV
	avl1xPeiZdVSLch6Rqq/QLC6tflUEDFsobsVDXsoDhNcc2lTd5GbQIyB/UIbz0Xj
	rV+y6w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et2a73j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 23:02:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so2556335a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 16:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790722943; cv=none;
        d=google.com; s=arc-20260327;
        b=Dho4e7X8dBaqTMFawpHXp4Q+5uu4RvpJSTXzLm/zK23yAnBZLRMXXgZCRodh3uEgUC
         RfLU1vblEXhUlUjYtyADWnauut/hICoJGcAsdz5RWSS4ZgNzYk3qiBDvjp8ZP1Zo1DDV
         m1hENubSTKL1no+Vp9+CT2QswcTtKdtb8e6OyHdr6GEr1laPSUNaJMvFI6OO86yczG34
         IVFwGWdESYLwjuvLrTrNPD/J1eiJ6mQ3frgsgx6j+7QPtP7/FN2a0EtbaAFKPdAiHkC3
         QV4mxz1YZPoM8fH3o+t45Tau4ELpxbKjosrB/+kSAHxnH/wp6CpEjHfyaO5NjtoZy+Vn
         5mTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JSUqGLzMSXL2yrdvRjtkLJ3chLL5oTlBSrB9W4tAplQ=;
        fh=xnOaUls3fX1MgwMNtMDkDiGoQxhyNw4USVsvy9bchPw=;
        b=gPw8UP2xC5CsmXm2rYr/qHbgz4aFKRswLBWfZC8raLORajGCfySdIEEC7y+S1InmhA
         NVXk0XlO32NJS+bwQhGviViZDzAC6UrbOUTc7VNgh15caBLkR0stZYOfOXuc1xMwDi0T
         F5dK/HkkFHfHi3tb5d6zAjlxDA+bJThDPf8SI+NNtVKIOqMhGNCWhztWOntlyqsGcCN2
         HN8K9HW5eLy1wdD61At9fGilgtTJMRaEsixAg9ThXkXV9R472vn6O46pu0zRUXJN9vgA
         Mru+lzeeFVTKbOMp6LIqkdmBbitgC1yNeQMdEXBEz4tNpSbDgkW53gSlfRdkNSf8Lix9
         k5mg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790722943; x=1791327743; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JSUqGLzMSXL2yrdvRjtkLJ3chLL5oTlBSrB9W4tAplQ=;
        b=Tyv9ckwrPsTp+SPLR5xGxZE1wGljdI5CSWSpW/ZRWhhQerpzu11YfOiDUWVEP9MgUm
         u5U4eBdudFFqZKCNbSIgqcxfCzMx4eeuxV6x/E39XHQHeVC4NOihu8KaH/knuzALSW8P
         chdRktPubLWA9M0/O5KjgaZ8y+2qwlSCap0hd2w2c52wkhEyBa3gotF6sZ7SbOdbOS27
         +7BCd9oA0NnkipoP4fRr1EvwJ8gHayro33eT+RdF/WUNA1uABxNpSe8O0UJXKJh5MV+5
         ATHWzpRrcogfg1vvn7uqH63fBtxAB2cGRLjAfDwLiUonKWMLamuqohQulo77HqfFFuR4
         Fe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790722943; x=1791327743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSUqGLzMSXL2yrdvRjtkLJ3chLL5oTlBSrB9W4tAplQ=;
        b=nxcUa0MURkLI1Vq7UIHVwOwQaMnTCvfPErdEX8UzJIkmXNeXjYCSKOWU1KGiOjhi+o
         x9T4bVRAg9GCIllSnmYIeaovveXHXgF3J/jd1kbq0yb3CoPzx/gkyK74MNatT/lEPxb0
         nRIl/aCZF9QC2sYkrFtE6X0qXghEvZQILlhsoXjDUJ96RIPfGX/8+o8Cx7Rr+g7Qjpmd
         I6AgeoyLs/8gPMUopc7ENp5vNcNIAue6EVSLJBnNFo+2s+iRgWMgZpGVJcKnrT1dvRA7
         PFz3JaYVXMAs79MK+6iP2tQZMUUfMM6YTH8kPj5SfWLq/3FpdFrbfOHvbTM3OgEWQ13s
         UlOg==
X-Gm-Message-State: AFuF++k2r5mm+5NkaXXIGy60DmTBaOCltP0Uozu+497iC6ti0r5ailFd
	UbsddsPiSyu0rZsYYiLYXCsiO0vX77G5nb0Qy7Khh5WC8r5DUdqDdrr9VcPjZFKY2VAetPnigJ1
	Y3RLMTQ46F3ryrzhp/PFAa//07RaXvepRpwKEsLPQfVCdDp66Zl+8rg0X2xNv+Djb2EUCytf+78
	F2VOtqlyn9CyICLtsSiql6WjRoTgKzqMsx7x0nLK1rs4b9eo5tuzt4
X-Gm-Gg: AYBFou3blhX27dlhw2H359JtqBxsWZdNcPcoxK7ZlB4uTxiTiX56dKxe1SDmP2GqwWz
	2aQ7jzi7OPba8N8qsEJPDlw4gWL0v/o8wKv7sL2+1PeaLagZ8KVRvNYM4ZcNJrSbORtyDtVk+FP
	hZltdgOwphmFoGSISyFsHGxZ6IIO1SunZnifYa4B/8+zLD1FoOI8KC6sTr9sk=
X-Received: by 2002:a05:6a20:9e48:b0:3da:421e:40f3 with SMTP id adf61e73a8af0-3de952826b3mr426566637.17.1790722942643;
        Tue, 29 Sep 2026 16:02:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e48:b0:3da:421e:40f3 with SMTP id
 adf61e73a8af0-3de952826b3mr426538637.17.1790722942077; Tue, 29 Sep 2026
 16:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com> <CANNYZj8T1WwNfCrSg98e_37B7i=n+aG9Mx3FF0-2unVn9ajbXw@mail.gmail.com>
In-Reply-To: <CANNYZj8T1WwNfCrSg98e_37B7i=n+aG9Mx3FF0-2unVn9ajbXw@mail.gmail.com>
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 20:01:44 -0300
X-Gm-Features: AclHuK-1T665_aWUDvMTkwgXXvhoXjfHPmQTdwyoPuwnMiIkOs_ql0loqcwu_Pg
Message-ID: <CAA_5youAxbvmrc10VgGQrG_C3Qe6KFthLWQZ0bHSBFfrLCc4ig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, jose.quaresma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7ORZCeXpxp_uwiWhRgkbDI7ZkI8UJ1yj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MSBTYWx0ZWRfX9eQHWcV0XJpv
 Ew5EvsalE4b/+DpE3Q/b8yS+jvPYBSvk9G5CX2YRSLGrFlcwT8Uf5M6gNcV/FC5OzSMn/bJb1y/
 TmqCggB0JbVCqASFtAAFluIfawcIseDlJ9jqwBZwr//rL8AiyMBjiWW9Vg+lRHYRoGcihDIlK3g
 M2eedpFtDTVtOvSNlGWDUO+6DDYlJXdcai0ejwPtSRzqUcG+tLvOHqvg0RXp7xLDH16ZEcm4/z9
 wdfxX2XTpEmAI/+bxePCbPvKYx9JCidzxkhiwPmUbW2s5htD4cbJMC1EaTjCG2D57ky6pU2xm+P
 SLmzzc+LpTUNBl5b9s5f3Nzi6EnplbyhmJyDNNuKYpOyRpzZNAAbuErfLeUxNtQSyMGmfssyRcB
 uYb1or1xFsbr1hHLrPQyTflkqslvrbOefncgyjUU6f/jZgss9YAn+pvVXcvSlpzlPZp7Rve8nzu
 Jym4ODaF81813nT8GYw==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abc437f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=Q4-j1AaZAAAA:8
 a=FDHGvlcuFz9O1KpsdM8A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-ORIG-GUID: 7ORZCeXpxp_uwiWhRgkbDI7ZkI8UJ1yj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MSBTYWx0ZWRfX+tnBdbdtu6XY
 aIBJ9T2cQrN9507PnO+Cenf+1EDuipV0o1HlE1sVy2myvVX3s45S4XrJKddcDLZ3nItreoXF9PN
 pfHSPUTwioV/v9RpyyVDEXQ4NDH59VU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290091
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 23:02:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20281

On Tue, Sep 29, 2026 at 1:48=E2=80=AFPM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Tue, 29 Sept 2026 at 03:28, Ricardo Salveti via lists.openembedded.org=
 <ricardo.salveti=3Doss.qualcomm.com@lists.openembedded.org> wrote:
>>
>> Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
>> mounted over NFSv4.2. What corrupts the file there is not addressed,
>> only the recovery on retry. Tested with the new tests, which fail
>> without the fix.
>
> What is the plan for addressing the actual issue? Has it been reported? I=
s it investigated?

Yes, it was reported to AWS and we are following up with them in
parallel (about how the file gets corrupted on that storage).

> The problem with such workarounds is that they remove all incentives to f=
ix the actual issue. Worse yet, they can obscure that the issue exists to b=
egin with, or that it has appeared on a system update where previously ther=
e wasn't any (e.g. a new bug).

I agree with the concern in general, but I don't think it applies here.

The fetcher issue is valid on its own, the shared storage is just how
we found it. Once a .tmp file has the wrong content, for whatever
reason, it is never discarded: the next download of the same file
resumes it with --continue, mirrors included, so it aborts every
future build until someone removes it by hand. This reproduces on
current master with a local http server and nothing else:

 - upstream serves a file which doesn't match the recipe checksum
(e.g. a tarball regenerated upstream) and a mirror has the right one:
the  fetch fails, as the mirror download reuses the .tmp file left by
the upstream one instead of fetching its own copy. With the patch the
mirror is used, which is what the fetcher intends ("will attempt other
sources if available").
 - a bad .tmp file and no mirror: every attempt fails. With the patch
the first attempt still fails and the next one works.

Both are covered by the tests added in the patch.

It also doesn't hide anything. The checksum failure is still reported,
and still fails the task when there is no mirror to fall back to, and
the bad file is kept as <file>_bad-checksum_<sum> with a warning, same
as the fetcher already does for any other file with a bad checksum.

Today the only way out is to delete the .tmp file, which is what
destroys the evidence.

Thanks,

Ricardo

