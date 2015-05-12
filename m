Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7342073F4E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 May 2015 11:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4CBI2sL029375; Tue, 12 May 2015 12:18:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qNZo_j8VsFri; Tue, 12 May 2015 12:18:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4CBHvie029323
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 May 2015 12:18:08 +0100
Message-ID: <1431429477.30971.123.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Liam R. Howlett" <Liam.Howlett@windriver.com>, "Rifenbark, Scott M"
	<scott.m.rifenbark@intel.com>
Date: Tue, 12 May 2015 12:17:57 +0100
In-Reply-To: <1429204998-29516-1-git-send-email-Liam.Howlett@WindRiver.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<1429204998-29516-1-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Tue, 12 May 2015 11:18:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-04-16 at 13:23 -0400, Liam R. Howlett wrote:
> BB_ALLOWED_NETWORKS is a list of hosts that the fetcher will be allowed
> to use when BB_NO_NETWORK is not set.
> 
> If BB_NO_NETWORK is set, then networking is still disabled.
> 
> If BB_ALLOWED_NETWORKS is not set, the behaviour remains the same as
> today.
> 
> If BB_NO_NETWORK is NOT set, and BB_ALLOWED_NETWORKS is configured, then
> only the hosts in the list are usable by the fetcher.
> 
> eg:
> BB_ALLOWED_NETWORKS="yoctoproject.org git.gnu.org"
> The fetcher will be able to download from yoctoproject.org, git.gnu.org,
> but not ftp.gnu.org or any other hostname that is not in the list.
> 
> There is also limited support for wildcards on the beginning of the
> hosts, so BB_ALLOWED_NETWORKS="*.gnu.org" with match git.gnu.org and
> ftp.gnu.org as well as foo.git.gnu.org
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
> ---
>  lib/bb/fetch2/__init__.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/bb/tests/fetch.py     | 37 +++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)

I've merged this, however, one of the things we're trying to do is
improve the documentation of bitbake. Would you be able to work with
Scott (cc'd) to ensure this is documented in the manual please?

Cheers,

Richard


