Received: from mail-qw0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Rkf6y-0004DF-FQ
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:03:48 +0100
Received: by qabj40 with SMTP id j40so207312qab.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2012 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=/qXK347QBtwC13VCXOjh9qTNrEj5eukl1T+JH+UpPDE=;
	b=E25C1mKITPYJuDyeqziQbYeIyq1tvRhAuZ0W0L5atTT8pM6mOZJokgYHvoxCMtJsgY
	OoNUXG0V5m85e1fiBXH6G75xVNaRFaagUlGSaKhcl2CuWsy7DJEX30INyV8ROc0lDInZ
	aHXYwg/MB7JcqV73JdTTOHuISruCRMvG0vKfE=
Received: by 10.224.186.72 with SMTP id cr8mr25673337qab.95.1326214578484;
	Tue, 10 Jan 2012 08:56:18 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.187.141 with HTTP; Tue, 10 Jan 2012 08:55:57 -0800 (PST)
In-Reply-To: <1326128453.9278.23.camel@ted>
References: <1326128453.9278.23.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Jan 2012 09:55:57 -0700
X-Google-Sender-Auth: Wna7_sMFk7I9CvRuUXDKrWvuTY8
Message-ID: <CABcZANk6NM5DrpPhzX9iY60mmyyMHE=w45V+Gd7DL7ox5WY4GQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/knotty: Show summary of warning/error messages shown
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
X-List-Received-Date: Tue, 10 Jan 2012 17:03:48 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Jan 9, 2012 at 10:00 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Show a summary count of warning/errors messages shown to the user during the
> build and make it clear when an error exit code is being set.
>
> [YOCTO #1540]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

This is a nice start, good idea. For the future, I think we should
consider gathering up warning/error messages themselves and showing a
summary of the problems seen at the end, rather than just a count. The
problem there would be keeping sufficient context (e.g. task
associated with the message).
-- 
Christopher Larson


