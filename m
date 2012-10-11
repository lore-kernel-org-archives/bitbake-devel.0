Received: from mail-ia0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jefro.net@gmail.com>) id 1TMMgP-00050U-22
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Oct 2012 19:36:29 +0200
Received: by mail-ia0-f175.google.com with SMTP id b35so1430153iac.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Oct 2012 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=Kr0Q2EXdd51r9omPZOpbxQrPIyLhGeczltMoeJF++0U=;
	b=U31fQpgWI/FmTJMU7SzCj/bKWE2YOpz/c7CDh1tiNLxXQ4iUw4AuH3nTkNRO+cgXh/
	F7fKQ11qrQakkEESE7II/MKiVuW335WZVFGBZaloekYdKVu3ssn6ARwVxXttmy1yHbUZ
	PNnE1Mn0/5w8NH1ZguwX6VsI5gRH2w9zGo44+TLd3+iage+w/74n4hMnE9I5sUZckGQC
	rjtkvEg/e7VK4MAM992bMG3RJ8/CXEKcbWNyNQC0XPQ4cMacTkzJDOPLHgRMKAxbOA0N
	c8EJxa0jbX/RXMRfsjjIYSJFHv56WxsmkDLQVA/+uwaZV4xLG+LY1OtT75PIeefsRVGR
	3WAg==
MIME-Version: 1.0
Received: by 10.50.173.37 with SMTP id bh5mr1629124igc.45.1349976198007; Thu,
	11 Oct 2012 10:23:18 -0700 (PDT)
Sender: jefro.net@gmail.com
Received: by 10.64.147.37 with HTTP; Thu, 11 Oct 2012 10:23:17 -0700 (PDT)
In-Reply-To: <CAARmjOUkPhUdqUwKiRXcdKP_mwkT2+iTns=NRxO=Oax=Ap6fvA@mail.gmail.com>
References: <CAARmjOUkPhUdqUwKiRXcdKP_mwkT2+iTns=NRxO=Oax=Ap6fvA@mail.gmail.com>
Date: Thu, 11 Oct 2012 10:23:17 -0700
X-Google-Sender-Auth: xfZNRadRBEDzrc9P-npqPvOzv0g
Message-ID: <CA+YB3rZxWWtCe18jeMxFrujTpvtcyyFFRDoLSGnU1gC=FSTH5g@mail.gmail.com>
From: Jeff Osier-Mixon <jefro@jefro.net>
To: Frederic BLAIN <frederic.blain@valeo.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: recipes & kernel dependencies
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
X-List-Received-Date: Thu, 11 Oct 2012 17:36:29 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Fr=E9d=E9ric

I think what you are looking for is DEPENDS and RDEPENDS, and possibly
RECOMMENDS and RRECOMMENDS. Some docs are here:

http://www.openembedded.org/wiki/Getting_started
http://www.openembedded.org/wiki/Inspect_DEPENDS
http://www.yoctoproject.org/documentation

Also, the bitbake-devel list is normally used specifically for
development of the bitbake tool, so it is not often watched as closely
for those actually using the tool. You'll probably have better luck
with the openembedded-core mailing list.

hope this helps!

On Thu, Oct 11, 2012 at 6:17 AM, Frederic BLAIN
<frederic.blain@valeo.com> wrote:
> Hello,
>
> I'm quite new to bitbake but I'm facing a issues with some of my
> software components that require specific kernel features to be
> enabled (CONFIG_GPIO_SYSFS, ...) and that the current kernel config
> does not.
>
> Is there any way to indicate in a recipe that the component depend on
> specific kernel feature ? What I'm looking for is a kind of KDEPEND
> that ideally would trigger an error during the do_qa task.
>
> Thanks for your support,
>
> --
> Fr=E9d=E9ric
> This e-mail message is intended only for the use of the intended recipien=
t(s).
> The information contained therein may be confidential or privileged,
> and its disclosure or reproduction is strictly prohibited.
> If you are not the intended recipient, please return it immediately to it=
s sender
> at the above address and destroy it.
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



--=20
Jeff Osier-Mixon http://jefro.net/blog
Yocto Project Community Manager @Intel http://yoctoproject.org


