Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Rvd82-0007bd-PI
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Feb 2012 00:10:14 +0100
Received: by qadz30 with SMTP id z30so4965921qad.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Feb 2012 15:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=XFzDm784bw9VIS9cSDk5aT6wN6i4Kh2xLHBnl8He0WU=;
	b=alXW4Kazwlp3qIq+t9rUQlsCC++e2BouO9/iaCmqlhhLO8NSRCoLbh+AWhbJNxspm0
	8jzA44pJwejvGYDUmACvYfC/QPI0TKwaDj51JC+VqlTgvSAL2ZF+lT9YXnbGgLbhZ9KD
	4V+hRfP1OMx/YZn/dd/LSpzOvguOGA5joxGPI=
Received: by 10.229.75.138 with SMTP id y10mr2432383qcj.110.1328828529198;
	Thu, 09 Feb 2012 15:02:09 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.33.68 with HTTP; Thu, 9 Feb 2012 15:01:49 -0800 (PST)
In-Reply-To: <1328170876-12909-2-git-send-email-rep.dot.nop@gmail.com>
References: <1328170876-12909-1-git-send-email-rep.dot.nop@gmail.com>
	<1328170876-12909-2-git-send-email-rep.dot.nop@gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 9 Feb 2012 16:01:49 -0700
X-Google-Sender-Auth: V_rog4GSiXHra5lUOFRTVGl4kM4
Message-ID: <CABcZANmZ6+PP0k2Nyh__TNXNWZ2tiED0aRbgAwYK-nVO5LOtTg@mail.gmail.com>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] setup.py: Install concurrent too
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
X-List-Received-Date: Thu, 09 Feb 2012 23:10:14 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 2, 2012 at 1:21 AM, Bernhard Reutner-Fischer
<rep.dot.nop@gmail.com> wrote:
> I was getting:
> Traceback (most recent call last):
> =C2=A0File "/scratch/src/oe/bitbake/build/scripts-2.7/bitbake", line 39, =
in <module>
> =C2=A0 =C2=A0from bb import cooker
> =C2=A0File "/scratch/src/oe/bitbake/build/lib/bb/cooker.py", line 35, in =
<module>
> =C2=A0 =C2=A0from concurrent import futures
> ImportError: No module named concurrent
> Command exited with non-zero status 1
>
> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>


Just as an FYI, this was the wrong approach. setup.py already declared
our dependency on concurrent.futures. If you needed to install it, you
need to install the dependencies as well. If you use it in place in
the source tree, the installed files are irrelevent. Neither of which
require what you tried to do here. Of course, this is irrelevent now
anyway, as we no longer use futures, but I wanted to make this clear.
It was handled the same way we handle all our other dependencies (e.g.
progressbar). We copy it local for those running from the source tree,
and add the dep to setup.py.
--=20
Christopher Larson


