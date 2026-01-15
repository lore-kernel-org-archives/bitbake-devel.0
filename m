Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA2FD44C5B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:49:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37419.1768488585392804681
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 06:49:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=SxGnSeXk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FBU9ds2165358
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 14:49:44 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpydugfp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 14:49:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c337375d953so569650a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1768488583; x=1769093383; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKrYyMa5YkLA7Q/rXc/aYGnfb4TJxNhMsSBREcK2SsI=;
        b=SxGnSeXkLFAfngYfdkWx80Vsvja1xG2iDjTDVACa1RBQQEKbdKMxbqKpYGcrRTCDhh
         f9nuNe33qxvysb+YzJ7pf+ua6J2rpKObx93VzkR5t51vSsxcEe+Bcx+Ie7icAx2R1t/v
         yoCrM9iyOIspNJe6f1FPfuGUWONkEsfSjzlHrsvp5Bm3N3qUm00ucxihCfWrgoymAf2r
         0BSGUx3z6i8lFbeJRAa1NRmoG1OLH/e/nRb0bPBWRDDLSy9lr4J4ALre6EAparrDN4Z/
         pqsFA1MrSLpuvpCDuPqsbvMKF6QkE85pidzJkKBzsqFn5B/UVbsf2Wjt8INr8yZ5+L7v
         i4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488583; x=1769093383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKrYyMa5YkLA7Q/rXc/aYGnfb4TJxNhMsSBREcK2SsI=;
        b=MSXbK1yDiHySoVdpxuxUjfDyQ6nhsI+P70wKUNtLmhhYmXvNWxABBcQnnYhC1/0bbc
         2fI+TO+6evuxgVTr2MJ6bxgGv7mtcxhPTShzrTtlsYBtiLjJRa+/dGqKsomQVYuhns0N
         nL7YvkUywT91DyGzErjzva0vsAZDLlJisVjqwfKWPccsN+7qnEBDX4ThMhy/tpDbgPw1
         SQpGNBF+yr71wGxf2868p1ZpfIC/TDgF1C/+INeICewgLee4zPvT1ylH3iN88wqt5dDk
         BocX2B0AGaWnUwvddwcrzXXERTzgVyA/0g7qFJZXTdtQGe8ftHD/wzngAbnSiWMcJ0Y6
         50nw==
X-Gm-Message-State: AOJu0YwmO7xYY4o0UuswA3CZVzNmwBtLdpcEOd/sXsEfyb/pXAcayhXc
	VOavyjOmR+7UyIgwO6HWgNRDNYlOzemeO1BkFQ3Xw64UW1EkP6pQud1CMeNOkwQC6GImYS+RC45
	/ldsR4fcKfSw6a/5oJp0SxK/mSprUMPi3mHkUyono7oMKtET0Xy80DciZvMx53i83kZCWdoLo9f
	0VyMx9cuZbSgtlnrJItR9tnNBt67rJOFmfIkGbmf+MmaR/Jkzn9DQ=
X-Gm-Gg: AY/fxX7JI9Y5LFNXjKR0lFH0pHA89Q9soTBjdzqun4zFuOJKPTW1TBBgP7aCeh7uJPL
	uWRyXzWJqPILGT1qf5ZFzuK5W4lxlo/uMDoY5I0d9yf+tc3BR6YRD8K8zXJgaEvdGYLVFI+UBSw
	P8qCaj5ARodCHGONcAh2TfrnH2wdTOTCdYB54tKMOtf0YwQIIQfv9r+qeZQzeZMgBSRDs+xDJlx
	ccMDDeRLyNNYT1Ayi4p2+WG2Q2t6DxNGYdQqMNjQ4bdqQx1g/H5Srk3
X-Received: by 2002:a17:90b:1cc6:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-3510913e871mr5767689a91.30.1768488583307;
        Thu, 15 Jan 2026 06:49:43 -0800 (PST)
X-Received: by 2002:a17:90b:1cc6:b0:33f:eca0:47c6 with SMTP id
 98e67ed59e1d1-3510913e871mr5767671a91.30.1768488582862; Thu, 15 Jan 2026
 06:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20260115132223.2034792-1-daiane.angolini@foundries.io> <CANNYZj-5nZLvez9VVz1UxYotBu3xZxY19hagxJ9srrgrBjDzng@mail.gmail.com>
In-Reply-To: <CANNYZj-5nZLvez9VVz1UxYotBu3xZxY19hagxJ9srrgrBjDzng@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Thu, 15 Jan 2026 11:49:30 -0300
X-Gm-Features: AZwV_Qii96OlJPwgsaD9prRqogVIernpoRyHBRvkJkagcbs9WvZPJH30pGHBKMo
Message-ID: <CA+HEL7_1fF5tNAvzTfSgHLtpR2z7B4udYQdF_pkjBv6csj0cww@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: verify if a configuration
 file is html
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDExMCBTYWx0ZWRfXzzih8lzVMZFg
 /w4Jl+whDC+oEXV/4S+GYeceStkLPT1OLaWAF/AxkNuwB0jaN+dkDtuvKNWXRiiO0aO4jIyuzDQ
 axucUW9fysakL7IChCbzm8qFEsCTU3YgSkxQ/cdVbY1NTRlnRetBvicRhSTf/VUe/Qwo2Osa6xE
 +Vvbkg+HJ3YKw1Htyu+hBhrNIJ49ZfP6yzZfE0xiMFYi8GsJ1170xu2kwAoSErjAjWLQNHPWqeg
 1QT07M2d/lD5Eh1ai7l7Q0edybdbEDsrUpl6IdCOc5AhdesYPGFGYbCQtJ8c2XknjlpxbIpO2Vz
 rXfGXDxa8/fT5IUcxkVWUp4zERN/ccmgv/MlDnowb6I+I2ATTjP8li4gz7hsbCVyUC3pX7lwtwR
 bNQFmZZH/VelCofuGB9wBqErxvP+eDttxAS2DiD5ebyi2gi1uvqjsllNAcj2Tykjj1JR1jFU73P
 LxRv429OFyExyYbWNcQ==
X-Proofpoint-ORIG-GUID: uJzqUtno3HvZLKqd4T8O_tAg1s7_zCq3
X-Authority-Analysis: v=2.4 cv=NafrFmD4 c=1 sm=1 tr=0 ts=6968fe88 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8AHkEIZyAAAA:8 a=pGLkceISAAAA:8
 a=Q4-j1AaZAAAA:8 a=2V6DY6BgAAAA:8 a=NEAV23lmAAAA:8 a=HdMDhIewZqt9SfbRrD4A:9
 a=QEXdDO2ut3YA:10 a=OryzfZJIzKIA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-GUID: uJzqUtno3HvZLKqd4T8O_tAg1s7_zCq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_04,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150110
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 14:49:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18781

On Thu, Jan 15, 2026 at 11:14=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Thu, 15 Jan 2026 at 14:22, Daiane Angolini via
> lists.openembedded.org
> <daiane.angolini=3Dfoundries.io@lists.openembedded.org> wrote:
> > If the file is a html and not a json, lets notify the user.
>
> The commit message needs a bit of additional context: when a user is
> copy-pasting a URI from a browser, they need the URI to the raw JSON
> data, not an HTML representation of it (as is common with web UIs to
> git repositories for example). JSON decoding errors are not helpful in
> that situation, so let's provide a better message.
>
ok

> >
> > Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> > ---
> >  bin/bitbake-setup | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> > index abe7614c8..1a1f0cdd4 100755
> > --- a/bin/bitbake-setup
> > +++ b/bin/bitbake-setup
> > @@ -528,7 +528,10 @@ def obtain_config(top_dir, settings, args, source_=
overrides, d):
> >              logger.info("Reading configuration from network URI\n    {=
}".format(config_id))
> >              import urllib.request
> >              with urllib.request.urlopen(config_id) as f:
> > -              upstream_config =3D {'type':'network','uri':config_id,'n=
ame':get_config_name(config_id),'data':json.load(f)}
> > +                content =3D f.read().decode('utf-8')
> > +                if content.lstrip().startswith('<!') or content.lstrip=
().lower().startswith('<html'):
> > +                    raise Exception("Invalid configuration file: recei=
ved HTML instead of JSON from {}".format(config_id))
> > +                upstream_config =3D {'type':'network','uri':config_id,=
'name':get_config_name(config_id),'data':json.loads(f)}
>
> if f contains valid json, then f.read() is followed by json.loads(f).
> Will the second call still obtain the needed json data from f, once
> it's already been read previously?

I've decided to go with the flow, let it fail and only raise the exception.

>
> I'd suggest simply:
>
> try:
>     json_data =3D json.loads(f)
> except json.JSONDecodeError as e:
>    ... (do stuff with e.doc per
> https://docs.python.org/3/library/json.html#json.JSONDecodeError)

Thanks, will do that!

Do you think it worth trying to guess the raw/plain URI and use the
guessing instead? I know how to guess for git.openembedded and
github.com, but I cannot imagine how to guess for every single
possibility in the world (that's why I haven't tried to guess)

Daiane
>
>
> Thanks,
> Alex

