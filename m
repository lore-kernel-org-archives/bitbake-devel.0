Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4844BCA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 14:08:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16207.1791468492750571676
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Oct 2026 07:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Vwkhs/jZ;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=N72Mlj3u;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BK8CB1882247
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Oct 2026 14:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YeOrwreO+dCqsRX6yr/rAhV0C3YrIuMGCyzT05fAr1s=; b=Vwkhs/jZtHXKCKiD
	5ek8ARURytHCLyEgspkCYSvX+P6uRckZlNQUdfFwcWpgh6lhlhuA09/hDeXYsuzo
	8TMP0O68PpvBbFn9wgd/Rm90VmICPSsAdSJgJUwH4HRMbolUahBNIJLcazi/d9wR
	ShyilSfyIN+mRovQF/3EkvycmjdDTvAEO/xBZO5wH2aG9x0YD92IvwRoC97EJWX0
	86CaJwDtR8jHUfXFmr71s+x0hR9lqKgzQ6VEMIYnxEwdCta3qznjq27ZMhZpoqa9
	hsuBPmnVgi3N5moXYxWLpOPJxlB7zCIat1qT873v0AFR3QPYSO4dDL81Jk1D7Lyw
	Cdf/bQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2u7fk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 14:08:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e827b3a6b4so5500935ad.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 07:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791468491; cv=none;
        d=google.com; s=arc-20260327;
        b=LQz5yv4s4fFRO6rf6wJcFOhjg6ZjB2wUSkFnRCPLBitSU37mZP3K2pmwhsn7pdoRVH
         7x3I8EFW4EZSUif6QnnXi9FEopwlIJJ0m4RX1kIZyT+hZMuqxAkR4afbQaaIyghw9IN1
         s9BvYz1PkJbQEDSahckSWpqtoxDxeU6rF7xx1Y/ErasRr20oVLcY7WTpAhMrEiCykwwH
         hkbQ5a52VApZfolO353zPp1HcAHUv52blC75a1XOxPdeW8ShztTPtnGxHuRLsEah2+CY
         VM2znuyiMdkNW1s0K19RrlXibyFZyydpqCC5ZrCCvsYEWmsuFI0LI/O+ebB6q8xHZvZu
         NWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YeOrwreO+dCqsRX6yr/rAhV0C3YrIuMGCyzT05fAr1s=;
        fh=qOOAMKVA7u3aeVJgxG3SJq5uqGN802hSqygsgAcS41s=;
        b=rZAEtARbXaB3L4+WqIQhR9H8UsBdOgyTaMiBy6EJ3VabEGtEr799s9ADlzdJCh2km6
         /81gFe11d0jySr9DVEFzXD1LlisFXvCShDxdt31qmVP42y3yTJMQVmM2kRmpwoOpsYBM
         914SVd380QYPg4oVeMA2VjtydOpxnCTEgAK/zib+ib2DhmyGaf+4Hqm+8VtSG701rsAb
         i/xT76SxL4pwQ8iSVWzgRPz4IXu/pSkNEoZbRNtTprth7pQmjRpJI9c6IqFPq8O2PafG
         BQPN7k2Xez9o0I//7Xa7htIYvBJ6Fn5M/+6opdSM2m43BnFc60TMix9J9rEeoaNxCDKY
         GbHA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791468491; x=1792073291; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YeOrwreO+dCqsRX6yr/rAhV0C3YrIuMGCyzT05fAr1s=;
        b=N72Mlj3ueOHMMkumTypWHLAuprTe8awt9uPTXyON+yeX7YSdcWavBugsGpTFSY0sL1
         rP1TIVhyYZxPI55IY5wCfR1iw/zdijtwVKzThTjvIBrQoz0JvKL+ZUukO7412Yk4X738
         hbC+OMaoXEchFGlHuUqbz687h1TkYZuzTbWBUYVmhmhH0AvcdkBrUvdSRzKgSuVHTiHh
         7rufLdjIynjUSrISWnzCkK2jKu07P1A7f22UWNv7bErDLL/TfUz+3y88h8KxImbZOTFH
         XCXYULHxaPZY4KjQhW6B+o9JbLNO4+h/jxc8bVdcBdDo7La1o7fQ5HawLT+ajRD1igqw
         uhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468491; x=1792073291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YeOrwreO+dCqsRX6yr/rAhV0C3YrIuMGCyzT05fAr1s=;
        b=L/x3qMNBbrzbifNCpBerlELOxf1qYMhFXUoQFtdPd+5pCojZlq+DZ2jLzQ57xOH4Ba
         tg7gaq528hgNuU8kiEqWNbkEFpoWKToK65jHS7h58eiEQj0Vfcm14B/ahLDi4MYSAcTe
         78rZbMH0xjz5egZ0kFdz+eDGdN11wruUsmHHE8MqxzpUcfWLku7zBWnUPgywV/HW6ZHu
         69BGZl/UYWZ1xSDRn4szyb/Ry20YVBBt4cH+xTJtOPPP2IMN0aEhHtMYtICgeOiByy91
         2jF+nt9cRwc95c+YO8e1FT8Z3CNxkWsIuxy76GCmxCVzjw/t2kmA6H5AVmY6xEk2X0mK
         vtow==
X-Gm-Message-State: AFq9FYI4W3cXYsIIpoCd1yID38X5D5EBHci7aiHwh9K3jbO9ThzZlK+S
	g6xRMx9hOGX3m53GL4aTYTyamJIwPldHzpRBuk2aruj5FEP2uBkQmIhXxb8X2zEntrc7ntJhCBs
	H4Q9WfSHfwNPXfdVklh+nK1+jJXlk+RF4DMmG1QcKzEymW1LfZm2VpD4M5s6ngj4Dd5sANvaVMA
	IhRx8jFB/yxVavqfiI90YtF9NLT2GEdZIHIWhs0B3B9se641ypMD5J
X-Gm-Gg: AYBFou0gIdMZPg60rSq4KkT1/j9IrqzIT5KnNRVDD/H7Wf/YQ1NuZWsYSM4E4kk5MLk
	ET2QBN+h+8D8UlNs14RqlVaBPdjHuuO/t6hkoUqeJZ5qoqnF7Z4Rv8hcz4tq6QnYOc2AjfNxeKS
	YKaAHEFujjGkE+4E80TC+Pf/th1ijvvLA7RxFGGaTr41oGa8wu005ua246Gg==
X-Received: by 2002:a17:903:2a83:b0:2d9:2149:57c0 with SMTP id d9443c01a7336-2e6003c25aemr51689175ad.22.1791468491152;
        Thu, 08 Oct 2026 07:08:11 -0700 (PDT)
X-Received: by 2002:a17:903:2a83:b0:2d9:2149:57c0 with SMTP id
 d9443c01a7336-2e6003c25aemr51688815ad.22.1791468490588; Thu, 08 Oct 2026
 07:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org>
 <20261006213334.3360919-1-ricardo.salveti@oss.qualcomm.com> <DLY4FJIPDYDE.1E2VH902D858L@smile.fr>
In-Reply-To: <DLY4FJIPDYDE.1E2VH902D858L@smile.fr>
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 16:07:33 +0200
X-Gm-Features: AclHuK9mb0wU6cwRrploEt4coPNBU71SRWFzl9UYi5FYLrUlk073_6htkYqV5E8
Message-ID: <CAA_5youj13dBFP06u4nW_T8T3xwR-fEHqSutaRZj=Nt6fwk6uw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: don't rely on wget
 --continue in the corrupt partial test
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
        jose.quaresma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1NiBTYWx0ZWRfX4en3k2f0jVfl
 82ICjurAyHcITXqkzyk0UES+R8sg24VqV9pnWZ6/4UZASPKGmtokYS7XfrVB/F61CxWJWP0NRQC
 k88M0GZuz+73qYKJUYu5+jgVrAcATa8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1NiBTYWx0ZWRfXw/KTD1kNsrhN
 PGKgGFy5K/E/milY6/R5F38JNrZETTKrdT+JwFP7mIRTG2yJYsiGYrUQYC4Ge7BRLJccuRU/2q0
 zDw3nCw7JdQ2VCwx8gHdFVqr7OOn8efkOVc5AXZMfeKRAtOlmhcWgCuwSpK0sgNAOX8exhak21D
 +lVet43oF8rhdTy47qSBhqVb2IwuMb+km3Nt7IdRypfr+dK/J7unF4ejdGED24uXkphObSFhKAZ
 +wKEVzHNks99lNTkW9PB+38Q98Evu/s0m59gUz1pDwbieILevWDkGXASH7jkNOZDEGkWjeU5uzI
 OSSRO73UmmcWyuU0MkFn3+gs1VqUzhILYk+D2xddbV5Bp9kFrc9jSfQgSgJYN7sgAJL9nm9y2Re
 HtVpAVXDhDkuwGNCtqVt+yCZhas4mxb9N+0BQe4hH/xU+kQxcPRE9xRGZOodwy6OQzTXVOrWcNv
 69Jq+HMCVKDVtodIvFg==
X-Proofpoint-ORIG-GUID: oG9gKcdEb-El1-Bk0X_JMhj6Wk5aVt5v
X-Proofpoint-GUID: oG9gKcdEb-El1-Bk0X_JMhj6Wk5aVt5v
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac7a3cb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=lWIw4zNB15KzJH3b:21 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=iGHA9ds3AAAA:8
 a=Q4-j1AaZAAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8 a=Ev7zbb5uxp_ZO25PVBkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
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
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 14:08:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20307

Hi,

On Wed, Oct 7, 2026 at 12:50=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
> On Tue Oct 6, 2026 at 11:33 PM CEST, Ricardo Salveti via lists.openembedd=
ed.org wrote:
> > test_wget_corrupt_partial_download expected wget --continue to leave an
> > existing .tmp file as large as the remote one alone when the server
> > ignores Range, which is what GNU wget 1.21.4 does. wget2 2.1.0 rewrites
> > the file instead, so the fetch succeeds, and wget2 2.2.1 (Fedora 45)
> > appends the whole download to it, so the bad file ends up under another
> > checksum than the one the test looks for. Don't run wget for that first
> > fetch, so the fetcher sees the partial download as it was left,
> > whichever wget is in use.
> >
> > Tested with wget 1.21.4, wget2 2.1.0 and wget2 2.2.1 (Fedora 45). The
> > test still fails without the fetcher fix.
> >
> > Fixes: 37b9c56ae3b2 ("fetch/wget: rename the partial download on checks=
um mismatch")
> > Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> > ---
> >  lib/bb/tests/fetch.py | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Hello,
>
> Do you think this could be a fix for
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16153 ?
> (previous patch definitely sound related)

Yes, the merged one (37b9c56ae) fixes the sequence described in the
bug: the upstream download fails its checksum, and the mirror is then
fetched with --continue on top of the .tmp left by it, so a bigger
mirror file ends up garbled (corrupt head, mirror tail). With
37b9c56ae the .tmp is renamed to <file>_bad-checksum_<sum> as soon as
the checksum fails, so the mirror download starts from scratch and
there is nothing for --continue to resume.

Having issues with my account in bugzilla, would you mind updating the bug?

Thanks!

Ricardo

