Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RMKrv-0001t7-Ld
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 Nov 2011 15:35:43 +0100
Received: by wyh5 with SMTP id 5so2533157wyh.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Nov 2011 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=ipZwigHpeXvk/ekm157PGXAXD+aL3BWmDObOcY9OBaA=;
	b=DHuEbO5giOwy3D7dl1x9euAD2jfESAg5AJHLf45FmYSaU9u3/z/OlD1IlhPQlYl+4E
	IeHZA9/t37bWmbDbg2nz8aQMqvq3Dzk3XfFVxRI+4V8GYKmGiOtFZAhUX+kSNPNsSkWq
	3YQfAFhrIQIIWVk0L060/7xUjIswL/AyJpnyw=
Received: by 10.216.221.163 with SMTP id r35mr4568389wep.21.1320416971093;
	Fri, 04 Nov 2011 07:29:31 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.28.138 with HTTP; Fri, 4 Nov 2011 07:29:09 -0700 (PDT)
In-Reply-To: <1320416679.20107.114.camel@ted>
References: <1320416679.20107.114.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 4 Nov 2011 07:29:09 -0700
X-Google-Sender-Auth: HuZCEAT4zGlyX6i1hEQ1AqsQyrE
Message-ID: <CABcZANmwa=kYAM9MEtWd6LQtG=1y5SGN5duv-LkBzDaLyZuS=w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Removal of fetch v1 from master?
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
X-List-Received-Date: Fri, 04 Nov 2011 14:35:43 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, Nov 4, 2011 at 7:24 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Now we have the 1.14 release out there I'm tempted to remove the fetch
> v1 code from master.
>
> Any strong objections?

Sounds like a good plan to me. Those using classic can stick to the
1.14 branch or earlier.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


