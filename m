Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE0D2FED5
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 18:17:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18587.1769537849435502943
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 10:17:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=I64LO4Dt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RFx0KQ1714647
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 18:17:28 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by0g08h3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 18:17:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ec823527eso10017623a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769537847; cv=none;
        d=google.com; s=arc-20240605;
        b=P0AQ31zfF4AdSB8ykbDg/PyntAmO7ez+75RYa8GHRlZS/Et5uHISGNGuv97QYR7T2t
         RwQkz8d4hz+DbNcmEhqaLm0xC5srkcsHum6PFyIeMZDpa2dADKDqjksw4tFjETwJYnDe
         9GMDJnHlwYX8p8uI2jTvHU/25yycl9os/g6pj3YBcB123iD3jpop8s4aqZGRY95ekxuJ
         JUX77aYxi77dIa36Hw9EdAF8p5YV88Of2yLqpYKq7lOnCmr6vArDDCNX0HBCEsuU4ZUf
         4lbnnQUSSfAzcPAMmdwtfABX0up4gdH0ijSh/Gm3UeHJemzXdqIYlzpYH92XvhRLUnqr
         l4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hT7oEiipyhtT/w2BNqfazuSf7V89RXDuVDA53iIL4A0=;
        fh=NKkLj6L+nUbD6hAjAWotzbluVejeJE7nVmH+pBQI1yg=;
        b=ekFj5p6du+e5jlC7ATFktCd8tT3yHfE739zXzOPvehKKEEwyFzLkGM9t1M6+XlFgKc
         lxXgF3eDbTlSl+dtrNNojEwr5PaPwrKWpRj1bTHKFHdvlpFw3beyH6Cq1DB9ksgmmpTE
         /Fb3WuzyDAovapfXhW2HUknRBYX2i4B4HWOL298awdBisHe5ijUHPzmMTOvOzZe6yTGF
         h8eXC0iavrhrr7p8RbTwVhuyRvFniGIg4YwmvKZLol2bvrw2CfANP5+nj6FWCCKu9Ysw
         pCshj/Yk7oSi6EUTEjX+rfRPeQ8KvZSTXY/iCrzdkgfGST7omrdYlS0+bzR2jLH6e6rK
         Kacg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769537847; x=1770142647; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT7oEiipyhtT/w2BNqfazuSf7V89RXDuVDA53iIL4A0=;
        b=I64LO4Dt1h5rzgg6rXW9XzYs60nD/yScWQoSDl3V5YErbTEkn2VejTJVvxAm/N1XSP
         BHG6KaMqh9uMy82Tl2xHR7tQK1bBNgJW780MhB+swdJxuabaQ6CPj+OYLBxH78ehnU3K
         aBBYVYjYe0BSNYVR8jLMnqqfGDWoNtOyonYGGPOSDaZ833NnYkO32wO1WXzwqlQ4zBcq
         F4N7JTKfN3TUNaRLArMyXuP5kqrnO9EgFz0Irh0pGldujuE99A4WxkPqYhkQMacAZGms
         srziAeCz4k/eVYUnEKb0Sj8B153jZ2ZulwTlyKM+SVA5dkwJy838zs5QYOZkWRDz2SwN
         O+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537847; x=1770142647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hT7oEiipyhtT/w2BNqfazuSf7V89RXDuVDA53iIL4A0=;
        b=PALs/06ouZSqjEs4QFWp625kdnqGIXzS+T9b8sOhMxjOCBOC873hfs/lyW+j0JbkJe
         S1DrOk7t3oVZMKuSahe6yR6YymvE7J/d3/IE0E2Odpe8z9wnqEMHgATI72w1Hi8Tx6Bg
         4FwIJ4TWFc3cOreHM2TXPzHSv1sG1Gp24BaVHPvwSm2+vaWuqv0rbLZQo5Iaqa4gBdhc
         QvJte0dfx6CdUtF4Hm44idnPKQdOmeIsASbbCoXdfYUi0d5w1Ji8/Bg9CnAzzCXE8X3B
         X1oqX2Wekumc1D4TqHm6vGDeGfxS7TblkqoeTI5wY9+DGsq7C1kyyYjnWVQwuC6rSXDl
         WdAw==
X-Forwarded-Encrypted: i=1; AJvYcCV71JLqcvrOrRjdHX0ew8vJy0Hlhv6t7K6t94FottgnZUiAnFMZ7VdtH41F9KmKErvUL6xqPw+zvuqIsQEl@lists.openembedded.org
X-Gm-Message-State: AOJu0YzQStPwr5nSV1Ft1KD1amxEsQVeNd5cNWrfuMrWAHggEGVQgHq9
	VyLiYrJ2LzEAogWkzUWmBvnKbAQR09Wt/GsV7Ixb9Tl2JuFCg7oNHJv38XHaWcBPmJtSfe8z6N9
	QG6NmLG03ueFbvgacv+5y0O1f13qOFD+uIArfnzQUJ7g1mkaAmWiv2Ec2MzW28I4VbQHKwj/6Pr
	J37FvEJFxMD0ydXlSeYh3Ui4AoOWtFpqvg6OgmmFN3QU4f9riK6NE=
X-Gm-Gg: AZuq6aLfkiyoFsn7cwW+vYkoWQRrVcm9FobpadAs6m/7by2pD/4uyamz69xKP6OKS7P
	F0BnjThOTjzzauNa9RdRbyeDf9Qgl3fE0e3lJwyQx0r8KPeY6IrQt5huh/go6GMc4F62bYKVP3e
	hZt9yDBHdIhs46lRXqmpQfApsCDl8dmmFibVaJKiGyWG4xFnhBBIlFCm/G84qcJ6YG0FxvggB4W
	Oy+sH2DDAIYk72FX9NzWf83GxiWm/CxZHFH6w/vepikxgoVrrediVL+
X-Received: by 2002:a17:90b:3901:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-353fedcc422mr2480304a91.37.1769537847098;
        Tue, 27 Jan 2026 10:17:27 -0800 (PST)
X-Received: by 2002:a17:90b:3901:b0:353:e91:9b2f with SMTP id
 98e67ed59e1d1-353fedcc422mr2480281a91.37.1769537846766; Tue, 27 Jan 2026
 10:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-2-daiane.angolini@foundries.io> <DFZAUTK11Y5A.1PPDDZRLH02PU@bootlin.com>
 <CANNYZj_DhwvpzBcG0Vi7E9aYqx7b30uDUxJFkmdE686f1+Zkog@mail.gmail.com>
 <CA+HEL79Bs-OaWjNa2OSrVULiBqpeXU_0m1u=vUwgh3cXWXY5uA@mail.gmail.com> <CANNYZj_o9A8hpmnwrJ3Ng+ZvPLHy+AbGnRcS3QJm2nUDT=SW0Q@mail.gmail.com>
In-Reply-To: <CANNYZj_o9A8hpmnwrJ3Ng+ZvPLHy+AbGnRcS3QJm2nUDT=SW0Q@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Tue, 27 Jan 2026 15:17:15 -0300
X-Gm-Features: AZwV_Qjc01R1xqwrv6ieBYPZGrCZoBkG0E9AggAi5WI6l-eb6jeuGGYxP_fUJkk
Message-ID: <CA+HEL79+C2zsSq_dC3-DjkvFS74OqPs-AB6eCdKrUQ2fmOOoHQ@mail.gmail.com>
Subject: Re: [docs][PATCH 2/5] bitbake-setup: Change the output to match the
 terminology in the docs
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org,
        docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iK6Vem4E7Sd0D86PjGZEWcztcSbpzHaS
X-Proofpoint-GUID: iK6Vem4E7Sd0D86PjGZEWcztcSbpzHaS
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69790138 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=LVY25okwlNza5Yhv:21 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=OTZOkuoYe6Fad0i9pToA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0OCBTYWx0ZWRfX6rl0hfFaLBQw
 F8Y2JfBEulnoxD2accDDVrpwWdtr5TD65KooT9dKz5HT71MmRzX3HhGL0qvAcxHC3grSAvrXaId
 SC4cYKHmJKEePuMB0Bai2I184iU560+AQg5Lf9uDuU2GBEhTxXx1CzOzVWDvNMfWzG3aFNFynV6
 h/VG/g+x/Zbzw5F/gpiOnJYQ49FzR+bjSBq2K8nxVVBp2l0731eyi1I0+6wd1QnGcP8xbl9xFrl
 CQXsnJNbwiLoIdlBWz2n3ElIAZIwzEt6oSU9JJThaFUeq/Eo9QCCMX+lkq6Dv3Z28bLEHabKYcP
 5WwBS05UpPVYHp3J1Jy7lqBk19Tk41D4MhgJmP06760Ms2Bo3MY2nqND3vMgtcM0DgIS5XkhYIT
 hj3kd/WG2hbVTS1ZN12cB2hus92Y3yANxbkTj0JoHPc/jj7Q7QausbB7qSZ8puE93sQpn8r1wbl
 80+5bJDCOb0PN1NF1ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270148
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 18:17:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18904

On Tue, Jan 27, 2026 at 2:45=E2=80=AFPM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Tue, 27 Jan 2026 at 14:21, Daiane Angolini
> <daiane.angolini@foundries.io> wrote:
> > If everything is configuration, all stuff is the same for the
> > newcomer. Bitbake configuration is the most generic way to refer to
> > anything. If I have a site.conf with DL_DIR set there, it's a bitbake
> > configuration, if I have a KERNEL_DEVICE inside a machine.conf it's a
> > bitbake configuration.
> >
> > How do you like Fragment Set?
>
> It's not just the fragment set. It's also what layers are enabled in
> bblayers.conf, and what is in site.conf. All these things together are
> collected in build/conf/, they define what bitbake starts with (the
> metadata in layers is pulled in based on what layers are included in
> bblayers.conf) , and they are commonly understood as adding parameters
> to bitbake configuration for a particular build directory, on top of
> layer metadata - if you change those things, then it affects only that
> build directory.
>
> So maybe 'bitbake configuration' isn't unambigious, but tweaking
> build/conf to adjust the bitbake configuration without changing layers
> is a well understood concept. Can you suggest a better name for that?

Not today. Today I can only think about "former local.conf".

I will prepare v2 without touching on variants.

Daiane
>
> Alex

