Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 70F8378CA3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 21:30:38 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so29908634oie.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=9so99LnywDY0DNJ1VtqUz6evN7n/ktGnRQf2X8xaFuc=;
	b=VW8u4xdg88+6IOzxxnDK/YCyJ0ufLzdjREgxLt+RClt3B+ibcBzdKP0ecWOu46sOss
	lhxWXGR5XLw2+GZ7GzvPUzY07n9vSIvukqg1tlxurWye0LzRtc4AZmoGzFYRNuLEMcm1
	053q3duDxQ76P/TFYGDitLnEvHanNTMpzEIic4VsdAotjO7no5e+khOzG8Mr08QM4clE
	I82H2xBQfTBs64EDIwY/Vin1VkOCanfl9QwkgzviDL+ZykmfuftCMro040AFgBv9sLF2
	cBONEb6jfMbvnOvaEfBTrDt+Ln1W5hDhEAvcdurDLgJuqkJ9Ovos63w17qUyyKl8FyAT
	K+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=9so99LnywDY0DNJ1VtqUz6evN7n/ktGnRQf2X8xaFuc=;
	b=E2yQNypNG7+dQPxXF1OqotDEYZTwGdH0zVbII7rTSYxucQtWS1Wh1hAodW7kyNDrG5
	MdPb+V6oQaQDBy3rbWD/3I8x2aNYQPxwCoaGjU777dANifaEljBzkdsx5ItRWQ9mEYUm
	APXnjwFko0RliSjoPdtQFZOaTuPUzKWK+rOkY70Ew2XgZ7INSaKT4CmIQxoqqt1CPUgc
	oqU8bmZFLaAPu8RRyT+xbdSzi7UM3i/2rRwy+JD/agbhF72uuMxOp+IzeM/y6qV9i37A
	litCWwYdVfNQKn9JDCefMu1lQ1w/jf54Q5Qyu3xWHuCEUn48P8uSBlwcvq8IQVTYKrrF
	aJCw==
X-Gm-Message-State: AOUpUlHzVbJThE6O77HsCAfoGUHBgxC8lB3IRa/h+6pGHMToSKQlrhSL
	sUhywYflLmKa32gBpK1pDx2LkulggF78OSwMbOE=
X-Google-Smtp-Source: AA+uWPxbtNR40PyFtzkm1TL3XzMr2G6FG1+3MJ3lm9DiifaTBDQOIgoipa2oDGuKvYdQSEA8wG4lfi/rnBLPUsJVzLA=
X-Received: by 2002:aca:ab11:: with SMTP id
	u17-v6mr18328573oie.53.1534195839379; 
	Mon, 13 Aug 2018 14:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 14:30:38
	-0700 (PDT)
In-Reply-To: <CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Mon, 13 Aug 2018 23:30:38 +0200
Message-ID: <CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
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
X-List-Received-Date: Mon, 13 Aug 2018 21:30:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 11:20 PM, Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
> 2018-08-13 23:04 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.com>:
>> To get most out of build host, bitbake now detects if the CPU workload i=
s low.
>> If so, additional tasks are spawned. Maximum 'dynamic' tasks are set by
>> BB_NUMBER_THREADS_LOW_CPU.
>
> So the best improvement is going from 114.5 minutes to 113.5 minutes?
> I don't think it's worth the trouble. Maybe it's time to invest in 16
> (or even 32!) core amd threadripper? :)
>
Indeed - but I have to wait till next holiday to assemble such kind of mach=
ine.

I still can't believe the results are that disappointing...

Andreas

