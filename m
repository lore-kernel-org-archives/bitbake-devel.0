Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SWAqH-0000Lq-6U
	for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 20:26:57 +0200
Received: by werg55 with SMTP id g55so3103228wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 May 2012 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=Q5oB3bFR8kMZL6Gj/nYMl5vjNhxqa1fWr+salodZwY0=;
	b=sQ0Rlu6sXVoMUsJnbpqixIxeQX8qZw/roaI41Sm4HpvK5tWjh0J8jj50f2KPPrvUrG
	SNqKdrseroUF9el4X5gPYHNsn7cPKkHWtUd70d9PixPnQYJarQkn7N/Lbi1Btqf0f2FV
	a4J0xPB1xWqhkQaQwWOvutWjSVQ+q9qvX3UidA+7lazfVf/KBuT8LKzY1KlAYm2ukzmG
	tKmNPa9ACKL3RVn3eT+LLKcZAc3bhQu/hnUampU+OJ3y92SFQk7L8fATYCjFXnOxdvKe
	J03Nxe3T8nRqGfhvNvyu50iMVCgCJsdqhB4xBQ87vYi+lKcT0CD+itG2D0m/7KMihzFc
	i59A==
Received: by 10.180.85.129 with SMTP id h1mr18439147wiz.2.1337537810683; Sun,
	20 May 2012 11:16:50 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Sun, 20 May 2012 11:16:30 -0700 (PDT)
In-Reply-To: <cover.1337515887.git.liezhi.yang@windriver.com>
References: <cover.1337515887.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 20 May 2012 11:16:30 -0700
X-Google-Sender-Auth: 9-ghFeClQEP_70g1-yo8DAS9d1s
Message-ID: <CABcZAN=i=KtJzuRjW3s8qn7=ypCQ2KoPGFfmN224WGZCHypw_Q@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/2] V4 replace os.system and os.popen with subbprocess module
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
X-List-Received-Date: Sun, 20 May 2012 18:26:57 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2012 at 5:36 AM, Robert Yang <liezhi.yang@windriver.com> wr=
ote:
> * Changes of V4:
> =C2=A0Fix use readline() for the return value of bb.process.run(), the
> =C2=A0return value is already a string, we can't (or don't have to) use
> =C2=A0readline() for it, the string is what we need.
>
> * Changes of V3:
> =C2=A0Use bb.process.run() rather than bb.process.Popen() to replace os.p=
open()
>
> * Changes of V2:
>
> =C2=A0- Remove the 2>/dev/null since we dont' need it.
> =C2=A0- Use the wrapped Popen from bb.process, which is simpler than
> =C2=A0 =C2=A0subprocess.Popen(....).
>
> * Original message of V1:
> Replace os.popen and os.system with subprocess.Popen and
> subprocess.call, since the older functions would fail (more or less) if
> the executed program cannot be found, this would cause potential errors
> since we don't know whether the problem executed well or not.
>
> For the performance issue, I've done the testing before the patches and
> after with the oe-core layer (also the oe-core have applied the similar
> patches):
>
> # The sources are on local disk
>
> 1) Before applied these pacthes to bitbake and similar patches to oe-core=
:
> $ time bitbake core-image-sato
> real =C2=A0 =C2=A0177m50.723s
> user =C2=A0 =C2=A0436m1.551s
> sys =C2=A0 =C2=A0 71m29.588s
>
> 2) After applied the pathes:
> $ time bitbake core-image-sato
> real =C2=A0 =C2=A0176m26.194s
> user =C2=A0 =C2=A0436m7.931s
> sys =C2=A0 =C2=A0 71m1.994s
>
> After applied these patches, the time has reduced 84 seconds, this is
> very slight, I think that we can assume this is just a deviation, it
> doesn't cause performance problems.

This version looks good to me.
--=20
Christopher Larson


