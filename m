Received: from exprod5og103.obsmtp.com ([64.18.0.145])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <frederic.blain@valeo.com>) id 1TMIxG-0008FC-RP
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Oct 2012 15:37:39 +0200
Received: from mail-ie0-f175.google.com ([209.85.223.175]) (using TLSv1) by
	exprod5ob103.postini.com ([64.18.4.12]) with SMTP
	ID DSNKUHbIjcNYRxpceMJZIt7Zea6nu8duM+Tv@postini.com;
	Thu, 11 Oct 2012 06:24:30 PDT
Received: by mail-ie0-f175.google.com with SMTP id c13so2941529ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Oct 2012 06:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type
	:content-transfer-encoding:x-gm-message-state;
	bh=uPfYkWHK7FnSvjQ90jhYWR4iStBqzHjtxrE+y8QLqq4=;
	b=ZtoR55OnYtoqlB4DvqmMmbPweRoJMPUchqfk8JrMKfT/cES+WTHCf+tICJTy1h32fC
	Gt7RBFjF4tj/6aQ8hSvvINTUUMiDILQzrqHMWsPhpR7PgB5BVWNjzETBV716VyG50gCK
	32bRolpnq7HzDJCE+y4ZQMiwqw5XJ8rkbNN1XyANgPvqQwxZYN0lgXQNqRa+Ok/wMuVR
	llj+hPdRz/9vUodzhzIhAh6Z8rmm4nD7njahIoUZwGIhhCNa21hOjhRF8v282LxvKFSM
	s4k6iEUX1vSM1211KqRDQz1Q8UOAq7dQJYnNw0vpzn946MR2eainxnrrwMkQcyKyrO/5
	E+kQ==
Received: by 10.50.219.229 with SMTP id pr5mr734099igc.59.1349961491808; Thu,
	11 Oct 2012 06:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.107.168 with HTTP; Thu, 11 Oct 2012 06:17:50 -0700 (PDT)
From: Frederic BLAIN <frederic.blain@valeo.com>
Date: Thu, 11 Oct 2012 15:17:50 +0200
Message-ID: <CAARmjOUkPhUdqUwKiRXcdKP_mwkT2+iTns=NRxO=Oax=Ap6fvA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQnp80GA4F0qync7FCRP5rcMcvkZ2l62hWPQroXeRunyralrUCqLfQ87mdVD0ArFN4C/X4PX
Subject: recipes & kernel dependencies
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
X-List-Received-Date: Thu, 11 Oct 2012 13:37:39 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I'm quite new to bitbake but I'm facing a issues with some of my
software components that require specific kernel features to be
enabled (CONFIG_GPIO_SYSFS, ...) and that the current kernel config
does not.

Is there any way to indicate in a recipe that the component depend on
specific kernel feature ? What I'm looking for is a kind of KDEPEND
that ideally would trigger an error during the do_qa task.

Thanks for your support,

--
Fr=E9d=E9ric
This e-mail message is intended only for the use of the intended recipien=
t(s).
The information contained therein may be confidential or privileged,
and its disclosure or reproduction is strictly prohibited.
If you are not the intended recipient, please return it immediately to it=
s sender =

at the above address and destroy it. =

=0D


