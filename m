Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF1ED41174
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 11:16:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33183.1768475780958951564
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 03:16:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=fIaUGYeJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60F6gIVN1172623
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 11:16:20 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpg84ap39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 11:16:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso1851676a91.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 03:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1768475780; x=1769080580; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7uYiUl4OJXVTv866RjmZueEWWkfhMrvSNeHwIZMp7I=;
        b=fIaUGYeJI8SvPbypq6a3Oey3ISPwqW+r5a17OHJmxh4/GsdjoYENBo8CbCIXhQqI5a
         17b/i8a9hCiZ+yw1EN6Vu3oE/bxGxXt1Ft0TTJwowahiYcrbXUhGKyJBP7syx5/WU59M
         nf9Eic6W9DhA0/7tgiCE1Qp3WhkzW2Q09B6+ep8RjAltoNppCGM07AY3sY03TknSN3Sn
         yvt6qZgUCOy5fqslVfNpJh5CuCiheLjTszDu7hHzqJh+yTAg9qoaMKJbESjgnY7UJDlp
         N72fJ7q1iNG+0iZu/WrqV7T1BHJNTdgOYKPUMnkQ/vYKJgSJ2rx6dR94ET+9TZ/ZHVUE
         lygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475780; x=1769080580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7uYiUl4OJXVTv866RjmZueEWWkfhMrvSNeHwIZMp7I=;
        b=m4Heb0zJlUj7O+rhyJzVMAtD1oABcLH6OT7dqLsHNNpxRRdUoSM8/x6rj2g2QvzaSf
         F8+4SRLOdRfbDBxwHNibmTqAdn29eFRxSR/2kwL2V5K7T9RArfTfviJ8vVhfmQOZkal0
         FrZuHwAOLgAkTwKgbwc0QAdXdjyQmBdosa6KjHFvQNVV3JW1AVViZ3RHREVbQmZBhc0H
         F5fnmsFmZKSvr9DhrxySvv3QaCozunaiBaKX8Lmll4lM/Ug6Su7omlFzHA0GZaJCJjcb
         eXB3Do6a0sLnONXCzpNyoJu6AkiUoH3bG0x0I3Wu5vj5g/x9oPD6fQnhw9jFR5eMoMXh
         RGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpd+vqlb7flU+14PZ7unWLx53aH5UHc5ppVYNuaurDhWPRKUTN8ghz6oJ/FwxLPNrsGu3yqtCc6IoaKLXn@lists.openembedded.org
X-Gm-Message-State: AOJu0YzOUhbwmVqxQZsrbHKEqusLtu/amPlUJMABOOKa35rAh18LYCaw
	kvSGtp4OtI7TSdMp6/xdn0Wc2rCLUWZSqgaSIMziYn+92pVSFvniDc26tdcsrNaloe7aYhgR87s
	EPmCIjYlhusNb1XzuPv6E8Ox6hAchCLs7fYTxo+lGUMHHvS3STJvZroQwBfrfoVfS0wrzzosk4m
	CYFlfLsULYq34wJOb2y7Ysqk7ifXOdz8WKLtPq4jWbhedOGoHC5ZU=
X-Gm-Gg: AY/fxX5DPKYbiG0ob3TlrZ6fxoSiMAi+3ucaBkDaMgOVzICAmAlOPQXyXLj79WGwIwl
	lXFqM7AdeSDJhEtWM2OQ7Wuxi42mbSu6q3xnSDBCvY3Wezj4LIvKj0IkmgwqTHzqDO5QnIJh3kg
	xQraxuX7/nNOm4oo136X9yjXye8RoOYaiCT2XS4eeQ4ySaK1Adwf8Ve7GaJjmiXnKjGvcddVbHL
	9X5ydlWj0JWZAi1+OMtvfdWXoagrmrd1Y2T9v198yJ9CvAbT/MrGCbK
X-Received: by 2002:a17:90b:3a8e:b0:340:b501:7b83 with SMTP id 98e67ed59e1d1-35267865126mr2386153a91.10.1768475779715;
        Thu, 15 Jan 2026 03:16:19 -0800 (PST)
X-Received: by 2002:a17:90b:3a8e:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-35267865126mr2386139a91.10.1768475779286; Thu, 15 Jan 2026
 03:16:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
 <CANNYZj_ERuqEY6w49NRKO5OsBr-HqG8hDSHiAB-e55LVhZq=cQ@mail.gmail.com>
 <CA+HEL78C8y7fgiw1GVkGovT-rEBObyqF1+eRy62suE-wHHW-og@mail.gmail.com> <CANNYZj9yJrsWAnjFMSXZbZJGoqMjC9Hc5cHg7MtX9qRiEFGQqw@mail.gmail.com>
In-Reply-To: <CANNYZj9yJrsWAnjFMSXZbZJGoqMjC9Hc5cHg7MtX9qRiEFGQqw@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Thu, 15 Jan 2026 08:16:07 -0300
X-Gm-Features: AZwV_Qi0n3j7pxOToivhPp991lYwlmWnfXdcAsEHXLVAkTMc3hfFpJJOh4MhsFk
Message-ID: <CA+HEL7_sm9vGAYravu8eqLMBEJy7J6fhU_pjHgyN8uZWy8owmA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
To: alex.kanavin@gmail.com
Cc: otavio.salvador@ossystems.com.br, bitbake-devel@lists.openembedded.org,
        Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA4MiBTYWx0ZWRfXz/LumJhtAxbV
 zTtflRJnTwNYwbYKH6yMoLm7tXAQ2M/ffSENMJSketJq3BfZGNfnMasddoo9dgFYU2iICFQI4Gl
 rRyPSqf56BBYYuhEn2kmDLZrIFRuwqwN0bXmkLzzsEGcTQHqMA8zDJsPlLlDfJ/MvGz55e6UHH0
 OFa21SHs53iinKSnRN3+Fgv1w33Y7tGVgBTMrREpdBSMdt3ChO5pEQNaLYGAlA0triG72USUSgT
 D93DpK+qsEns113IEyv6a1+aM6Yls0YX1UnIxQzB/Foo0SjCcITlCgWyPPOvMRdFw6r1KNpwGS2
 ip7Q08Yq8DUiA0jLvsPdPd4s1L+AmLP625z89h7r6Sg5CncHmfp+guNV4ij2MXswXFK99zm5owY
 WhX4jw4xmrimfQ/mh9Xe/1c2eFS13FUVScknq5iXN0TfbW6UST8rVaI7CxjezOaSAzLDkdq2aot
 ixXtYshnNaQCksS5WFw==
X-Authority-Analysis: v=2.4 cv=IO8PywvG c=1 sm=1 tr=0 ts=6968cc84 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8
 a=J8eAvVc7XXdmLa8d9I8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-GUID: us54bvQVCHSHdpVXka43AtwrWAc2wpNx
X-Proofpoint-ORIG-GUID: us54bvQVCHSHdpVXka43AtwrWAc2wpNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_03,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150082
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 11:16:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18771

On Thu, Jan 15, 2026 at 5:00=E2=80=AFAM Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:
>
> On Wed, 14 Jan 2026 at 18:43, Daiane Angolini
> <daiane.angolini@foundries.io> wrote:
> > Let me frase this in another way. My project has all and every
> > configuration needed into a distro conf file. I want to create a
> > .conf.json to share. Can I create one file without any
> > variant/fragment/bitbake configuration?
>
> You still need to specify in the json what layers need to be included
> into a bitbake configuration, and what distro and what machine needs
> to be selected, if you want bitbake-setup to produce a functional
> build where bitbake can run. If you don't do that, bitbake will
> immediately tell that a machine isn't set, or that there are no layers
> or some such error.
>
> So you need to define at least one top level variant thusly:
>
>     "bitbake-setup": {
>         "configurations": [
>         {
>             "name": "poky how it used to be"
>             "bb-layers":
> ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-po=
ky"],
>             "oe-fragments": ["machine/qemux86-64", "distro/poky"]
>         }
>         ]
>     }
>
> In another message there's a question of what would be the equivalent of:
>
> git clone <poky> -b LTS
> source oe-init-build-env
> bitbake <image>
>
> The above is the equivalent. bitbake-setup will not ask any questions
> about choosing something, because there is only one choice.
>
> I appreciate the standard configs are quite a bit more complex than
> that, and a 'simple' example might've been helpful, but we want to
> give users a range of options rather than impose very specific
> selections on them as was done previously.
>
> > Or, Why is the variant "poky" empty? [1]
>
> There's a "poky-with-sstate" variant next to it. Both variants are
> nested in a higher level variant that sets common configuration for
> both of them. One is supposed to use that common configuration without
> change, the other adds the sstate enabling fragment. Think of it as a
> tree of variants. You can define sub-variants with as much nesting as
> you want. For example if you have a range of target machines, they
> could all share a common configuration, and then each would add a
> specific machine fragment.
>
> > Or, why is there "two pokys" for me to choose?
> >
> > ```
> > Available configurations:
> > 1. poky-master  Poky - The Yocto Project testing distribution
> > configurations and hardware test platforms
> >
> > Available bitbake configurations:
> > 1. poky Poky - The Yocto Project testing distribution
> > ```
> > from the iterative `bitbake-setup init` output, from [2]
>
> Please do not trim the output because that gives a misleading
> impression that the same question is being asked.
>
> The first question is about whether you want poky (the reference
> testing distro) or a basic openembedded build, and which release of
> either (master, or whinlatter, or soon there will be the upcoming LTS
> option there as well) you prefer:
>
> Available configurations:
> 1. oe-nodistro-master    OpenEmbedded - 'nodistro' basic configuration
> 2. oe-nodistro-whinlatter    OpenEmbedded - 'nodistro' basic
> configuration, release 5.3 'whinlatter' (supported until 2026-05-31)
> 3. poky-master    Poky - The Yocto Project testing distribution
> configurations and hardware test platforms
> 4. poky-whinlatter    Poky - The Yocto Project testing distribution
> configurations and hardware test platforms, release 5.3 'whinlatter'
> (supported until 2026-05-31)
>
> Assuming you chose poky, he second question is about whether you want
> to enable pre-build sstate from yocto infrastructure to accelerate
> your builds if your machine isn't very powerful:
>
> Available bitbake configurations:
> 1. poky    Poky - The Yocto Project testing distribution
> 2. poky-with-sstate    Poky - The Yocto Project testing distribution
> with internet sstate acceleration. Use with caution as it requires a
> completely robust local network with sufficient bandwidth.
>
> We could probably improve the descriptions and suggestions in these,
> but the intents of these choices are hopefully more clear now.
>
> > And when I created the draft `conf.json` for meta-freescale I realized
> > I could just choose none of the variants (because the base is the
> > DISTRO and I might want only that)
>
> You still need to create one top level variant with that distro name
> specified in it, and the list of layers to enable, and perhaps a
> target machine.

I understand the intention here is that "Assuming you chose poky, he
second question is about whether you want to enable pre-build sstate
from yocto infrastructure" or not.

In the terms of: I know you want poky as DISTRO, but you want clean
poky or poky with sstate configured?

I was thinking in terms of: Now that you have already decided which
DISTRO do you want, what do you want to add to that? <fragment1>
<fragment2> <set of fragments 3>

this way, if I only want to use the clean DISTRO, no variant is needed.

Ok, I can work with that. Thanks.

Daiane
>
> > I'm not sure it makes sense, please help me understand
>
> Hopefully this is a bit more clear now.
>
> Alex
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18765): https://lists.openembedded.org/g/bitbake-deve=
l/message/18765
> Mute This Topic: https://lists.openembedded.org/mt/117253653/5992125
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [daiane=
.angolini@foundries.io]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

