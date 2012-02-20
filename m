Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1RzZV1-0008EQ-9w; Mon, 20 Feb 2012 21:06:17 +0100
Received: by qadz30 with SMTP id z30so4016223qad.6
	for <multiple recipients>; Mon, 20 Feb 2012 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=d4t/LvCda9O9NzEtIsuubRtKYcg7o6v0vTDRRQFR4WY=;
	b=Yipa0+BlQefeWCY3PzoFl3UB1r2RsLdJewGGmPGM/C/pqmuiq278NqWopTWHEUiaCM
	DMtiQiwbS0kFAHFcJPV4rEjeK9Q+uULR0tYcV+vuf20QTjIQ5LWbXyc4GoGgIlahlBbA
	bmXOR9ojLOolNZGVEQn83wTaNkCJDZ806YEZM=
Received: by 10.229.78.204 with SMTP id m12mr14246959qck.130.1329767876520;
	Mon, 20 Feb 2012 11:57:56 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.224.145 with HTTP; Mon, 20 Feb 2012 11:57:36 -0800 (PST)
In-Reply-To: <1329746700.22425.2.camel@lenny>
References: <1329608182.4436.48.camel@ted> <1329746700.22425.2.camel@lenny>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 20 Feb 2012 12:57:36 -0700
X-Google-Sender-Auth: FIrgqDzGnwMUzEsOtGof140KR1U
Message-ID: <CABcZANmS1TK6p3VD-GQv34X=sPmMOQo8ik370CrnH6qa=rbNUA@mail.gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] Bitbake Memory Usage
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
X-List-Received-Date: Mon, 20 Feb 2012 20:06:17 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2012 at 7:05 AM, Colin Walters <walters@verbum.org> wrote:
> On Sat, 2012-02-18 at 23:36 +0000, Richard Purdie wrote:
>> As soon as the child starts trying to remove
>> things from memory, we lose the benefits of CoW and USS and PSS rise.
>
> Note that even leaving out the garbage collector, the cPython VM
> incrementing/decrementing the refcount of objects will force the copy.
>
> The python multiprocessing module has some classes which allow
> explicitly sharing memory. =C2=A0Certainly for various caches e.g. if
> they're just read-only after a certain point it might make sense
> to wrap them in e.g. a multiprocessing.Value.

Hmm, that's quite interesting, thanks for that tidbit. We should
consider looking into that. On a related note, I think we should sit
down and basically review every use of a cache anywhere in bitbake and
rethink their operation. We still have multiple caches stored as
globals with no expiration policy of any sort, they accrue
indefinitely, until process exit. As we review them, we could consider
this as well on a case-by-case basis.
--=20
Christopher Larson


