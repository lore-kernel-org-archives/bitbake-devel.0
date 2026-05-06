Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D322CD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 14:03:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19147.1778076183529615049
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 07:03:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=MFG6j7V7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C5NL63036585
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 14:03:02 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf0edu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 14:03:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-364c0e269e5so6968269a91.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 07:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778076181; cv=none;
        d=google.com; s=arc-20240605;
        b=DJNv1li+zQQdPqX1qzVLi6JjHxzTjpTDfKZmo7il2xHrvfeFaSrgVgi3LOiNkSMTtG
         zj6SKm1dz+8SZB3p4hkrcU3V9LEX8NhBh2SaFH2wsauhE10Bki4d9XChlFK/sHOS8rON
         AxjqeWP7bYYTqkEBBhBWX9Evi/wQcjSpOf5DWcJyY2RPjvUMdxtUtVsFmTuq7vWvMcwB
         isZOU1cPjC8wGTQsQ/SrddQGP0h0jckP9awspo9LcrmX9PnXCktM9d6powKvY4gZPZxI
         Gug5z1IrZejuGIWJxu+ApX7SqMf1FVA5ibyQN8e2iV4R+NP+aqgFWVAuAcBSFZn23jBX
         vaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IOO0fROWfBOULb40izKwzZ607kz4/2jI/bzhOQuqEAQ=;
        fh=skzSbiBtW1d3v8c3XpE9Wic2ROKlKgA4JS6lIrCJk+s=;
        b=Yi9H9znYPlHO+2Cbj07LLsD9PqGxu+7DKiUe9tx3Lfu/MNWKOnRsk/baN6YxFpjyrC
         gAh4PXLqfR4kGmZO2drzggdc/J3sABt6cdJUCZhdKAF1pVTvdQW52bToNN2gTDcJRBxJ
         qYmR+QsDFSyyCVhg3gSWy9iqDsAknGzJj5hAl1dZDLS4VSmRpgFoYFvbO9TexGun2SgD
         S1zEmi4O1KuSl5VoDnu4R2NJS/dr8aQ51DHLvTV+uWq2JyY1nXr5D4jYU1H0PV1Jr2Td
         +u3Lmmr2zTwetLWTnP2OPTtStOCiooZaw+gKp1GyjInxAKDSlGMijpuNlfw5iDAPs7v+
         bYeA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1778076181; x=1778680981; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOO0fROWfBOULb40izKwzZ607kz4/2jI/bzhOQuqEAQ=;
        b=MFG6j7V7Hs1DPTMa/jK97LvVNH1CL6jsFd5/GgdQ4oPfdijnD8pcF5vSbSFoBKHUX+
         aFe0/8GJOF/NeVDNaO87fB8zSCkr4iEp7goJPhrSHH+UmizQJgqnenrmnXdyGejjDkPt
         m3fz/OpHkPDf0IKqHj8UbHIueL5BYGhtVG9YWv3DiLt9mtwsmnEogBnZz9p/OOXOXT6l
         Uo8garE+8XoqhxrX3DO1p66XQDiJnuA6UanDQ+EQ34zVff82DNy1ayWHD28X8D854odL
         jurGgd0iSNI0UABkdWyhuGL7z4BJ99/24X9B5bkXhChMY3FVdMZcyxU9Fk+REew2PYyg
         9svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076181; x=1778680981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOO0fROWfBOULb40izKwzZ607kz4/2jI/bzhOQuqEAQ=;
        b=Rn21DoDgHqzEXG83IWLrV9bqU0rmzURoLrP8m4vDt7P3zxcFZyOQvpZKdwWMdZyhBv
         mvkr3s0mo1t7z57bwW3dH+ax56Bpy3xxxbZCnMKePuY0gFw7PLP/yCYHFBQXEwE7q7XP
         RpHxDET7sKhTQJfSiMMg5Q/4tlx9f3vipmdBPdrfW1S4EBnXsffOP+rSkFM5t82/A5ZT
         3bObSOeL47mR0Da3DQSWiNNBHt+6i5eg6lj54a0+smIGAdV4kicW824kaaYZ6KgWHFud
         JiRLaR2ISBMbUVqNG9F7Hj5qTqkwn5BJKpbxHm8oIIIWZd2cBY5mbSwGoD6rjOmUX5Uo
         du9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9oiYcHf+/Sv2zLBOFJQFJ49O6URbwLI/hIC8nMhGvOkoTQlM4X+XISjHhWs4zAzuGYcbpqOzcxXwVOei1G@lists.openembedded.org
X-Gm-Message-State: AOJu0YzifG/q3DDrsz0f1OeJfK0s1zK3F6MlWc5aZR9PJKD9JW3I3TOg
	j27/3QDiejoifmIqFGWBSLdLAIYHxsj1bykyENhzMij163wKDZMCacr76+wgMG3HWhQbcHxtUNX
	Jw3AEplNUopdiY7exMNmzvjTuEvxF+gbNjU3mxT0atb5tjkrVu2OekAqVjZElzIxjru/aLFt99M
	6AlxPGHOAoWQOWSRC5qwEzN0oEqEgqpbMZIeOviEktCQGKFOT8R2A=
X-Gm-Gg: AeBDieuFsHRm3EI7bO4NvF3x8LE57V+uYisNj5uP5gOHguqe4Iuugiy5t4XP7W++t3P
	MVi3o2uy4ATBj9Hbz1zKZxJy+9GmNz8npHzwf8Ag5/h5ZKI4aPEPBM5XHPdwddM5LwFOTkx+cYq
	qGDsxQMGFWi0boXvaNUJUH1F42YrUi/P3rsf2E6KdJNBrp0yQ5Ldf8XHZ4AofXYePhxdM1+xVsU
	1CASbbfjjnq7IM2mXwlcQpslAdJvkAw1B98XdC8GLmufgJ6kyTOE+6QlmUDIgrloZ/9QQbMOzc4
	8Dg=
X-Received: by 2002:a17:90a:d60d:b0:362:e7e5:a20a with SMTP id 98e67ed59e1d1-365ab9b8e52mr3403941a91.4.1778076181125;
        Wed, 06 May 2026 07:03:01 -0700 (PDT)
X-Received: by 2002:a17:90a:d60d:b0:362:e7e5:a20a with SMTP id
 98e67ed59e1d1-365ab9b8e52mr3403863a91.4.1778076180345; Wed, 06 May 2026
 07:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com> <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
 <CA+HEL7_H1MJe3WGhdP3TMQho8u0M8g5OfUv2oFXxQjefAo6Hnw@mail.gmail.com>
 <CANNYZj9=Qap1AsWfgFgEforE17Gz8ft8fNz4hJcU4Y=zmTKDZA@mail.gmail.com> <58d89d74-bca7-49eb-8591-5c5e1a0a40fe@baylibre.com>
In-Reply-To: <58d89d74-bca7-49eb-8591-5c5e1a0a40fe@baylibre.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Wed, 6 May 2026 11:02:48 -0300
X-Gm-Features: AVHnY4IPzPgtjHXq_QDpGMKJyEAlLL0SQrLluI7pAG0AhB3OdQGXppNiny5ycaw
Message-ID: <CA+HEL7_pJqDsKUn2OL3Kqhiy4y_H7LRoQTWuVJ-EbOH7k8NymA@mail.gmail.com>
Subject: Re: [Openembedded-architecture] proposal: build pipelines in bitbake-setup
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: alex.kanavin@gmail.com,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>,
        bitbake-devel <bitbake-devel@lists.openembedded.org>,
        Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOCBTYWx0ZWRfX6VhkGG7GH/oG
 DAtN+0SxICeqOa14PkWmAH75ULGZRVUev4nF81jkckYa/6vu/8U5jbv4UGREj/f7p6qyDy/BQP2
 nBI8lx2QgKVUwyz1KDCKVh0Fbl0dimbUz9yaZY2YEUIHwnVCBf92Gw0W2S2G+f60ZRSzy2sQrF9
 xTOLiHi/weMudfnp6GwOCl1BzCe57LMfLC2O4eshaNJ307Tc1h2NhKwxtB5pBpMkML1BLMM1xcS
 lchN0nnojaZQ2K7AWjdQx1LEEr0jFBFhdNsK/XY9UXeYHe2W5rc52/rLE63/H3GUIDHR6TQwESJ
 xGCO89ntr3MX+S8R35W3jIbXt+2FQnD4xbfStNsdjYsBA+5mKqoE1LZKMa1JScT2Dq4fj/Wgx12
 o6IFd+ySqTaKnlGy6rPffb0IrMZ2idiVF0tWBCCRQm0cAIod+d13RmS0MMui4iBAUz+8/3yguUm
 VUrvZrWxzRgMnFD9bxQ==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fb4a16 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=Q4-j1AaZAAAA:8 a=IpJZQVW2AAAA:8
 a=l2JSiykuDEm4BzqryJ4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: FzeJPh30D6s6Aa_WydbuUysm-yI1mfPm
X-Proofpoint-ORIG-GUID: FzeJPh30D6s6Aa_WydbuUysm-yI1mfPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060138
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 14:03:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19448

On Wed, May 6, 2026 at 10:29=E2=80=AFAM Trevor Gamblin <tgamblin@baylibre.c=
om> wrote:
>
> I do like this version of the proposal better. Having read the responses
> from the two of you, I think 'bitbake-setup run' might be a reasonable
> compromise for running steps and pipelines. What do you think?

To be honest, I think that we download bitbake to install bitbake
(using bitbake-setup) so we can use another tool (bitbake-pipeline) to
build bitbake. Although I understand why, it looks confusing.

Why not:
$ bitbake-setup --non-interactive <all your choices>
$ ./<pipeline-name> all/step1/from-step15

Can I pip install bitbake-pipeline? For example.

I understand `bitbake <pipeline-name>` is not what we want because
some of the steps will not be bitbake dependable (such as a deploy
which is only cp a image to a storage), that's why this pipeline isn't
strictly a Yocto recipe (even though a Yocto recipe is just a list of
steps). So the pipeline is a list of steps that may or may not depend
on bitbake, which is kinda bash script for example?

I like that the bitbake configuration template may provide a set of
usable steps, but I don't understand what this other tool does (other
than wrapping the build script)

Daiane
> >
> > Alex
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#2328): https://lists.openembedded.org/g/openembedde=
d-architecture/message/2328
> > Mute This Topic: https://lists.openembedded.org/mt/119158252/7611679
> > Group Owner: openembedded-architecture+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/openembedded-architecture=
/unsub [tgamblin@baylibre.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >

