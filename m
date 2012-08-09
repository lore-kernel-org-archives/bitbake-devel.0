Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SzX7r-0005vX-0c
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 20:06:27 +0200
Received: by lban1 with SMTP id n1so369855lba.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Aug 2012 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=RPPy3lBnzJ1OcE0NVxz9+Xgs2EWczpQS1jGL50VEvI4=;
	b=TympqqiQVP1j3e8U66IzRr8ZwcP4wQoGaiPQEbX6daPdp32JhCDAssTHIpdmR01yIZ
	O5uIj688SkGo9NfaFTarGBS813kabzX3qiATzuylcQtvoCEA2QTD5PjGKmauCjLYTtuf
	4dJhDk3VoZ8cFWdW3Awn6OXIlUYALKlD476D5Of0kA3khSv0tS/09nynpJ6rNOttwNZ/
	7mem2451fL6dvI8JQpFuiddafyClpgCgMGGfuHdx3uIOZW+UzV/0KQ47mLfSo+oqVICQ
	/fcaT3h3tLWWkdeUduIwwZjAgEah9xjLCortsBI1O6dEfw+INZoGxEPjx+LU9qGdk0IL
	0oiQ==
Received: by 10.112.100.234 with SMTP id fb10mr1235559lbb.12.1344534878353;
	Thu, 09 Aug 2012 10:54:38 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.64.209 with HTTP; Thu, 9 Aug 2012 10:54:18 -0700 (PDT)
In-Reply-To: <20120809124425.797f12fa@e6410-2>
References: <cover.1344467794.git.peter.seebach@windriver.com>
	<9005aeb8b41113f05121842055434fdeeda8c63c.1344467794.git.peter.seebach@windriver.com>
	<1356576.1YqSGvrhCQ@helios> <20120809124425.797f12fa@e6410-2>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 9 Aug 2012 10:54:18 -0700
X-Google-Sender-Auth: hHrwAh3tsj6wVUGag5Nb-u6YoW8
Message-ID: <CABcZANkAA0zafxPckoOTOEoQvY7PerX0HtOHnnn7wW93d0dSJA@mail.gmail.com>
To: Peter Seebach <peter.seebach@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] cooker.py: Remove explicit build targets from the ignored list
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
X-List-Received-Date: Thu, 09 Aug 2012 18:06:27 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 9, 2012 at 10:44 AM, Peter Seebach
<peter.seebach@windriver.com> wrote:
> On Thu, 9 Aug 2012 18:30:57 +0100
> Paul Eggleton <paul.eggleton@linux.intel.com> wrote:
>
>> I'd rather we not change it to behave this way - the better approach
>> would seem to me to be to just print a warning that the requested
>> target is in ASSUME_PROVIDED and then not do anything else; if the
>> user really wants to build the thing they can just remove it from
>> ASSUME_PROVIDED.
>
> Removing things from ASSUME_PROVIDED can be a bit tricky, because they
> can come from more than one place. And it may not be easy to see where
> they came from. (In my most convenient build, there are at least two
> files setting ASSUME_PROVIDED.)

For what it's worth, I agree with Peter's approach on this. The user
should always be able to override assumptions. Explicit should win.
Technically variables can be explicitly set by the user as well, but
generally speaking I think we have always interpreted the command-line
as overriding the metadata when appropriate. Consider BBPKGS, which is
a list of providers to build if and only if the user doesn't specify
any.
-- 
Christopher Larson


