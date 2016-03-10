Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C09E26080F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 16:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2AGUXVm014180; Thu, 10 Mar 2016 16:30:33 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JeysqSum4TQs; Thu, 10 Mar 2016 16:30:33 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2AGUW12014177
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Mar 2016 16:30:33 GMT
Message-ID: <1457627432.2804.226.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 10 Mar 2016 16:30:32 +0000
In-Reply-To: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
References: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch2: include PV in 'Unable to get checksum for SRC_URI entry' warnings
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
X-List-Received-Date: Thu, 10 Mar 2016 16:30:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-03-10 at 08:15 -0800, Andre McCurdy wrote:
> Referencing PN only is ambiguous if multiple versions of a recipe are
> present.
> 
> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Now that we have recipe level messages getting a prefix during logging,
do we still need this with master?

Cheers,

Richard

