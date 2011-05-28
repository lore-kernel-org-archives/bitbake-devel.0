Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1QQ7yp-0002pV-Km; Sat, 28 May 2011 03:06:18 +0200
Received: by wye20 with SMTP id 20so1840550wye.6
	for <multiple recipients>; Fri, 27 May 2011 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=hwdb6KHYdlDjPnwM7Xj9XPzxK2wmO8wXOGm4fgUIy+E=;
	b=G6adMZZVvI7PoVZa0ue/vbxEkukswWEHz7OtdRfpjMz5Mr06fPj7bLZZ/RsDi6YN1b
	CjDaqNxZc+bpF71DS15g6I+Q/F4O0pcVAZCw2FEhwG1rvqwCJLdqnPGK4uh1BtScZz53
	mTr9rI1nBmlOLsd9gIQaNetq/DbbXuyFxnXAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	b=YyjgHpPMzVSYG98IdjLrwvxsleXvJ0s9n8j0AY++7dxprbnz+qSjkZ6QMUxJ93K1Jb
	aIyuRAe3P85q3SADgBiNfmWzmL5UsTWiGqtgTgOqyvxaT1JMDCoUK0ORJ8faBrMQed58
	gB9ImMjAffd6P1esscq+UkRKzKA2kDBmcbWb8=
Received: by 10.216.235.33 with SMTP id t33mr2607619weq.6.1306544590099; Fri,
	27 May 2011 18:03:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.60.145 with HTTP; Fri, 27 May 2011 18:02:40 -0700 (PDT)
In-Reply-To: <1306534180.27470.305.camel@rex>
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal> <1306534180.27470.305.camel@rex>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 27 May 2011 18:02:40 -0700
Message-ID: <BANLkTim9C=WvgeHDxVNpKBQQ4jLBucOftQ@mail.gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 28 May 2011 01:06:18 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, May 27, 2011 at 3:09 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2011-05-27 at 13:09 -0700, Joshua Lock wrote:
>> Upstream BitBake still has the xmlrpc server removed. The version in
>> Poky's BitBake is functional (I use it daily).
>>
>> Attached are two patches against BitBake master to add back the xmlrpc
>> server (copied from Poky's tree) and fix the uievent.
>
> There have been API changes in upstream which mean this code will fail
> to work with bitbake itself although it will work with the pr server.
>
> I've merged the patches as a bandaid to allow things to work but we've
> now got two different server backends using different server APIs. I
> really just want to highlight I'm aware of this and it will get
> addressed next week. Its been on my todo list and is way overdue. The
> main priority is to get people's builds with OE-Core working again.
>

btw. I am at 6c412f009e33e77cbcb5d4881c110e6bdda05282 of bitbake
I still see the problem

> Cheers,
>
> Richard
>
>
>
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core
>


