Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C4E1960603
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 15:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8SFEUTe002681; Wed, 28 Sep 2016 16:14:30 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lcRMN1oDvjDl; Wed, 28 Sep 2016 16:14:30 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8SFESpQ002678
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Sep 2016 16:14:29 +0100
Message-ID: <1475075668.30475.72.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Armin Kuster <akuster808@gmail.com>, akuster@mvista.com,
	bitbake-devel@lists.openembedded.org
Date: Wed, 28 Sep 2016 16:14:28 +0100
In-Reply-To: <1475075217-17547-1-git-send-email-akuster808@gmail.com>
References: <1475075217-17547-1-git-send-email-akuster808@gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Wed, 28 Sep 2016 15:14:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-09-28 at 08:06 -0700, Armin Kuster wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> "hash() is randomised by default each time you start a new instance
> of
> recent
> versions (Python3.3+) to prevent dictionary insertion DOS attacks"
> 
> which means we need to use hashlib.md5 to get consistent values for
> the codeparser cache under python 3. Prior to this, the codeparser
> cache was effectively useless under python3 as shown by performance
> regressions.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 12d43cf45ba48e3587392f15315d92a1a53482ef)
> 
> We kept running into an issue where shell scripts were not
> getting generated on 32bit hosts. It seemed to be caused by this
> code.

I'm puzzled. This patch is in master. I'm therefore assuming you're
suggesting this for 1.30 but it doesn't say that anywhere.

1.30 isn't python3 based and therefore doesn't have the problem
described above?

Cheers,

Richard


