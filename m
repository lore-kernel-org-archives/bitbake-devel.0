Return-Path: <dendy.ua@gmail.com>
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com
	[209.85.128.169])
	by mail.openembedded.org (Postfix) with ESMTP id 60DD378870
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jan 2018 07:06:35 +0000 (UTC)
Received: by mail-wr0-f169.google.com with SMTP id f6so8242119wra.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=cBqobRT0+TMnjtHX8EXTDvmRD7iIy3o/3dTd07+r68Y=;
	b=FPxhUxQAdnQntYp87WOyfmag6R/8/LcBBJCpsXatvw9gpBSE7vtoHR5/1AX4eXKpEy
	AjecQ/RovWPd6tqxbwbDIeaUOE2CqOaIIntSMXz8fQ+uZdDuVPU8n163F6rzzH6a3EMz
	VRsV0cN2LgO/7qQ2Ikm1sGnquurA35UeT3x5r5RBj8t589IDvfSN/aerYhAE8g8usnDv
	Hb9sCE/gx8Iq6S2E3c9ZSkHSWnVurl07ULVpo/qNyzBoHDyg2nXmmFEoTXAATT21MIiz
	2fs0RkLC3/od0yjm25JitgKGWZF//ZBFj2CjdJ/G5Ib3fxfCq4XdC1VcUqRm6oHbHYBm
	8Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=cBqobRT0+TMnjtHX8EXTDvmRD7iIy3o/3dTd07+r68Y=;
	b=M0VJbJLd1wK41PE87/L/jU1dyv7Hc1A8Fd9kZ3C6s8T3Ofrqswm1WgOXFChdeuy9xS
	CerWmSMrZfAhqXubzq91Ci10yrDX/BSf4jMpltDSqSj61fqPEOErelk4BxE3lFlzvqPX
	9rQ77Gxb3TT7fIuGmEUvuLpdq4em6hMoJlt4kAhp2+PPGMJnNOO0Kr/X5ltUV8ULve2Y
	/zbKFP7sHfNjIXQIIZkmTNqh0NXKdURg+1OrjPNG2C5MxrQTYWW2AMYkhEzZU8pU3eTE
	nfCJg/OyMPXItswAe30J5xp9KI/N39gBKyTlBoqUVtED5E2e10Wv3D2R7opmNBvJ5dm7
	IJZA==
X-Gm-Message-State: AKwxytfMMlaI5NkxRhlkF4VuGhQPgG0CeBtyrZ3X+qiuFc3dWiGKjDnf
	MGtwjB7IyjSeHBxMSyzqyDTtGX7stVxS5VXE/GI=
X-Google-Smtp-Source: AH8x224WzcuUZurewA7KxeBNO3hOv/XVGOZtCBTfzfcAHH8Z09ckPvRxfcPczP/gFc8YykpXGADyCed7RfE7hpDp9sM=
X-Received: by 10.223.128.169 with SMTP id 38mr20873206wrl.104.1517295996532; 
	Mon, 29 Jan 2018 23:06:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.150.143 with HTTP; Mon, 29 Jan 2018 23:06:36 -0800 (PST)
From: Daniel Levin <dendy.ua@gmail.com>
Message-ID: <CAAvz69xX76ukua1z=t9OxeXKxx_K=UFO_C47QDux-nCSN_eZwg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 02 Apr 2018 22:23:24 +0000
Subject: Conditional DAG recalculation at build time
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
Date: Tue, 30 Jan 2018 07:06:36 -0000
X-Original-Date: Mon, 29 Jan 2018 23:06:36 -0800
X-List-Received-Date: Tue, 30 Jan 2018 07:06:36 -0000
Content-Type: multipart/alternative; boundary="94eb2c059106e47f080563f90089"

--94eb2c059106e47f080563f90089
Content-Type: text/plain; charset="UTF-8"

In short: does bitbake support dependency graph recalculation at build time?

I am looking for a dependency resolution similar to BYPRODUCTS in CMake and
restat in Ninja.

In other words when task _after_ execution might tell that output did not
actually change. So all dependencies of that target should not be updated.
Even when initially they were treated as (potentially) to be updated.

Usually in CMake that results in remaining task count decreased instantly
during build time, because in fact they must not be running.

I found documentation in bitbake about task _input_ checksum, which is used
to evaluate whether task need to be executed.
So I am looking for the similar checksum for the task _output_. And when
task does not change that output checksum means that dependencies of that
output does not need to be triggered.

If this topic is well known and documented then could you please point me
to the appropriate section in the documentation?

Thanks,
Daniel

--94eb2c059106e47f080563f90089
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In short: does bitbake support dependency graph recalculat=
ion at build time?<div><br></div><div>I am looking for a dependency resolut=
ion similar to BYPRODUCTS in CMake and restat in Ninja.</div><div><br></div=
><div>In other words when task _after_ execution might tell that output did=
 not actually change. So all dependencies of that target should not be upda=
ted. Even when initially they were treated as (potentially) to be updated.<=
/div><div><br></div><div>Usually in CMake that results in remaining task co=
unt decreased instantly during build time, because in fact they must not be=
 running.</div><div><br></div><div>I found documentation in bitbake about t=
ask _input_ checksum, which is used to evaluate whether task need to be exe=
cuted.</div><div>So I am looking for the similar checksum for the task _out=
put_. And when task does not change that output checksum means that depende=
ncies of that output does not need to be triggered.</div><div><br></div><di=
v>If this topic is well known and documented then could you please point me=
 to the appropriate section in the documentation?</div><div><br></div><div>=
Thanks,</div><div>Daniel</div></div>

--94eb2c059106e47f080563f90089--
