Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S9zza-0000cd-IY for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:24:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2KEDU7B010725;
	Tue, 20 Mar 2012 14:13:30 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09853-05; Tue, 20 Mar 2012 14:13:26 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2KEDKtD010718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Mar 2012 14:13:21 GMT
Message-ID: <1332252802.9740.89.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Date: Tue, 20 Mar 2012 14:13:22 +0000
In-Reply-To: <1332158179-2776-1-git-send-email-eric@eukrea.com>
References: <1332158179-2776-1-git-send-email-eric@eukrea.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q2KEDU7B010725
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] runningbuild.py: fix goggle ui
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
X-List-Received-Date: Tue, 20 Mar 2012 14:24:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 12:56 +0100, Eric B=C3=A9nard wrote:
> * goggle ui actually fails with :
> Traceback (most recent call last):
>   File ".../bitbake/lib/bb/ui/goggle.py", line 35, in event_handle_idle=
_func
>     build.handle_event (event, pbar)
>   File ".../bitbake/lib/bb/ui/crumbs/runningbuild.py", line 234, in han=
dle_event
>     pbar.update(0, None, bb.event.getName(event))
> TypeError: update() takes exactly 3 arguments (4 given)
>=20
> Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>

Merged to master, thanks.

Richard



