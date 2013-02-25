Received: from mail-qe0-f51.google.com ([209.85.128.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <elizabeth.flanagan@intel.com>) id 1U9nnl-0002Z3-Co
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 03:29:03 +0100
Received: by mail-qe0-f51.google.com with SMTP id nd7so449020qeb.24
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Feb 2013 18:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=RLOJnytxsi0kNF/s1aF1lblMcis2LlOGrx8CJNgXuKM=;
	b=PXKaB4ZbyLRb+kw8muJSGKGCTY6nHgs82/JtgGcnzH/Hlc9SYu7iBWJAx25jZnAnkw
	DImJwljk6mDNXDRczAdmKo4k2Ik4bGye+6egogyFfK/Mxh+CLng3xCN1+aJ45bRut+0S
	LQgbIvwTevz9yfkvFq+lTW+MTp5jJYq6/3A/fBHThhFW1uHNJRf2icko0nhShIzPe5hz
	dnj6bjI3xzbFrPtZ79ahrmFBKNbShfIFfETle+SIMVi1Oh081dOZ1UdZDgLXZHeKQg6E
	gG2uD+4vAl2Yp1kNEMk7OV6HM0wQCufCTMRGJyw70dP7XeiG077whxLnWvYG9l5VAhTY
	du7g==
MIME-Version: 1.0
X-Received: by 10.224.213.134 with SMTP id gw6mr3715511qab.72.1361758327952;
	Sun, 24 Feb 2013 18:12:07 -0800 (PST)
Received: by 10.49.71.163 with HTTP; Sun, 24 Feb 2013 18:12:07 -0800 (PST)
In-Reply-To: <CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
Date: Sun, 24 Feb 2013 18:12:07 -0800
Message-ID: <CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
From: "Flanagan, Elizabeth" <elizabeth.flanagan@intel.com>
To: Chris Larson <clarson@kergoth.com>
X-Gm-Message-State: ALoCoQlzttxxOQgTsw6iayzVpuBebrCJ8m6WPw89CZm9UNtoIIH5yWji5zOg3kNc1erdkjJncsBm
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 02:29:07 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 6:31 AM, Chris Larson <clarson@kergoth.com> wrote:
>
> On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=FCller
> <schnitzeltony@googlemail.com> wrote:
>>
>> with current bitbake master I get
>>
>> ERROR: Command execution failed: Traceback (most recent call
>> last):#########################################################
>>                               | ETA:  00:00:17
>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
>> 92, in runAsyncCommand
>>     self.cooker.updateCache()
>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>> 1330, in updateCache
>>     if not self.parser.parse_next():
>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>> 1703, in parse_next
>>     self.virtuals +=3D len(result)
>> TypeError: object of type 'ExpansionError' has no len()
>
>
> Hmm, looks like it's returning the exceptions rather than raising them, f=
or
> some reason, but that doesn't make much sense =97 the pool code always ra=
ises
> any exceptions from its imap iterator's next() method.
> --
> Christopher Larson
>

I'm hitting this as well with
poky:dde7a481354d5b0539762109bdfaaba6f85f879b, meta-ti and pandaboard
as my machine.

-b

> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>

--=20
Elizabeth Flanagan
Yocto Project
Build and Release


