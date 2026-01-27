Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3430FD2F011
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 13:21:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10572.1769520105858033829
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 05:21:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=d5B7TebQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBwjM5670721
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:21:44 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs2ssp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:21:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f29ae883bso39368595ad.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 05:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769520103; cv=none;
        d=google.com; s=arc-20240605;
        b=OyLb0rboUKl4PbLQuUujLSdQK2UYPJwTAByvJ0hFMiQvuW1M9MFAf/nZUYNNBGifAf
         Y6TeUD/x/jqL8spe5x+7ftSJdXNYjywXJmhgum84iR8HLuDB3qS/hUknC+q2s4/8r2XG
         k4MGORuoLIyUF4+HazkWloxF6ZTAVMbPYUSeNyhDn0v9/NSWGi47uzUpOnIqcKIQoW0U
         31EjcmW47dJVXYRg2EYtuYhYq1YpYJdauK2cdsenIDk2UsT6QdAB9cSkuA89BpI7+udT
         hztA42RXycDtkizxQmRDAf6g3L8xDJvxBN4g2rl/NUH1wLTWpltNm9jTFUv5uZPMNJQM
         aq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=je2IuncgIfRBkrIaSPK+sCxxKtUxxGJ3zqanMM8wsA0=;
        fh=VzOwsr1wQt0dPTb782U9LKXVlcF96/fU9uuIHJUf8Ao=;
        b=deywHzrBWDhtA0WsZZ2/N92rJhxsAyD7fNwLp0t3VHMihVGHAsdnjsCLvnnrDruWV4
         adPsylvI+IezXOX8HtmywdTWsFIodXafnNifPW4P20fTU7nUIuF4T5vXfsiVIejdh6Ib
         el/kQQDzUp5/1TOz27CYvoNTP7tfuu5jQpB4NWBgch9ZICm3Hc3ecHCPY4ahsXENK+6r
         TLzpTyiD1jt+4yJ+z6DIt0kkJk57fZBUbBhsHgJ3hvlFOBmkHtaaQA++nkfewaseiAz5
         y9AOGHrdOAActNB1P+lKirgzlk3ehQ9IIimVeTlStEkMGrn7+Cph2DZ/73txQBnjkWKY
         EPIg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769520103; x=1770124903; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je2IuncgIfRBkrIaSPK+sCxxKtUxxGJ3zqanMM8wsA0=;
        b=d5B7TebQ/cRq/JxOzVgn4a6lldKMeZYnLMD2PM4eEmznQeIFY9oN/YTVLNunKyguzh
         OqM4F+L/v02VmQUDqG9bQ/nS7eKgYrXS8uf82iAp8x/TP8m7kVqCYE0dsY5Ha1LEA5hF
         Wgnn+IPeZy1E5imByoKkUBrvy/oeJT0ifKz8FsCl3ANLuX9l3bG5eUgdyhLaqgYLo1wt
         ugMKJ5UjzzHVlUdQcYlEuU2gBKrxUzy7cAAET7tBSK5HJ91bSTFRbCiwnTT+1HTJwSJr
         SSFXa0/Rg2NdvX6q1qoPUpfVcQ5x2jqWR+8LpB1bu41yUXszDSDNgX389fQwOWcmMooa
         NwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520103; x=1770124903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=je2IuncgIfRBkrIaSPK+sCxxKtUxxGJ3zqanMM8wsA0=;
        b=XRk1Oa4a++JOXlSIxkYzwdhDvFfbBFqvX7Gs5FGExs28bGxx3oS2zYI9gZ1MRkILYC
         KjVOO9WBixDHqgbaNMO9pGJoLzoT/UEUQAgq5cgTit2FBn4ZTx6HUeymSL13sVfC0Jj5
         Z10BAXhkPsGGTLOJWWu8alN7hXekHcblyhfP5iCIpgFVWTmO//dFFCIEgxBO1w5Znvku
         GA4br71dM0rG5Hb6EAxLj/1+N1HIuVm66y48rSdgoNKAf4z2g8AWYSi9/8nrkMbmglLz
         rp9mjzoekJjiQE9ptAJmDcdoeEVubOC8KhfZEF7ubWO5050/olsQ1Km+2Dc3f/guH6y1
         40bw==
X-Forwarded-Encrypted: i=1; AJvYcCWSR4OpZTfRlJAfPS1ZpjctLcxIsJZ+retQgyF/HjcJhjdCJNn6RqPdZeRMZibz9rLvKzMkNNrJxp3hc9oB@lists.openembedded.org
X-Gm-Message-State: AOJu0YzCD1ODFALZEqOY1e59zEAqA05lxkgxvV57Ft4B/0QqAinXSBpe
	Fh3ejWR3jpDWGGoM93thaYXjVUQx02Q+4OXG1j3jWoSBRTAD/MkilrdQzYX10bJTI1UVDqMBHlW
	y9vFnmX0GFYRH9d3yfwD75dCt5U4f3XIKJQPU8MaH7X2RQOP5bJB84Kp433t8UgtuIpuTVYX8bK
	NhLki79q1Cagl0dMdY2alBcUnh+2K+0JeKruZrRdAkQs33G5B/6Cs=
X-Gm-Gg: AZuq6aKJrQp/nY5XLW4KqZ1PB/2jmnwJ9JIgktGgSxOESj96uKD/YJBMUU36ODmEtve
	T/k3JjyzFD8FnLEDsvhGF/Z9deqwUITRkkdA//RJeHCpxbh0GX1DkLE6GIEhzYcD86uHS7yrpNW
	9XlCG4jSNIMmk01I2U2S4LPeJVjJKHrefGCd0/cAiiIA7w/2E/uq5Bq2KWcQ1II6ztsmYuCCvU3
	Zv57XLwbB1Tn0nYXa2fQlNIa1lsuAQGp8tJv9q25EAbxqzjF3/jnc3c
X-Received: by 2002:a17:903:22c3:b0:2a7:c8db:4884 with SMTP id d9443c01a7336-2a870d4925dmr16850475ad.12.1769520103628;
        Tue, 27 Jan 2026 05:21:43 -0800 (PST)
X-Received: by 2002:a17:903:22c3:b0:2a7:c8db:4884 with SMTP id
 d9443c01a7336-2a870d4925dmr16850215ad.12.1769520103209; Tue, 27 Jan 2026
 05:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-2-daiane.angolini@foundries.io> <DFZAUTK11Y5A.1PPDDZRLH02PU@bootlin.com>
 <CANNYZj_DhwvpzBcG0Vi7E9aYqx7b30uDUxJFkmdE686f1+Zkog@mail.gmail.com>
In-Reply-To: <CANNYZj_DhwvpzBcG0Vi7E9aYqx7b30uDUxJFkmdE686f1+Zkog@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Tue, 27 Jan 2026 10:21:31 -0300
X-Gm-Features: AZwV_Qi7dDGQhhkW2PeNI_ZTeO3GV5FcYw3Z5_1AmhueG_CWp6YRa_c8_Sd89d0
Message-ID: <CA+HEL79Bs-OaWjNa2OSrVULiBqpeXU_0m1u=vUwgh3cXWXY5uA@mail.gmail.com>
Subject: Re: [docs][PATCH 2/5] bitbake-setup: Change the output to match the
 terminology in the docs
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org,
        docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2rQs1LLHEYfi74iIdPGPJ9iM8r_eVyju
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=6978bbe8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=LVY25okwlNza5Yhv:21 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=iGHA9ds3AAAA:8 a=QywrWj0JBaodNPk8WKYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: 2rQs1LLHEYfi74iIdPGPJ9iM8r_eVyju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwOSBTYWx0ZWRfX1JzMECLjaKqn
 mGbhCY+BEXKfRw3DoNzZ0QE83O/p75ZLtDxqRny2ioP5f9RKO7iKulNe5+uDt9wFUeRBeIYCyOR
 sSWfZOCVJ29ps6S0+xwtQ5Jpupjmi7H+XAW8r8KlrLs0TKvWRCo3zIGs81tNwpFdN7tUW4da6N7
 ALO6wVXmRwTVgtMSbd4vWwZI4rEZ57VwlH/s2E9MqQ2/maSnPOkVBW+sg1G82buzDja6fLC9Ld+
 7pLTiHDov0zqDkL6prYZZ6D8kUdIWlqN7z8ySgGi4gO2KMrkCatU7zrr48yDjb/OK74vS7rS2Vl
 37qSKy46u0KaHLDEzHyHbKrV2hLgjfNwtUgIk4ibGU78QQ5k3Zmcmo++2VuU4FxN1NFJ1sqrc1D
 T7JdZi2oxssMYTqk09ZvE6AGMogdQQbvFybfmY5K8xs4eChujh4EhlXuvmap2JpphdMJfxoKt5a
 YujHVA5K+00aJcIRNgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270109
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:21:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18887

On Tue, Jan 27, 2026 at 7:38=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Tue, 27 Jan 2026 at 11:29, Antonin Godard via
> lists.yoctoproject.org
> <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
> > > -    logger.plain("\nAvailable bitbake configurations:")
> > > +    logger.plain("\nAvailable Variants:")
>
> To be honest, I am no longer sure introducing 'variants' as a term is
> an improvement. Someone well familiar with the terms will get it,
> someone running the tool for the first time will be baffled. 'bitbake
> confugurations' is more familiar and straightforward.

If everything is configuration, all stuff is the same for the
newcomer. Bitbake configuration is the most generic way to refer to
anything. If I have a site.conf with DL_DIR set there, it's a bitbake
configuration, if I have a KERNEL_DEVICE inside a machine.conf it's a
bitbake configuration.

How do you like Fragment Set?


>
> Alex

