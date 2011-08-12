Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <tom.rini@gmail.com>) id 1QrtmA-0006o8-LY
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 17:35:58 +0200
Received: by yxi19 with SMTP id 19so2029319yxi.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=RrOefuInYpfCrKNcWcWZJQFQZLvsdp+cwMI6vmS0Tx4=;
	b=qaueD84MPEhmrtYhOHnbSfUnVYM3V3xffnA7gkQNvBmHBmn+t+gsbulBoASZpV/Wj7
	ZDJlJ9MF3cuhq9pvx+CoS/ktd9I+YH1k8IEvMoEarQDzE0Wy3oRfBn8onCTUy1QiWm65
	3K8/M/5X1hvRoI1AHmLaOm2gOVXn+cG1AEOeQ=
MIME-Version: 1.0
Received: by 10.42.246.137 with SMTP id ly9mr1042857icb.506.1313163085290;
	Fri, 12 Aug 2011 08:31:25 -0700 (PDT)
Received: by 10.42.213.1 with HTTP; Fri, 12 Aug 2011 08:31:25 -0700 (PDT)
In-Reply-To: <1313159106.14274.490.camel@rex>
References: <1313159106.14274.490.camel@rex>
Date: Fri, 12 Aug 2011 08:31:25 -0700
Message-ID: <CA+M6bXm2Pt6FVsKOogg47Wme5T0+G-3AA+7tbNeJSA51QAGGpQ@mail.gmail.com>
From: Tom Rini <tom.rini@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake/logging: Overhaul internal logging process
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
X-List-Received-Date: Fri, 12 Aug 2011 15:35:58 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 7:25 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> At the moment it bugs me a lot that we only have one effective logging
> level for bitbake, despite the logging module having provision to do
> more advanced things. This patch:
>
> * Changes the core log level to the lowest level we have messages of
> =A0(DEBUG-2) so messages always flow through the core logger
> * Allows build.py's task logging code to log all the output regardless
> =A0of what output is on the console and sets this so log files now
> =A0always contain debug level messages even if these don't appear
> =A0on the console
> * Moves the verbose/debug/debug-domains code to be a UI side setting
> * Adds a filter to the UI to only print the user requested output.

Can we also get a way (or big enough log level) to get timestamps thrown in=
?

--=20
Tom


