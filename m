Received: from mail-wg0-f45.google.com ([74.125.82.45])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1UUKIM-0005lu-Dn
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 19:13:09 +0200
Received: by mail-wg0-f45.google.com with SMTP id l18so1094677wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Apr 2013 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:content-type;
	bh=yUJTtOr49LWOjSXY/YVzaTrxQxx8miiqMjKqalpM5+c=;
	b=E94qG8wLEtkhUBiFj99qgsKSkz9iAH4rqIgEebOd9VB4bfX/MVQarDBcBV1EpYmFZd
	FImRqigKLMyOxPsGV+WaTFgzfaUhVMrdrMc/AHfQTdVL9KXTC0X8isYgAC/YhiSiWXHb
	t8xWRCkRS66VH9fUCHBFkNbCBjStxVnK5Dqrs4RiFfNNk9NJShTOJYyfLOM5HLd+RTjm
	onV0toMXb+SSU9nts7XlDHbxR6VBHeIYaIe2ZOHIkDwwIjyj7nsjKsJWKLuOoXHv6nI2
	SFX6u2iNYNvXLRgfWW/gias9BntUMUi+34vtdS6zzfxY4LfvLxcmc5F5fixED8MrNoCo
	5F2Q==
MIME-Version: 1.0
X-Received: by 10.180.20.37 with SMTP id k5mr15642305wie.27.1366649508954;
	Mon, 22 Apr 2013 09:51:48 -0700 (PDT)
Received: by 10.194.167.73 with HTTP; Mon, 22 Apr 2013 09:51:48 -0700 (PDT)
In-Reply-To: <1366640172.23738.12.camel@ted>
References: <1366640172.23738.12.camel@ted>
Date: Mon, 22 Apr 2013 12:51:48 -0400
Message-ID: <CAHUNapQoJ4kOsEMZ-FB9gcSVQcU0ZcY2EfOOGcAGScvueHXHAw@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Mon, 22 Apr 2013 17:13:14 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 22, 2013 at 10:16 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
> We'd add in some kind of
> timeout of say 15 minutes so that it would gracefully exit.

Hopefully this time-out will start at the completion of the most
recent bitbake command, rather than from its start?

> The reason for doing this is simple, it would allow commands to be much
> more responsive rather than having the cache/configuration loading each
> time which is where our current overhead is.

This sounds like a very nice feature to have.

> This would then lead into the second proposal which is to add better
> support for new commands.

It would be nice if there was a way to zero-in on an existing
environment variable. For example:

    $ bitbake -e <image>

produces a lot of information which I then have to parse in order to
figure out how a given environment variable is being set. It would be
nice if I could simply:

    $ bitbake -e <image> <variable>

and just get the pertinent parts.


