Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A1B9B60E79
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  6 Apr 2014 11:47:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s36BlbRd008300; Sun, 6 Apr 2014 12:47:37 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HRy5t145B7AS; Sun,  6 Apr 2014 12:47:36 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s36BlWv6008292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 12:47:33 +0100
Message-ID: <1396784846.24597.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>
Date: Sun, 06 Apr 2014 12:47:26 +0100
In-Reply-To: <CAPbeDCnEFRneQq7=uXtaW0EYGU8bUtG15Cmtico1fHYsQLeVWQ@mail.gmail.com>
References: <1396778902.24597.3.camel@ted>
	<CAPbeDCnEFRneQq7=uXtaW0EYGU8bUtG15Cmtico1fHYsQLeVWQ@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: Fix bug in file checksum generation
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
X-List-Received-Date: Sun, 06 Apr 2014 11:47:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2014-04-06 at 12:39 +0200, Jacob Kroon wrote:
> Perhaps it would be cleaner to do 
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 4335e7a..03ab234 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -979,9 +979,8 @@ def get_file_checksums(filelist, pn):
>                          checksums.append((fullpth, checksum))
>          else:
>              checksum = checksum_file(pth)
> -
> -        if checksum:
> -            checksums.append((pth, checksum))
> +            if checksum:
> +                checksums.append((pth, checksum))
>  
>      checksums.sort(key=operator.itemgetter(1))
>      return checksums
> 
> 
> or am I missing something here ?

The other patch indicates more specifically what the problem was, this
is probably the cleaner code. They amount to the same thing...

Cheers,

Richard




