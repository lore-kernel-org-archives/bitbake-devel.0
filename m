Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id 4203575C60
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 10:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 958361EE0896;
	Tue, 16 Aug 2016 12:42:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id dox-aafUd-vW; Tue, 16 Aug 2016 12:42:18 +0200 (CEST)
Received: from [10.1.8.214] (gre92-5-82-237-199-7.fbx.proxad.net
	[82.237.199.7])
	by idris.smile.fr (Postfix) with ESMTPSA id 6D1391EE0870;
	Tue, 16 Aug 2016 12:42:18 +0200 (CEST)
To: Ulf.Magnusson@bmw.de, peter.kjellerstedt@axis.com,
	jeremy.rosen@enst-bretagne.fr, bitbake-devel@lists.openembedded.org
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
	<1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
	<14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
	<91CC97698835684980CD15EFCBE86BDC26D002B4@smucm59b>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
Message-ID: <4463a36c-8101-9b4e-b647-41d692d939d9@smile.fr>
Date: Tue, 16 Aug 2016 12:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <91CC97698835684980CD15EFCBE86BDC26D002B4@smucm59b>
Cc: jeremy.rosen@openwide.fr
Subject: Re: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Tue, 16 Aug 2016 10:42:18 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Will fix all those wording in V2.0

thx


On 15/08/2016 16:58, Ulf.Magnusson@bmw.de wrote:
> These two statements remove the DATE variable and the do_fetch[noexec]
> variable flag" is better. "...results in... to be cleared" sounds weird.


