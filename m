Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD7CCA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 14:16:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16639.1791468974948299748
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Oct 2026 07:16:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=awl5KZkt;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=e0SfV4jQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BJthh1881896
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Oct 2026 14:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	emkRnFFzoal0cC+dw9XBjspaQYqiTEHOAGra9Zr2igs=; b=awl5KZktEzjWBtc6
	UliLZ2lOF8kf2I5vXT8SveI3rCXy4hHRlU85Mk40PnHsQKZsvVEUA9qoDwNeerAR
	WYqwQ6TC0yZfOWkqgQFfyHAocAceH5q91DtiTnJM9Bs9lgasHecZo5BWQq+Lm0k1
	n1CHTnU8la3kt7JaGbj3xvkyIbDFNP5TGajeOkF3awMsSkPyXRjid6lwUoiiGvya
	9jtOnogjR3JT0lp4DeF6hmpTobdQBfLEYQUCwamncVerkg3hZfGlsX6woD7AX3fV
	vARCLJEtp+jZXlpSzGaXoiT5JXf6PJXCD2J54Zg8P/FSDH/3oSWwaxTKSiUL6E4/
	BbchYQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2u8cv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 14:16:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2e0bc619fso54677445ad.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 07:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791468974; cv=none;
        d=google.com; s=arc-20260327;
        b=kAibPZqRhYoZ4zHF6eAS7zHgxqC+oPSBvqY8f+kz3S8KX1ABO9imSGG+SlYZodxXho
         uhjB3cd2ZSRKW6mQGx141sr4vMl6fOJe5AUSqOy46KBwXX9EHZ3oSzwcVnjCpfw+5+Xl
         fxRihnH/WnZmYbdry4cjLpF0/2+LxdsVRYabdFLEIKPXWA6n/G5tKcm3oZczW0VR0aE4
         s23s/FKPqfQyEJ4LxtAwnQacLSMbqLzE0OH2l5mPF9L81dP4nTETOqCloAvUBbsp0WrL
         8jgBR3PpqjmcJTIsu2huEHC8oKTCflu+BGnFkFGiSt2Z1wFEfdbDja8k57hg20MQQv0s
         ZMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emkRnFFzoal0cC+dw9XBjspaQYqiTEHOAGra9Zr2igs=;
        fh=rOWnPaxX2CNI+4jjrLga9GP/aVNz1ZKnx602Vqv/co0=;
        b=kJpl586g9xCaga/iTEH6yWAaPc9poZkUQZaCYPCop1tZsq+wzUUvN+auLeC7rEDkcs
         Pg28aYg4TUNiI5MRSxX0ByQ91aSdRW3c0RK6mLeYCvCljVSOHxq8uuazRM1I1P4/Ww0T
         +B9+lPgDbBVD+wU2KB1YZQ7tQk03pkRSdHwSHTX7q7rcZB9JiMxwiv81dYB4YXtTHgOH
         uojXd2PYLScDlkcrLvVWzZFTOT7G6Ss/5NLzK3paZqC2hnBZIwsAfgJ6byAE30u7ZMly
         R+tfkVlHPVWg3mK4SuiHk7ylxvvjC6vEOmKxScvBEevhvfpnoPoxsYpc6owtANNJE96t
         Uzsw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791468974; x=1792073774; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=emkRnFFzoal0cC+dw9XBjspaQYqiTEHOAGra9Zr2igs=;
        b=e0SfV4jQFty6To+Z7aOW1mUQxSVMnk3nhcTgmKaekft6xLTHgIzJTPzMq/2kxLfpku
         XUhOCHi/+4y+pvuqMG/xO5tfR3GWoIz2VGbH5utT+V+6VYc2jeyNfZnjhwgaK59c9S/S
         oI671tpdrUsr5qoDn0dhP886smx2z1DhBduJadIQpTTCpMd6uCe+Gf+yaziw3gmHT5O0
         fUCYoTIngsiLwmr2OjUd39MKhUYL4QQsA6eaV9ZYZDsh4E5SkqccnR8MHhz0VNbUxUjq
         2rP6ErTiw+xIkxdPMVFJV1CoOAs+/TBKu/Aud/fIgjmcBP8tlel2Zq61M33+hy/IpVCK
         W+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468974; x=1792073774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emkRnFFzoal0cC+dw9XBjspaQYqiTEHOAGra9Zr2igs=;
        b=WP7Us0F2dfwI/ynZfU+NCSWbcGR7DtgnXmYVlkh19CdBqZxI4oKtbTNIDVuNFbax+c
         HWCtp4fpG/fPdczAVqQuYKylqQ8WGfCpJOOLkeHgedM/UBImwpe8+SSIbmcRvFLpdhAI
         j6rSsuZMXjxOoPemf805ToJvDT/NEP0Y7livGk3gCn43KmxaYpMFFWOD0pFT8pTq5otz
         Qqv+7Gpa8ffJeLXskGE3PuxlqaExezzOHh/k3SNkw7qhZ1Gs5NCzKUGlTbFUREMwdcx4
         fgbQ3cOYrYNdvbk1owsU9jB2LuUdv5ha1PGT+RK1MjtxuTB9vsvS/uYzatMv6nNWwEP2
         ANdw==
X-Gm-Message-State: AFq9FYIsMteRnYaeX+uaOj0HGTienj5PlBgKil0yvKIFikFqdqi2D5+4
	51Xr0TgvnII1+H1naEdpm1X+mFd/Y4KYR9wLYvwLL8z18C3qD9Q6HoocyVqij+XSnpoKsRoxssc
	sVo3cZWg9OvqWd9heiXdcpoZN+YXgQBF2lSkovQJlbvNLi1gR5vQH59Pd5zEJd38xGGFMSH3snA
	o7WuJ7wEwIJqhR51FHTotISHHUL6ULgTxijR+KHP/Q4MuvEiDjVMOe
X-Gm-Gg: AYBFou0K1vumj2Hb4WXXqcS8pwIfa8ikMbtYeixFPbWWJ/hThCNoBS3L2HPh5bGxG9z
	dFxYg4FbhNXkD26H2yEzsNA+WwmbPh8pne9axDfoZd9CuNxPr+6cTqkviB22roouhyg/pvxhR0Q
	fzPZzzavIxk/eRtT0Gb61+RFAJNQigvg0Ih/6n7pptNvIrd96NiXdL+n30Ew==
X-Received: by 2002:a17:903:acc:b0:2e6:437:bc06 with SMTP id d9443c01a7336-2e60437c2ebmr46477945ad.45.1791468968568;
        Thu, 08 Oct 2026 07:16:08 -0700 (PDT)
X-Received: by 2002:a17:903:acc:b0:2e6:437:bc06 with SMTP id
 d9443c01a7336-2e60437c2ebmr46477595ad.45.1791468968005; Thu, 08 Oct 2026
 07:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com> <DLZ9GSOJRTMT.3IL2I0HZPLFE5@bootlin.com>
In-Reply-To: <DLZ9GSOJRTMT.3IL2I0HZPLFE5@bootlin.com>
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 16:15:31 +0200
X-Gm-Features: AclHuK8PFyxDxA9Lod5DAEbAIQHq-Ly0lqZW-PBiuJb1FE21R3scd31LxaT6s3s
Message-ID: <CAA_5yot9BGhTmHH1v+NJicxrdpRM9+nkbryESmG5V18GW1+vzQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, jose.quaresma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1NiBTYWx0ZWRfX+8gwGTc3lYAl
 qQzLBUHJEWhUxmEn1bmarrWsZyie+Wo6GENCmZdhLT4xyoVMNYksc5vHxfkSjpP6W5l2pCCWMdL
 Xt92NxVwXuOb01fZav8z4lpZ534mTIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1NiBTYWx0ZWRfXzeWubPbMK758
 Pc/Q54TeuwO8J9xpvWl19UWmw/PPu2IZfNqgq1CJLcGmDzi89B1VxZrQ3HgYrg+qruSXlsySGUv
 dj1InvURqlhHSN9J9byI2JtjjMPGLTKpRyE17J2wcEjmXBC8k7kXwQpKVRwsdocHKmvVcIKSzaJ
 Zx52S0q86giSx4JEzsBKcNcDIts3WSMD9T7vHtUjn91VvatyBBrZgR/J2Dvp/Gx1WzuZgCJqBBR
 OYx9e/Dz1EnAhF/u/hJkmulxuL5ybNg12/NuTGd41v1+LPHVUkE7x32KTEKV9CywefEmFALvSch
 +W7R91Ef6xaC4edWIqn8vSXIPTKsluzmF0LFHGb2Y6H2VChO3EoNskosseMSrJdIpusPGiYyWeU
 nLu1G9hZa2CMQ23IEifPH35sKf8QBs/XKRilF0uHgygfNQCetvpRUvmjglnmBTj5z6QggHq+4UG
 pyd7Z6ukNcpSwtLk2SQ==
X-Proofpoint-ORIG-GUID: behokVgLqg2CKpgfcEyG-qb_gf0XpL8g
X-Proofpoint-GUID: behokVgLqg2CKpgfcEyG-qb_gf0XpL8g
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac7a5ae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8
 a=Q4-j1AaZAAAA:8 a=xOU3QFeLvvG__j1Ac8gA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080056
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 14:16:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20308

Hi,

On Thu, Oct 8, 2026 at 8:59=E2=80=AFAM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> On Tue Sep 29, 2026 at 3:28 AM CEST, Ricardo Salveti via lists.openembedd=
ed.org wrote:
> > The wget fetcher downloads into a .tmp file which is resumed with
> > --continue and is shared with the mirrors of the same file. When it
> > fails checksum verification it is left in place, so MIRRORS reuse the
> > bad file instead of downloading their own copy and, without a mirror,
> > every retry fails the same way until it is removed by hand. Rename it
> > with rename_bad_checksum(), as done for any other file with a bad
> > checksum, so it can be inspected and the next attempt starts from
> > scratch. Mirror downloads skip this check and are still handled by the
> > existing code once moved into place.
> >
> > Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
> > mounted over NFSv4.2. What corrupts the file there is not addressed,
> > only the recovery on retry. Tested with the new tests, which fail
> > without the fix.
> >
> > AI-Generated: Uses Claude Code (Claude Fable 5.1)
> > Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> > ---
>
> Hi Ricardo,
>
> I suspect this patch is responsible of intermittent failures we can see
> during test_wget_corrupt_partial_download selftest, only on Fedora
> workers.
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16445
>
> Do you have any clue about what might be wrong here?

Should be fixed with
https://patchwork.yoctoproject.org/project/bitbake/patch/20261006213334.336=
0919-1-ricardo.salveti@oss.qualcomm.com/,
mind giving it a try?

Thanks,

Ricardo

