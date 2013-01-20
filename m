Received: from mail-bk0-f49.google.com ([209.85.214.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <yanglei.fage@gmail.com>)
	id 1TwmkP-0008F5-Mc; Sun, 20 Jan 2013 05:43:09 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so2596452bkc.36
	for <multiple recipients>; Sat, 19 Jan 2013 20:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=cRcT7G/CmmJRtz9MtEgQTHJg6KO7GOTi2H8PJ+rGMrE=;
	b=YTENvFl5el3ZbNbS4sFLLvo7m86lcJf0rDDtIEDB73m1p8edR+A7pZLJR79Kl5/+CT
	USmlWqDOjuOt+NzauPIJC6WjO5ikq57pAwrgpJvGAJ+RNMkvgUVIYvu7LyK4rpMmBwMv
	H5zmKUPmeXh+KrpWjaZbhAX0shTTh6p19B6OUxIZ8sVehkqBcZXoAoa4ithG31QC2ONi
	slSyVcDKGLUp2TrQQEjcF72wTiAk68e50Xy6yk/lLL3mOLJjndcO2BiRDe4mKNv6yPWV
	xElBD+FtMI1ow1EqNAVxqKteqyftc5q0Oqk6Umfr9OngCxBtDNH0gSF9TOBRTa5CkhZH
	giKQ==
MIME-Version: 1.0
X-Received: by 10.204.5.202 with SMTP id 10mr3646936bkw.135.1358656062822;
	Sat, 19 Jan 2013 20:27:42 -0800 (PST)
Received: by 10.204.11.86 with HTTP; Sat, 19 Jan 2013 20:27:42 -0800 (PST)
In-Reply-To: <CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
References: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
	<CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
Date: Sun, 20 Jan 2013 12:27:42 +0800
Message-ID: <CAHsH0E-Y5dLPvgqGCN57vt8BzKZy7ftdxZv7vL=HT0BYavCWcw@mail.gmail.com>
From: lei yang <yanglei.fage@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: git address in SRC_URI, doesn't works for me
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
X-List-Received-Date: Sun, 20 Jan 2013 04:43:10 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Jan 20, 2013 at 10:15 AM, Chris Larson <clarson@kergoth.com> wrote:
>
> On Sat, Jan 19, 2013 at 2:13 AM, lei yang <yanglei.fage@gmail.com> wrote:
>>
>> SRC_URI = "git://git.opensvc.com/multipath-tools/.git;protocol=http"
>> it doe noting,and trying to find COPING,but it doesn't clone it
>
>
> This is the correct syntax. The URL scheme (git://) determines what bitbake
> fetcher, and therefore what tool, is used to fetch. If you use http://,
> it'll try to download it with wget, not git.
> --
> Christopher Larson

But, the fact is git://git.opensvc.com/multipath-tools/.git can't be
used, you can't  git clone  git://git.opensvc.com/multipath-tools/.git
(git:// is not valid this this git repos)
but you can "git clone  http://git.opensvc.com/multipath-tools/.git",
I think bitbake doesn't handle this

Lei


