Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4008D77FFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:43:29 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILhTZs013420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 22:43:30 +0100
Message-ID: <1500414209.22282.15.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:43:29 +0100
In-Reply-To: <1500413820-24816-5-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1500413820-24816-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:43:30 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 5/6] server: Rework the server API so process and xmlrpc servers coexist
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Jul 2017 21:43:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-07-18 at 22:36 +0100, Richard Purdie wrote:
>  lib/bb/cooker.py              |  58 +----
>  lib/bb/cookerdata.py          |   5 +-
>  lib/bb/main.py                | 224 +++++-----------
>  lib/bb/server/__init__.py     |   6 -
>  lib/bb/server/process.py      | 592 +++++++++++++++++++++++++++-----
> ----------
>  lib/bb/server/process.py.orig | 323 +++++++++++++++++++++++

Spotted this sneaked in, its killed in -next.

>  lib/bb/server/xmlrpc.py       | 492 --------------------------------
> ---
>  lib/bb/server/xmlrpcclient.py | 154 +++++++++++
>  lib/bb/server/xmlrpcserver.py | 158 +++++++++++
>  lib/bb/tinfoil.py             |   2 +-
>  lib/prserv/serv.py            |   4 +-
>  11 files changed, 1102 insertions(+), 916 deletions(-)
>  create mode 100644 lib/bb/server/process.py.orig
>  delete mode 100644 lib/bb/server/xmlrpc.py
>  create mode 100644 lib/bb/server/xmlrpcclient.py
>  create mode 100644 lib/bb/server/xmlrpcserver.py

which makes the diffstat a better looking:

 10 files changed, 779 insertions(+), 916 deletions(-)
 delete mode 100644 lib/bb/server/xmlrpc.py
 create mode 100644 lib/bb/server/xmlrpcclient.py
 create mode 100644 lib/bb/server/xmlrpcserver.py

Cheers,

Richard

