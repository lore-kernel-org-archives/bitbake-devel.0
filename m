Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SzEMd-0004EQ-9Z
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 00:04:27 +0200
Received: by lban1 with SMTP id n1so656489lba.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Aug 2012 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=17XInbqWmfv6tUkRgnFyyL7d0aVn3oF4v7a73Fi0gio=;
	b=NTfRDmMSkb9sftP5tLfKVli9Lugy5bYaEELuD6isDF/XQ231tF7DZZOfNqAsyUCsd/
	n9KFR+2Mz1G2JDFvoHjxpT98k4E8MF3Faqspmy+zAkGlrVQhsZFNNCSZa8AX4kFJXDto
	InZMp2aaSoqmp/eP+X5tnm2rFnIe7vmznTm3A3LGJnp66y8JYuyF6MZ5v4J+Pmh/Qlxe
	stF2KQjj8q3ONzPlkxxEpqWxS9yeFSd+9UqWTQv8aSnfNXpHgOL1uPFtr7YZ/MmWuOWB
	xkrTgMosd+LvxbbK4gnr3aEsAMshEqvgTgYKXj91pXoFLo4ulZCVVFXltUznutdoYPZu
	y0LA==
Received: by 10.152.127.98 with SMTP id nf2mr19947738lab.4.1344462759705; Wed,
	08 Aug 2012 14:52:39 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.64.209 with HTTP; Wed, 8 Aug 2012 14:52:19 -0700 (PDT)
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F690@NAEMMAIL02.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F2A8@NAEMMAIL02.na.leapfrog.com>
	<CAEsOVNc6KjAdgpgnUgJ_UiR=vD6kE2OYo1BX4JfKLGUStPhVRQ@mail.gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0FB5B1F690@NAEMMAIL02.na.leapfrog.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 8 Aug 2012 14:52:19 -0700
X-Google-Sender-Auth: T0hjHihyQ2iwY51WFlofbbpKIcY
Message-ID: <CABcZANmKZ20vk1aPV4Bw6imhFZc=3kc2ZiGbWpynpZsU+3jbWg@mail.gmail.com>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	"'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Making a noexec task executable again
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
X-List-Received-Date: Wed, 08 Aug 2012 22:04:27 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 8, 2012 at 2:19 PM, Daniel Lazzari <dlazzari@leapfrog.com> wrote:
> Good suggestion but it didn't seem to work. I added this to my image:
> addtask fetch2
> do_fetch2[dirs] = "${DL_DIR}"
> python do_fetch2() {
>         base_do_fetch()
> }
>
> And I get an error saying:
> NameError: global name 'base_do_fetch' is not defined

base_do_fetch is a metadata function, not a def'd python function. Use
bb.build.exec_func() instead.
-- 
Christopher Larson


