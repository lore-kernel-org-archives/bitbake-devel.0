Return-Path: <mark.hatle@windriver.com>
X-Greylist: delayed 10930 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 03 May 2014 19:14:58 UTC
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 265C765EF2
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 May 2014 19:14:58 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s43GCm7h001479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 3 May 2014 09:12:48 -0700 (PDT)
Received: from Marks-MacBook-Pro.local (147.11.116.120) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.169.1; Sat, 3 May 2014 09:12:48 -0700
Message-ID: <53651583.5000708@windriver.com>
Date: Sat, 3 May 2014 09:12:51 -0700
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9;
	rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1399112321.12731.101.camel@ted>
In-Reply-To: <1399112321.12731.101.camel@ted>
Subject: Re: [PATCH] prserv/db: Avoid fsync() calls
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
X-List-Received-Date: Sat, 03 May 2014 19:15:00 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/14, 3:18 AM, Richard Purdie wrote:
> If the power were to fail, it doesn't matter to us much if the data
> makes it to disk or not, we'd have other problems. However an fsync()
> call on a multi build autobuilder is painful so lets avoid them.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> index 86eafe3..49f36da 100644
> --- a/bitbake/lib/prserv/db.py
> +++ b/bitbake/lib/prserv/db.py
> @@ -220,6 +220,7 @@ class PRData(object):
>                   raise e
>           self.connection=sqlite3.connect(self.filename, isolation_level="EXCLUSIVE", check_same_thread = False)
>           self.connection.row_factory=sqlite3.Row
> +        self.connection.execute("pragma synchronous = off;")
>           self._tables={}
>
>       def __del__(self):
>
>

Does the prserver make any noticeable difference?  This may be the one case 
where I could see an fsync being desired.  If you are serving remote machines, 
once you've requested a PR, the number should be stored to disk so that it will 
be the same one that comes back again.  ... but I can easily see that in the 
middle of a build, when the PR server is on the same machine (and not shared) 
this could cause enough slow down to justify turning off the fsync.

--Mark

