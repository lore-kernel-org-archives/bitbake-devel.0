Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R6Mb4-0006AN-Ua for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 15:12:19 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8LDDBgD001479; Wed, 21 Sep 2011 14:13:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Hu6p+vcjbKWh; Wed, 21 Sep 2011 14:13:11 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8LDD5cA001476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 21 Sep 2011 14:13:09 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Wed, 21 Sep 2011 14:06:51 +0100
In-Reply-To: <cover.1316567365.git.josh@linux.intel.com>
References: <cover.1316567365.git.josh@linux.intel.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316610417.13085.45.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob fixes
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
X-List-Received-Date: Wed, 21 Sep 2011 13:12:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-09-20 at 18:13 -0700, Joshua Lock wrote:
> The first patch is another case of my submitting patches with a dumb typo in,
> apologies folks, it re-enables the right-click menu for the log messages of
> failed tasks.
> 
> The second patch fixes the consistency and the URI of the 'Browse folder of
> built images" label.
> 
> Richard, please consider these for Yocto 1.1 as well as master.
> 
> Regards,
> Joshua
> 
> The following changes since commit 705156e2812afb288632f01416fcbbf9add26bee:
> 
>   hob: enable package only builds even if an image has been built (2011-09-19 15:28:09 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (2):
>   ui/crumbs/runningbuild: fix log messages right-click menu
>   hob: fix opening of image output dir on image build completion

Merged to master, thanks.

Richard



