Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RoHhe-000456-4p for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:52:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGiutB020362;
	Fri, 20 Jan 2012 16:44:56 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20240-03; Fri, 20 Jan 2012 16:44:52 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGilHf020356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jan 2012 16:44:48 GMT
Message-ID: <1327077887.4268.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 20 Jan 2012 16:44:47 +0000
In-Reply-To: <1326661433-26379-2-git-send-email-Martin.Jansa@gmail.com>
References: <1326661433-26379-1-git-send-email-Martin.Jansa@gmail.com>
	<1326661433-26379-2-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] prserv: fix import of sqlite3
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
X-List-Received-Date: Fri, 20 Jan 2012 16:52:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-01-15 at 22:03 +0100, Martin Jansa wrote:
> * this is used in all other bitbake parts where sqlite3 is used, don't
>   know why it wasn't used here, but it fails e.g. on Gentoo
>   Traceback (most recent call last):
>     File "bin/bitbake", line 39, in <module>
>       from bb import cooker
>     File "lib/bb/cooker.py", line 39, in <module>
>       import prserv.serv
>     File "lib/prserv/serv.py", line 4, in <module>
>       import xmlrpclib,sqlite3
>   ImportError: No module named sqlite3
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/prserv/serv.py |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Merged to master along with 1/2.

Why this is needed I'm not sure since I thought sqlite3 was included in
python 2.6 onwards. Since you're running into it and it doesn't hurt
anything I've merged it though.

Cheers,

Richard



