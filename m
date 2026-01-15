Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD792D4660D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 18:34:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1801.1768502044703253860
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 10:34:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=Ctb4nA6d;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FFYqaV1723413
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:34:03 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bptna22gh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:34:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0d59f0198so12822705ad.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 10:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768502043; cv=none;
        d=google.com; s=arc-20240605;
        b=gA8mmlFxY0bhTjqkH5Kee+QcoMyKgTcfSJAe6HvgrYNp1Aoh7pohaBHefoFhmEcayr
         4Fx3ofYQOZTgrlKMpifrK8KIzfD8GCFLMf6digy4oExwNDLsvwgUL4pFN5gQvzQcjBm9
         I9PIQyjwiOfr/CAcdFHij82ijs62ROqQ3+IANnxbMeheURbc6HNsQOlu/8gzfWIRN1IQ
         NfaYpPVFR+SYpWMMtjmEor+EkPbKTpZqTF13rE4PUDxIBEvX+C7yMMKWIYRHb+eZICDD
         sNSaNVq7eA5PR34EabRLcSe+s4h+wbpDnOWOVjxgjrzAbdRUZR6J8HK0i6f5VPB0O3Gl
         aMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nzu4U/gK4WqxHdgvfOWtbKDAr3x1Lcw6/ir5EKZ4cbw=;
        fh=dGhMZmBQcdDlInfqMh/AGf4gkCSnr037ETBnNt2bW84=;
        b=NdsI29GNpdo31V1bj7V9SUqUhDO7AdVhg+/tIr8W6mMEnd/VyUObsjUkVLRycCywUx
         xrj7mj64kwNUx5fPkURlAvflDWUDSDzg3mLH1PnlKNii5sZjZwogbUVFgdIMdSrAn3Yw
         4ZLLvmYv9s+DduE+0PPu16bHmuNjMl6ijSOaNoatk7GzR7dtrKxH07ERrXcpTbMvnHbP
         tteJgwFbLPPvrcubLFvMIYBrSqrskoYh4u37RBTCLoTS/dExnWUNSJoZ2GFFfa7RCrng
         0SpFk+y2+Q0kTZSrrghjJ4nQMOBL7rbbMiou1/DH9ZE+GIGOepEVH9elZSXzWZFeTjcv
         vHkw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1768502043; x=1769106843; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzu4U/gK4WqxHdgvfOWtbKDAr3x1Lcw6/ir5EKZ4cbw=;
        b=Ctb4nA6dAOjhaz2jIhejtjPGcv3O/CEXzal9aUFGJaPijF6MXBjCV9B4b/FdgX7FkL
         qftEGFET7ECCvdgl4yX0nLzaqKHELSF1TwteO9k4rcg/POa9V3ulTgq9GXV5EMXgR/qV
         Us40sEhSdNv1gowsi+Qs5Jne1y2ljpWwHB7NK04pFchC/EsFBOqbTztnxlu40CIQttc5
         jIaleztsfF7Z0Pnh0f56pTwf3tNNAC5KORNJAdthqt3meAIt0h20xA2Trn6pOwIpB6Ts
         8cMnR2fBb/O+6LaiFEFfPA0m4jLKoEthv/mptnWzu7IzY61xZgM0WRKV0FioGppZg5Ud
         PaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502043; x=1769106843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzu4U/gK4WqxHdgvfOWtbKDAr3x1Lcw6/ir5EKZ4cbw=;
        b=ca9C68gf5Ht4ybwMgu3BVcD4sHPx3OWIzAHmKIejA7eCniY2WByPlsD9ixnmMBJdHd
         g3DsillLJIPZshOGKyIwQa1vUyDK8mMACUkruvjAiQyxxRbNagPTNObIMZ1rvARgL9y/
         YARAq0SIuXHVZj//gSFSMxuUI4XipTkwyj1wDWP9YqRbD62/wGecIB8ckjMh1i5sdG3u
         UIi1SDNHPy2uleu77WQsPj7Wh3kRD6PYXcvmJ+uh3zHWiE3iAWP/uaE2K1Yb47tDvTz7
         egDmj9axk8h0/paeYlhRHI/7rvWjP5DNntw4SRCax10HQ53NxZkyw7SQT6yXgZepLZ6Z
         arGg==
X-Gm-Message-State: AOJu0YzOx+kpfdnSJh/eLG2pl8EF5nkJNK+kQiun/Ch7rCTMIr0U9mpZ
	NlMQMjsWik8fUEH7VFtmEkiqDn3u+yfJC+7Ji9J7IFgMZl6BMblxNsPB+8VpsS+AicfTmhLL4D7
	1i3O/V5I4hzQ0oKNIvxb2Feu+GinneXHVzabpszxRdaqpAtoAPOui343EPy+bvwRbxteRZ3nsGA
	4v9owzHLf1JWhAv2BLtWGm6j5pa1+jnBhc9E40zhd60oynnuOaHME=
X-Gm-Gg: AY/fxX5WBUt8hKxoAphAIT5nEcY9MSobA97s4iFyY0XU7ssqlRPMvMm6MeT9r5I2iK1
	OMFo9aZ5GA4zL2X5sR3LJ9qSR05HNEGvNnQRgl7gW6yjpSvkLhTnFJBw545eu4aENuO4RArU0gm
	gMDyXneexP0niyiCNxCdVXJRQlG9yH8JJ5lkz3F6NJLqprtuy9F3zS4bRNALM3F0S66qqw7i8KO
	6/1OyhXacHyCwDtLfhXpK1bVHrkmFwohnxJAFhyBZxvon7hzal0ijPk
X-Received: by 2002:a17:902:cccf:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-2a7175a5cb1mr4004895ad.37.1768502042592;
        Thu, 15 Jan 2026 10:34:02 -0800 (PST)
X-Received: by 2002:a17:902:cccf:b0:295:b46f:a6c2 with SMTP id
 d9443c01a7336-2a7175a5cb1mr4004645ad.37.1768502042200; Thu, 15 Jan 2026
 10:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20260115132223.2034792-1-daiane.angolini@foundries.io>
 <CANNYZj-5nZLvez9VVz1UxYotBu3xZxY19hagxJ9srrgrBjDzng@mail.gmail.com>
 <CA+HEL7_1fF5tNAvzTfSgHLtpR2z7B4udYQdF_pkjBv6csj0cww@mail.gmail.com> <CANNYZj-axXJ-OeLr9_Mu3RC7z0YZXLzX9Jk3nEmJ2gmM7jBw7w@mail.gmail.com>
In-Reply-To: <CANNYZj-axXJ-OeLr9_Mu3RC7z0YZXLzX9Jk3nEmJ2gmM7jBw7w@mail.gmail.com>
From: Daiane Angolini <daiane.angolini@foundries.io>
Date: Thu, 15 Jan 2026 15:33:51 -0300
X-Gm-Features: AZwV_Qi1nTzJYSmPVFZevx2nc5c5PUGHq5PHFeNLDWs1Scso5lWugXz7lZhxI2o
Message-ID: <CA+HEL79Jr48K44HsBcb_b=o=aSr5BgnmmMzN1o7eafWyaQh2cA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: verify if a configuration
 file is html
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 6l4CEnzFgvmmUUk26DRGr4hKKEIc0MWM
X-Proofpoint-ORIG-GUID: 6l4CEnzFgvmmUUk26DRGr4hKKEIc0MWM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0MyBTYWx0ZWRfX/FpGuGoLBu5O
 8xHQD7wO25vN52RUcnj+i5Su55DcTzhp8sX1P+oqV0GKm4bsjILtfukzGdXS3lYcpHlqwe1iqTL
 1Nn6oA0mr2TArimXE7yK+lDzDKH4MyH5VNAMPzEP40E0Uj1+9i4PqAXok4veoLdMPpcRNqTJKaV
 T/qEfrCBQ13zVUtxwHdSxtTZljShtzok4OV/8aEoWjAWAuUpRaf2lkYQsgkbhqurYByNR4PdoFX
 xzUqEg1MZotLV+AMjG5S9UuasvZ+NooxnBpAEMq1CmUwAwYYUo+3XwqMgIoCVN+utTDAjdT2GeE
 E5exZfzDhlZyOMJIel7ODSVmZi79a0wG71PTIlAXYD7H2vrlTw4YFXmfMWsPXCbzb2KGpVIfd2a
 2SBHLCOYeBFegSbr55BsEDLZUWaosbhWN1WO2Su8TQWKTf1issVtim/LR+iPzkJn0PjEn/h5uOt
 1jd4qczYM+ste9ZtX+g==
X-Authority-Analysis: v=2.4 cv=fsHRpV4f c=1 sm=1 tr=0 ts=6969331b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0pv0EnzFAAAA:20
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=VHExOxmOumDpewYnCxgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150143
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:34:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18790

On Thu, Jan 15, 2026 at 2:32=E2=80=AFPM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Thu, 15 Jan 2026 at 15:49, Daiane Angolini
> <daiane.angolini@foundries.io> wrote:
> > > if f contains valid json, then f.read() is followed by json.loads(f).
> > > Will the second call still obtain the needed json data from f, once
> > > it's already been read previously?
> >
> > I've decided to go with the flow, let it fail and only raise the except=
ion.
>
> That does not confirm that the code works when it is reading valid json.
>
> Indeed, getting valid json over http works without the patch, and with
> the patch it breaks like this:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $  /srv/work/alex/bitbake/bin//bitbake-setup init
> https://raw.githubusercontent.com/kanavin/bitbake/refs/heads/akanavin/bit=
bake-setup/default-registry/configurations/poky-master.conf.json
> NOTE: Reading configuration from network URI
>     https://raw.githubusercontent.com/kanavin/bitbake/refs/heads/akanavin=
/bitbake-setup/default-registry/configurations/poky-master.conf.json
> Traceback (most recent call last):
>   File "/srv/work/alex/bitbake/bin//bitbake-setup", line 1140, in <module=
>
> ...
> TypeError: the JSON object must be str, bytes or bytearray, not HTTPRespo=
nse
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Even though the logic will be rewritten, please try to test all scenarios=
.

v2 sent
This time I tested with working/not working, but still only github.com

there was doubts from my side how do you like it, but after you review
I change again.
I appreciate your attention in advance.

>

> > Do you think it worth trying to guess the raw/plain URI and use the
> > guessing instead? I know how to guess for git.openembedded and
> > github.com, but I cannot imagine how to guess for every single
> > possibility in the world (that's why I haven't tried to guess)
>
> I wonder if it should even try to guess whether it's html. Just say
> that the data at that URI cannot be decoded as it is not valid json,
> and suggest that it might be a html page that shows the data, not the
> raw data itself, and ask the user to find the raw data link on the
> page. There can be all kinds of bogus data coming from the network,
> and this would cover all possibilities.
ok (meaning ok, let it be like this for now)

>
> Cheers,
> Alex

