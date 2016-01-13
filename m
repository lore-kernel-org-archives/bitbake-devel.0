Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id B96DF6067D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 23:20:03 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id b14so396355619wmb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 15:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=1Co4gzv/U9UUl/ISHLjA0NQFRrenu+g8yAeFY7NBPMk=;
	b=knKLEi+s0LQ8RYO1A8a+LEkPtOAUJwY5ABJ99sNpBxyRTOZ1xh7qgCLSYrOWWn+i3J
	d8lTpzdW9OrvEQLII+SnuCALET76r5DhkktKtcUUSPJ5Xpx1YxfEASxatLImESrnzxMj
	suNc11+cNS86td60jbIgzll1Bg+GNfQLK3Vt9X/dJN/psJ0h8pe1pJXeHajsKKofVUSb
	bR8Y21OuQil42Vhs491KKzI00+ocLWngdvSeDB1xigkdvoqjrqiZkEPcJt5ETmbLcrKB
	zu2ZXDkfZBPe4CWN/fuir+AHwukSEMBFRw+zuNL7UOE04Fe6vtBqaKvhcqqXN+xGzyhl
	lTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=1Co4gzv/U9UUl/ISHLjA0NQFRrenu+g8yAeFY7NBPMk=;
	b=UL/F+S5Eb8Uq/C5PiSuwmtRXdDQqxio4wrQ1CyK7yqZupZB/ey8Z+0NvX/w3l0Wh/f
	62t0NLj1Scgk3i0irh9X9UTxf473GFog3R5BJ4ITEtLOvJjGDUs7adcKjFL5Ab1/K7dy
	5+fvglm/6Upm5trd2EIom2LNjObP4W6cN0XpHygwj/VF7+Uc62/QBM0XWOqFVDx9hor/
	xZ+2khyscpS0IZ2NPOw9dDz2yY7ple8Zf2Df3kq7GzPUcWG9YvdKfjAp2LHekhFtKMYq
	dil5TUTmCAsILjPL19Mso57d3CsNUBb0AqbAZXZ8G5Al75Z/HMX0FmvJDrL03/74RiJa
	Gg3A==
X-Gm-Message-State: ALoCoQk3km1IwjX0uYAe9diVHk3pMb8RPVZYRRFK6gvgc6qWoIZHiDm7kqR5mC5zLBy2fZ/tpgYRC0vTSUP7UTn/JFvNFA0Wxw==
MIME-Version: 1.0
X-Received: by 10.28.182.133 with SMTP id g127mr12122739wmf.61.1452727203741; 
	Wed, 13 Jan 2016 15:20:03 -0800 (PST)
Received: by 10.194.209.131 with HTTP; Wed, 13 Jan 2016 15:20:03 -0800 (PST)
In-Reply-To: <1452723582.28375.118.camel@linuxfoundation.org>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
Date: Wed, 13 Jan 2016 15:20:03 -0800
Message-ID: <CAJ86T=XoCWwjRwMC7rhGHkpNnCdm=moWQe4+GiSUrZx182T_hg@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Wed, 13 Jan 2016 23:20:03 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 13, 2016 at 2:19 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Wed, 2016-01-13 at 13:37 -0800, Andre McCurdy wrote:
>> On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>> > Some servers, e.g. bitbucket.org can't cope with ssh:// as part of
>> > the git url syntax. git itself is happy enough with this but you
>> > get server side errors when using it.
>> >
>> > This changes the git fetcher to use the more common ssh url format
>> > which also means we need a : before the path.
>>
>> This seems to break SRC_URIs using ssh to access self hosted git
>> servers setup following the process described here:
>>
>>   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Ser
>> ver
>>
>> An example of such a SRC_URI, which now fails to work:
>>
>>   SRC_URI = "git
>> ://git@mylocalserver.com:/opt/git/myrepo.git;protocol=ssh"
>
> Does:
>
> SRC_URI = "git://git@mylocalserver.com/opt/git/myrepo.git;protocol=ssh"
>
> work though?

Removing the ':' breaks things from the command line, but it does work
OK in a SRC_URI (previously because of the ssh:// prefix and now
because the fetcher is effectively adding the ':' back again).

Updating my SRC_URIs looks like the best solution.

> I'm not sure we ever suggested people should use ":/" in SRC_URI since
> that isn't a url format the system was ever designed to cope with. It
> might have happened to work but that is different...

":/" comes from the examples in the git-scm.com documentation:

  https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server

It would be nice if those examples (continued to) work in SRC_URIs and
it's also nice if git URLs from SRC_URIs can be tested with git on the
command line. Maybe those goals aren't worth the extra complexity
though...


> Cheers,
>
> Richard

