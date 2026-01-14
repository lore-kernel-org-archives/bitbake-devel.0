Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A6D39004
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 17:43:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16206.1768412602711990798
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 09:43:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=PoYhxdaW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EChUYA3925406
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 17:43:21 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbdbs1v4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 17:43:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso733565ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1768412600; x=1769017400; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpSmW0jMUjX3BhBbMv1zC6fX3U3x84LNRSIPUF1idZU=;
        b=PoYhxdaWGcVI4cvYrN/Pnjz+TQgvc/y0Tyx8Y03FBI2ywYY0zS78/b/dujaqnYGvoC
         9k+TMcKvQPakwsAa3x+a7g0yOscrTOexGA6CDn8LskObEkjaX59usNuW/IASGH7rNISI
         VsmH/mNsSVL0f+NoLLsdhrzh/qNWRmDfICvEE0Ysx0VGmX6g54+Ns0k1o73Qjd/UZLks
         U/0dYOk3ts6evLfqXJBOTCfWQuZ85c0Urjm1v1AtFypIJo6PAM+FabsmSrsTZfq08r3Q
         RVq3EqrCW/GwJR+My/rhlCLP3PIs6zF6i3VhyCzpe56CJi2/a9kMNlzCLL2T1hp+LkSU
         G70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412600; x=1769017400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpSmW0jMUjX3BhBbMv1zC6fX3U3x84LNRSIPUF1idZU=;
        b=aXo9HTOE4Fpp5RMEBH9NyoGsvzgBawPISXaNGVfZMgtK+2jRMFv+cqTXfylA4gvsna
         Q3KeSnDYvAizCx4E7XIFIIllKCjqVETH47AmGNWDbKec/uSTDBU0D4SPBZYDYAfmAv/0
         zRlpfU2QAi7hwnhwj1g+OBwkGJkXD4tmCiBObC0kmQd7txnQz/QR/8lBLHzXwQoKVxP4
         2xx+RclTKnGCT8cKl00P7kciGUI/uPJLLOiUy1xeBW9OkAMZ0XQSzOK8f1tgVqF98ktH
         4bGUzFv6dkbSvEMjiIDxx4iXTSHoFl1pCPgtxEMSyhHSbDoCk+YNPu6Yr87btK/xjoLL
         FXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKUBaig5ZDsHE3wO+ysyZRA1/SXQrlBQEeiHid5RNRf0F0nVt1dY3mZnveNXlDXT48Rqv7n7tuK0/CihEF@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx51E+luA7PUN3HL87cRsmes0GcZV7BFGcgIzBLHFuh4Ibkht+g
	6pXzFdCVxC4nnnnizXVy8zKXy52oAeCeiobQEibC1NWjPZTt6DH1xIm94o70wf+nU3X84bzJmd4
	pAibnNdmS1Ie1Ux3oXEng/Bm8eof2uKynNXwUIibmziBqf68eRKMIAFW3388cmVii6vjbmUQq9D
	pmn+pAIrbP/Jtsl+WxDpVYi59ayJWWs0BdVJGrLHQcToA7Gz9dSRA=
X-Gm-Gg: AY/fxX7zMFkL5sXqM28igdqcA5iHT4qY2tW4x/36TMCb5Bhds2tF1oXFzJU6aTCKAoV
	plLwX1ioonI7Eqau5yTNk9eXrH1Shnflww1izA4Eu+eRJIP19FjvctWpxokq9MB92g8fgrzmO3G
	298bhvi4WU6UCAbrPof5hucMHoiPbpTi6hhIU3pozdOMT/JrU+Cem67AcYUUYoVgCAnUA=
X-Received: by 2002:a17:903:22d2:b0:2a0:9e6f:2ce2 with SMTP id d9443c01a7336-2a599e4ab1cmr33999615ad.41.1768412600548;
        Wed, 14 Jan 2026 09:43:20 -0800 (PST)
X-Received: by 2002:a17:903:22d2:b0:2a0:9e6f:2ce2 with SMTP id
 d9443c01a7336-2a599e4ab1cmr33999375ad.41.1768412600143; Wed, 14 Jan 2026
 09:43:20 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
 <CANNYZj_ERuqEY6w49NRKO5OsBr-HqG8hDSHiAB-e55LVhZq=cQ@mail.gmail.com>
In-Reply-To: <CANNYZj_ERuqEY6w49NRKO5OsBr-HqG8hDSHiAB-e55LVhZq=cQ@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Wed, 14 Jan 2026 14:43:08 -0300
X-Gm-Features: AZwV_QhwTLjkobBrQulW-sDQ2M_4TsXJT2dqNmshtmH_Q4zFw0PThstSxizplug
Message-ID: <CA+HEL78C8y7fgiw1GVkGovT-rEBObyqF1+eRy62suE-wHHW-og@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
To: alex.kanavin@gmail.com
Cc: otavio.salvador@ossystems.com.br, bitbake-devel@lists.openembedded.org,
        Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NvncssdJ c=1 sm=1 tr=0 ts=6967d5b9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8
 a=cpenunzqXUXvdi5TAeYA:9 a=QEXdDO2ut3YA:10 a=o03EqElSOXwA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: oCnv0JMLfBlFAhBm3fc3vKYv76IEof6x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE0OCBTYWx0ZWRfXz0SST47I3BEk
 yXppQ7NrVIGH923lzEEZQygCmW306ybeNuuED2XHJPGnToyEdr5ohJOFxsJnheyfFJVVEAhyZRd
 yBfBaUN8XIwYbFEm8onmplia60Q5NCsaPPu5rsLgwENoWdyIA8n4Ol0UhpIVq+1aqlPDHVtg5kI
 ARkfVWOmvyCPWT+z5Akzb+fzvgMGivYlY1TXjYACdBXv0kGtIwKmEUSNIinTyqxeHwXFOpRDrIT
 Q1672vIxeTR2w73YF5s4wzCoaFuzDLyN3WPmw++lv77YOOnyL+7ZIFACA4qp7zOhbR8uhLnMbZc
 cZIqdrpzUda9Q+hcE8gvNKA7gMRTCVdpVcDIo+EgiFOZXmkhrpeTRkKjyEtr6g5cyXHBtXQ7cIb
 wMwtV9Un/pHOahoYtKOJtaH6pv0AU7+WUuy9QkH48xh0QflH0ck7frjSy+Q21IoJold12wmH3aC
 Gx+L+ebAf8y3d5CTFeQ==
X-Proofpoint-GUID: oCnv0JMLfBlFAhBm3fc3vKYv76IEof6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140148
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 17:43:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18763

On Wed, Jan 14, 2026 at 2:25=E2=80=AFPM Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:
>
>
> The only issue I don't quite understand yet is "allow empty variants in t=
emplates".
>
Let me frase this in another way. My project has all and every
configuration needed into a distro conf file. I want to create a
.conf.json to share. Can I create one file without any
variant/fragment/bitbake configuration?

Or, Why is the variant "poky" empty? [1]

Or, why is there "two pokys" for me to choose?

```
Available configurations:
1. poky-master  Poky - The Yocto Project testing distribution
configurations and hardware test platforms

Available bitbake configurations:
1. poky Poky - The Yocto Project testing distribution
```
from the iterative `bitbake-setup init` output, from [2]

I may have made mistakes with the concepts, but those were the
questions I made myself when I first started trying to understand
`bitbake-setup` and I'm not a newcomer, so I assume for the newcomer
it will be even more confusing.

And when I created the draft `conf.json` for meta-freescale I realized
I could just choose none of the variants (because the base is the
DISTRO and I might want only that)

I'm not sure it makes sense, please help me understand

[1] https://git.openembedded.org/bitbake/tree/default-registry/configuratio=
ns/poky-master.conf.json#n66
[2] https://docs.yoctoproject.org/singleindex.html#use-git-to-clone-bitbake=
-setup

Daiane

> Alex
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18762): https://lists.openembedded.org/g/bitbake-deve=
l/message/18762
> Mute This Topic: https://lists.openembedded.org/mt/117253653/5992125
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [daiane=
.angolini@foundries.io]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

