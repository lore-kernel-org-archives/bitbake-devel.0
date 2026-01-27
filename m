Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B25D2FED0
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 18:07:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18534.1769537211650253316
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 10:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=OJwVuIGQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHVnfa786330
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 18:06:50 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93kpd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 18:06:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a07fa318fdso53781335ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769537209; cv=none;
        d=google.com; s=arc-20240605;
        b=TelWw7HnWo4oclvMX8UnJhvOYk8Jit6+WcvLYqHUe/0WbmgrCk907u2/MhFyx8d/ro
         mcwNiSRWRrh32J9Qzgx0dRKCB8YkgzotGEvxtIhrxWCstCa69W3fy3SEiqNZB+GPgF58
         V1bwUTcdJEHvAY51hcxDoDwmkRTRA7rX28i6+KFMV0DtO2/UIgoejSTY6j9P2QjbKbVK
         b8t8QPFG/T9IZyfgdxYNsuX+v3ord0aRjng9C6kB/iOW2Rljc6KgngXDdsl7TTYeLqBd
         50ZETVQGaPKPa5MjkNyBZXQckz8haGGGi/IBGl3jcsS5gNrblkN13ySi6NZHMfleq5EL
         N4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v84rYts3G0FceH/049AyyBi8qgyd6/NT/hFCfJ9kaD4=;
        fh=Reg383s+A38ukQUPH3hX48gx7ArLRe6nqVHLsGH/6dw=;
        b=huhzfKqwnj1FbapOvLGwAPZoBebML02pvtVpwAzgxeUQm7ayq2vvAq43TuTXZZ5GDR
         HXkKRd3BE23rDfoarIfbY438oDvV2tzMnfIk6rb9NCJmaFNJJDUhn9rKgysCbcOTnt+c
         ILT/MIHSfZtrSHUyDkufmBIzOrZ5pECPT9gHqRJLYtPLuYunJOphaPLxpCy76kVz8m+T
         WvR1kQVnXcdPj65tbZ+/iz4FNNqxQOHuBfNBwatkiRml+kx0byUwfbVwQZ7M1Bhopb1l
         d7RX4+6WiRYReyphN5Rj4ZGIcmjwFalrhaQQA83sJGnDjmcFsDJB8ly2yz1VNRCQT67h
         2X0A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769537209; x=1770142009; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v84rYts3G0FceH/049AyyBi8qgyd6/NT/hFCfJ9kaD4=;
        b=OJwVuIGQavI3pN2eHmzyY/5VD3E+S4JJZErQjP6MuGacknZLQH2/W0qvxTT0M6ab9R
         9EAzvjLvEjLwyR/QgoTWcUjLm6pNo1KHw7qCBdVBWyMpLwGKEtTcBbhcd5IEfYa05afn
         zk9sAlpV5+p97jmnTJmVMBXyPIaRlSh1yOJ+/RcX0RDlnrdWE2M8RkOGIHOjvwIANzhI
         Z+8sjmoVV9Eq4w/TIrcI4pCYl8NTM2JlPXGkDYv3jObzZwAZc506VfENV6E60MEhdpn0
         AFu/PepdwjjJL3bwjubS+cAH/3fwrdU7Zwo+Y8f1a6FwqoJHs5Qw7IKSzk/fuRLLkMNH
         Ez5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537209; x=1770142009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v84rYts3G0FceH/049AyyBi8qgyd6/NT/hFCfJ9kaD4=;
        b=sh0uCAl1wJaOsheSIcZaVq6oCc57KaQQ7/M/X5QgNkNW5wjqYKHgal6+DQ4Hy7JnuB
         dkZdM8cJ3ORUDIm23CRjgkj+mX/2IzTOlJReD5oU7LICHP9VHxQ/L1cxkRR3xkzwNg/c
         Jrwj+NJehtSUjPNIMvIuoorlNujA1Kg9Uq5US6aq3aSOndlNxkuBUP4emSU+jWQCVAnU
         iBKuC23b34CHAYxNtlc5LnoKmLmvdk/omPDYISS5jg+vwEiLRrvGb4aJa+xLjg/wXo0E
         dX6l+7mzlcpxp4c/S+0IJryDntpaox9BU8aB2AfkAz92Wf3oKX0sqltDgVRJmTcb+gn0
         G24w==
X-Forwarded-Encrypted: i=1; AJvYcCVP2UYs39NI2ktnVlV6C6RDzP8aDFHZtnHFPWuNaD/r3TvewHwM7/5w9c2GZS5sOCcuA+Z/bWBwOvRy1lsQ@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw2BswEOO23iZNvXUb+DkcsXhFy9D6JyODfK4U575lSMC+3o+fW
	N2S0hMejPjVafIYCN+E4hEsdy5e3k3wQg1GStUN50zqK6AZdIL04Ns7AvnLVBOMGF5FCcZziN6u
	F3pLWiRUfFWK9rGJ24aSMEvLKKEa1Rrh/QAqrPulyvV//fRziV6I7iYPOiZFHRJBzUO8mwamtvR
	2R6Uso6PaTQpSZbn4F0/FxLXOfT1svs52rXvCcUL0X5qtdTHtERBA=
X-Gm-Gg: AZuq6aJsrMJG3nyi2liPOVpo4WaTjZutabvDFXj49JN8tnyagoISMZ5vcGicabXEfe9
	t9jHi0FLajdhqVMrxBhIPVFzWlnoGMIBosakc+8M7ONzZffi98C+hDFDlgHWAX0UAIvpV5oUDxP
	FYnMDrmLMnSXK9h+s5cTst1xsqdZPRMLL7ftSF25JgMroSJjGoej+adQ+NOxaG0FIi03vgOlpAw
	ujYRcNdOqnxfKwt5oEB9mi3MGJm3ZLpc/H+FQ71cxHg5IoxgcjR3dqL
X-Received: by 2002:a17:902:ceca:b0:2a1:35df:2513 with SMTP id d9443c01a7336-2a870d613bfmr27145215ad.17.1769537209545;
        Tue, 27 Jan 2026 10:06:49 -0800 (PST)
X-Received: by 2002:a17:902:ceca:b0:2a1:35df:2513 with SMTP id
 d9443c01a7336-2a870d613bfmr27144955ad.17.1769537209066; Tue, 27 Jan 2026
 10:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-5-daiane.angolini@foundries.io> <DFZAULAJWR0S.1RQ0LXOE4BSUR@bootlin.com>
 <CANNYZj_Y1JiRoXK3iW2mwe1Cvga95icXtx3FzByfBzRs4upMuQ@mail.gmail.com>
 <CA+HEL791UhQ28wsGx4zofiadgbgx4kfYDG+fQR6P1PrTvKQeeQ@mail.gmail.com> <CANNYZj9+x9hxi2XFOM5G5FUCTT+tkrwmtoY89JrOSQMPpx2gJQ@mail.gmail.com>
In-Reply-To: <CANNYZj9+x9hxi2XFOM5G5FUCTT+tkrwmtoY89JrOSQMPpx2gJQ@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Tue, 27 Jan 2026 15:06:37 -0300
X-Gm-Features: AZwV_QgYBFyqn6gtrmxXtAyLEnZrMBZ7L4ckqYisXMA2lgDSoBTTKSvVlVqRHHI
Message-ID: <CA+HEL7_x3+=s_VXHPEhRVaNJyK95rOLGZkyU6Ovx4JPEqpB5sA@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs][PATCH 5/5] docs: Fix sources as required
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org,
        docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NyBTYWx0ZWRfX/BEmhATOVMgG
 0A7eHC3uoYGW+BW+LyVEeAkSxnxIn0UFTDkBZZsX2GAIXOySJPyohHFXIodsTpGCXS5Yp5Yo+rW
 Eyf1puPyHBTX+v1e/Ohe871IeLYJC3VWpL0EAVLclyh7kEoc5nzWOxm3jK0bNXIsgShZrWXWs93
 dr/xqg0JjfoBgaTSqLXaw9nFBGhIl4Z58+4qmb89i+ICw+bg34jRcA7tAuv/Wmqfk7uNBI6L6VW
 Tt8P/EcfVisHmSANoptMyBOkGGp02yIG3up1k556IKiN4grJ3Ti2i42rxFeLB7SY08OyJkuW/he
 owhW9lcIdlyIeq9PKOI/zq0saF71DLV2VhfSdH0hmmImQnTYZ1hhzGpVNgKgo62z3KOx4yPL4zA
 DW8Q2R5vO+FuPv7vFbFmEO9DGx8kZUBarANQ4AswoVvlbNHsw2xBbDd5Y5JvqIFz/D/n50+VHZx
 HSednrvs06K/JavNkJg==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=6978feba cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=beYWP-WcvahK77ATy8QA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 86CpO1EKouQFkrI9CWHBtNpELkZrrzAz
X-Proofpoint-GUID: 86CpO1EKouQFkrI9CWHBtNpELkZrrzAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270147
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 18:07:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18903

On Tue, Jan 27, 2026 at 2:47=E2=80=AFPM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Tue, 27 Jan 2026 at 14:27, Daiane Angolini
> <daiane.angolini@foundries.io> wrote:
> > For this one, I'm really guessing. Because, when I made a "wrong" json
> > file, I got an error that bitbake source is needed (so I added
> > bitbake).
> >
> > But when I drop "sources" completely, nothing is created (and I was
> > expecting at least the top directory and the .conf files)
> >
> > So, saying it's "optional" is not accurate, but saying it's "required"
> > is not accurate either.  But I don't quite understand the constraints
> > here.
>
> It's just that these are all not very common corner cases, and they
> aren't tested. We test the common case, but if behaviour in such
> special situations doesn't make sense, that can be fixed in the tool
> itself if there's a need for it.
>
> 'configurations' without 'sources' doesn't make sense though, as
> configurations contain lists of layers and fragments, which are both
> references into sources .

so, it's required.

Daiane
>
> Alex

