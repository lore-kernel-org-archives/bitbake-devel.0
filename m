Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1QXM8z-0004Ye-PC
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Jun 2011 01:38:37 +0200
Received: by pwj9 with SMTP id 9so1043113pwj.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=8stlZsMt8O87Yayw0i4EjD6MiuSZ4RQ/roVrXGKsobM=;
	b=Mg65BL1SohO+xPWvbzajPLFzQu+lVH+HD38tMkG8FyQCxKbAZHdqPQQPgj3mXXlkgu
	tFWxDrV31W2EnBpTALJ3yhbDeDArdlBQiONa/yPnYN/z5WuG8e4z0GwYqG2dhtW48izO
	Tu8pQfZvQyGQyTizUYMltPh00v35BMQ/ZQMkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	b=xru3E1BUstjLgnpW81+KmwfKkSMb7fSEt6c6ZbyTVoHlPoWt4oLRDNSIa342JhztXf
	KC2fS0/QpZAJaS5YnejdSOiASZvkTvfaNcI4RGdZOc5CSQvhrLljWWWJt76i8sUIMm9v
	H2oTQVh1ckGJ7Xzxnt9BYSWDBnpq+/Ib/ffTI=
Received: by 10.143.79.6 with SMTP id g6mr280438wfl.275.1308267308909;
	Thu, 16 Jun 2011 16:35:08 -0700 (PDT)
Received: from [192.168.1.70] (99-57-141-118.lightspeed.sntcca.sbcglobal.net
	[99.57.141.118])
	by mx.google.com with ESMTPS id z39sm1404197wfd.23.2011.06.16.16.35.06
	(version=SSLv3 cipher=OTHER); Thu, 16 Jun 2011 16:35:07 -0700 (PDT)
Message-ID: <4DFA9328.8040605@gmail.com>
Date: Thu, 16 Jun 2011 16:35:04 -0700
From: Khem Raj <raj.khem@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1308232450.15712.436.camel@rex>
In-Reply-To: <1308232450.15712.436.camel@rex>
Subject: Re: Couple of nasty bitbake issues
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
X-List-Received-Date: Thu, 16 Jun 2011 23:38:38 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/16/2011 06:54 AM, Richard Purdie wrote:
> We have two nasty bitbake issues I've found:
>
> a) Our event handlers don't behave quite as you'd expect due to the use
> of global namespace.
>
> Basically, if you *ever* register an eventhandler, even in an optional
> class like native or nativesdk, your will always subsequently get called
> for any event.
>
> This means a handler in native.bbclass will see parsing events for a
> recipe which doesn't use it. The problem comes from ast.py:
>
>      all_handlers = {}
>      for var in bb.data.getVar('__BBHANDLERS', d) or []:
>          # try to add the handler
>          handler = bb.data.getVar(var, d)
>          bb.event.register(var, handler)
>
> Since we register the handlers but never un-register them or only call
> the ones which the current recipe uses.
>
> I can work around this for now but we really should fix this.
>
> b) The none server is totally broken for logging during parsing. Trying
> to cram two combine two pieces of code into one main loop turns out not
> to work so well.
>
> The first problem is that any events coming from the sub processes
> forked off during parallel parsing don't get sent to the server/UI. I
> know this has been commented on by various people, this is the root
> cause. I was able to fix that by borrowing queue code from the process
> server, so far so good.
>
> The problem then is the logger, since the logger in the UI uses the same
> namespace and setup as the one in the server. The one in the server is
> supposed to fire() events, the one in the UI is then meant to write them
> to the console. Trying to do both things in the same process goes
> horribly wrong. I have a hacky fix where each event is just seen twice
> but it doesn't look like an easy problem to solve. I'm unable to find an
> easy way to setup two loggers in parallel copying the config from one to
> the other which is ideally what is needed.

Does something like this can help
http://www.valuedlessons.com/2008/04/events-in-python.html

>
> I like the none server as its simple to debug. At present its looking
> like it might be too ugly to fix this though. My hacks are:
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/ml&id=a3a130b3c6ca760066ca830eb46fa472ecb84c88
>
> Cheers,
>
> Richard
>
>
>
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



