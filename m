Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QrtrY-0006uJ-6b
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 17:41:32 +0200
Received: by vxj14 with SMTP id 14so2726414vxj.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=1S/xKkf/phlRnCLPha1qRje03G1o75vbV109HS5YyYA=;
	b=Mim7Oys5dgm6viMB8rQFkilwiYz8sqV07HPEoiaSHf0jiLDrO2SJOxnB/aC/Tq3cHw
	zQcfdwv6xZo+hVIvfsPxnZZbSAMaWYTWSSn5T/y3D1feYh74YFgvK56xCBT6cg0YX8wH
	aRl9ZVV5OD4Db66hSG379qNneB9/Moog1QaWA=
Received: by 10.52.176.97 with SMTP id ch1mr946394vdc.297.1313163419062; Fri,
	12 Aug 2011 08:36:59 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Fri, 12 Aug 2011 08:36:39 -0700 (PDT)
In-Reply-To: <CA+M6bXm2Pt6FVsKOogg47Wme5T0+G-3AA+7tbNeJSA51QAGGpQ@mail.gmail.com>
References: <1313159106.14274.490.camel@rex>
	<CA+M6bXm2Pt6FVsKOogg47Wme5T0+G-3AA+7tbNeJSA51QAGGpQ@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 12 Aug 2011 08:36:39 -0700
X-Google-Sender-Auth: ZT95E4Nasg-oTPvpy0S864CX6Do
Message-ID: <CABcZANncyNeZPg8aJ0D6bUkBbSTdLPOomORCaQpajDgN-kGPtQ@mail.gmail.com>
To: Tom Rini <tom.rini@gmail.com>
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
X-List-Received-Date: Fri, 12 Aug 2011 15:41:32 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 8:31 AM, Tom Rini <tom.rini@gmail.com> wrote:
> On Fri, Aug 12, 2011 at 7:25 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> At the moment it bugs me a lot that we only have one effective logging
>> level for bitbake, despite the logging module having provision to do
>> more advanced things. This patch:
>>
>> * Changes the core log level to the lowest level we have messages of
>> =C2=A0(DEBUG-2) so messages always flow through the core logger
>> * Allows build.py's task logging code to log all the output regardless
>> =C2=A0of what output is on the console and sets this so log files now
>> =C2=A0always contain debug level messages even if these don't appear
>> =C2=A0on the console
>> * Moves the verbose/debug/debug-domains code to be a UI side setting
>> * Adds a filter to the UI to only print the user requested output.
>
> Can we also get a way (or big enough log level) to get timestamps thrown =
in?

I think it would be nice to provide a way to influence the format
string used by the formatter in the UI, either directly, or via a
logging configuration file as supported by the logging module.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


