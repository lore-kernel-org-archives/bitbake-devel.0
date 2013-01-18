Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jon.szymaniak@gmail.com>) id 1TwH29-0000AY-1N
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 19:52:19 +0100
Received: by mail-ie0-f173.google.com with SMTP id e13so6710463iej.18
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2013 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=zr2g6rMEonkjSdh4PSrwPnQuiva3lf8xhnzByPqkzDk=;
	b=BTNI1zqL8b/a02k9g3pnsre1qRnX97JSmRHtthL4wjIhzLLgEN6wdQKj454THDuhN6
	PT0YVd+TukJ9ckSS9axKjqMhumMBunFnC8tXFfe/Rr1muTk99vZlfVrJb5qQZyvJ5nMY
	tpYP5hkhLb+wJwFI3hDrJ9ao2gfc4bw4aZDdDHgsCIaU2IdSVLH4iIDgGHT4OXCBIYvE
	P/mKL9iyuDqWkzrRPMnl2cJL/wJ/X605qSHDGEDDC5YaOUB4j7kUS1KuuY7YJmnfh53e
	gTGyCVdQtHBjR81h/PraeG7l5Xx7I8AajmFn9DZdkOHmXxkNaE9Zw22dx6Me18L2RvX/
	3ZwQ==
X-Received: by 10.43.83.1 with SMTP id ae1mr6800742icc.24.1358534155778; Fri,
	18 Jan 2013 10:35:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.12.129 with HTTP; Fri, 18 Jan 2013 10:35:34 -0800 (PST)
In-Reply-To: <1358513490.27799.23.camel@ted>
References: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
	<1355507217.32519.33.camel@ted>
	<CANge7vVQnTVasye41HJiB9JOMno4fTX5mn=p499y7kus5O4NQw@mail.gmail.com>
	<CANge7vURMxSYh=-O0ZHUWqopVjCkUwFMxhC8-bqHTy6J8mF2Mw@mail.gmail.com>
	<CABcZANmUyaCd0kx0FSq5Ye=OXKiKdziGfAyiy3dH9BxrJtEh6g@mail.gmail.com>
	<CANge7vVSFKAxDYyXh40bFP-uEpu+Otwbhdx69QrX0YgTaGhNjg@mail.gmail.com>
	<1358513490.27799.23.camel@ted>
From: Jon Szymaniak <jon.szymaniak@gmail.com>
Date: Fri, 18 Jan 2013 13:35:34 -0500
Message-ID: <CANge7vUkt+m6iPddVXqrjr4r8HGV9KtjYFvRLX4TMaYNk4sBNw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Chris Larson <clarson@kergoth.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: hg fetcher failures for SRCREV set to a tag
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
X-List-Received-Date: Fri, 18 Jan 2013 18:52:21 -0000
X-List-Received-Date: Fri, 18 Jan 2013 18:52:21 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jan 18, 2013 at 7:51 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Sat, 2012-12-22 at 12:36 -0500, Jon Szymaniak wrote:
>> >> Hi Richard,
>> >>
>> >> Thanks for pinging back on this. (Sorry I just double-sent this to
>> >> you. Forgot to include the list! :P)
>> >>
>> >> I think a fairly simple solution might be to just clone the entire
>> >> repo by not adding "-r REV" to options[] for an 'hg clone' invocation.
>> >> The 'hg update' that follows on lines 142-147 should set the repo to
>> >> the desired revision.
>> >
>> >
>> > This does sound like the best bet, to me.
>> > --
>> > Christopher Larson
>>
>> Hi all,
>>
>> Just wanted to touch base on this issue. I didn't hear anything back
>> on the little patch I posted...not sure if that's a silent rejection,
>> if I didn't include the right info in the subject line, or if folks
>> haven't had a chance to test it. If there's something I screwed up,
>> please do let me know for future reference. :)
>>
>> http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-December/003962.html
>
> Sorry about the delay, vacation and lots of other distractions. The
> patch was find and I've merged it now, thanks. I did have trouble
> applying it as it appeared the whitespace was messed up. I fixed it up
> manually this time though.
>
> Cheers,
>
> Richard
>

Richard,

Thanks for pinging back -- I know it's certainty that busy time of year. :)

If you happen to have any details on those whitespace issues, mind
shooting that my way? I'd like to get a feel of where I screwed up
there. (e.g. email client, stuff in my .vimrc, etc)

Thanks,
Jon


