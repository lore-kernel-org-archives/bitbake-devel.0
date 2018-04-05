Return-Path: <kergoth@gmail.com>
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com
	[209.85.217.179])
	by mail.openembedded.org (Postfix) with ESMTP id 4777374690
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Apr 2018 16:09:46 +0000 (UTC)
Received: by mail-ua0-f179.google.com with SMTP id g2so9949508uan.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Apr 2018 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JzPyohnGMZnbADODYwBwTi6tEbFli9QQKrQIT1uH794=;
	b=S6gvL8pbfSh8NatHhT3wr5+LEUYA/ck7iLGCF0OusKRQ92YdL8IyaAFkF7XgWHNApF
	TJVVcShy3RKezlSzLkD88sG1Lfg8PCtzk68ZAiyoIdW392sPfkIY/L2HFzJ1LTiqUpKw
	Xobkw/XTSjFGvofbtXlgRQi/j+sHiyOnIZSVupw+VSCy3DtkcvNs2oQex34r17n6j8eo
	fpAA1eYwHmglRkCCovYlik1PFOkzaC5vh7H7s+5JqwgeB8iL47EpVY1F/SWzVsWbIpmo
	wyzjYYDyCZ2NeIU/4iRbOr073WX12zz0FivxguzJRcqg9AWJvGYyDH/iJpXnNXOY+5wx
	iwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JzPyohnGMZnbADODYwBwTi6tEbFli9QQKrQIT1uH794=;
	b=dMyTSWDbbjkfGy26BRc0L/ADtjkCpyxJpv3Dv+GQC1YwYuxCBZygXP2ltX+MHoHcSi
	OYRxJcbF0u3a7r6AzMEcI+rwUm5ZdZVcc6wV6O7znX5nN92TLgaAxOk0iSCsDm5xcldY
	tPcckMa7mswSfwkHquBuICqz6LvPL88+9gYoGfBuHvbbuRs2O5yhfUpSFNCRgmaoE3jC
	TLx2jjRwrR+QeEbhTUGmpgdktRYjbKRe/5c7P0c5qGak4feGc84JkgKlgnufKh4nzLVv
	irdErRSXgM8VVXfzok9VNmj+tDVWXSt16MCPKiRwWLZZ8i0C+CthC6lrpE5PuSbUe7lf
	K7gw==
X-Gm-Message-State: ALQs6tA6KS+M9rIS//LRz205fbsuXsHeh6xwxPRo97jH7qKnu4aP3su4
	i3/9InwIJDJAe95uwk5n7OR7nya2Uw1H2MaUsQU=
X-Google-Smtp-Source: AIpwx4995WJpGo9cn5hBkXmWSG4iexhACn/LoMcAiYcWplYg3i4sWzZZBBsbj/EgeluurtlVC+MBZ3qFhQ3LKV8kSUk=
X-Received: by 10.176.75.85 with SMTP id i21mr15361526uaf.161.1522944587787;
	Thu, 05 Apr 2018 09:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvz69xX76ukua1z=t9OxeXKxx_K=UFO_C47QDux-nCSN_eZwg@mail.gmail.com>
In-Reply-To: <CAAvz69xX76ukua1z=t9OxeXKxx_K=UFO_C47QDux-nCSN_eZwg@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 05 Apr 2018 16:09:37 +0000
Message-ID: <CABcZANnfqLf35E5Sp4zGeN4yZ4DZUrE+Ue_OKZ_yHZZeYyExcw@mail.gmail.com>
To: Daniel Levin <dendy.ua@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditional DAG recalculation at build time
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
X-List-Received-Date: Thu, 05 Apr 2018 16:09:47 -0000
Content-Type: multipart/alternative; boundary="f403045e90b62af2ad05691c2b3f"

--f403045e90b62af2ad05691c2b3f
Content-Type: text/plain; charset="UTF-8"

Afaik Bitbake does not currently have that capability. It's a feature I've
wanted to add for a long time, but it hasn't been a priority for us up to
now. I believe patches to add such a feature would be welcomed. I'd suggest
opening a bug in bugzilla for tracking potential future development of such
a feature.

On Mon, Apr 2, 2018 at 3:23 PM Daniel Levin <dendy.ua@gmail.com> wrote:

> In short: does bitbake support dependency graph recalculation at build
> time?
>
> I am looking for a dependency resolution similar to BYPRODUCTS in CMake
> and restat in Ninja.
>
> In other words when task _after_ execution might tell that output did not
> actually change. So all dependencies of that target should not be updated.
> Even when initially they were treated as (potentially) to be updated.
>
> Usually in CMake that results in remaining task count decreased instantly
> during build time, because in fact they must not be running.
>
> I found documentation in bitbake about task _input_ checksum, which is
> used to evaluate whether task need to be executed.
> So I am looking for the similar checksum for the task _output_. And when
> task does not change that output checksum means that dependencies of that
> output does not need to be triggered.
>
> If this topic is well known and documented then could you please point me
> to the appropriate section in the documentation?
>
> Thanks,
> Daniel
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--f403045e90b62af2ad05691c2b3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Afaik Bitbake does not currently have that capability. It&=
#39;s a feature I&#39;ve wanted to add for a long time, but it hasn&#39;t b=
een a priority for us up to now. I believe patches to add such a feature wo=
uld be welcomed. I&#39;d suggest opening a bug in bugzilla for tracking pot=
ential future development of such a feature.</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr">On Mon, Apr 2, 2018 at 3:23 PM Daniel Levin &lt;<a h=
ref=3D"mailto:dendy.ua@gmail.com">dendy.ua@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">In short: does bitbake su=
pport dependency graph recalculation at build time?<div><br></div><div>I am=
 looking for a dependency resolution similar to BYPRODUCTS in CMake and res=
tat in Ninja.</div><div><br></div><div>In other words when task _after_ exe=
cution might tell that output did not actually change. So all dependencies =
of that target should not be updated. Even when initially they were treated=
 as (potentially) to be updated.</div><div><br></div><div>Usually in CMake =
that results in remaining task count decreased instantly during build time,=
 because in fact they must not be running.</div><div><br></div><div>I found=
 documentation in bitbake about task _input_ checksum, which is used to eva=
luate whether task need to be executed.</div><div>So I am looking for the s=
imilar checksum for the task _output_. And when task does not change that o=
utput checksum means that dependencies of that output does not need to be t=
riggered.</div><div><br></div><div>If this topic is well known and document=
ed then could you please point me to the appropriate section in the documen=
tation?</div><div><br></div><div>Thanks,</div><div>Daniel</div></div>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--f403045e90b62af2ad05691c2b3f--
