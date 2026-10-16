Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02AFCCF2C1
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 21:37:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5183.1792186666909449312
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Oct 2026 14:37:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=dclrA9Hs;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=VufnQdXl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJf1EM3179349
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 21:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PeurMZ72g7KRHn+Bz8Rrs78ieowDk1l3qyiHcrJQeTs=; b=dclrA9HsMDPwAND8
	7LB3irSrmqR2j8AwERaVc2kJtnGcGIMThbe7g267LMnUQ6FwQDaX8slXeIdHsYNX
	n5sshU2Z9nMQYd6LMzXP7KQpAvLWulOip8OAeo8+2Ab05hYmrK5cwM2TtgS0Nqs7
	UbrlhCgg2ZLt3UQplOVcs2XibOhtawBcfMCTvqLWAjCUqjGwKMfYIvHCuCXEuY+6
	0LcwHCAqx5Uok6m2u3PL7OOCbHQfpMzZhXzZBDIsfD6oxnNGOfcx2Rjk8IKp2aGN
	RNl16r2NT6dP9owzbh0hyrUfPmfkk9ahd1eg8eb9Q/OGnIpTS6AFE+YZhDy7qkMZ
	aFQk5Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5ytx9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 21:37:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88c76888646so214012b3a.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 14:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792186664; cv=none;
        d=google.com; s=arc-20260327;
        b=XmwZrAPelajfO4Fn+tiV/0GPDyQApLm2R3I/vPPgVzEvpOx3r+uIjJMsF8Hxx+mHa0
         YeLdADFREm/Sz+UxJxFZP86bh3+YMJeQ0PPXzkmXq2JgCQCPluFS4Iq+ArJxm0p9m68r
         nIn6vEPNwf1hn9ZgYgj8XbFpLddXByRAPhCH7Sry1CV/b+xI7nva6W7Se6mrThjRrVKo
         J7cPw3lrFusQGdYtdJbqKSInMCtkKQFw1gDDL1y76RboMzKTzdvIl2KWfS0lf7ODTAi8
         cwaAXeUqmftctVejnSVA2yTFQh6F2FLD/YFW/dLaG1Hut1nSaKaZBruxpavlBXV0Bcny
         WHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PeurMZ72g7KRHn+Bz8Rrs78ieowDk1l3qyiHcrJQeTs=;
        fh=TKMmSTAL3VHGyheGwPnYyuPfBT88uFi/qjhGCjO3Hfk=;
        b=Pu2SM7PaE6FLExOQ6pvOYPj22XKjKXMmXbFgk6qQwg8YPXbspAKgUZuKN04MjOapBF
         Y9jQB5tnIpLqMtRr00YvVbU16USZsXXXaVYFpypUrZ0jXYhA1em7HF/TKyZ2e5AJhxTn
         zRnsOkdIKnfGYrfGnkZ981kxdPH49J+FyQ0hTAra0cg3KHzvhQMIgwVNEpn2WqkcDW6a
         q/+67Kf7i1b71XEIjCJ7QUF6BbJpxMciJgtJidzCmKfDRi6Jkingi6ah82wSz7JjXLU4
         F2NZaX2KP7vSz6f63FAjVkoM50kUaKMekAI2Yck/6Cvy7RzMoZnl9Fvkte+tnSJhXHdQ
         m5kQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792186664; x=1792791464; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PeurMZ72g7KRHn+Bz8Rrs78ieowDk1l3qyiHcrJQeTs=;
        b=VufnQdXlLT/R+j2NldJBx+O4DA04QTnMreey+kvAiFk9N12PkYCRxrG4Db3Hv8GZ/t
         mTuRguQdU+8PVkOzUqhH0MfLLJJA40SFjg/8SUE8kcpFo3PMUJXDwiOew9wcTzcjmEps
         g/J7eqNfdvDNGDMzjYjDxTv9me6efZ/wQcQy8KPTDjvSzz9BvDUX3betVTCugt4QSBZm
         cn3VPplhy2wMYfHQc3dw/t2NdJHpe1yciMgCDF+MGuIt+h8jG3Tm05o560h5/GpmLMT7
         ELn3Uuj2HAs1sY9E0kSunKoPTrN0eqKt7YpO+vDi3kAOkzYFbe6rKz4qQy6IJDyGeRVd
         WnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186664; x=1792791464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeurMZ72g7KRHn+Bz8Rrs78ieowDk1l3qyiHcrJQeTs=;
        b=Q+yyp4L+NwA5HxL0wtrfYMPU1VkJo9DTVdPpFJrebTDDI5sw4CuH6cn61+2DFaNLwG
         4GaoQkVLh+jYuO7Osi52BqcfnKDqU2HHpBZA3GAYm53y1WaLIuyORSIWe42dtPlhrJLx
         cW1oGEEjkWVmipnzykOl45ptHbrioxiuw2rxUc+6YjQ8OyaLENjOrMl1SzlulLJFyZum
         Jm0lamjU9xUSipq7RRKiefrodYhNhiLEmYr7oiNdShALPeHoipi8D+Xyxrlzt/SIy7jO
         dUAl0BG5TFq22zFK27BQ9prH+rAIv9PAq+rvTNBfKzIc1vh9M1h8dwy9xSa22fHkaZT1
         A6NQ==
X-Gm-Message-State: AFq9FYLiYOsNWmUI0N0qNAJ41DF8hqIi05rG5pv1qsE279/k9XIH/LqZ
	vtDZG59uUf75L95G5LObPmURLNA1pBYJ9YbpdijZxhXymM2xo6dJnfaF15dGloTYZLCJz+2q0UH
	3T+jy3sfKkJkNx7eCbLb3jEjB8CrjYaK0a4r4HzkbXugUmV3TzGAXvilwWJhtT/x1e/NXqbsyoq
	GJ2jmEz/rIEj3Npefm+1yCUgPiA6JD1dy/HDw2puYJRQjoprvIsfwB
X-Gm-Gg: AYBFou2RU68lDmkDvlSPFAUSeNGTiZPrqwOvS1mairYpt6XZDAdye1pZeGVIHJnXnNM
	01VJjOeoR3O9zRCEQkjlwMfpUOxpt9ebr01GNhBguOwOR+1GiHM2y9gBpNMbIHfcqZYKmKtiaiU
	GOpHJD2mFAqp9bOLtbRE/ERGrAybZgsXBC7hy0XSDJaqeHk8avUZ+YHtjIqA==
X-Received: by 2002:a05:6a00:2788:b0:89e:4987:9dec with SMTP id d2e1a72fcca58-8a04cb1ac2fmr710237b3a.28.1792186664399;
        Fri, 16 Oct 2026 14:37:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:2788:b0:89e:4987:9dec with SMTP id
 d2e1a72fcca58-8a04cb1ac2fmr710218b3a.28.1792186663872; Fri, 16 Oct 2026
 14:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com> <DLZ9GSOJRTMT.3IL2I0HZPLFE5@bootlin.com>
In-Reply-To: <DLZ9GSOJRTMT.3IL2I0HZPLFE5@bootlin.com>
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:37:07 -0300
X-Gm-Features: AclHuK-JCebDTR88ltxl7LpofMlwqKFI18AytTDWGuY9_AtKzU8eTy-n4Uo_Xk0
Message-ID: <CAA_5yovWtCyMOWEBrUwJj7DsZO2NUEAc+gtSN=hj+2qX-ToXAg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
To: mathieu.dubois-briand@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, jose.quaresma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: K7DhFTCuA1ubY-l0NHNxLP8cZacpBbe0
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad29929 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=Q4-j1AaZAAAA:8
 a=xOU3QFeLvvG__j1Ac8gA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4NiBTYWx0ZWRfX7ObOUk1wWsMB
 uK+gyrUoDJ4TuaZM+6eXhFi7RASwr7ynGGTgPos5PNaYl8CK644PyTdZTmRr/d3QLZ35HhwDYaL
 9meKY2BY6L00m3YtZwug56U5CyJxzq4=
X-Proofpoint-GUID: K7DhFTCuA1ubY-l0NHNxLP8cZacpBbe0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4NiBTYWx0ZWRfX+vZwtuydYbj0
 2FMieVgYc8qeIVK03g4dtSB8L+t4QIw97sBZLK9RkGEtT5RD/FtsRM3nG8lggV5o0bXISEX1AeC
 i0qA9xR2XpvdqHs9zglBmLuNA8e/zk+FQYCJvmrFgg+YITNQPpxl8AnZevhvVKNuEM7ipkRD0tB
 IV7VuN6jO1ISWnFxxk8BUzgoWcOtdGz1EGvJJefcWBYqvgS/L1ZTAKXJVpfomd+28CxMacRut8Q
 KouvGnXHTM6veVVFPWmFz4kXTJgv7eABxhVO/nwCbLS2XilXA4rfbrIRiMSJl3YTCL7V4eR1p/0
 YHYVUA6co0nSo7i5Lt2ze/bk3RLxRxf6rcJI2i74pHrwUfcNfkbKihBQ45rD6A4dwJ+SVY8+Wr5
 KNQbebV6YZyTFpVBYnB662zmvzeZBnqmdbQQdXHoDORh5YmCVc+I+PUswcFvJCp9LKBCYy2UlSc
 v2nMzZek6RbhC0XIIuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160086
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 21:37:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20352

Hi,

On Tue, Oct 13, 2026 at 2:54=E2=80=AFPM Mathieu Dubois-Briand via
lists.openembedded.org
<mathieu.dubois-briand=3Dbootlin.com@lists.openembedded.org> wrote:
>
> On Tue Sep 29, 2026 at 3:28 AM CEST, Ricardo Salveti via lists.openembedd=
ed.org wrote:
> > The wget fetcher downloads into a .tmp file which is resumed with
> > --continue and is shared with the mirrors of the same file. When it
> > fails checksum verification it is left in place, so MIRRORS reuse the
> > bad file instead of downloading their own copy and, without a mirror,
> > every retry fails the same way until it is removed by hand. Rename it
> > with rename_bad_checksum(), as done for any other file with a bad
> > checksum, so it can be inspected and the next attempt starts from
> > scratch. Mirror downloads skip this check and are still handled by the
> > existing code once moved into place.
> >
> > Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
> > mounted over NFSv4.2. What corrupts the file there is not addressed,
> > only the recovery on retry. Tested with the new tests, which fail
> > without the fix.
> >
> > AI-Generated: Uses Claude Code (Claude Fable 5.1)
> > Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> > ---
>
> Hi Ricardo,
>
> I suspect this patch is responsible of intermittent failures we can see
> during test_wget_corrupt_partial_download selftest, only on Fedora
> workers.
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16445
>
> Do you have any clue about what might be wrong here?

Right, it would require
https://patchwork.yoctoproject.org/project/bitbake/patch/20261006213334.336=
0919-1-ricardo.salveti@oss.qualcomm.com/
to avoid the failures in the latest fedora, but I don't think it was
taken into master-next yet.

Thanks,

Ricardo

