Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E90CD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 10:23:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15348.1778063025212941315
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 03:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=EaFJW61b;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6469xtVM1985549
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 10:23:44 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03gp02cb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 10:23:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3594620fe97so14423136a91.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 03:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778063023; cv=none;
        d=google.com; s=arc-20240605;
        b=BBIXPq5sGoXF6lMd3m5ZMvD07mX5mrzUPjaalfc1ZWt/aCO6ssapwPDpCpfN+jaXrB
         lCs/ZFnCYapx6CLkkFF/8W5or80nuVrat5ecYS2CThjYf3A++XDycNmxOTztTYfad8zR
         1TaEvCg6Vq5IG216mH4Uepgb/6Ap/gK6Kg6FFJj2C8bRZeqUxmvf/M5fgFEylz5dQhZq
         I+3n0eaOMA5xfCzVBhjCCd4fokBbIobGdSf65uJoOBrd8ezBp2n4kcNf8AYxyV+xA34z
         spxC/OH4AIhoRoNcRkuZ1lnDoH/iQw5oLvxTu1Otihxbab2yPv4+qEnbb9C2lsDbUVcn
         ZTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6zQ5jOrqv9e9iFAB7euxVylQyC3AoAMpSAGsWRs0nMw=;
        fh=g2Fod9whPmIvB3dbnbynLSdjwf1m2/di5D9Ffz1Cmmo=;
        b=EUCsaQJp3FNpRAdfMshFjYKJU0Cf1toSh/NDZ54R09TBEcrEDOcvCRDOB39Eqb+naT
         RXeVsJRmbKlokqzIXpOrxRzvMupdUlEDiEUBun/TYe3B/q7p7RNx4ekyI9gS82l763OD
         J80dfVcJyjFpgC/mQn34Gnbc98z8j+Zuyr1DZgOOWI+mXgbzFbLChHEOVIvxff7Wyv13
         MZ4owmaNhtHdM3/Lx6eRVlxji1LWVNbq6UKMKVPlgiqJBWmDDitSNXqfq0PFBPC9EWnj
         wheVjp1gQedLyJeivPLP3heStonNj1TgEoPRPpcUV82YbxEdoE1T1B3nlyxsKmh/ZwOb
         jE9Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1778063023; x=1778667823; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zQ5jOrqv9e9iFAB7euxVylQyC3AoAMpSAGsWRs0nMw=;
        b=EaFJW61bROddSNQFRAMyYHdQ4Yx7fPJ3XWRXixtNUEL8M42L5sEeRUjUy+cKTWL2Ug
         DOv9EnZ30byRBJbfdVrxJuDf5XgPzwQAIooX6l1RH+wAKFmpwfLnT2BlBmmk99hzpOuY
         vvISvpyhG7cX5/3oDePF/168aQ/98K96O06R3ku5vY5UPWOJvGPJ7UJaBf5HNd/eVywy
         h/f0IsfaP64BOuGK0DzUt9n4dKaKik/+qoboxVyGWJ6N7mMfF7/sRRaGNvRNsHH7CQwy
         Vh0QIM+P6zp9Zo6UPbVYnL7I6hSU930bz29nUG7zEOx3FgeBfK5rYSxF4rDZHY7iYgxS
         /CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063023; x=1778667823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zQ5jOrqv9e9iFAB7euxVylQyC3AoAMpSAGsWRs0nMw=;
        b=UNH8wTNiIBaQGjmNpKsRQ/+SxT/mUxtskXiPS8GNg6e0s3v8rysyk6Sr2+zcjlLWnz
         enK5aPf6R+jI0KGYas4prE8iW0Er5KvTnAiWb6Z0oPqeTIQP5Mwy7VfZl96Ne8j2qcEJ
         z6U0142ptEdmuZIakXhpXQmvLgDmtY+ZPbpV9Zmu391W/FwwEUsBMhY56nw8ZwKvpmqb
         7iM1L++7JTPf2sVtEDUgT3sGb0d4u0giLbh0xyoShhm6ubU0qY5G2zdKMjX2nU1DeRGl
         VzaLbfOezUXpJTM4I4vcMo0zKiJxBjRrk3jYgUbAKt27btmrrOXR8V3qreAKWRV1jeMi
         WyYg==
X-Forwarded-Encrypted: i=1; AFNElJ/nEkXIe7dGkzfLh8PqtcCWfrImcuoacBtkVvmB2lot9qFRwxWfBS7Qfmh/2LLY9nIuiNfH3ZNZ6d0ogZJE@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyzs/K8/M7p4SfILdH4Jtn00T+whwHIl6LpifsPZl6D8Cw6DbX/
	1I/Qe2pa6PiF0rPGycXHyAOtzY3kGL7vvzZrEYkks/AknhCbY6sKjd8ZRwKxMU5WK/IJelTjyNg
	EvkhVxKtGzcgbe5ixyGcdAmfKLrCL79YeSxaje1Qw3QXlGXGG7pCpemVrWntDxiOVnLnxXAam/b
	eRsJUjGpCICkdvyvJNyP7692+M6zqt0hM/q3W5oWtcbu42VixJEEM=
X-Gm-Gg: AeBDiet5heEQFPz6mKwunakQGiDH2vWxjT86LiaGfCHij6qHhdsg81alUO4QhHIyM1P
	XDAgyD1BV5PTCcid2WsHHks0BCAJvzI6/JObCYNrpVDzDIT3yI46XOBOdDEVdmZlFygE2Qlg99k
	J/WjNs/ncwAWMX3HwGEOhsGWVqQhcvmNEvZ9epULo0Wo+/uuVI9u6VnNlq/qyfshu2CtLVU6IEv
	A7ZfmQFXdUHZp5cjpwvPGEpVxGUNNAscaEQvUyA4LrcGLVA0rX+crm00u2IM8XD56bibS6hk5y+
	VVU=
X-Received: by 2002:a17:90b:2703:b0:35d:a861:36de with SMTP id 98e67ed59e1d1-365ac769f1cmr3126203a91.24.1778063023118;
        Wed, 06 May 2026 03:23:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2703:b0:35d:a861:36de with SMTP id
 98e67ed59e1d1-365ac769f1cmr3126180a91.24.1778063022736; Wed, 06 May 2026
 03:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com> <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
In-Reply-To: <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Wed, 6 May 2026 07:23:30 -0300
X-Gm-Features: AVHnY4Jyx1_2tCHKcpJEgEWTQLgZF8UD-4PLOvIOnd3o0WSLl5lYVomTXD7_R-k
Message-ID: <CA+HEL7_H1MJe3WGhdP3TMQho8u0M8g5OfUv2oFXxQjefAo6Hnw@mail.gmail.com>
Subject: Re: [Openembedded-architecture] proposal: build pipelines in bitbake-setup
To: alex.kanavin@gmail.com
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>,
        bitbake-devel <bitbake-devel@lists.openembedded.org>,
        Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEwMSBTYWx0ZWRfX4lAndv7KLk1z
 +mpdafZZXiiTPEPAkcW3CITPy1vGUkOK+djYc7N0MCrjCw7JgTqs3boS1zff7lTXpmj7jupBZnF
 XfF0a09LipXjvMXClbd3SYd3nPVXpdIHUauV6zDQEgeve1AC5c4I1Bhejd2Bets8IZ9leDQW1nG
 uVhhRUjjh/84sxGNwMJruqhpv9mJHmdZuJGbyH/907FeSrqAnI92ExeM+C4PbUE+nI96FQEydmn
 KClVCG8ND9Zu6wc4kO/s4Oo0lbNTqMS+VxgCnnuSCH+DapnjIZOcsTpmOY3q9/LTi+0TMVovwLp
 Wq7bIOF7gN1wSidSI/edkxQor1aTaKHvdf9ShXa5LTPEp2PaOoFO03ZMrs5EjyUwoLIosniSLWx
 /W17DNf5a4kijifVvD0rXz1WPXiQVj+xic+mnYuV4wFNkbK4rZPxvlnl1e4iZP9FCo1BblbGMlW
 0ZJDRFjE5VL/SyE1D9w==
X-Proofpoint-ORIG-GUID: paf4CmzDYajzqyT9iEFHJHEA_4Ukx3PM
X-Proofpoint-GUID: paf4CmzDYajzqyT9iEFHJHEA_4Ukx3PM
X-Authority-Analysis: v=2.4 cv=W8wIkxWk c=1 sm=1 tr=0 ts=69fb16b0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Q4-j1AaZAAAA:8 a=r_ZPwY8akaNxwzTECaEA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060101
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 10:23:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19441

On Tue, May 5, 2026 at 3:42=E2=80=AFPM Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:
>

> 6. Run a pipeline, stopping after a particular step:
> $ bitbake-setup build <pipeline-name> --stop-after <step-name>
>
> Etc. How's this looking?
>

I like the term `steps`. I would like to add that this should be
optional, not required. One can still decide to avoid creating a
pipeline.

Regarding a setup tool for builds, why not use `bitbake
<pipeline-name>` instead of `bitbake-setup build <pipeline-name>`?

Daiane
> Alex
>

