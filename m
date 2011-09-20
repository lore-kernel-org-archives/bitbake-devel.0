Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R67lc-00022y-B2 for bitbake-devel@lists.openembedded.org;
	Tue, 20 Sep 2011 23:22:12 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8KLN5cH003314; Tue, 20 Sep 2011 22:23:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c94kGUlxR+yQ; Tue, 20 Sep 2011 22:23:05 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8KLMuTK003311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Sep 2011 22:23:00 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Tue, 20 Sep 2011 22:16:42 +0100
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316553408.14488.78.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Various hob fixes
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
X-List-Received-Date: Tue, 20 Sep 2011 21:22:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-09-20 at 08:01 -0700, Joshua Lock wrote:
> This series contains 3 bug fixes.
> 
> The first has been submitted previously but hasn't been applied or commented
> on so I've rolled it into this pull request.
> 
> Patch one and two contain bug fixes for reported issues, patch three is a
> minor change but a noticable one should one stumble accross it.
> 
> Please review and consider for master and the Yocto 1.1 release.
> 
> Regards,
> Joshua
> 
> The following changes since commit 3e7f8afeacf7c8c8de3e87778a3907e33d4a06b3:
> 
>   fetch2/git: fix subpath destination directory (2011-09-19 12:33:38 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (3):
>   ui/crumbs/hobprefs: re-enable reloading of data after prefs changes
>   hob: fix build again when building packages only
>   hob: enable package only builds even if an image has been built

Merged to master, thanks.

Richard



