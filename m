Return-Path: <pbarker@toganlabs.com>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
	[209.85.128.175])
	by mail.openembedded.org (Postfix) with ESMTP id 250DE786FA
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 22:20:58 +0000 (UTC)
Received: by mail-wr0-f175.google.com with SMTP id s5so19315727wra.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=toganlabs-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=sj2SD1OfSWECF30x5SYkammd+k5WLtIVPUHSQ3msLk8=;
	b=zLKUGKsTG7+yJs8vvAWgXB1WB4TwvvGhaHepulVLelv2mqD7Tz14AGgQ1wDh/Bo1/w
	zgWM7p3pSKAhSNCg68DACFxdN67l9pgnnIHToVfv+gISGdIB2mIXMrI9zHUj7nh8k2eq
	CAEswiXfEuc6ucW9/rJSOKiRnT3YMqGEl81pD65qmrgEPvjaO+QkVQqMUOGLBIR9Y/Cp
	/OwQcPJnLKK3JKPMWt/crVcBZotHWJV+1yo7jCvcxPsg4qHeqcj7+09lM8ZU7/JRqch/
	Nz/ale0FbhVQ0R6PJTwK0LbEs2+dHe2Wvwxdtx9Pf3YBff5EA6MA95CfJjuyquIIrkkL
	T9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=sj2SD1OfSWECF30x5SYkammd+k5WLtIVPUHSQ3msLk8=;
	b=iVbWjpOEL/rbpx8WRvlWEuDqKXlp5yUrKaSnB43pLoJnKiEIwTjOVLgYyzICOGpACw
	ZSOsGgw9+BlMuzVha3MLTiORGo1miO1P2HuhBRisUQj7nv/JHYXWiBCND9HMJoTiYMum
	ApiMwxREY0KJNP8Mz9bBSRhA7uTsJSyiMNtibyHdMD1iCL8uPCaUcje3EmMjEo0b+Wfr
	+9ndJb8Sg1mF4CO5f/SxJSrrP33rCtvwnXpbj1YlHkDfbL9ONABzaHvHUs7U1wnEwwTq
	8dxS2EG4kSQFWOEomLX5AQ3pyU6ph6Ou+kUrgA2SiOlKFr9IkqtHKUEcbbGqRc3Ezt4n
	3dpQ==
X-Gm-Message-State: APf1xPCiUV90ycrJaTfB7m5ibHEZZfKkBvAeLZIUfKiE63r0S+oPU37Q
	/71JljR4Fkr7+b117Q406JNcBA12572rB7FrkwVyT5X1O70=
X-Google-Smtp-Source: AH8x226GZj8OuE5ZVqFjnNta2X5l90fHhe5mQznyyu4xntcyZyRPbF1CwMytnnfS7tnNqKSqSk2UT8dp2sa9nR56jnU=
X-Received: by 10.223.165.67 with SMTP id j3mr8032016wrb.111.1519597259794;
	Sun, 25 Feb 2018 14:20:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.48 with HTTP; Sun, 25 Feb 2018 14:20:59 -0800 (PST)
In-Reply-To: <CAPyrkgxDenV61oP1CZLFSFueqM3NXo2BOptNgSFTDnRHpm62iQ@mail.gmail.com>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
	<CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
	<1519596717.24236.384.camel@linuxfoundation.org>
	<CAPyrkgxDenV61oP1CZLFSFueqM3NXo2BOptNgSFTDnRHpm62iQ@mail.gmail.com>
From: Paul Barker <pbarker@toganlabs.com>
Date: Sun, 25 Feb 2018 22:20:59 +0000
Message-ID: <CAPyrkgzzasujqZ1D5pABM+vudjjaM=4wdVuseFNB8u0OHVdMCA@mail.gmail.com>
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
X-List-Received-Date: Sun, 25 Feb 2018 22:20:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 10:17 PM, Paul Barker <pbarker@toganlabs.com> wrote=
:
> On Sun, Feb 25, 2018 at 10:11 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> On Sun, 2018-02-25 at 19:25 +0000, Paul Barker wrote:
>>> I've been having build failures recently which I've tracked down to
>>> this commit in bitbake via git bisect.
>>>
>>> I have an image recipe, oryx-image, and a publish recipe,
>>> oryx-publish. In oryx-publish I have a do_publish task that copies
>>> files out of "tmp/deploy/images/*" to their final places and so it
>>> needs to run after the tasks in oryx-image that create the relevant
>>> files. So I've explicitly added oryx-image:do_build to
>>> do_publish[depends].
>>
>> Is do_publish added before do_build?
>> Does oryx-publish inherit any of the image/meta classes?
>>
>> I suspect I need to better understand the problem as you've described
>> what you think the problem is but not what problem you're seeing...
>>
>
> The recipe is here:
> https://gitlab.com/oryx/meta-oryx/blob/master/recipes-core/publish/oryx-p=
ublish.bb.
> ORYX_SYSTEM_PROFILE_PUBLISH_DEPENDS expands to "oryx-image:do_build".
>
> The problem I'm seeing is that the files don't exist in
> "tmp/deploy/images/*" when do_publish runs. Investigation via "bitbake
> -g" shows that the dependency on "oryx-image:do_build" has been
> dropped from do_publish:
>

Somehow trying to paste resulted in the email being sent.... stupid gmail!

The problem I'm seeing is that the files don't exist in
"tmp/deploy/images/*" when do_publish runs. Investigation via "bitbake
-g" shows that the dependency on "oryx-image:do_build" has been
dropped from do_publish:

"oryx-publish.do_publish" [label=3D"oryx-publish
do_publish\n:1.0-r0\n/home/pbarker/oryx/meta-oryx/recipes-core/publish/oryx=
-publish.bb"]
"oryx-publish.do_publish" -> "image-json-file.do_build"

Commenting out the following lines in lib/bb/runqueue.py seems to
improve things for me but I know this is just a hack:

        for tid in self.runtaskentries:
            self.runtaskentries[tid].depends.difference_update(recursivetas=
ksselfref)

With those commented out, the dependencies are correct for do_publish:

"oryx-publish.do_publish" [label=3D"oryx-publish
do_publish\n:1.0-r0\n/home/pbarker/oryx/meta-oryx/recipes-core/publish/oryx=
-publish.bb"]
"oryx-publish.do_publish" -> "image-json-file.do_build"
"oryx-publish.do_publish" -> "oryx-image.do_build"

Cheers,

--=20
Paul Barker
Tog=C3=A1n Labs Ltd

