Received: from mail-qy0-f182.google.com ([209.85.216.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <tom.rini@gmail.com>) id 1RMO9N-0001Ao-58
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 Nov 2011 19:05:57 +0100
Received: by qyk9 with SMTP id 9so2453830qyk.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Nov 2011 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=sJzT7vqAcw8X+xQzZV3TfAIzoYD1jF9uo6BVNoyzWdE=;
	b=ms+51jJdyiK6cko4z06mj3uVPpb/hwJ6/9Ql50fsv993cqpuB+JVSb7V/Yh+7lliHv
	wRr/M5u87CBghXkPR+NjuGyOrMyWA5pvAfa5R5hCCijrFsZUhIXbbNPLU0uxHpAOcn1e
	m1H8rZrYjIVCJOZ2ChNKPhMrav8Tv4F7f6QHs=
MIME-Version: 1.0
Received: by 10.229.251.73 with SMTP id mr9mr214615qcb.264.1320429159447; Fri,
	04 Nov 2011 10:52:39 -0700 (PDT)
Received: by 10.229.94.72 with HTTP; Fri, 4 Nov 2011 10:52:39 -0700 (PDT)
In-Reply-To: <CABcZANmwa=kYAM9MEtWd6LQtG=1y5SGN5duv-LkBzDaLyZuS=w@mail.gmail.com>
References: <1320416679.20107.114.camel@ted>
	<CABcZANmwa=kYAM9MEtWd6LQtG=1y5SGN5duv-LkBzDaLyZuS=w@mail.gmail.com>
Date: Fri, 4 Nov 2011 10:52:39 -0700
Message-ID: <CA+M6bXmk1ks2t8UFHJK-s_ZH9jf0okMC11e4oDbg5QG0yCLkRA@mail.gmail.com>
From: Tom Rini <tom.rini@gmail.com>
To: Chris Larson <clarson@kergoth.com>
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
X-List-Received-Date: Fri, 04 Nov 2011 18:05:57 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Nov 4, 2011 at 7:29 AM, Chris Larson <clarson@kergoth.com> wrote:
> On Fri, Nov 4, 2011 at 7:24 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> Now we have the 1.14 release out there I'm tempted to remove the fetch
>> v1 code from master.
>>
>> Any strong objections?
>
> Sounds like a good plan to me. Those using classic can stick to the
> 1.14 branch or earlier.

With my 2011.03-maintenance branch hat on, this works for me.

-- 
Tom


