Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
	[209.85.218.54])
	by mail.openembedded.org (Postfix) with ESMTP id 1D78C744C5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 21:20:49 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id w126-v6so29843227oie.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=mOOOLwVencZbBGUsV3/9ubVsSj9aCay0m6MT8SDnXTI=;
	b=SYusflDSs1gMtB+OfYBNLV8mkIgegXm7tUNd28BSlcm77uc8mDEPGyA6msAOQC72wU
	ktgYnDCXkkq85PxISJhTnQXLM0o7Hv0GuIqaszXfT7Dg5BST/oA4RaRE/Gl69J1pxSsU
	7YSkWjiJeDs4TWSuaXqgVCvNXeJN++HAhjrNeKhttd8Y0413rTnqfXvldZH7EcjXHcLS
	4lYOWc5oX5KYzzOckycixfnFjrHNjb5Y+wAaMgYMDj24WzurPBmfKt/IUqHS17FMzqNY
	ZwvBiIYsPmUNI5+rLRr/V19lh98gmnkKOKcFp/gsMNIgYfD4IBuyNN3/HDyXZh9pTYCR
	bIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=mOOOLwVencZbBGUsV3/9ubVsSj9aCay0m6MT8SDnXTI=;
	b=EZ4f+1xJA40IhF73HYwvSwVr88YYwzYnYzVllwe3bbkeEcd6++XTTeaSn/UpD006cW
	M5HEPqis+aFOXMDNHw+kF+XGk5vnA9PgLZh7GR7J0Pa7mgh1EH5AU3Icufp9/ZaNsnVA
	eP5EpTDnBOZgJwJ/qsLQQmg3xagDLTDxyRbSFzhAR8acmhdz3sI6lY4QDQS1jg8NIROO
	I1T5H0amq+1WUqA7Lmovb2OlNSGLRytV2Y32ntL6hjyDxLJJ7aqd9Q7FxYVWz2Lhks8d
	8L3qsoEu26ZZ5kVkWr1A+yuQZmmmws4Bap/3ue27K0bdEE1ERCmdm8AREFV3t7/DoYw9
	NzxA==
X-Gm-Message-State: AOUpUlGL4MDn9ckZAUzpidGp7SbDeRh9xfvv9kM1Vzg97KOTcxP4+3Gq
	dOEQghNUrNjTkJ82yoNn36d98FGbyjjnzfeGWXs=
X-Google-Smtp-Source: AA+uWPzwwgQKxxrS9BfRQgEgr545ly4cK9i+cVbUahx6UsK2WETHdFtT1PWUxjw75ksIt0hd68MsMOBGvRa42+imtFI=
X-Received: by 2002:aca:3d4:: with SMTP id
	203-v6mr18453120oid.321.1534195251062; 
	Mon, 13 Aug 2018 14:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 14:20:50
	-0700 (PDT)
In-Reply-To: <20180813210445.32496-3-schnitzeltony@gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 13 Aug 2018 23:20:50 +0200
Message-ID: <CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
To: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Mon, 13 Aug 2018 21:20:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-08-13 23:04 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.com>:
> To get most out of build host, bitbake now detects if the CPU workload is=
 low.
> If so, additional tasks are spawned. Maximum 'dynamic' tasks are set by
> BB_NUMBER_THREADS_LOW_CPU.

So the best improvement is going from 114.5 minutes to 113.5 minutes?
I don't think it's worth the trouble. Maybe it's time to invest in 16
(or even 32!) core amd threadripper? :)

Alex

