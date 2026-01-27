Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8ACD2F02D
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 13:27:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10674.1769520467456868888
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 05:27:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=Q5GhMyMy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R87K9V2379270
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:27:46 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr90qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:27:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso5763361a91.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 05:27:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769520466; cv=none;
        d=google.com; s=arc-20240605;
        b=H1dp1V0gi2kBVXIQ8LXb7cRKBDVaz0Bx/Ig91ZeRVyMDsyXJ9o0DVdNFgBuc8bPgzA
         sou3nVGRzZ7yUhDAQKpUYRUB6FSBiKqPkTfmrPp1a9JW3WcWDLv/9Qfx/eAtCZGwcuj7
         /w3qIKdgmVwrAQhNjxoznEZ5Y4pgZ795erFN9lcGj6wck0z1mtf9UqUSBS/AWNIb/bC8
         ZvjuWiG09Hg77JleUeVom/jQ0OdKImoB01aQjgdK8saiN4uN3k+dzmruEEZTdd/HSR7l
         9t4+AH6YmPFnTdEZFO+ddKT3M8AWz31Xn1PDh0iNFoNErgHhUJqI5G/h64+2o5N6IThL
         ERDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LVlj+0XbeeQhSr59/AnGewyFag7N/yXgB4iwOUTpqU=;
        fh=U+dDV5S/UeFKnwwrcssMbPy7kn2CB4gTS0T3rHhKzGY=;
        b=iZ0GVGnJoSUx0UHrS//rMaNUgp1pKG6ToqJPfRe91NkzoW81ZQGelUEGZzNmNSALfk
         AHD+KzjS9ct+wV1cvOsBpvBczVJY2ksr2UfLt2qlEUJCxYE0CSXqm/2zOzsJMbf3s/Vl
         xWAkYFH3wFfWeYk2dO97pj2aEzcVVYJRsE78qv6L1S7fJK3NnmoDtvw7VJhulyWIAl/e
         SZ8MycegkrIawMsuCcylDROEOzmVqalYb2clXxt+HRKItut8TZvUanjkm1OfeCccW2dM
         YYXjHUUi5nfYZ/PRabAiDd+dqknC/kn28tvukSRSI9QBURgnYRauXixgmZKMPbiIh1Lp
         AzuQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769520466; x=1770125266; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LVlj+0XbeeQhSr59/AnGewyFag7N/yXgB4iwOUTpqU=;
        b=Q5GhMyMyZ4UuHb8fu3KiLV4AQcCumvJjF0bX1Y/lehBWZe8Z6EhwrEAzqCLRdgB/+9
         UVTDesGWENUQ080CsnPJ0yz6GxSgeycKOs9/Qb0JRZlg4fACxsIUxOWKISXak82aFl/p
         U5R0Bpr+vkDc9RlSJK0O7W8tEQ1wpA/9FxZ61IVEVZHzR5yg0XW0T2py7vXaFDgySRlA
         J8T/wU95fy72UMDIQB6zmYg4F5LwazhewgMViskmWjRcpQdkH7ak+NNmmqsJ88WjN490
         /A0cqKiBO1mAJBfBxfKL/Ti9SOsepgrEoUU2z7LbpeAxW/BEepKEG1MyLHbTXwEZo9Ou
         0Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520466; x=1770125266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LVlj+0XbeeQhSr59/AnGewyFag7N/yXgB4iwOUTpqU=;
        b=JIIWoR640juwMkfZGXiedcOH+SfLU+MCrMjuH10oBPwqmgZQOX0+GV1dcCuimV9n17
         g5PeQ9pWtIt88l6yOYx/x5qoJpOtJ9lytnG6Ou60oz1cuIryoYk0wl66qYYUJjq+/Zhc
         lookh6CK5XB6XH4v9/zQuTS2JGU56T+sK7v1rIhnbk+l42mXZ1w7BxJuBkEk65GCcoFE
         /1ydyH2USRCTZgWpNf9u6dVY7nE31CILMg8fsz4/dGa7st0Wsodu6cxIhBTsJPLz5Hbo
         l5mP/BF1oIM/qgvHoRhdbflDNVuAqLkB0Duwy5QK22nvk3xaDhL8rl37mtyKZqsvZD0W
         2fJA==
X-Forwarded-Encrypted: i=1; AJvYcCX+NX0kWtksLkZihez5Laqc0xEwmtPhgH7M4zOXAVKDeSQoIievuAbPPcG5+gmnSvg+W0mvgaBtbTLIamQE@lists.openembedded.org
X-Gm-Message-State: AOJu0YzVofky42FCjTlii7jPBRqW1jjy6g8TIXFhuyfFURj9tlr5x07v
	p8/aVDFHbCAR3QVO+SdFkxmIUw5aok9OsL100SJmcrBN4euah5DY/ZdnAbElYhi/69x0t+hBN4k
	y0h8S6MBCNcvyaXyZGPRxhh4+dgxe4aE0+4ZGqcNmEyoIDQOvqxpiUdpJRw2o/gXmu/DJIq2WXl
	R4SCDES8LOVkNbNqFNJaov4+xJXr6Hn1c/Q88pW8rhaBQG2eEjtrk=
X-Gm-Gg: AZuq6aJFIZsJCqkZzSB5hLa33lUcmG2UoW/gwXH8Z5KAGQqq1vhz1lFmJe0w1PXOMdy
	OYUajBVunfnCboXcxmDE5RZ11PKl17Yqc4e0tJB1x6sMaP3BRp3FleDzraaessm7lBZ3jGFA/0P
	ShfkFhpz6mFHRM73Z01VmhzgmzYl1yEzZU4W7psGPfsdkH8UdQOyE8K1ornK/cSXhFg/EZ+IKl7
	2p7LgZrX0zzkqCe2MSHvxcFmgoiodLJfDhhguHDF5nFLaurP+jzVy40
X-Received: by 2002:a17:90a:e7d0:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-353fecf48d8mr1760749a91.12.1769520466008;
        Tue, 27 Jan 2026 05:27:46 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:341:3ea2:b625 with SMTP id
 98e67ed59e1d1-353fecf48d8mr1760725a91.12.1769520465390; Tue, 27 Jan 2026
 05:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-5-daiane.angolini@foundries.io> <DFZAULAJWR0S.1RQ0LXOE4BSUR@bootlin.com>
 <CANNYZj_Y1JiRoXK3iW2mwe1Cvga95icXtx3FzByfBzRs4upMuQ@mail.gmail.com>
In-Reply-To: <CANNYZj_Y1JiRoXK3iW2mwe1Cvga95icXtx3FzByfBzRs4upMuQ@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Tue, 27 Jan 2026 10:27:33 -0300
X-Gm-Features: AZwV_QiilGMoSrzfHmDfQcEXBIPQcl6v38SfgH6ld5djXcUxPiHz-BVTQ28nwCc
Message-ID: <CA+HEL791UhQ28wsGx4zofiadgbgx4kfYDG+fQR6P1PrTvKQeeQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs][PATCH 5/5] docs: Fix sources as required
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org,
        docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: iJRFERDrcTXMBNrtaR4xeVbKTLXEyYnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwOSBTYWx0ZWRfXxjX69rW7qTEC
 SvRf9hS9sYjl/19lTaTo+7083GMrbSDZzuJKY1K+ia2Stcmdll/RiWLc2rAP5JB707ZuMm0wI2q
 UxiKLwvS4YTCdwgh0TSmW8ElWbvom+1wFgBxodnr8Rw8DR6v0Jbp0zaiCq89mXG4j9YrRriiqdu
 hs3R2j454P03efu/e4fEvuz3g1CPcDg0QVOOQsDPOOxEafHKZN9wVci0UV/Si/+QjLEOwOilimG
 Z2suR4gCn+LzI6m2aHQPDoMFe6Vu4fI6ao/V+xjY+kRQfWrjW0zqz/0uzupjwrzBT+KJAz9O2uj
 C7xx5DsPZ8okOpwUiMUKhO1EMlUvCtHc8omQU1Kg7t+nO3chDO6oX8yCJvK6tvrNPNujVWpddNe
 Y6p0P6A5+wvP+ln4LH1OY1c08LLY/6REWrLFfzXYBpOx/QeEm5tKM+z69Oh4PC2T+sp+61obiAJ
 +XqCc3NUQ9aEk2wq/Qw==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=6978bd52 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=iGHA9ds3AAAA:8
 a=X6vjHCo-xMRvEbcC8qUA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: iJRFERDrcTXMBNrtaR4xeVbKTLXEyYnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270109
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:27:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18888

On Tue, Jan 27, 2026 at 7:50=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Tue, 27 Jan 2026 at 11:28, Antonin Godard via
> lists.yoctoproject.org
> <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
> > > +   under ``layers/`` directory of a :term:`Setup`. Although the list=
 of sources
> > > +   can be very flexible, at least BitBake should be cloned to genera=
te a
> > > +   :term:`Setup`.
>
> Not necessarily. It's an esoteric example, but one could write a list
> of sources without bitbake in it, and leave 'configurations' empty. In
> this case bitbake-setup will clone/unpack the sources and stop there.

For this one, I'm really guessing. Because, when I made a "wrong" json
file, I got an error that bitbake source is needed (so I added
bitbake).

But when I drop "sources" completely, nothing is created (and I was
expecting at least the top directory and the .conf files)

So, saying it's "optional" is not accurate, but saying it's "required"
is not accurate either.  But I don't quite understand the constraints
here.

Daiane
>
> Alex

