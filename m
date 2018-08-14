Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id ED59C74583
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 07:57:10 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so31975149oih.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=oOEY+WjsWdeqBvkDP8wYY3p67vQ9vGesQK6b0+aIZeU=;
	b=cdzKSPgyVBHUA/ZT6QLqZkBUiwrBwZCJQ6oZeKXnSCcw3Wt8qGknHGTefHnu9QSvJk
	zhNfBvlvzX9OzD+j7Y1Jkjp5tcitEIYnSxhhkPGFWyPLL5CpbhFGcGUS9b26yn+YrLox
	0URa8iaIKEiMfgt0LatVb8521MguWUuJT4xxRZDgpKncC+yhAppwRodkiUbTxIsl2mZN
	XgvsOjYNSFvxaPBSqE48QedGJ/+dPjrMztoXiY0YZETKX7BHZ7WRaNjmO3NYOUpEgMoE
	S2VWsq2+2I7Mp6hH/Vbt8m6nyQbuEbG4r6Il9YdgMfadQLezRk1zy5I6W58OdO/MC1xK
	69Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=oOEY+WjsWdeqBvkDP8wYY3p67vQ9vGesQK6b0+aIZeU=;
	b=kuYSd/i2IDT1MRfwU4cr6FgNwBzMMCwZKS4Kr4qi+s8mDbDmn00gN55ADv+0YSa0HF
	h02jgHWh8Dk5SMaDrk2mrYtwiS0i79YPjqaaubjhe1GVXJ4H2d2/OhyCe2/as+24zY4I
	kkbdT1P9kkxrgavyUqrOBJBJJ1VwVRn6RNvvUtQ5BXMrTt1xT4lDtJHZG3DYvs8gWV6y
	c2J7lu62TSXU2AJSWah3ci50VUUXuK+FRMbOkseH/D/m4yPGe7OMlgTgnfdpD0np2d2B
	3YjexB4jg7iAeW7Hw4vqNwWprBqpTiru9cRcR2Y1SZ96RSee48++4SYYxhN3tfFdYhlI
	WQow==
X-Gm-Message-State: AOUpUlGn5fayddhBZmLUf3aEbzD2VwrNHgryVo8tWUb/N+JDl4mUkBHl
	K+AxukCgi9uGldDT7SRXguB7qo1aSZedeqBXKBQ=
X-Google-Smtp-Source: AA+uWPzLlsZdBAuxor+R1Df/KSzyeb5EjySql2N/ZPMZQkBPg6XBQCl9onPLIK9hnom97iV28TXBD6oTUzmJGOk7ZeE=
X-Received: by 2002:aca:c00a:: with SMTP id
	q10-v6mr22893220oif.4.1534233431912; 
	Tue, 14 Aug 2018 00:57:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 00:57:11
	-0700 (PDT)
In-Reply-To: <20180814063203.GJ8291@hiutale>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Tue, 14 Aug 2018 09:57:11 +0200
Message-ID: <CALbNGRShtP9VAd9_vN-PrOAxXfSXJ0SGEzsSSC6_8CjSZrOxng@mail.gmail.com>
To: Mikko.Rapeli@bmw.de
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 14 Aug 2018 07:57:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 8:32 AM,  <Mikko.Rapeli@bmw.de> wrote:
> Just my 2 =E2=82=AC cents to the discussion:
>
> we had to limit number of threads because heavy C++ projects were using
> all of RAM and causing heavy swapping. Single g++ processes were eating
> up to 20 gigabytes of physical ram. It's not just the CPU which is the
> limiting factor to parallel task execution.
>
LOL: My first approach was to extra-spawn in case memory occupied is
less than 50%. That solution performed really bad. I think adding
tasks on a CPU performing already with ~100% just cause overhead
reducing overall performance. I think the target for best performance
is running CPU with 100% with as few tasks as possible.

Again: Major problem with this solution is that a low workload caused
by CPU waiting for hard-disk or resuming from spawns additional tasks.
That is totally wrong.

Andreas

