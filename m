Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UHxEo-0001eC-LI for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 15:10:04 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JE2F6n009258; Tue, 19 Mar 2013 14:02:16 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0vU3qdyE8ucK; Tue, 19 Mar 2013 14:02:15 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JE2AU0009229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 19 Mar 2013 14:02:13 GMT
Message-ID: <1363701172.16482.104.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
Date: Tue, 19 Mar 2013 13:52:52 +0000
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/11] replace tooltips with property windows in HOB
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
X-List-Received-Date: Tue, 19 Mar 2013 14:10:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-03-05 at 17:36 +0200, Andrei Dinu wrote:
> [Enhancement 2248] - https://bugzilla.yoctoproject.org/show_bug.cgi?id=2248
> 
> Added property windows for recipe selection page, package selection page
> and also replaced the tooltips information pages with dialogs.
> 
> Andrei Dinu (11):
>   added extra variables to cache_extra.py
>   extended cooker.py variables
>   replaced the function that displayed tooltips
>   added information for the information dialogs
>   new class added for the property windows.
>   added entries for information dialogs
>   added information columns needed for prop dialogs
>   added functionality for the information dialogs.
>   added information so that it displays correctly
>   added event for the "All packages" tab
>   added events for the "Package Groups" "All recipes

I merged these but in future please put a suitable prefix in front of
the shortlog message. Please see the versions I committed for examples
of what should have been there. It makes "git log" much more readable as
you can easily tell which areas of code changed.

Cheers,

Richard



