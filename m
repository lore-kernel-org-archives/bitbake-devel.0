Return-Path: <pbarker@toganlabs.com>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
	[209.85.128.172])
	by mail.openembedded.org (Postfix) with ESMTP id F1D9D786D2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 16:55:58 +0000 (UTC)
Received: by mail-wr0-f172.google.com with SMTP id v111so9728235wrb.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=toganlabs-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=9aCWip8CdKBtsWv2CX1XbT9ooHDr9FI0KnM8eLyq8uY=;
	b=wSGfffB9EBAYzKtVXOBbfBAXp2VDvJDsnZ61GZimqIDDTGAm031GvYBNJSBu3oB5CF
	HCf8P+qDiU2zwPWkHDRlYDmTt/IWH0OQudNPaNxDG78e1QiNDT1133bTwsRCCQyUuZgU
	LaB66+9xxacXRwNpJbwaoH8Cn/9ixmT9sBJHPjVk8CDVERwKEpxj63BqqzgkHzh8DiK1
	F4cexz6M3ijR/CnZ/oZoODITJlR5DUTXBA7GU8833GzU4VYU1cDc88p38e2ul/bW3Cxz
	qFCEBOG5LbV2Gb0FfgTGwxeIKWmY9+hRu0vY+oEXFkPVDbco6oXVlrpMvAVF8AusOV0h
	GS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=9aCWip8CdKBtsWv2CX1XbT9ooHDr9FI0KnM8eLyq8uY=;
	b=NOeTrOVayz+sWGY+lc7RvNGdcViOUI+8A97AaqTWV+qIBCafx/oP6k3OF/OsVcZqjm
	sNBDjb1HFGZAk+AdfCIJzxFV42gD/g84/sVoJGveWtO0OXU017eHcRU93kTagOs4dyIt
	QELrmYJWKTYnU4+io/xK8axNoWyMokTbEE6VRmQdFfViKZ/LBrBkI7WA921vYlxMHh66
	LcJD8WI8EIAnJqhHNkaF4jqronafE8wudPWBrnQ03ZOAPbUDOnqs66dCvFR/4ymqcael
	x0n9egspYuAv7Pc8TkqvIT/UnHForyJ8TnA6UfdbbWLWy1YpzCGilYH880InYeMvomYu
	WRuw==
X-Gm-Message-State: APf1xPCPdCyjPfDrs28BHG8OyUaUOLO519an8V13Fa8dctrCB8pSZdw2
	n/CFb4r6A9BWRMkyvdEQSr/uRTy6rIn66keWpbxzaQ==
X-Google-Smtp-Source: AH8x226HPqpCR3A2l+gziySi4GXV6JZdQoSQbc0ipJ53Hn9B4I1vi/sIApjjOxo7ls5FFHVaN/xaJQMIiLinS3cjV2w=
X-Received: by 10.223.152.73 with SMTP id v67mr9811796wrb.19.1519664159599;
	Mon, 26 Feb 2018 08:55:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.48 with HTTP; Mon, 26 Feb 2018 08:55:59 -0800 (PST)
In-Reply-To: <1519663996.24236.387.camel@linuxfoundation.org>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
	<CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
	<1519596717.24236.384.camel@linuxfoundation.org>
	<CAPyrkgxDenV61oP1CZLFSFueqM3NXo2BOptNgSFTDnRHpm62iQ@mail.gmail.com>
	<CAPyrkgzzasujqZ1D5pABM+vudjjaM=4wdVuseFNB8u0OHVdMCA@mail.gmail.com>
	<1519663996.24236.387.camel@linuxfoundation.org>
From: Paul Barker <pbarker@toganlabs.com>
Date: Mon, 26 Feb 2018 16:55:59 +0000
Message-ID: <CAPyrkgxbBhVotXYVdnXBby4xCN2O_YjeJTpPU33DmhnnW+Mmsg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 26 Feb 2018 16:56:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 4:53 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Sun, 2018-02-25 at 22:20 +0000, Paul Barker wrote:
>> On Sun, Feb 25, 2018 at 10:17 PM, Paul Barker <pbarker@toganlabs.com>
>> wrote:
>> >
>> > On Sun, Feb 25, 2018 at 10:11 PM, Richard Purdie
>> > <richard.purdie@linuxfoundation.org> wrote:
>> > >
>> > > On Sun, 2018-02-25 at 19:25 +0000, Paul Barker wrote:
>> > > >
>> > > > I've been having build failures recently which I've tracked
>> > > > down to
>> > > > this commit in bitbake via git bisect.
>> > > >
>> > > > I have an image recipe, oryx-image, and a publish recipe,
>> > > > oryx-publish. In oryx-publish I have a do_publish task that
>> > > > copies
>> > > > files out of "tmp/deploy/images/*" to their final places and so
>> > > > it
>> > > > needs to run after the tasks in oryx-image that create the
>> > > > relevant
>> > > > files. So I've explicitly added oryx-image:do_build to
>> > > > do_publish[depends].
>> > > Is do_publish added before do_build?
>> > > Does oryx-publish inherit any of the image/meta classes?
>> > >
>> > > I suspect I need to better understand the problem as you've
>> > > described
>> > > what you think the problem is but not what problem you're
>> > > seeing...
>> > >
>> > The recipe is here:
>> > https://gitlab.com/oryx/meta-oryx/blob/master/recipes-core/publish/
>> > oryx-publish.bb.
>> > ORYX_SYSTEM_PROFILE_PUBLISH_DEPENDS expands to "oryx-
>> > image:do_build".
>> >
>> > The problem I'm seeing is that the files don't exist in
>> > "tmp/deploy/images/*" when do_publish runs. Investigation via
>> > "bitbake
>> > -g" shows that the dependency on "oryx-image:do_build" has been
>> > dropped from do_publish:
>> >
>> Somehow trying to paste resulted in the email being sent.... stupid
>> gmail!
>>
>> The problem I'm seeing is that the files don't exist in
>> "tmp/deploy/images/*" when do_publish runs. Investigation via
>> "bitbake
>> -g" shows that the dependency on "oryx-image:do_build" has been
>> dropped from do_publish:
>>
>> "oryx-publish.do_publish" [label=3D"oryx-publish
>> do_publish\n:1.0-r0\n/home/pbarker/oryx/meta-oryx/recipes-
>> core/publish/oryx-publish.bb"]
>> "oryx-publish.do_publish" -> "image-json-file.do_build"
>>
>> Commenting out the following lines in lib/bb/runqueue.py seems to
>> improve things for me but I know this is just a hack:
>>
>>         for tid in self.runtaskentries:
>>             self.runtaskentries[tid].depends.difference_update(recurs
>> ivetasksselfref)
>>
>> With those commented out, the dependencies are correct for
>> do_publish:
>>
>> "oryx-publish.do_publish" [label=3D"oryx-publish
>> do_publish\n:1.0-r0\n/home/pbarker/oryx/meta-oryx/recipes-
>> core/publish/oryx-publish.bb"]
>> "oryx-publish.do_publish" -> "image-json-file.do_build"
>> "oryx-publish.do_publish" -> "oryx-image.do_build"
>
> Thanks, more information helped. I think you have found a bug. I'm
> wondering about:
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 48df0131556..f2e52cf758c 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -765,7 +765,7 @@ class RunQueueData:
>              bb.debug(1, "Added %s recursive dependencies in this loop" %=
 extradeps)
>
>          # Remove recrdeptask circular references so that do_a[recrdeptas=
k] =3D "do_a do_b" can work
> -        for tid in self.runtaskentries:
> +        for tid in recursivetasksselfref:
>              self.runtaskentries[tid].depends.difference_update(recursive=
tasksselfref)
>
>          self.init_progress_reporter.next_stage()
>
> as a fix for it...
>

That makes sense. I'll apply that change and see if it works.

--=20
Paul Barker
Tog=C3=A1n Labs Ltd

