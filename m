Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1TcwlA-0001SS-UM; Mon, 26 Nov 2012 12:21:57 +0100
Received: by mail-pb0-f47.google.com with SMTP id un1so5671760pbc.6
	for <multiple recipients>; Mon, 26 Nov 2012 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type;
	bh=Qxiu2iJO7fiCaF3zhCBka1ok0k5pFNO9tnXaoQ60424=;
	b=luM9t6ixy9IrFCXjn+WSnTNZDzWnWdHCHCGCMAiqsQagRSJFyys1DGFxtH2oMzRT7t
	+zGSQ2aRSCS/6k4sRsNtCHNlEEYJel7BnbyfiVlnsnJuSQYebia+LLQ9+w1gvRTkiUy7
	Pk3M+ucMAT8LKAgOUJXFzVqKo5ghdxwgYeO428affagjsj3lUu/dTC6esqBi1K7wD5wx
	WCs5qkS1vIwOY/2mmWFyHDl7Suh9pKWPD4IYi6uH/4/6/CevGlm10xUdP9oz06wNL0fX
	c5Bd8BPjM1RMdPU0hjt1kIf5tAeoO66EBncepjIPMWiqKgp6fgV/5HMnQ6iiXwAZg6nm
	ydHA==
MIME-Version: 1.0
Received: by 10.66.81.198 with SMTP id c6mr16981991pay.50.1353879845224; Sun,
	25 Nov 2012 13:44:05 -0800 (PST)
Sender: otavio.salvador@gmail.com
Received: by 10.68.16.225 with HTTP; Sun, 25 Nov 2012 13:44:05 -0800 (PST)
In-Reply-To: <1353878494.21863.26.camel@ted>
References: <1353691611.1361.28.camel@ted>
	<CAP9ODKqPx8AE9O66ALLkpwXDFxr1outs_tdeDG2DnyZdw9Q=Ag@mail.gmail.com>
	<1353699909.7352.2.camel@ted>
	<CAP9ODKqQnj4ot2kF7FPYj2QxtT+hr5QTaD_UJhVQM6cSLP3cfg@mail.gmail.com>
	<1353878494.21863.26.camel@ted>
Date: Sun, 25 Nov 2012 19:44:05 -0200
X-Google-Sender-Auth: NuYe-eRwPFtYS-u4z81owAe0FkU
Message-ID: <CAP9ODKo1a-R-r2X+PWuPYuE9zJLtpz+nYhZgBwEx-sw3DCG-Mg@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Constantin Musca <constantinx.musca@intel.com>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] RFC: Versioning of git recipes (and incremental PR)
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
X-List-Received-Date: Mon, 26 Nov 2012 11:21:57 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Nov 25, 2012 at 7:21 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Sat, 2012-11-24 at 11:55 -0200, Otavio Salvador wrote:
>> On Fri, Nov 23, 2012 at 5:45 PM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>> > On Fri, 2012-11-23 at 17:23 -0200, Otavio Salvador wrote:
>> >> I like to idea of a single updating place. What I dislike is AUTOINC
>> >> not being taken care in the fetcher.
>> >>
>> >> In this case any GIT revision changes, the AUTOINC won't bump as usual
>> >> (without PR server)?
>> >
>> > Why do you need AUTOINC to bump? The only reason we have increments in
>> > the fetcher is for package upgrading...
>>
>> Yes but in this case the fetcher won't change AUTOINC and you'll have
>> same revision even when changing SRCREVs. This will break the upgrade
>> path for people not using PR server, no?
>
> We're going to need the PR server for upgrade paths in future regardless
> so that shouldn't be an issue.

Yes I agree but in this case this change would need to wait for PR
server to be the default before be applied.

-- 
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br


