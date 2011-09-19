Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R5c8j-0001Tp-TZ for bitbake-devel@lists.openembedded.org;
	Mon, 19 Sep 2011 13:35:58 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBanj1013373; Mon, 19 Sep 2011 12:36:49 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id N9+i74LMnsaC; Mon, 19 Sep 2011 12:36:49 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBaet7013357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Sep 2011 12:36:44 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Mon, 19 Sep 2011 12:30:28 +0100
In-Reply-To: <98fa70c07936c71785162f74971b8a868b17ec31.1316039862.git.josh@linux.intel.com>
References: <cover.1316039862.git.josh@linux.intel.com>
	<98fa70c07936c71785162f74971b8a868b17ec31.1316039862.git.josh@linux.intel.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316431834.14488.4.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetch2/wget: make checkstatus() quieter
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
X-List-Received-Date: Mon, 19 Sep 2011 11:35:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-09-14 at 15:40 -0700, Joshua Lock wrote:
> Change the wget fetcher to not emit the commands output when calling checkstatus, this
> matches the behaviour of the git fetchers checkstatus() method.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/fetch2/wget.py |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Merged to master, thanks.

Richard



